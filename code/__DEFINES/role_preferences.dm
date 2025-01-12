

//Values for antag preferences, event roles, etc. unified here



//These are synced with the Database, if you change the values of the defines
//then you MUST update the database!
#define ROLE_MANIAC				"Maniac"
#define ROLE_WEREWOLF			"Werewolf"
#define ROLE_VAMPIRE			"Vampire"
#define ROLE_NBEAST				"Vampire Lord"
#define ROLE_BANDIT				"Bandit"
#define ROLE_DELF				"Dark Elf"
#define ROLE_PREBEL				"Peasant Rebel"
#define ROLE_ASPIRANT			"Aspirant"

#define ROLE_ZIZOIDCULTIST		"Cultist"
#define ROLE_LICH				"Lich"

#define ROLE_NECRO_SKELETON		"Necromancer Skeleton"


GLOBAL_LIST_INIT(special_roles_rogue, list(
	ROLE_MANIAC = /datum/antagonist/maniac,
	ROLE_PREBEL = /datum/antagonist/prebel,
	ROLE_BANDIT = /datum/antagonist/bandit,
	ROLE_ASPIRANT = /datum/antagonist/aspirant,
	ROLE_WEREWOLF = /datum/antagonist/werewolf,
	ROLE_ZIZOIDCULTIST = /datum/antagonist/zizocultist,
	ROLE_NBEAST = /datum/antagonist/vampirelord,
	ROLE_LICH = /datum/antagonist/lich
))

//Job defines for what happens when you fail to qualify for any job during job selection
#define BEOVERFLOW 	1
#define BERANDOMJOB "Be Random Role"
#define RETURNTOLOBBY 	"Return to Lobby"
