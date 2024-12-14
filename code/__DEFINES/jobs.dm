#define JOB_AVAILABLE 0
#define JOB_UNAVAILABLE_GENERIC 1
#define JOB_UNAVAILABLE_BANNED 2
#define JOB_UNAVAILABLE_PLAYTIME 3
#define JOB_UNAVAILABLE_ACCOUNTAGE 4
#define JOB_UNAVAILABLE_PATRON 5
#define JOB_UNAVAILABLE_RACE 6
#define JOB_UNAVAILABLE_SEX 7
#define JOB_UNAVAILABLE_AGE 8
#define JOB_UNAVAILABLE_WTEAM 9
#define JOB_UNAVAILABLE_LASTCLASS 10
#define JOB_UNAVAILABLE_JOB_COOLDOWN 11
#define JOB_UNAVAILABLE_SLOTFULL 12

#define JOB_DISPLAY_ORDER_DEFAULT 0

#define NOBLEMEN		(1<<0)

#define LORD		(1<<0)
#define LADY		(1<<1)
#define HAND		(1<<2)
#define STEWARD		(1<<3)
#define KNIGHT		(1<<4)
#define GUARD_CAPTAIN		(1<<5)
#define MARSHAL		(1<<6)
#define HOSTAGE		(1<<7)

#define GARRISON		(1<<1)

#define GUARDSMAN	(1<<0)
#define MANATARMS	(1<<1)
#define DUNGEONEER	(1<<2)
#define GATEMASTER	(1<<3)
#define BOGGUARD	(1<<4)
#define BOGMASTER	(1<<5)
#define SHERIFF		(1<<6)

#define CHURCHMEN		(1<<2)

#define PRIEST		(1<<0)
#define PURITAN		(1<<2)
#define MONK		(1<<3)
#define GRAVEDIGGER	(1<<4)
#define CONFESSOR	(1<<5)
#define DRUID		(1<<6)

#define COURTIERS	(1<<3)

#define JESTER		(1<<0)
#define WIZARD		(1<<1)
#define PHYSICIAN 	(1<<2)
#define BUTLER		(1<<3)
#define COUNCILLOR	(1<<4)

#define YEOMEN		(1<<4)

#define BARKEEP		(1<<0)
#define ARCHIVIST	(1<<1)
#define GUILDSMITH	(1<<2)
#define ALCHEMIST	(1<<3)
#define ARTIFICER	(1<<4)
#define SEAMSTER	(1<<5)
#define MERCHANT	(1<<6)
#define SCRIBE		(1<<7)
#define ELDER		(1<<8)
#define APOTHECARY	(1<<9)
#define ARCHITECT	(1<<10)

#define PEASANTS	(1<<5)

#define HUNTER		(1<<0)
#define FARMER		(1<<1)
#define BUTCHER		(1<<2)
#define FISHER		(1<<3)
#define LUMBERJACK	(1<<4)
#define MINER		(1<<5)
#define COOK		(1<<6)
#define GRABBER		(1<<7)
#define NIGHTMASTER	(1<<8)
#define BEGGAR		(1<<9)
#define WENCH		(1<<10)
#define ADVENTURER	(1<<11)
#define PILGRIM		(1<<12)
#define VILLAGER	(1<<13)
#define PRISONERR	(1<<14)
#define PRISONERB	(1<<15)
#define LUNATIC		(1<<16)
#define MIGRANT		(1<<17)
#define BANDIT		(1<<19)

#define YOUNGFOLK	(1<<6)

#define APPRENTICE	(1<<0)
#define CHURCHLING	(1<<1)
#define SQUIRE		(1<<2)
#define SERVANT		(1<<3)
#define ORPHAN		(1<<4)
#define PRINCE		(1<<5)
#define SHOPHAND	(1<<6)
#define CLERK 		(1<<7)
#define MAGEAPPRENTICE	(1<<8)

#define MERCENARIES		(1<<7)

#define MERCENARY	(1<<0)
#define VETERAN		(1<<1)
#define SEELIE		(1<<2)
#define MERC_CLERK	(1<<3)

#define GOBLIN		(1<<8)

#define GOBLINCHIEF	(1<<0)
#define GOBLINCOOK	(1<<1)
#define GOBLINGUARD	(1<<2)
#define GOBLINSMITH	(1<<3)
#define GOBLINRABBLE	(1<<4)
#define GOBLINSHAMAN	(1<<5)

#define SLOP		(1<<9)

#define TESTER		(1<<0)
#define DEATHKNIGHT (1<<1)
#define SKELETON	(1<<2)

#define JCOLOR_NOBLE "#aa83b9"
#define JCOLOR_COURTIER "#81adc8"
#define JCOLOR_CHURCH "#c0ba8d"
#define JCOLOR_SOLDIER "#b18484"
#define JCOLOR_YEOMAN "#819e82"
#define JCOLOR_PEASANT "#b09262"
#define JCOLOR_MERCENARY "#c86e3a"


// job display orders //

// Nobles
#define JDO_LORD 1
#define JDO_LADY 1.1
#define JDO_PRINCE 1.2
#define JDO_HAND 2
#define JDO_STEWARD 3
#define JDO_CLERK 3.1
#define JDO_MARSHAL 4
#define JDO_COUNCILLOR 4.1

// Courtiers
#define JDO_MAGICIAN 5
#define JDO_MAGEAPPRENTICE 5.1
#define JDO_PHYSICIAN 6
#define JDO_JESTER 7
#define JDO_BUTLER 7.1
#define JDO_SERVANT 7.2

#define JDO_GUARD_CAPTAIN 8
#define JDO_KNIGHT 8.1
#define JDO_SQUIRE 8.2
#define JDO_CASTLEGUARD 8.3
#define JDO_GATEMASTER 8.4
#define JDO_SHERIFF 8.5
#define JDO_TOWNGUARD 8.6
#define JDO_DUNGEONEER 8.7
#define JDO_BOGMASTER 9
#define JDO_BOGGUARD 9.1

#define JDO_PRIEST 10
#define JDO_PURITAN 11
#define JDO_TEMPLAR 12
#define JDO_MONK 13
#define JDO_DRUID 13.1
#define JDO_CHURCHLING 14
#define JDO_GRAVEMAN 15
#define JDO_SHEPHERD 16

#define JDO_MERCHANT 17
#define JDO_SHOPHAND 17.1
#define JDO_GRABBER 17.2

#define JDO_ARCHIVIST 18

#define JDO_CHIEF 19
#define JDO_GUILDSMITH 20
#define JDO_APPRENTICE 21

#define JDO_ARCHITECT 22
#define JDO_ARTIFICER 22.1

#define JDO_SEAMSTER 23

#define JDO_BARKEEP 26
#define JDO_COOK 27

#define JDO_BUTCHER 27.1
#define JDO_SOILSON 27.2

#define JDO_NIGHTMASTER 28
#define JDO_WENCH 28.1

#define JDO_VILLAGER 30
#define JDO_ADVENTURER 30.1
#define JDO_PILGRIM 30.2
#define JDO_MIGRANT 32.3

#define JDO_MERC_CLERK 31
#define JDO_MERCENARY 31.1
#define JDO_VET 31.2
#define JDO_SEELIE 31.3
#define JDO_BANDIT 31.4

#define JDO_VAGRANT 33
#define JDO_ORPHAN 34

#define JDO_PRISONERR 35
#define JDO_PRISONERB 35.1
#define JDO_HOSTAGE 35.2
#define JDO_LUNATIC 35.3

#define JDO_GOBLINCHIEF 36
#define JDO_GOBLINCOOK 37
#define JDO_GOBLINGUARD 38
#define JDO_GOBLINSMITH 39
#define JDO_GOBLINRABBLE 40
#define JDO_GOBLINSHAMAN 41

#define MANOR_ROLES \
	/datum/job/roguetown/jester,\
	/datum/job/roguetown/veteran,\
	/datum/job/roguetown/clerk,\
	/datum/job/roguetown/wapprentice,\
	/datum/job/roguetown/servant,\
	/datum/job/roguetown/squire,\
	/datum/job/roguetown/butler,\
	/datum/job/roguetown/magician

#define NOBLE_ROLES \
	/datum/job/roguetown/prince,\
	/datum/job/roguetown/councillor,\
	/datum/job/roguetown/physician,\
	/datum/job/roguetown/marshal,\
	/datum/job/roguetown/captain,\
	/datum/job/roguetown/hand,\
	/datum/job/roguetown/knight,\
	/datum/job/roguetown/lady,\
	/datum/job/roguetown/lord,\
	/datum/job/roguetown/steward

#define KING_QUEEN_ROLES \
	/datum/job/roguetown/lady,\
	/datum/job/roguetown/lord

#define CHURCH_ROLES \
	/datum/job/roguetown/churchling,\
	/datum/job/roguetown/shepherd,\
	/datum/job/roguetown/druid,\
	/datum/job/roguetown/monk,\
	/datum/job/roguetown/undertaker,\
	/datum/job/roguetown/priest,\
	/datum/job/roguetown/puritan,\
	/datum/job/roguetown/templar

#define PEASANT_ROLES \
	/datum/job/roguetown/villager,\
	/datum/job/roguetown/nightmaiden,\
	/datum/job/roguetown/beggar,\
	/datum/job/roguetown/butcher,\
	/datum/job/roguetown/cook,\
	/datum/job/roguetown/lunatic,\
	/datum/job/roguetown/nightman,\
	/datum/job/roguetown/farmer,\
	/datum/job/roguetown/orphan,\
	/datum/job/roguetown/shophand,\
	/datum/job/roguetown/bapprentice,\
	/datum/job/roguetown/prisonerb,\
	/datum/job/roguetown/hostage,\
	/datum/job/roguetown/prisonerr

#define YEOMEN_ROLES \
	/datum/job/roguetown/woodsman,\
	/datum/job/roguetown/archivist,\
	/datum/job/roguetown/architect,\
	/datum/job/roguetown/barkeep,\
	/datum/job/roguetown/guildsmith,\
	/datum/job/roguetown/artificer,\
	/datum/job/roguetown/seamster, \
	/datum/job/roguetown/merchant,\
	/datum/job/roguetown/scribe

#define WANDERER_ROLES \
	/datum/job/roguetown/pilgrim,\
	/datum/job/roguetown/adventurer,\
	/datum/job/roguetown/guild_clerk,\
	/datum/job/roguetown/mercenary,\
	/datum/job/roguetown/seelie,\
	/datum/job/roguetown/grabber,\
	/datum/job/roguetown/bandit

#define GARRISON_ROLES \
	/datum/job/roguetown/bogguardsman,\
	/datum/job/roguetown/bogmaster,\
	/datum/job/roguetown/dungeoneer,\
	/datum/job/roguetown/gatemaster,\
	/datum/job/roguetown/manorguard,\
	/datum/job/roguetown/sheriff,\
	/datum/job/roguetown/citywatch

#define GOBLIN_ROLES \
	/datum/job/roguetown/goblinchief,\
	/datum/job/roguetown/goblincook,\
	/datum/job/roguetown/goblinguard,\
	/datum/job/roguetown/goblinrabble,\
	/datum/job/roguetown/goblinshaman,\
	/datum/job/roguetown/goblinsmith
