//Shamelessly stolen from https://github.com/tgstation/tgstation/pull/74808 by Dominion

/*
 * BYOND loves to tell you about its loving spouse /global
 * But it's actually having a sexy an affair with /static
 * Specifically statics in procs
 * Priority is given to these lines of code in REVERSE order of declaration in the .dme
 * Which is why this file has a funky name
 * So this is what we use to call world.Genesis()
 * It's a nameless, no-op function, because it does absolutely nothing
 * It exists to hold a static var which is initialized to null
 * It's on /world to hide it from reflection
 * Painful right? Good, now you share my suffering
 * Please lock the door on your way out
 */

//I've put this in (repo_root)/modular rather than somewhere in code/ so that it's at the very end of the dme- if you remove modular/ just make sure this stays at the bottom of the DME
/world/proc/_()
	var/static/_ = world.Genesis()
