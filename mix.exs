defmodule SwiftElixirTest.MixProject do
  use Mix.Project

  def project do
    [
      app: :swift_elixir_test,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      compilers: [:elixir_make] ++ Mix.compilers,
      aliases: [compile: [&configure/1]]
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
      {:elixir_make, "~> 0.6.1", runtime: false}
    ]
  end

  defp configure(_args) do
    System.cmd("#{File.cwd!()}/configure", [])
  end
end
