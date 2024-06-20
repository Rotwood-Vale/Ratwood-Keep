/*
	Data object dedicated to holding the relevant data for a drifter wave
*/
/datum/drifter_wave
	// Name of the wave to be shown where relevant
	var/wave_type_name = "ERROR"
	// Maximum playercount of wave
	var/maximum_playercount = 12
	// Tooltip when mousing over a wave type name in the menu
	var/wave_type_tooltip = "ERROR: If you see this one report it"
	// Title of the job related to the job subsystem thats being made/equipped towards for the wave
	var/job_rank = "Drifter"
	// Categories this drifter wave is in
	var/list/drifter_wave_categories = list(DTAG_DISABLED)
	// If you stick something in here, we will not use the job equip related to the job rank and instead force this specific outfit onto them
	var/datum/outfit/bypass_job_and_force_this_outfit_on
	// Delay before we fire when its our turn to be current wave
	var/wave_delay_time = 2 MINUTES

	//Restrictions on what is required in order to enter the wave
	//Make sure to set this up if you need it otherwise you might cuck someone if theres a class selection w requirements.
	var/list/allowed_sexes
	// This wave does not allow a swap of gender based on species variables
	var/immune_to_genderswap = FALSE

	var/list/allowed_races
	var/list/allowed_patrons
	var/list/allowed_ages = ALL_AGES_LIST
	var/list/allowed_skintones



/*
	How many of each class category type we will attempt to roll
	EX: advclass_cat_rolls = list(CTAG_PILGRIM = 5, CTAG_ADVENTURER = 5)
*/
	var/list/advclass_cat_rolls
	// Whether we bypass the requirements on the advclasses or not
	var/class_cat_alloc_bypass_reqs = FALSE

/*
	If we are going to plusboost classes
	EX: class_cat_plusboost_attempts = list(CTAG_PILGRIM = 2)
	2 plusboosts to pilgrim category
*/
	var/list/class_cat_plusboost_attempts

/*
	If you are going to force specific datums into their selector
	EX: forced_class_additions = list(/datum/advclass/cockballs)
	be forewarned this is a list of types not refs
*/
	var/list/forced_class_additions
	// If we are going to bypass the requirements on forced class additions
	var/forced_class_bypass_reqs = TRUE

/*
 	How many times we are going to plusboost the forced classes
	EX: forced_class_plusboost = 2
*/
	var/forced_class_plusboost

/*
	List of atoms that shall be the place we will dump our guys in at
	I will opt to not initialize this list right here
	for the reasons of people should build their landing spots
	and pre-existing slop might not want us to place the guy anywhere
*/
	var/list/drifter_dropzone_targets

/*
	Proc to build a dropzone for us to be at
*/
/datum/drifter_wave/proc/build_dropzone()
	return FALSE


/*
	Pre drifter wave run proc
	Runs right after its set to be the current wave
*/
/datum/drifter_wave/proc/pre_drifter_wave()
	var/datum/job/target_job = SSjob.GetJob(job_rank)
	target_job.drifter_wave_attachment = src

/*
	Occurs after character creation
	specifically right after they are forced to the dropzone
*/
/datum/drifter_wave/proc/post_character_handling()
	return FALSE

/*
	Post drifter wave run proc
	Runs right before next current wave is set, aka we've reached the normal end of life
*/
/datum/drifter_wave/proc/post_drifter_wave()
	var/datum/job/target_job = SSjob.GetJob(job_rank)
	target_job.drifter_wave_attachment = null


