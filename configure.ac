dnl Process this file with autoconf to produce a configure script

AC_INIT([priv/.libs/libnif.so], [1.0])
AC_CONFIG_MACRO_DIRS([m4])
AM_INIT_AUTOMAKE([-Wall -Werror foreign])

AC_ARG_VAR([ELIXIR], [Elixir])
AC_ARG_VAR([ERL_EI_INCLUDE_DIR], [ERL_EI_INCLUDE_DIR])
AC_ARG_VAR([ERL_EI_LIBDIR], [ERL_EI_LIBDIR])
AC_ARG_VAR([CROSSCOMPILE], [CROSSCOMPILE])
AC_ARG_VAR([ERL_CFLAGS], [ERL_CFLAGS])
AC_ARG_VAR([ERL_LDFLAGS], [ERL_LDFLAGS])

AC_PROG_CC
AM_PROG_AR

AC_MSG_CHECKING([whether Elixir works])
AC_PATH_PROG(ELIXIR, $ELIXIR, elixir)

if test "x$ERL_EI_INCLUDE_DIR" = "x"; then
	AC_SUBST([ERL_EI_INCLUDE_DIR], [$($ELIXIR --eval ':code.root_dir |> to_string() |> Kernel.<>("/usr/include") |> IO.puts')])
fi

if test "x$ERL_EI_LIBDIR" = "x"; then
	AC_SUBST([ERL_EI_LIBDIR], [$($ELIXIR --eval ':code.root_dir |> to_string() |> Kernel.<>("/usr/lib") |> IO.puts')])
fi

if test "x$ERL_CFLAGS" = "x"; then
	AC_SUBST([ERL_CFLAGS], [$($ELIXIR --eval '"-I#{System.get_env("ERL_EI_INCLUDE_DIR", "#{to_string(:code.root_dir)}/usr/include")}" |> IO.puts')])
fi

if test "x$ERL_LDFLAGS" = "x"; then
	AC_SUBST([ERL_LDFLAGS], [$($ELIXIR --eval '"-L#{System.get_env("ERL_EI_LIBDIR", "#{to_string(:code.root_dir)}/usr/lib")}" |> IO.puts')])
fi

LT_INIT()
AC_CONFIG_FILES([Makefile])
AC_OUTPUT
