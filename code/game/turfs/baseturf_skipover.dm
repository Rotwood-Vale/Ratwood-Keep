// This is a typepath to just sit in baseturfs and act as a marker for other things.
/turf/baseturf_skipover
	name = "Baseturf skipover placeholder"
	desc = ""

/turf/baseturf_skipover/Initialize()
	. = ..()
	stack_trace("[src]([type]) was instanced which should never happen. Changing into the next baseturf down...")
	ScrapeAway()

/turf/baseturf_bottom
	name = "Z-level baseturf placeholder"
	desc = ""
	baseturfs = /turf/baseturf_bottom
