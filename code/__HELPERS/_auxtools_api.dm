//This is for the auxtools debugger

/proc/auxtools_stack_trace(msg)
	CRASH(msg)

//The auxtools debugger replaces these at runtime, i. e. the bodies of these procs will be replaced by auxtools, they simply need to be defined.
/proc/auxtools_expr_stub()
	CRASH("auxtools not loaded")

/proc/enable_debugging(mode, port)
	CRASH("auxtools not loaded")
