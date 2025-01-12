GLOBAL_LIST_INIT(noble_positions, list(
	"Duke",
	"Duke Consort",
	"Heir",
	"Retinue Captain",
	"Royal Marshal",
	"Councillor",
	"Steward",
	"Knight",
	"Court Magos",
))

GLOBAL_LIST_INIT(courtier_positions, list(
	"Court Physician",
	"Jester",
	"Head Butler",
))

GLOBAL_LIST_INIT(garrison_positions, list(
	"Watchman",
	"Vanguard",
	"Warden",
	"Man at Arms",
	"Dungeoneer",
	"Gatemaster",
	"Town Sheriff",
	"Veteran",
))

GLOBAL_LIST_INIT(church_positions, list(
	"Priest",
	"Acolyte",
	"Mortician",
	"Templar",
	"Druid",
))

GLOBAL_LIST_INIT(inquisition_positions, list(
	"Inquisitor",
	"Confessor",
))

GLOBAL_LIST_INIT(yeoman_positions, list(
	"Merchant",
	"Scholar",
	"Barkeep",
	"Guild Smith",
	"Seamster",
	"Alchemist",
	"Architect",
	"Artificer",
	"Scribe",
	"Mayor",
	"Harbormaster",
	"Longshoreman",
))

GLOBAL_LIST_INIT(peasant_positions, list(
	"Soilson",
	"Butcher",
	"Cook",
	"Lunatic",
	"Miner",
	"Hunter",
	"Fisher",
	"Lumberjack",
	"Towner",
	"Henchman",
	"Nightmaster",
	"Prostitute",
	"Docker",
	"Prisoner",
	"Beggar",
	"Town Seelie",
))

GLOBAL_LIST_INIT(mercenary_positions, list(
	"Mercenary",
	"Guild Clerk",
))

GLOBAL_LIST_INIT(youngfolk_positions, list(
	"Squire",
	"Clerk",
	"Smithy Apprentice",
	"Magicians Apprentice",
	"Churchling",
	"Servant",
	"Shophand",
))

GLOBAL_LIST_INIT(foreigner_positions, list(
	"Refugee",
	"Migrant",
	"Bandit",
))

GLOBAL_LIST_INIT(roguewar_positions, list(
	"Refugee",
))

GLOBAL_LIST_INIT(goblin_positions, list(
	"Goblin Chief",
	"Goblin Cook",
	"Goblin Guard",
	"Goblin Rabble",
	"Goblin Smith",
	"Goblin Shaman",
))

GLOBAL_LIST_INIT(roguefight_positions, list(
	"Red Captain",
	"Red Caster",
	"Red Ranger",
	"Red Fighter",
	"Green Captain",
	"Green Caster",
	"Green Ranger",
	"Green Fighter",
))

GLOBAL_LIST_INIT(test_positions, list(
	"Tester",
))

GLOBAL_LIST_INIT(job_assignment_order, get_job_assignment_order())

/proc/get_job_assignment_order()
	var/list/sorting_order = list()
	sorting_order += GLOB.noble_positions
	sorting_order += GLOB.church_positions
	sorting_order += GLOB.courtier_positions
	sorting_order += GLOB.garrison_positions
	sorting_order += GLOB.inquisition_positions
	sorting_order += GLOB.yeoman_positions
	sorting_order += GLOB.peasant_positions
	sorting_order += GLOB.youngfolk_positions
	sorting_order += GLOB.mercenary_positions
	sorting_order += GLOB.foreigner_positions

	return sorting_order

GLOBAL_LIST_INIT(exp_jobsmap, list(
	EXP_TYPE_TOWNER = list("titles" = peasant_positions | yeoman_positions | youngfolk_positions),
	EXP_TYPE_NOBLE = list("titles" = noble_positions | courtier_positions),
	EXP_TYPE_CHURCH = list("titles" = church_positions | inquisition_positions),
	EXP_TYPE_GUARDS = list("titles" = garrison_positions),
	EXP_TYPE_ADVENTURER = list("titles" = foreigner_positions | mercenary_positions),
))

GLOBAL_LIST_INIT(exp_specialmap, list(
	EXP_TYPE_LIVING = list(), // all living mobs
	EXP_TYPE_ANTAG = list(),
	EXP_TYPE_GHOST = list() // dead people, observers
))

GLOBAL_PROTECT(exp_jobsmap)
GLOBAL_PROTECT(exp_specialmap)


//this is necessary because antags happen before job datums are handed out, but NOT before they come into existence
//so I can't simply use job datum.department_head straight from the mind datum, laaaaame.
/proc/get_department_heads(job_title)
	if(!job_title)
		return list()

	for(var/datum/job/J in SSjob.occupations)
		if(J.title == job_title)
			return J.department_head //this is a list
