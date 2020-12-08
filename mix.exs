defmodule SwiftElixirTest.MixProject do
  use Mix.Project

  def project do
    [
      app: :swift_elixir_test,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      compilers: [:elixir_make] ++ Mix.compilers(),
      aliases: [
        compile: [&autoreconf/1, &configure/1, "compile"],
        clean: [&autoreconf/1, &configure/1, "clean"]
      ],
      make_clean: ["clean"]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:elixir_make, "~> 0.6.2", runtime: false}
    ]
  end

  defp autoreconf(_args) do
    System.cmd("autoreconf", ["-i"])
  end

  defp configure(_args) do
    arch = get_arch(System.get_env("REBAR_TARGET_ARCH"))

    System.cmd(
      "#{File.cwd!()}/configure",
      ["--prefix=#{Mix.Project.app_path()}/priv", "--host=#{arch}", "--target=#{arch}"]
    )
  end

  defp get_arch(nil) do
    lib_dir =
      System.get_env(
        "ERL_EI_LIBDIR",
        :code.root_dir() |> to_string() |> Kernel.<>("/usr/lib")
      )

    System.cmd("ar", ["-xv", "#{lib_dir}/libei.a", "ei_compat.o"])

    r =
      case System.cmd("file", ["ei_compat.o"]) do
        {result, 0} ->
          l = String.split(result)

          arch =
            Enum.filter(
              %{
                "x86_64" => l |> Enum.filter(&String.match?(&1, ~r/x86.64/)) |> length,
                "arm64" => l |> Enum.filter(&String.match?(&1, ~r/arm64/)) |> length,
                "aarch64" => l |> Enum.filter(&String.match?(&1, ~r/aarch64/)) |> length
              },
              fn {_, v} -> v != 0 end
            )

          platform =
            Enum.filter(
              %{
                "apple-darwin" => l |> Enum.filter(&String.match?(&1, ~r/Mach-O/)) |> length,
                "linux-gnu" => l |> Enum.filter(&String.match?(&1, ~r/ELF/)) |> length
              },
              fn {_, v} -> v != 0 end
            )

          "#{arch |> hd() |> elem(0)}-#{platform |> hd() |> elem(0)}"

        _ ->
          {arch, 0} = System.cmd("uname", ["-m"])
          {s, 0} = System.cmd("uname", ["-s"])
          {rr, 0} = System.cmd("uname", ["-r"])

          platform =
            case s do
              "Linux" -> "linux-gnu"
              "Darwin" -> "apple-darwin#{rr}"
              _ -> raise "unsupported platform"
            end

          "#{arch}-#{platform}"
      end

    File.rm("ei_compat.o")
    r
  end

  defp get_arch(arch), do: arch
end
