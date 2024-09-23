// Bard spells/abilities
// A bard's bread and butter. Maybe jester too?
/obj/effect/proc_holder/spell/invoked/mockery
	name = "Viscious Mockery"
	overlay_state = "null"
	releasedrain = 50
	chargetime = 0
	range = 6
	warnie = "mockery"
	movement_interrupt = FALSE
	no_early_release = FALSE
	chargedloop = null
	sound = 'sound/magic/whiteflame.ogg'
	associated_skill = /datum/skill/magic/arcane
	xp_gain = FALSE
	antimagic_allowed = FALSE
	charge_max = 60 SECONDS
	invocation_type = "shout" //can be none, whisper, emote and shout
	miracle = FALSE

/obj/effect/proc_holder/spell/invoked/mockery/cast(list/targets, mob/living/user)
	if(isliving(targets[1]))
		user.say(generate_insult(), forced = "spell")
		var/mob/living/carbon/target = targets[1]
		target.apply_status_effect(/datum/status_effect/buff/egomangled)
		target.visible_message("<span class='info'>A look of deep hurt crosses [target]'s face. Their eyes seem to glaze over.</span>", "<span class='notice'>Those words sting worse than any blade.</span>")
		target.blind_eyes(1)
		target.blur_eyes(15)
		target.adjustFireLoss(15) //a sick burn
		return TRUE
	return FALSE

/datum/status_effect/buff/egomangled
	id = "egomangled"
	alert_type = /atom/movable/screen/alert/status_effect/buff/egomangled
	effectedstats = list("speed" = -2, "fortune" = -5)
	duration = 30 SECONDS

/datum/status_effect/buff/egomangled/on_apply()
	. = ..()
	owner.add_stress(/datum/stressevent/egomangled)
	if(owner?.client)
		if(owner.client.screen && owner.client.screen.len)
			var/atom/movable/screen/plane_master/game_world/PM = locate(/atom/movable/screen/plane_master/game_world) in owner.client.screen
			PM.backdrop(owner)
			PM = locate(/atom/movable/screen/plane_master/game_world_fov_hidden) in owner.client.screen
			PM.backdrop(owner)
			PM = locate(/atom/movable/screen/plane_master/game_world_above) in owner.client.screen
			PM.backdrop(owner)

/datum/status_effect/buff/egomangled/on_remove()
	owner.remove_stress(/datum/stressevent/egomangled)
	if(owner?.client)
		if(owner.client.screen && owner.client.screen.len)
			var/atom/movable/screen/plane_master/game_world/PM = locate(/atom/movable/screen/plane_master/game_world) in owner.client.screen
			PM.backdrop(owner)
			PM = locate(/atom/movable/screen/plane_master/game_world_fov_hidden) in owner.client.screen
			PM.backdrop(owner)
			PM = locate(/atom/movable/screen/plane_master/game_world_above) in owner.client.screen
			PM.backdrop(owner)

	. = ..()

/atom/movable/screen/alert/status_effect/buff/egomangled
	name = "Mangled Ego"
	desc = ""
	icon_state = "acid"

/datum/stressevent/egomangled
	timer = 3 MINUTES
	stressadd = 5

proc/generate_insult()
	var temp = run_or_give_up() +", you "+generic_insult()+"!"
	return temp

proc/run_or_give_up()
	var/list/bard_give_up_list = list(
		"Abandon hope", 
		"Accept your failure", 
		"Accept your fall", 
		"Accept your doom", 
		"Admit defeat", 
		"Beg for mercy", 
		"Capitulate", 
		"Despair", 
		"Despond", 
		"Disclaim thyself", 
		"Embrace submission", 
		"Embrace your dedition", 
		"Embrace your doom", 
		"Embrace your failure", 
		"Embrace your fall", 
		"Face your fugue", 
		"Face your requiem", 
		"Flounder", 
		"Give in", 
		"Give up", 
		"Kneel", 
		"Quail", 
		"Quit", 
		"Surrender", 
		"Succumb", 
		"Submit", 
		"Tremble", 
		"Relinquish hope", 
		"Repent", 
		"Taste defeat", 
		"Away with you", 
		"Back with you", 
		"Begone", 
		"Bolt", 
		"Crawl home", 
		"Decamp", 
		"Escape", 
		"Flee", 
		"Fly", 
		"Get you gone", 
		"Get you hence", 
		"Give up", 
		"Go and return not", 
		"Leave", 
		"Out, out", 
		"Quit", 
		"Remove your stench", 
		"Return whence you came", 
		"Run away", 
		"Scamper away", 
		"Scamper hence", 
		"Scamper home", 
		"Slither away", 
		"Slither hence", 
		"Slither home", 
		"Take your face hence", 
		"Turn tail"
		)
	return pick(bard_give_up_list)

proc/generic_insult()
	var temp = bard_insult_adjective1()+" "+bard_insult_adjective2()+" "+bard_insult_noun()
	return temp

proc/bard_insult_adjective1()
	var/list/bard_insult_adjective1_list = list(
		"artless", 
		"baffled", 
		"bawdy", 
		"beslubbering", 
		"bootless", 
		"bumbling", 
		"canting", 
		"churlish", 
		"cockered", 
		"clouted", 
		"craven", 
		"currish", 
		"defiled", 
		"dankish", 
		"dissembling", 
		"droning", 
		"ducking", 
		"erky", 
		"errant", 
		"euchred", 
		"fawning", 
		"feckless", 
		"feeble", 
		"fobbing", 
		"foisting", 
		"foppish", 
		"froward", 
		"frothy", 
		"fulsome", 
		"gleeking", 
		"goatish", 
		"gorbellied", 
		"grime-gilt", 
		"horrid", 
		"hateful", 
		"impertinent", 
		"infectious", 
		"jarring", 
		"loggerheaded", 
		"lumpish", 
		"mammering", 
		"mangled", 
		"mewling", 
		"obnoxious", 
		"odious", 
		"paunchy", 
		"peaked", 
		"peeagling", 
		"pribbling", 
		"puking", 
		"puny", 
		"pandering", 
		"pecksniffian", 
		"plume-plucked", 
		"pottle-deep", 
		"pox-marked", 
		"qualling", 
		"quaking", 
		"rank", 
		"reeling-ripe", 
		"rough-hewn", 
		"simpering", 
		"skyhacking", 
		"spongy", 
		"surly", 
		"tottering", 
		"twisted", 
		"unctious", 
		"unhinged", 
		"unmuzzled", 
		"vain", 
		"venomed", 
		"villainous", 
		"warped", 
		"wayward", 
		"weedy", 
		"worthless", 
		"yeasty"
		)
	return pick(bard_insult_adjective1_list)

proc/bard_insult_adjective2()
	var/list/bard_insult_adjective2_list = list(
		"base-court", 
		"bat-fowling", 
		"beef-witted", 
		"beetle-headed", 
		"boil-brained", 
		"clapper-clawed", 
		"clay-brained", 
		"common-kissing", 
		"crook-pated", 
		"dismal-dreaming", 
		"ditch-delivered", 
		"dizzy-eyed", 
		"doghearted", 
		"dread-bolted", 
		"earth-vexing", 
		"elf-skinned", 
		"fat-kidneyed", 
		"fen-sucked", 
		"flap-mouthed", 
		"flat-headed", 
		"fly-bitten", 
		"fob-snatching", 
		"folly-fallen", 
		"fool-born", 
		"fool-headed", 
		"full-gorged", 
		"guts-griping", 
		"half-faced", 
		"hasty-witted", 
		"hedge-born", 
		"hell-hated", 
		"idle-headed", 
		"ill-breeding", 
		"ill-nurtured", 
		"kobold-kissing", 
		"knotty-pated", 
		"limp-willed", 
		"milk-livered", 
		"miscreant", 
		"moon-mazed", 
		"motley-minded", 
		"moldwarp", 
		"mumble-news", 
		"nose-picking", 
		"nut-hook", 
		"onion-eyed", 
		"pigeon-egg", 
		"roguish", 
		"rude-growing", 
		"rump-fed", 
		"ruttish", 
		"saucy", 
		"shard-borne", 
		"sheep-biting", 
		"sow-suckled", 
		"spleeny", 
		"spur-galled", 
		"swag-bellied", 
		"tardy-gaited", 
		"tickle-brained", 
		"tip-merry", 
		"toad-spotted", 
		"toenail-biting", 
		"toot-wallowing", 
		"two-tin-hat", 
		"unchin-snouted", 
		"weather-bitten", 
		"weeb-spouting", 
		"weevil-witted", 
		"wibble-sucking"
		)
	return pick(bard_insult_adjective2_list)

proc/bard_insult_noun()
	var/list/bard_insult_noun_list = list(
		"apple-john", 
		"baggage", 
		"bandersnitch", 
		"barnacle", 
		"beggar", 
		"blabberskite", 
		"bladder", 
		"bloater", 
		"boar-pig", 
		"bootlicker", 
		"bounder", 
		"brigand", 
		"bugbear", 
		"bum-bailey", 
		"buzzard-bait", 
		"canker-blossom", 
		"clack-dish", 
		"clam", 
		"clotpole", 
		"Cock-Lorel", 
		"coxcomb", 
		"codpiece", 
		"crab-lanthorn", 
		"cross-patch", 
		"dandiprat", 
		"deadneck", 
		"death-token", 
		"dewberry", 
		"dingleberry", 
		"efter", 
		"erk", 
		"flap-bat", 
		"flax-wench", 
		"fleecer", 
		"flim-flammer", 
		"flirt-gill", 
		"foot-licker", 
		"frater", 
		"fustilarian", 
		"giglet", 
		"gnoll-tail", 
		"gonus", 
		"gudgeon", 
		"guttersnipe", 
		"haggard", 
		"harpy", 
		"hedge-pig", 
		"hugger-mugger", 
		"jarkman", 
		"joithead", 
		"lewdster", 
		"lout", 
		"maggot-pie", 
		"malt-worm", 
		"mammet", 
		"measle", 
		"mendicant", 
		"minnow reeky", 
		"mish-mash", 
		"mule", 
		"nert", 
		"nightsoil", 
		"nobody", 
		"nothing", 
		"pigeon-egg", 
		"pignut", 
		"pimple", 
		"pissant", 
		"pot-faker", 
		"prigger-of-prances", 
		"pustule", 
		"puttock", 
		"pumpion", 
		"ratsbane", 
		"reprobate", 
		"scavenger", 
		"scut", 
		"serf", 
		"simpleton", 
		"skainsmate", 
		"slabber", 
		"slime mould", 
		"snaffler", 
		"snake-molt", 
		"socdollager", 
		"strumpet", 
		"surfacer", 
		"swadder", 
		"tinkerer", 
		"tiddler", 
		"tiler", 
		"toady", 
		"urchin", 
		"varlet", 
		"vassal", 
		"vulture", 
		"wastrel", 
		"wagtail", 
		"whey-face", 
		"whip-jack", 
		"wormtrail", 
		"yak-dropping", 
		"zombie-fodder"
		)
	return pick(bard_insult_noun_list)
