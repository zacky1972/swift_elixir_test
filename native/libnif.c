#include <stdlib.h>
#include <erl_nif.h>
#ifdef OSX
#include "caller.h"
#endif

static ERL_NIF_TERM test(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[])
{
#ifdef OSX
	caller();
	ERL_NIF_TERM atom_ok = enif_make_atom(env, "ok");
	return atom_ok;
#else
	ERL_NIF_TERM atom_error = enif_make_atom(env, "error");
	return enif_make_tuple(env, 2, atom_error, enif_make_atom(env, "not_implemented"));
#endif
}

static ErlNifFunc nif_funcs[] =
{
	{"test", 0, test}
};

ERL_NIF_INIT(Elixir.SwiftElixirTest, nif_funcs, NULL, NULL, NULL, NULL)
