dnl Process this file with autoconf to produce a configure script

AC_INIT([priv/.libs/libnif.so], [1.0])

AC_CANONICAL_BUILD
AC_CANONICAL_HOST
AC_CANONICAL_TARGET

AC_CONFIG_MACRO_DIRS([m4])
AM_INIT_AUTOMAKE([-Wall -Werror foreign])

AC_ARG_VAR([ELIXIR], [Elixir])
AC_ARG_VAR([ERL_EI_INCLUDE_DIR], [ERL_EI_INCLUDE_DIR])
AC_ARG_VAR([ERL_EI_LIBDIR], [ERL_EI_LIBDIR])
AC_ARG_VAR([CROSSCOMPILE], [CROSSCOMPILE])
AC_ARG_VAR([ERL_CFLAGS], [ERL_CFLAGS])
AC_ARG_VAR([ERL_LDFLAGS], [ERL_LDFLAGS])

AC_ARG_VAR([OBJC_FLAGS], [OBJC_FLAGS])

AC_PROG_CC

build_linux=no
build_mac=no
all_mac=no

case "${host_os}" in
	linux*)
		build_linux=yes
		;;
	cygwin*|mingw*)
		AC_MSG_ERROR([OS $host_os on Windows is not supported])
		;;
	darwin*)
		if test ${build_os} == ${host_os}; then
			if test ${build_os} == ${target_os}; then
				all_mac=yes
				AC_PATH_PROG(XCRUN, xcrun)
			fi
		fi
		build_mac=yes
		;;
	*)
		AC_MSG_ERROR([OS $host_os is not suppurted])
		;;
esac

AM_CONDITIONAL([LINUX], [test "x$build_linux" = "xyes"])
AM_CONDITIONAL([OSX], [test "x$build_mac" = "xyes"])
AM_CONDITIONAL([ALLOSX], [test "x$all_mac" = "xyes"])

AM_PROG_AR

AC_PATH_PROG(ELIXIR, $ELIXIR, elixir)

AC_MSG_CHECKING([setting ERL_EI_INCLUDE_DIR])
if test "x$ERL_EI_INCLUDE_DIR" = "x"; then
	AC_SUBST([ERL_EI_INCLUDE_DIR], [$(LC_ALL=en_US.UTF-8 $ELIXIR --eval ':code.root_dir |> to_string() |> Kernel.<>("/usr/include") |> IO.puts')])
fi
AC_MSG_RESULT([$ERL_EI_INCLUDE_DIR])

AC_MSG_CHECKING([setting ERL_EI_LIBDIR])
if test "x$ERL_EI_LIBDIR" = "x"; then
	AC_SUBST([ERL_EI_LIBDIR], [$(LC_ALL=en_US.UTF-8 $ELIXIR --eval ':code.root_dir |> to_string() |> Kernel.<>("/usr/lib") |> IO.puts')])
fi
AC_MSG_RESULT([$ERL_EI_LIBDIR])

AC_MSG_CHECKING([setting ERL_CFLAGS])
if test "x$ERL_CFLAGS" = "x"; then
	AC_SUBST([ERL_CFLAGS], [$(LC_ALL=en_US.UTF-8 $ELIXIR --eval '"-I#{System.get_env("ERL_EI_INCLUDE_DIR", "#{to_string(:code.root_dir)}/usr/include")}" |> IO.puts')])
fi
AC_MSG_RESULT([$ERL_CFLAGS])

AC_MSG_CHECKING([setting ERL_LDFLAGS])
if test "x$ERL_LDFLAGS" = "x"; then
	AC_SUBST([ERL_LDFLAGS], [$(LC_ALL=en_US.UTF-8 $ELIXIR --eval '"-L#{System.get_env("ERL_EI_LIBDIR", "#{to_string(:code.root_dir)}/usr/lib")}" |> IO.puts')])
fi
AC_MSG_RESULT([$ERL_LDFLAGS])

working_foundation=no
working_nslog=no
if test "x$all_mac" = "xyes"; then
	AC_MSG_CHECKING([whether Foundation Framework exists])
	cat>_framework.m<<EOF
#import <Foundation/Foundation.h>
int main() {
	return 0;
}
EOF
	if xcrun clang _framework.m -o _framework > /dev/null 2>&1 && ./_framework > /dev/null 2>&1 ; then
		working_foundation=yes
	fi
	rm -f _framework.m _framework.o _framework
	AC_MSG_RESULT([$working_foundation])

	AC_MSG_CHECKING([whether NSLog works])
	cat>_nslog.m<<EOF
#import <Foundation/Foundation.h>
int main() {
	NSLog(@"hello world");
	return 0;
}
EOF
	if xcrun clang _nslog.m -o _nslog -framework Foundation > /dev/null 2>&1 && ./_nslog  > /dev/null 2>&1 ; then
		working_nslog=yes
	fi
	rm -f _nslog.m _nslog.o _nslog
	AC_MSG_RESULT([$working_nslog])
fi

AM_CONDITIONAL([EXIST_FOUNDATION], [test "x$working_foundation" = "xyes"])
AM_CONDITIONAL([WORK_NSLOG], [test "x$working_nslog" = "xyes"])

LT_INIT()
AC_CONFIG_FILES([Makefile])
AC_OUTPUT
