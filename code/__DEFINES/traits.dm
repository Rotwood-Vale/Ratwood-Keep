// ROGUETRAITS (description when right-clicking [skill] button)
#define TRAIT_WEBWALK "Webwalker"
#define TRAIT_NOSTINK "Dead Nose"
#define TRAIT_ZJUMP "High Jumping"
#define TRAIT_JESTERPHOBIA "Jesterphobic"
#define TRAIT_XENOPHOBIC "Xenophobic"
#define TRAIT_LEAPER "Leaper"
#define TRAIT_NOSEGRAB "Nosey"
#define TRAIT_NUTCRACKER "Nutcracker"
#define TRAIT_SEEPRICES "Skilled Appraiser"
#define TRAIT_SEEPRICES_SHITTY "Appraiser"
#define TRAIT_STRONGBITE "Strong Bite"
#define TRAIT_NOBLE "Noble Blooded"
#define TRAIT_EMPATH "Empath"
#define TRAIT_BREADY "Battleready"
#define TRAIT_MEDIUMARMOR "Maille Training"
#define TRAIT_HEAVYARMOR "Plate Training"
#define TRAIT_DODGEEXPERT "Fast Reflexes"
#define TRAIT_DECEIVING_MEEKNESS "Deceiving Meekness"
#define TRAIT_CRITICAL_RESISTANCE "Critical Resistance"
#define TRAIT_CRITICAL_WEAKNESS "Critical Weakness"
#define TRAIT_MANIAC_AWOKEN "Awoken"
#define TRAIT_NOSTAMINA "Indefatigable" //for ai
#define TRAIT_NUDIST "Nudist" //you can't wear most clothes
#define TRAIT_CYCLOPS_LEFT "Cyclops (Left)" //poked left eye
#define TRAIT_CYCLOPS_RIGHT "Cyclops (Right)" //poked right eye
#define TRAIT_INHUMEN_ANATOMY "Inhumen Anatomy" //can't wear hats and shoes
#define TRAIT_NASTY_EATER "Inhumen Digestion" //can eat rotten food, organs, poison berries, and drink murky water
#define TRAIT_WILD_EATER "Beastly Digestion" //can eat raw and rotten food and drink murky water
#define TRAIT_NOFALLDAMAGE1 "Minor fall damage immunity"
#define TRAIT_NOFALLDAMAGE2 "Major fall damage immunity"
#define TRAIT_MISSING_NOSE "Missing Nose" //halved stamina regeneration
#define TRAIT_DISFIGURED "Disfigured"
#define TRAIT_SPELLCOCKBLOCK "Bewitched" //prevents spellcasting
#define TRAIT_ANTIMAGIC	"Anti-Magic"
#define TRAIT_ANTISCRYING "Non-Detection"
#define TRAIT_SHOCKIMMUNE "Shock Immunity"
#define TRAIT_NOSLEEP "Fatal Insomnia"
#define TRAIT_FASTSLEEP "Fast Sleeper"
#define TRAIT_GOODLOVER "Fabled Lover"
#define TRAIT_SEEDKNOW "Seed Knower"
#define TRAIT_GOODRUNNER "Good Runner"
#define TRAIT_TINY "Tiny"
#define TRAIT_STUDENT "Student"
#define TRAIT_BOGVULNERABLE "Bog Vulnerable"
// ROGUEspecialTRAITS (description when rmb skills button)
#define TRAIT_CIVILIZEDBARBARIAN "Tavern Brawler"
#define TRAIT_COMICSANS "Annoying Face"
#define TRAIT_WATERBREATHING "Water Breathing"
#define TRAIT_DARKLING "Darkling"
#define TRAIT_EXCOMMUNICATED "Excommunicated" //cannot be target of healing miracles or anastasia or cure rot
#define TRAIT_SIMPLESPEECH "Simple Speech" // Can only say the 1000 most common English-language words; other words get modified

///trait determines if this mob can breed given by /datum/component/breeding
#define TRAIT_MOB_BREEDER "mob_breeder"

// PATRON GOD TRAITS
#define TRAIT_ROT_EATER "Blessing of Pestra" //can eat rotten food
#define TRAIT_ORGAN_EATER "Blessing of Graggar" //can eat organs
#define TRAIT_VINE_WALKER "Blessing of Dendor"
#define TRAIT_SOUL_EXAMINE "Blessing of Necra" //can check bodies to see if they have departed
#define TRAIT_ZIZO_MARKED "Blessing of Zizo" //basically just here so that they can avoid a negative moodlet
#define TRAIT_CRACKHEAD "Blessing of Baotha" //will never overdose
#define TRAIT_MATTHIOS_EYES "Matthios's Sight" //can see most expensive thing on a person
#define TRAIT_CHOSEN "Consecrated Priest"
#define TRAIT_NOCTURNAL "Noc's Moonlight" //Grants weak darkvision- lighting alpha 145, amplified for mages using the DV spell- alpha 200
#define TRAIT_FORGEBLESSED "Malum's Devout" //Reduces the fatigue cost of smithing a bit.

#define TRAIT_KNEESTINGER_IMMUNITY "Kneestinger Immunity"
#define TRAIT_BASHDOORS "bashdoors"
#define TRAIT_NOMOOD "no_mood"
#define TRAIT_BAD_MOOD "Bad Mood"
#define TRAIT_NIGHT_OWL "Night Owl"
#define TRAIT_BEAUTIFUL "Beautiful"
#define TRAIT_SIMPLE_WOUNDS "simple_wounds"
#define TRAIT_BANDITCAMP "banditcamp"
#define TRAIT_GOBLINCAMP "goblincamp"
#define TRAIT_VAMPMANSION "vampiremansion"
#define TRAIT_VAMP_DREAMS "vamp_dreams"
#define TRAIT_SPECIALUNDEAD "specdead" //Prevents necromancers from instakilling vampires and liches by turning them into skeletons. Any new undead faction should either get this trait or a similar trait
#define TRAIT_LIMPDICK "limp_dick"
#define TRAIT_SEXPASS "sexpass"
#define TRAIT_STEELHEARTED "steelhearted" //no bad mood from dismembering or seeing this
#define TRAIT_IWASREVIVED "iwasrevived" //prevents PQ gain from reviving the same person twice
#define TRAIT_ASTRATARISEN "astratarisen" //Astratan revivals only work once on someone.
#define TRAIT_IWASUNZOMBIFIED "iwasunzombified" //prevents PQ gain from curing a zombie twice
#define TRAIT_IWASHAUNTED "iwashaunted" //prevents spawning a haunt from a decapitated body twice
#define TRAIT_SCHIZO_AMBIENCE "schizo_ambience" //replaces all ambience with creepy shit
#define TRAIT_SCREENSHAKE "screenshake" //screen will always be shaking, you cannot stop it
#define TRAIT_NORUN "Decayed Flesh"
#define TRAIT_PUNISHMENT_CURSE "PunishmentCurse"
#define TRAIT_LEPROSY "Leprosy"
#define TRAIT_ROTTOUCHED "Rot Touched"
#define TRAIT_NUDE_SLEEPER "Nude Sleeper"
#define TRAIT_WANTED "Wanted Brigand"
#define TRAIT_WANTED_POSTER_READ "Read Wanted Poster"
#define TRAIT_COMMIE "Eye of a Brigand" //bandit trait
#define TRAIT_DEATHBYSNUSNU "Bed Breaker" // double sex damage (requires strong intent)
#define TRAIT_POISONBITE "Venomous Bite" // Adds tox damage on bites
#define TRAIT_RITUALIST "Ritualist" // Allows use of ritual feathers
#define TRAIT_DEATHBARGAIN "Death Bargain" // Used by UNDERMAIDEN'S BARGAIN
#define TRAIT_MATTHIOS_BRAND "Matthios Brand"
#define TRAIT_MATTHIOS_BRAND_OLD "Old Matthios Brand"

// PATRON CURSE TRAITS
#define TRAIT_CURSE "Curse" //source
#define TRAIT_ATHEISM_CURSE "Curse of Atheism"
#define TRAIT_PSYDON_CURSE "Psydon's Curse"
#define TRAIT_ASTRATA_CURSE "Astrata's Curse"
#define TRAIT_NOC_CURSE "Noc's Curse"
#define TRAIT_RAVOX_CURSE "Ravox's Curse"
#define TRAIT_NECRA_CURSE "Necra's Curse"
#define TRAIT_XYLIX_CURSE "Xylix's Curse"
#define TRAIT_PESTRA_CURSE "Pestra's Curse"
#define TRAIT_EORA_CURSE "Eora's Curse"
#define TRAIT_ZIZO_CURSE "Zizo's Curse"
#define TRAIT_GRAGGAR_CURSE "Graggar's Curse"
#define TRAIT_MATTHIOS_CURSE "Matthios' Curse"
#define TRAIT_BAOTHA_CURSE "Baotha's Curse"




GLOBAL_LIST_INIT(roguetraits, list(
	TRAIT_LEPROSY = span_necrosis("I'm a disgusting leper..."),
	TRAIT_ROTTOUCHED = span_necrosis("I've recovered from the rot plague, though it's taint is evident..."),
	TRAIT_CHOSEN = "Appointed by the Church of the Successors, you hold authority over all spiritual matters in the City.",
	TRAIT_BOGVULNERABLE = span_info("I am used to steady ground. The Terrorbog is unfamiliar terrain."),
	TRAIT_WEBWALK = "I can move freely between webs.",
	TRAIT_NOSTINK = span_dead("My nose is numb to the smell of decay."),
	TRAIT_ZJUMP = "Time to reach a new high.",
	TRAIT_JESTERPHOBIA = span_warning("I have a severe irrational fear of Jesters"),
	TRAIT_XENOPHOBIC = span_warning("Lesser races pollute our land"),
	TRAIT_NIGHT_OWL = span_info("I enjoy spending my time in the night"),
	TRAIT_BEAUTIFUL = span_info("People love looking at my face"),
	TRAIT_BAD_MOOD = span_warning("Everything just seems to piss me off"),
	TRAIT_LEAPER = "I can leap like a frog.",
	TRAIT_NOSEGRAB = "I love to grab idiots by their noses!",
	TRAIT_NUTCRACKER = "I love kicking idiots on the nuts!",
	TRAIT_SEEPRICES = "I can tell the prices of things down to the zenny.",
	TRAIT_SEEPRICES_SHITTY = "I can tell the prices of things... <i>Kind of</i>.",
	TRAIT_STRONGBITE = "Stronger bites, critical bite attacks.",
	TRAIT_NOBLE = span_blue("I'm of noble blood."),
	TRAIT_EMPATH = "I can notice when people are in pain.",
	TRAIT_BREADY = "Defensive stance does not passively fatigue me.",
	TRAIT_MEDIUMARMOR = "I can move freely in medium armor.",
	TRAIT_HEAVYARMOR = "I can move freely in both heavy and medium armor.",
	TRAIT_DODGEEXPERT = "I can dodge easily while only wearing light armor.",
	TRAIT_DECEIVING_MEEKNESS = "People look at me and think I am a weakling. They are mistaken.",
	TRAIT_CRITICAL_RESISTANCE = "I am resistant to wounds that would be life threatening to others.",
	TRAIT_CRITICAL_WEAKNESS = span_danger("I am weak to wounds that others could survive."),
	TRAIT_MANIAC_AWOKEN = span_danger("I am <b>WAKING UP</b> and the sheeple know this. They will resist."),
	TRAIT_NOSTAMINA = "I have boundless energy, I will never tire.",
	TRAIT_NUDIST = "I <b>refuse</b> to wear clothes. They are a hindrance to my freedom.",
	TRAIT_CYCLOPS_LEFT = span_warning("My left eye has been poked out..."),
	TRAIT_CYCLOPS_RIGHT = span_warning("My right eye has been poked out..."),
	TRAIT_INHUMEN_ANATOMY = "My anatomy is inhumen, preventing me from wearing hats and shoes.",
	TRAIT_NASTY_EATER = span_dead("I can eat bad food, and water that would be toxic to humen will not affect me."),
	TRAIT_WILD_EATER = span_info("I can eat raw food and drink from dirty water."),
	TRAIT_NOFALLDAMAGE1 = span_warning("I can easily handle minor falls."),
	TRAIT_NOFALLDAMAGE2 = span_warning("I can't be injured by falling."),
	TRAIT_DISFIGURED = span_warning("No one can recognize me..."),
	TRAIT_MISSING_NOSE = span_warning("I struggle to breathe."),
	TRAIT_SPELLCOCKBLOCK = span_warning("I cannot cast any spells."),
	TRAIT_ANTIMAGIC = "I am immune to most forms of magic.",
	TRAIT_ANTISCRYING = "I am immune to most forms of magical divination.",
	TRAIT_SHOCKIMMUNE = "I am immune to electrical shocks.",
	TRAIT_NOSLEEP = span_warning("I can't sleep."),
	TRAIT_ROT_EATER = span_necrosis("I can eat rotten food."),
	TRAIT_ORGAN_EATER = span_bloody("I can eat organs and raw flesh."),
	TRAIT_KNEESTINGER_IMMUNITY = "I am immune to the shock of kneestingers.",
	TRAIT_VINE_WALKER = "I can gracefully cross through weepvines.",
	TRAIT_SOUL_EXAMINE = span_deadsay("I know when someone's soul has departed."),
	TRAIT_CRACKHEAD = span_love("I can use drugs as much as I want!"),
	TRAIT_ZIZO_MARKED = span_info("Zizo is steering me to evil and chaos, it feels amazing"),
	TRAIT_COMMIE = span_bloody("I can recognize other free men, and they can recognize me too."),
	TRAIT_NORUN = span_warning("My body has atrophied in my state of decay; my leg joints just don't have the strength or durability for running anymore"),
	TRAIT_GOODLOVER = span_love("It's a lucky thing to share my bed."),
	TRAIT_SEEDKNOW = span_info("I know which seeds grow which crops."),
	TRAIT_CIVILIZEDBARBARIAN = span_info("Your fists are heavier."),
	TRAIT_COMICSANS = span_sans("I am cursed with a odd voice."),
	TRAIT_WATERBREATHING = span_info("I do not drown in bodies of water."),
	TRAIT_GOODRUNNER = span_info("I can run without breaking a sweat!"),
	TRAIT_NUDE_SLEEPER = span_warning("I can't fall asleep unless I'm nude and in bed."),
	TRAIT_TINY = span_info("I am tiny in size and quite fragile!"),
	TRAIT_STUDENT = span_info("The scholar has taught me new skills!"),
	TRAIT_DARKLING = span_info("I am a creature of the dark and am sensitive to the light. The hateful sun is especially harsh on my eyes, and I prefer to sleep during the dae."),
	TRAIT_BOG_TREKKING = "Expert in navigating these lands.",
	TRAIT_DEATHBYSNUSNU = "With strong intent, I can shatter pelvises.", // Ham change
	TRAIT_POISONBITE = "My bites inject venom into my target.", // Ham change
	TRAIT_WANTED = span_info("You are wanted in this kingdom, if someone sees your face they might run away or attack you."),
	TRAIT_EXCOMMUNICATED = span_info("The Ten are not on my side any longer..."),
	TRAIT_RITUALIST = span_info("I am skilled in the holy arts. Using a ritual feather, I can more deftly channel my God's powers via runes."),
	TRAIT_DEATHBARGAIN = span_info("A horrible deal has been prepared in your name. May you never see it fulfilled..."),
	TRAIT_SIMPLESPEECH = span_info("I can not say hard words.")
))

// trait accessor defines
#define ADD_TRAIT(target, trait, source) \
	do { \
		var/list/_L; \
		if (!target.status_traits) { \
			target.status_traits = list(); \
			_L = target.status_traits; \
			_L[trait] = list(source); \
		} else { \
			_L = target.status_traits; \
			if (_L[trait]) { \
				_L[trait] |= list(source); \
			} else { \
				_L[trait] = list(source); \
			} \
		} \
	} while (0)
#define REMOVE_TRAIT(target, trait, sources) \
	do { \
		var/list/_L = target.status_traits; \
		var/list/_S; \
		if (sources && !islist(sources)) { \
			_S = list(sources); \
		} else { \
			_S = sources\
		}; \
		if (_L && _L[trait]) { \
			for (var/_T in _L[trait]) { \
				if ((!_S && (_T != ROUNDSTART_TRAIT)) || (_T in _S)) { \
					_L[trait] -= _T \
				} \
			};\
			if (!length(_L[trait])) { \
				_L -= trait \
			}; \
			if (!length(_L)) { \
				target.status_traits = null \
			}; \
		} \
	} while (0)
#define REMOVE_TRAITS_NOT_IN(target, sources) \
	do { \
		var/list/_L = target.status_traits; \
		var/list/_S = sources; \
		if (_L) { \
			for (var/_T in _L) { \
				_L[_T] &= _S;\
				if (!length(_L[_T])) { \
					_L -= _T } \
				};\
				if (!length(_L)) { \
					target.status_traits = null\
				};\
		}\
	} while (0)
#define HAS_TRAIT(target, trait) (target.status_traits ? (target.status_traits[trait] ? TRUE : FALSE) : FALSE)
#define HAS_TRAIT_FROM(target, trait, source) (target.status_traits ? (target.status_traits[trait] ? (source in target.status_traits[trait]) : FALSE) : FALSE)

/*
Remember to update _globalvars/traits.dm if you're adding/removing/renaming traits.
*/

//mob traits
#define TRAIT_BLIND 			"blind"
#define TRAIT_MUTE				"mute"
#define TRAIT_ZOMBIE_SPEECH 	"zombie_speech"
#define TRAIT_GARGLE_SPEECH		"gargle_speech"
#define TRAIT_EMOTEMUTE			"emotemute"
#define TRAIT_DEAF				"deaf"
#define TRAIT_NEARSIGHT			"nearsighted"
#define TRAIT_FAT				"fat"
#define TRAIT_HUSK				"husk"
#define TRAIT_CHUNKYFINGERS		"chunkyfingers" //means that you can't use weapons with normal trigger guards.
#define TRAIT_DUMB				"dumb"
#define TRAIT_MONKEYLIKE		"monkeylike" //sets IsAdvancedToolUser to FALSE
#define TRAIT_PACIFISM			"pacifism"
#define TRAIT_IGNORESLOWDOWN	"ignoreslow"
#define TRAIT_IGNOREDAMAGESLOWDOWN "ignoredamageslowdown"
#define TRAIT_DEATHCOMA			"deathcoma" //Causes death-like unconsciousness
#define TRAIT_FAKEDEATH			"fakedeath" //Makes the owner appear as dead to most forms of medical examination
#define TRAIT_STUNIMMUNE		"stun_immunity"
#define TRAIT_STUNRESISTANCE    "stun_resistance"
#define TRAIT_SLEEPIMMUNE		"sleep_immunity"
#define TRAIT_PUSHIMMUNE		"push_immunity"
#define TRAIT_STABLEHEART		"stable_heart"
#define TRAIT_NOPAINSTUN		"no_pain-stun"
#define TRAIT_RESISTHEAT		"resist_heat"
#define TRAIT_RESISTHEATHANDS	"resist_heat_handsonly" //For when you want to be able to touch hot things, but still want fire to be an issue.
#define TRAIT_RESISTCOLD		"resist_cold"
#define TRAIT_RESISTHIGHPRESSURE	"resist_high_pressure"
#define TRAIT_RESISTLOWPRESSURE	"resist_low_pressure"
#define TRAIT_RADIMMUNE			"rad_immunity"
#define TRAIT_PIERCEIMMUNE		"pierce_immunity"
#define TRAIT_NODISMEMBER		"dismember_immunity"
#define TRAIT_NOFIRE			"nonflammable"
#define TRAIT_NOGUNS			"no_guns"
#define TRAIT_NOHUNGER			"no_hunger"
#define TRAIT_NOMETABOLISM		"no_metabolism"
#define TRAIT_TOXIMMUNE			"toxin_immune"
#define TRAIT_HARDDISMEMBER		"hard_dismember"
#define TRAIT_EASYDISMEMBER		"easy_dismember"
#define TRAIT_LIMBATTACHMENT 	"limb_attach"
#define TRAIT_NOLIMBDISABLE		"no_limb_disable"
#define TRAIT_EASYLIMBDISABLE	"easy_limb_disable"
#define TRAIT_TOXINLOVER		"toxinlover"
#define TRAIT_NOBREATH			"no_breath"
#define TRAIT_HOLDBREATH		"hold_breath"
#define TRAIT_HOLY				"holy"
#define TRAIT_NOCRITDAMAGE		"no_crit"
#define TRAIT_NOSLIPWATER		"noslip_water"
#define TRAIT_NOSLIPALL			"noslip_all"
#define TRAIT_NODEATH			"nodeath"
#define TRAIT_NOHARDCRIT		"nohardcrit"
#define TRAIT_NOSOFTCRIT		"nosoftcrit"
#define TRAIT_MINDSHIELD		"mindshield"
#define TRAIT_DISSECTED			"dissected"
#define TRAIT_SIXTHSENSE		"sixth_sense" //I can hear dead people
#define TRAIT_FEARLESS			"fearless"
#define TRAIT_PARALYSIS_L_ARM	"para-l-arm" //These are used for brain-based paralysis, where replacing the limb won't fix it
#define TRAIT_PARALYSIS_R_ARM	"para-r-arm"
#define TRAIT_PARALYSIS_L_LEG	"para-l-leg"
#define TRAIT_PARALYSIS_R_LEG	"para-r-leg"
#define TRAIT_NOMOBSWAP         "no-mob-swap"
#define TRAIT_XRAY_VISION       "xray_vision"
#define TRAIT_THERMAL_VISION    "thermal_vision"
#define TRAIT_ABDUCTOR_TRAINING "abductor-training"
#define TRAIT_ABDUCTOR_SCIENTIST_TRAINING "abductor-scientist-training"
#define TRAIT_SURGEON           "surgeon"
#define TRAIT_STRONG_GRABBER	"strong_grabber"
#define TRAIT_MAGIC_CHOKE		"magic_choke"
#define TRAIT_SOOTHED_THROAT    "soothed-throat"
#define TRAIT_LAW_ENFORCEMENT_METABOLISM "law-enforcement-metabolism"
#define TRAIT_ALWAYS_CLEAN      "always-clean"
#define TRAIT_BOOZE_SLIDER      "booze-slider"
#define TRAIT_QUICK_CARRY		"quick-carry"
#define TRAIT_QUICKER_CARRY		"quicker-carry"
#define TRAIT_UNINTELLIGIBLE_SPEECH "unintelligible-speech"
#define TRAIT_LANGUAGE_BARRIER	"language-barrier"
#define TRAIT_PASSTABLE			"passtable"
#define TRAIT_NOFLASH			"noflash" //Makes you immune to flashes
#define TRAIT_NOPAIN			"no_pain"
#define TRAIT_DRUQK				"druqk"
#define TRAIT_BURIED_COIN_GIVEN "buried_coin_given" // prevents a human corpse from being used for a corpse multiple times
#define TRAIT_BLOODLOSS_IMMUNE "bloodloss_immune" // can bleed, but will never die from blood loss
#define TRAIT_ZOMBIE_IMMUNE "zombie_immune" //immune to zombie infection
#define TRAIT_NO_BITE "no_bite" //prevents biting
#define TRAIT_NO_BLOOD "no_blood" // Cannot bleed or have blood

//bodypart traits
#define TRAIT_PARALYSIS	"paralysis" //Used for limb-based paralysis and full body paralysis
#define TRAIT_BRITTLE "brittle" //The limb is more susceptible to fractures
#define TRAIT_FINGERLESS "fingerless" //The limb has no fingies

//item traits
#define TRAIT_NODROP            "nodrop"
#define TRAIT_NOEMBED			"noembed"
#define TRAIT_NO_TELEPORT		"no-teleport" //you just can't
// #define TRAIT_NO_SELF_UNEQUIP	"no-self-unequip" // ALREADY A VAR, SEE: allow_self_unequip

// common trait sources
#define TRAIT_GENERIC "generic"
#define UNCONSCIOUS_BLIND "unconscious_blind"
#define EYE_DAMAGE "eye_damage"
#define GENETIC_MUTATION "genetic"
#define OBESITY "obesity"
#define MAGIC_TRAIT "magic"
#define TRAUMA_TRAIT "trauma"
#define DISEASE_TRAIT "disease"
#define SPECIES_TRAIT "species"
#define ORGAN_TRAIT "organ"
#define CRIT_TRAIT "crit"
#define ROUNDSTART_TRAIT "roundstart" //cannot be removed without admin intervention
#define JOB_TRAIT "job"
#define CYBORG_ITEM_TRAIT "cyborg-item"
#define ADMIN_TRAIT "admin" // (B)admins only.
#define CHANGELING_TRAIT "changeling"
#define CULT_TRAIT "cult"
#define CURSED_ITEM_TRAIT "cursed-item" // The item is magically cursed
#define ABSTRACT_ITEM_TRAIT "abstract-item"
#define STATUS_EFFECT_TRAIT "status-effect"
#define CLOTHING_TRAIT "clothing"
#define HELMET_TRAIT "helmet"
#define GLASSES_TRAIT "glasses"
#define VEHICLE_TRAIT "vehicle" // inherited from riding vehicles
#define INNATE_TRAIT "innate"
#define DEADITE_TRAIT "deadite"

// unique trait sources, still defines
#define TRAIT_BOG_TREKKING "trekking"
#define TRAIT_DARKVISION "darkvision"
#define TRAIT_DARKVISION_BETTER "darkvisionbetter"
#define CLONING_POD_TRAIT "cloning-pod"
#define STATUE_MUTE "statue"
#define CHANGELING_DRAIN "drain"
#define CHANGELING_HIVEMIND_MUTE "ling_mute"
#define ABYSSAL_GAZE_BLIND "abyssal_gaze"
#define HIGHLANDER "highlander"
#define TRAIT_HULK "hulk"
#define STASIS_MUTE "stasis"
#define GENETICS_SPELL "genetics_spell"
#define EYES_COVERED "eyes_covered"
#define CULT_EYES "cult_eyes"
#define TRAIT_SANTA "santa"
#define SCRYING_ORB "scrying-orb"
#define ABDUCTOR_ANTAGONIST "abductor-antagonist"
#define NUKEOP_TRAIT "nuke-op"
#define DEATHSQUAD_TRAIT "deathsquad"
#define CLOWN_NUKE_TRAIT "clown-nuke"
#define STICKY_MOUSTACHE_TRAIT "sticky-moustache"
#define CHAINSAW_FRENZY_TRAIT "chainsaw-frenzy"
#define CHRONO_GUN_TRAIT "chrono-gun"
#define REVERSE_BEAR_TRAP_TRAIT "reverse-bear-trap"
#define CURSED_MASK_TRAIT "cursed-mask"
#define HIS_GRACE_TRAIT "his-grace"
#define HAND_REPLACEMENT_TRAIT "magic-hand"
#define HOT_POTATO_TRAIT "hot-potato"
#define SABRE_SUICIDE_TRAIT "sabre-suicide"
#define ABDUCTOR_VEST_TRAIT "abductor-vest"
#define CAPTURE_THE_FLAG_TRAIT "capture-the-flag"
#define EYE_OF_GOD_TRAIT "eye-of-god"
#define SHAMEBRERO_TRAIT "shamebrero"
#define CHRONOSUIT_TRAIT "chronosuit"
#define LOCKED_HELMET_TRAIT "locked-helmet"
#define NINJA_SUIT_TRAIT "ninja-suit"
#define ANTI_DROP_IMPLANT_TRAIT "anti-drop-implant"
#define SLEEPING_CARP_TRAIT "sleeping_carp"
#define MADE_UNCLONEABLE "made-uncloneable"
#define TIMESTOP_TRAIT "timestop"
#define HUGBOX_TRAIT "hugbox"


#define TRAIT_I_AM_INVISIBLE_ON_A_BOAT "invisible_on_tram"

#define TRAIT_LIGHT_STEP		"light_step"
#define TRAIT_DRUNK_HEALING		"drunk_healing"

// RITUALS

#define TRAIT_RITUALIZED "Ritualized" //This is used to prevent cpr to work on humans that just got sacrificed
