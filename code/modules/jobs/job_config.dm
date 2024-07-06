GLOBAL_LIST_INIT(job_configs, build_job_configs())

/proc/build_job_configs()
	. = list()
	for(var/path in subtypesof(/datum/job_config))
		.[path] = new path()

/datum/job_config
	var/id = null
	var/list/disallowed_jobs

/datum/job_config/rockhill
	id = "rockhill"
	disallowed_jobs = list()

/datum/job_config/dakkatown
	id = "dakkatown"
	disallowed_jobs = list(
		/datum/job/roguetown/bogguardsman,
		/datum/job/roguetown/bogmaster,
		/datum/job/roguetown/prisonerb,
		/datum/job/roguetown/hostage,
	)
