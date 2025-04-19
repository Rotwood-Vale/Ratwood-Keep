/datum/status_effect/buff
	status_type = STATUS_EFFECT_REFRESH


/datum/status_effect/buff/drunk
	id = "drunk"
	alert_type = /atom/movable/screen/alert/status_effect/buff/drunk
	effectedstats = list("intelligence" = -2, "endurance" = 1)
	duration = 5 MINUTES

/atom/movable/screen/alert/status_effect/buff/drunk
	name = "Drunk"
	desc = ""
	icon_state = "drunk"

/datum/status_effect/buff/snackbuff
	id = "snack"
	alert_type = /atom/movable/screen/alert/status_effect/buff/snackbuff
	effectedstats = list("endurance" = 1)
	duration = 8 MINUTES

/atom/movable/screen/alert/status_effect/buff/snackbuff
	name = "Good snack"
	desc = "Better than plain bread. Tasty."
	icon_state = "foodbuff"

/datum/status_effect/buff/snackbuff/on_apply() //can't stack two snack buffs, it'll keep the highest one
	. = ..()
	owner.add_stress(/datum/stressevent/goodsnack)
	if(owner.has_status_effect(/datum/status_effect/buff/greatsnackbuff))
		owner.remove_status_effect(/datum/status_effect/buff/snackbuff)


/datum/status_effect/buff/greatsnackbuff
	id = "greatsnack"
	alert_type = /atom/movable/screen/alert/status_effect/buff/greatsnackbuff
	effectedstats = list("constitution" = 1,"endurance" = 1)
	duration = 10 MINUTES

/atom/movable/screen/alert/status_effect/buff/greatsnackbuff
	name = "Great Snack!"
	desc = "Nothing like a great and nutritious snack to help you on that final strech. I feel invigorated."
	icon_state = "foodbuff"

/datum/status_effect/buff/greatsnackbuff/on_apply()
	. = ..()
	owner.add_stress(/datum/stressevent/greatsnack)
	if(owner.has_status_effect(/datum/status_effect/buff/snackbuff)) //most of the time you technically shouldn't need to check this, but otherwise you get runtimes, so keep it
		owner.remove_status_effect(/datum/status_effect/buff/snackbuff)

/datum/status_effect/buff/mealbuff
	id = "meal"
	alert_type = /atom/movable/screen/alert/status_effect/buff/mealbuff
	effectedstats = list("constitution" = 1)
	duration = 30 MINUTES

/atom/movable/screen/alert/status_effect/buff/mealbuff
	name = "Good meal"
	desc = "A meal a day keeps the barber away, or at least it makes it slightly easier."
	icon_state = "foodbuff"

/datum/status_effect/buff/mealbuff/on_apply()
	. = ..()
	owner.add_stress(/datum/stressevent/goodmeal)
	if(owner.has_status_effect(/datum/status_effect/buff/greatmealbuff))
		owner.remove_status_effect(/datum/status_effect/buff/mealbuff)

/datum/status_effect/buff/greatmealbuff
	id = "greatmeal"
	alert_type = /atom/movable/screen/alert/status_effect/buff/greatmealbuff
	effectedstats = list("constitution" = 1, "endurance" = 1)
	duration = 30 MINUTES

/atom/movable/screen/alert/status_effect/buff/greatmealbuff
	name = "Great meal!"
	desc = "That meal was something akin to a noble's feast! It's bound to keep me energized for an entire day."
	icon_state = "foodbuff"

/datum/status_effect/buff/greatmealbuff/on_apply()
	. = ..()
	owner.add_stress(/datum/stressevent/greatmeal)
	if(owner.has_status_effect(/datum/status_effect/buff/mealbuff))
		owner.remove_status_effect(/datum/status_effect/buff/mealbuff) //can't stack two meal buffs, it'll keep the highest one

/datum/status_effect/buff/sweet
	id = "sugar"
	alert_type = /atom/movable/screen/alert/status_effect/buff/sweet
	effectedstats = list("fortune" = 1)
	duration = 8 MINUTES

/atom/movable/screen/alert/status_effect/buff/sweet
	name = "Sweet embrace"
	desc = "Sweets are always a sign of good luck, everything goes well when you eat some of them."
	icon_state = "foodbuff"

/datum/status_effect/buff/sweet/on_apply()
	. = ..()
	owner.add_stress(/datum/stressevent/sweet)

/datum/status_effect/buff/druqks
	id = "druqks"
	alert_type = /atom/movable/screen/alert/status_effect/buff/druqks
	effectedstats = list("intelligence" = 5,"speed" = 3,"fortune" = -5)
	duration = 10 SECONDS

/datum/status_effect/buff/druqks/on_apply()
	. = ..()
	owner.add_stress(/datum/stressevent/high)
	if(owner?.client)
		if(owner.client.screen && owner.client.screen.len)
			var/atom/movable/screen/plane_master/game_world/PM = locate(/atom/movable/screen/plane_master/game_world) in owner.client.screen
			PM.backdrop(owner)
			PM = locate(/atom/movable/screen/plane_master/game_world_fov_hidden) in owner.client.screen
			PM.backdrop(owner)
			PM = locate(/atom/movable/screen/plane_master/game_world_above) in owner.client.screen
			PM.backdrop(owner)

/datum/status_effect/buff/druqks/on_remove()
	owner.remove_stress(/datum/stressevent/high)
	if(owner?.client)
		if(owner.client.screen && owner.client.screen.len)
			var/atom/movable/screen/plane_master/game_world/PM = locate(/atom/movable/screen/plane_master/game_world) in owner.client.screen
			PM.backdrop(owner)
			PM = locate(/atom/movable/screen/plane_master/game_world_fov_hidden) in owner.client.screen
			PM.backdrop(owner)
			PM = locate(/atom/movable/screen/plane_master/game_world_above) in owner.client.screen
			PM.backdrop(owner)

	. = ..()

/atom/movable/screen/alert/status_effect/buff/druqks
	name = "High"
	desc = ""
	icon_state = "acid"

/datum/status_effect/buff/eoradruqks
	id = "druqks"
	alert_type = /atom/movable/screen/alert/status_effect/buff/druqks
	effectedstats = list("speed" = -3,"fortune" = -5, "constitution" = -2)
	duration = 20 SECONDS

/datum/status_effect/buff/eoradruqks/on_apply()
	. = ..()
	owner.add_movespeed_modifier("eoraslowdown", multiplicative_slowdown = 2)
	owner.add_stress(/datum/stressevent/high)
	if(owner?.client)
		if(owner.client.screen && owner.client.screen.len)
			var/atom/movable/screen/plane_master/game_world/PM = locate(/atom/movable/screen/plane_master/game_world) in owner.client.screen
			PM.backdrop(owner)
			PM = locate(/atom/movable/screen/plane_master/game_world_fov_hidden) in owner.client.screen
			PM.backdrop(owner)
			PM = locate(/atom/movable/screen/plane_master/game_world_above) in owner.client.screen
			PM.backdrop(owner)

/datum/status_effect/buff/eoradruqks/on_remove()
	owner.remove_stress(/datum/stressevent/high)
	owner.remove_movespeed_modifier("eoraslowdown")
	if(owner?.client)
		if(owner.client.screen && owner.client.screen.len)
			var/atom/movable/screen/plane_master/game_world/PM = locate(/atom/movable/screen/plane_master/game_world) in owner.client.screen
			PM.backdrop(owner)
			PM = locate(/atom/movable/screen/plane_master/game_world_fov_hidden) in owner.client.screen
			PM.backdrop(owner)
			PM = locate(/atom/movable/screen/plane_master/game_world_above) in owner.client.screen
			PM.backdrop(owner)

	. = ..()

/datum/status_effect/buff/ozium
	id = "ozium"
	alert_type = /atom/movable/screen/alert/status_effect/buff/druqks
	effectedstats = list("speed" = -5, "perception" = 2)
	duration = 30 SECONDS

/datum/status_effect/buff/ozium/on_apply()
	. = ..()
	owner.add_stress(/datum/stressevent/ozium)
	ADD_TRAIT(owner, TRAIT_NOPAIN, TRAIT_GENERIC)

/datum/status_effect/buff/ozium/on_remove()
	owner.remove_stress(/datum/stressevent/ozium)
	REMOVE_TRAIT(owner, TRAIT_NOPAIN, TRAIT_GENERIC)
	. = ..()

/datum/status_effect/buff/moondust
	id = "moondust"
	alert_type = /atom/movable/screen/alert/status_effect/buff/druqks
	effectedstats = list("speed" = 4, "endurance" = 4, "perception" = -3)
	duration = 30 SECONDS

/datum/status_effect/buff/moondust/on_apply()
	. = ..()
	owner.add_stress(/datum/stressevent/moondust)

/datum/status_effect/buff/moondust/on_remove()
	. = ..()
	owner.apply_status_effect(/datum/status_effect/debuff/moondust_crash)


/datum/status_effect/buff/moondust_purest
	id = "purest moondust"
	alert_type = /atom/movable/screen/alert/status_effect/buff/druqks
	effectedstats = list("speed" = 5, "endurance" = 5, "perception" = -2)
	duration = 40 SECONDS

/datum/status_effect/buff/moondust_purest/on_apply()
	. = ..()
	owner.add_stress(/datum/stressevent/moondust_purest)

/datum/status_effect/buff/moondust_purest/on_remove()
	. = ..()
	owner.apply_status_effect(/datum/status_effect/debuff/moondust_crash)

/datum/status_effect/buff/weed
	id = "weed"
	alert_type = /atom/movable/screen/alert/status_effect/buff/weed
	effectedstats = list("intelligence" = 2,"speed" = -2,"fortune" = 2)
	duration = 10 SECONDS

/datum/status_effect/buff/weed/on_apply()
	. = ..()
	owner.add_stress(/datum/stressevent/weed)
	if(owner?.client)
		if(owner.client.screen && owner.client.screen.len)
			var/atom/movable/screen/plane_master/game_world/PM = locate(/atom/movable/screen/plane_master/game_world) in owner.client.screen
			PM.backdrop(owner)
			PM = locate(/atom/movable/screen/plane_master/game_world_fov_hidden) in owner.client.screen
			PM.backdrop(owner)
			PM = locate(/atom/movable/screen/plane_master/game_world_above) in owner.client.screen
			PM.backdrop(owner)

/datum/status_effect/buff/weed/on_remove()
	if(owner?.client)
		if(owner.client.screen && owner.client.screen.len)
			var/atom/movable/screen/plane_master/game_world/PM = locate(/atom/movable/screen/plane_master/game_world) in owner.client.screen
			PM.backdrop(owner)
			PM = locate(/atom/movable/screen/plane_master/game_world_fov_hidden) in owner.client.screen
			PM.backdrop(owner)
			PM = locate(/atom/movable/screen/plane_master/game_world_above) in owner.client.screen
			PM.backdrop(owner)

	. = ..()

/atom/movable/screen/alert/status_effect/buff/weed
	name = "Dazed"
	desc = ""
	icon_state = "weed"

/atom/movable/screen/alert/status_effect/buff/featherfall
	name = "Featherfall"
	desc = "I am somewhat protected against falling from heights."
	icon_state = "buff"

/datum/status_effect/buff/featherfall
	id = "featherfall"
	alert_type = /atom/movable/screen/alert/status_effect/buff/featherfall
	duration = 1 MINUTES

/datum/status_effect/buff/featherfall/on_apply()
	. = ..()
	to_chat(owner, span_warning("I feel lighter."))
	ADD_TRAIT(owner, TRAIT_NOFALLDAMAGE1, MAGIC_TRAIT)

/datum/status_effect/buff/featherfall/on_remove()
	. = ..()
	to_chat(owner, span_warning("The feeling of lightness fades."))
	REMOVE_TRAIT(owner, TRAIT_NOFALLDAMAGE1, MAGIC_TRAIT)

/atom/movable/screen/alert/status_effect/buff/darkvision
	name = "Darkvision"
	desc = "I can see in the dark somewhat."
	icon_state = "buff"

/datum/status_effect/buff/darkvision
	id = "darkvision"
	alert_type = /atom/movable/screen/alert/status_effect/buff/darkvision
	duration = 10 MINUTES

/datum/status_effect/buff/darkvision/on_apply()
	. = ..()
	to_chat(owner, span_warning("The darkness fades somewhat."))
	if(HAS_TRAIT(owner, TRAIT_DARKVISION))
		ADD_TRAIT(owner, TRAIT_DARKVISION_BETTER, MAGIC_TRAIT)
	else if(HAS_TRAIT(owner, TRAIT_NOCTURNAL))
		ADD_TRAIT(owner, TRAIT_DARKVISION_BETTER, MAGIC_TRAIT)
	else
		ADD_TRAIT(owner, TRAIT_DARKVISION, MAGIC_TRAIT)

/datum/status_effect/buff/darkvision/on_remove()
	. = ..()
	to_chat(owner, span_warning("The darkness returns to normal."))
	if(HAS_TRAIT(owner, TRAIT_DARKVISION_BETTER))
		REMOVE_TRAIT(owner, TRAIT_DARKVISION_BETTER, MAGIC_TRAIT)
	else
		REMOVE_TRAIT(owner, TRAIT_DARKVISION, MAGIC_TRAIT)

/atom/movable/screen/alert/status_effect/buff/haste
	name = "Haste"
	desc = "I am magically hastened."
	icon_state = "buff"

/datum/status_effect/buff/haste
	id = "haste"
	alert_type = /atom/movable/screen/alert/status_effect/buff/haste
	effectedstats = list("speed" = 3)
	duration = 1.5 MINUTES

/atom/movable/screen/alert/status_effect/buff/enlarge
	name = "Enlarged"
	desc = "I am magically enlarged."
	icon_state = "buff"

/datum/status_effect/buff/enlarge
	id = "enlarge"
	alert_type = /atom/movable/screen/alert/status_effect/buff/enlarge
	effectedstats = list("strength" = 2,"constitution" = 2, "speed" = -2)
	duration = 1.5 MINUTES

/datum/status_effect/buff/enlarge/on_apply()
	. = ..()
	if(!(isseelie(owner)))
		to_chat(owner, span_warning("I feel myself growing leaps and bounds!"))
		ADD_TRAIT(owner, TRAIT_DEATHBYSNUSNU, MAGIC_TRAIT)
		owner.transform = owner.transform.Scale(1.25, 1.25)
		owner.transform = owner.transform.Translate(0, (0.25 * 16))
		owner.mob_size += 1
		owner.update_transform()
	else
		to_chat(owner, span_warning("I can feel arcyne magick supplement my tiny frame!"))
		
	


/datum/status_effect/buff/enlarge/on_remove()
	. = ..()   
	if(!(isseelie(owner)))
		to_chat(owner, span_warning("I feel myself shrinking again.."))
		REMOVE_TRAIT(owner, TRAIT_DEATHBYSNUSNU, MAGIC_TRAIT) 
		owner.transform = owner.transform.Translate(0, -(0.25 * 16))
		owner.transform = owner.transform.Scale(1/1.25, 1/1.25)
		owner.mob_size -= 1  
		owner.update_transform()
	else
		to_chat(owner, span_warning("I can feel the strengthening magicks fade from my small body.."))
	

/datum/status_effect/buff/seelie_drugs
	id = "seelie drugs"
	alert_type = /atom/movable/screen/alert/status_effect/buff/druqks
	effectedstats = list("intelligence" = 2, "endurance" = 4, "speed" = -3)
	duration = 20 SECONDS

/atom/movable/screen/alert/status_effect/buff/seelie_drugs
	name = "High"
	desc = ""
	icon_state = "acid"

/datum/status_effect/buff/seelie_drugs/on_apply()
	. = ..()
	owner.add_stress(/datum/stressevent/high)
	if(owner?.client)
		if(owner.client.screen && owner.client.screen.len)
			var/atom/movable/screen/plane_master/game_world/PM = locate(/atom/movable/screen/plane_master/game_world) in owner.client.screen
			PM.backdrop(owner)
			PM = locate(/atom/movable/screen/plane_master/game_world_fov_hidden) in owner.client.screen
			PM.backdrop(owner)
			PM = locate(/atom/movable/screen/plane_master/game_world_above) in owner.client.screen
			PM.backdrop(owner)

/datum/status_effect/buff/seelie_drugs/on_remove()
	owner.remove_stress(/datum/stressevent/high)
	if(owner?.client)
		if(owner.client.screen && owner.client.screen.len)
			var/atom/movable/screen/plane_master/game_world/PM = locate(/atom/movable/screen/plane_master/game_world) in owner.client.screen
			PM.backdrop(owner)
			PM = locate(/atom/movable/screen/plane_master/game_world_fov_hidden) in owner.client.screen
			PM.backdrop(owner)
			PM = locate(/atom/movable/screen/plane_master/game_world_above) in owner.client.screen
			PM.backdrop(owner)
	. = ..()

/datum/status_effect/buff/seelie/happy
	id = "Seelie Blessing"
	alert_type = /atom/movable/screen/alert/status_effect/buff/seelie/happy
	effectedstats = list("fortune" = 2)
	duration = 60 SECONDS

/atom/movable/screen/alert/status_effect/buff/seelie/happy
	name = "Seelie Blessing"
	desc = "A nearby Seelie has brought me fortune."
	icon_state = "stressg"


/datum/status_effect/buff/magicknowledge
	id = "intelligence"
	alert_type = /atom/movable/screen/alert/status_effect/buff/knowledge
	effectedstats = list("intelligence" = 2)
	duration = 10 MINUTES

/atom/movable/screen/alert/status_effect/buff/knowledge
	name = "runic cunning"
	desc = "I am magically astute."
	icon_state = "buff"

/datum/status_effect/buff/magicstrength
	id = "strength"
	alert_type = /atom/movable/screen/alert/status_effect/buff/strength
	effectedstats = list("strength" = 3)
	duration = 20 MINUTES

/atom/movable/screen/alert/status_effect/buff/strength
	name = "arcane reinforced strength"
	desc = "I am magically strengthened."
	icon_state = "buff"

/datum/status_effect/buff/magicstrength/lesser
	id = "lesser strength"
	alert_type = /atom/movable/screen/alert/status_effect/buff/strength/lesser
	effectedstats = list("strength" = 1)
	duration = 20 MINUTES

/atom/movable/screen/alert/status_effect/buff/strength/lesser
	name = "lesser arcane strength"
	desc = "I am magically strengthened."
	icon_state = "buff"


/datum/status_effect/buff/magicspeed
	id = "speed"
	alert_type = /atom/movable/screen/alert/status_effect/buff/speed
	effectedstats = list("speed" = 3)
	duration = 20 MINUTES

/atom/movable/screen/alert/status_effect/buff/speed
	name = "arcane swiftness"
	desc = "I am magically swift."
	icon_state = "buff"

/datum/status_effect/buff/magicspeed/lesser
	id = "lesser speed"
	alert_type = /atom/movable/screen/alert/status_effect/buff/speed/lesser
	effectedstats = list("speed" = 1)
	duration = 20 MINUTES

/atom/movable/screen/alert/status_effect/buff/speed/lesser
	name = "arcane swiftness"
	desc = "I am magically swift."
	icon_state = "buff"

/datum/status_effect/buff/magicendurance
	id = "endurance"
	alert_type = /atom/movable/screen/alert/status_effect/buff/endurance
	effectedstats = list("endurance" = 3)
	duration = 20 MINUTES

/atom/movable/screen/alert/status_effect/buff/endurance
	name = "arcane endurance"
	desc = "I am magically resilient."
	icon_state = "buff"

/datum/status_effect/buff/magicendurance/lesser
	id = "lesser endurance"
	alert_type = /atom/movable/screen/alert/status_effect/buff/endurance/lesser
	effectedstats = list("endurance" = 1)
	duration = 20 MINUTES

/atom/movable/screen/alert/status_effect/buff/endurance/lesser
	name = "lesser arcane endurance"
	desc = "I am magically resilient."
	icon_state = "buff"


/datum/status_effect/buff/magicconstitution
	id = "constitution"
	alert_type = /atom/movable/screen/alert/status_effect/buff/constitution
	effectedstats = list("constitution" = 3)
	duration = 20 MINUTES

/atom/movable/screen/alert/status_effect/buff/constitution
	name = "arcane constitution"
	desc = "I feel reinforced by magick."
	icon_state = "buff"

/datum/status_effect/buff/magicconstitution/lesser
	id = "lesser constitution"
	alert_type = /atom/movable/screen/alert/status_effect/buff/constitution/lesser
	effectedstats = list("constitution" = 1)
	duration = 20 MINUTES

/atom/movable/screen/alert/status_effect/buff/constitution/lesser
	name = "lesser arcane constitution"
	desc = "I feel reinforced by magick."
	icon_state = "buff"

/datum/status_effect/buff/magicperception
	id = "perception"
	alert_type = /atom/movable/screen/alert/status_effect/buff/perception
	effectedstats = list("perception" = 3)
	duration = 20 MINUTES

/atom/movable/screen/alert/status_effect/buff/perception
	name = "arcane perception"
	desc = "I can see everything."
	icon_state = "buff"

/datum/status_effect/buff/magicperception/lesser
	id = "lesser perception"
	alert_type = /atom/movable/screen/alert/status_effect/buff/perception/lesser
	effectedstats = list("perception" = 1)
	duration = 20 MINUTES

/atom/movable/screen/alert/status_effect/buff/perception/lesser
	name = "lesser arcane perception"
	desc = "I can see somethings."
	icon_state = "buff"

/datum/status_effect/buff/nocblessing
	id = "nocblessing"
	alert_type = /atom/movable/screen/alert/status_effect/buff/nocblessing
	effectedstats = list("intelligence" = 1)
	duration = 30 MINUTES

/atom/movable/screen/alert/status_effect/buff/nocblessing
	name = "Noc's blessing"
	desc = "Gazing Noc helps me think."
	icon_state = "buff"
/datum/status_effect/buff/darkling_darkly
	id = "Darkling"
	alert_type =  /atom/movable/screen/alert/status_effect/buff/darkling_darkly
	effectedstats = list("perception" = 1)
	duration = 5 SECONDS

/atom/movable/screen/alert/status_effect/buff/darkling_darkly
	name = "Darkling"
	desc = "You are at home in the dark. Unbothered. In your lane. Moisturized."
	icon_state = "stressg"


/datum/status_effect/buff/greatermanabuff
	id = "greatermanabuff"
	alert_type = /atom/movable/screen/alert/status_effect/buff/greatermanabuff
	effectedstats = list("speed" = 2, "intelligence" = 2)
	duration = 20 SECONDS

/atom/movable/screen/alert/status_effect/buff/greatermanabuff
	name = "Greater Mana use"
	desc = "My body feels well rested and i feel smarter."
	icon_state = "muscles"

/datum/status_effect/buff/sermon
	id = "sermon"
	alert_type = /atom/movable/screen/alert/status_effect/buff/sermon
	effectedstats = list("fortune" = 1, "constitution" = 1)
	duration = 20 MINUTES

/atom/movable/screen/alert/status_effect/buff/sermon
	name = "sermon"
	desc = "I feel inspired by the sermon!"
	icon_state = "buff"

/datum/status_effect/buff/gazeuponme
	id = "gazeuponme"
	alert_type = /atom/movable/screen/alert/status_effect/buff/gazeuponme
	effectedstats = list("speed" = 1, "intelligence" = 1)
	duration = 999 MINUTES

/atom/movable/screen/alert/status_effect/buff/gazeuponme
	name = "Excommunicated heretic"
	desc = "My PATRON is proud of ME!"
	icon_state = "buff"

/datum/status_effect/buff/maameat
    id = "maameat"
    alert_type = /atom/movable/screen/alert/status_effect/buff/maameat
    effectedstats = list("endurance" = 1)
    duration = -1 // permanent

/atom/movable/screen/alert/status_effect/buff/maameat
    name = "Man-at-Arms Flesh"
    desc = "The flesh of a Man-at-Arms, granting an increase in endurance."
    icon_state = "meatsteak"

/datum/status_effect/buff/templarmeat
    id = "templarmeat"
    alert_type = /atom/movable/screen/alert/status_effect/buff/templarmeat
    effectedstats = list("constitution" = 1)
    duration = -1 // permanent

/atom/movable/screen/alert/status_effect/buff/templarmeat
    name = "Templar Flesh"
    desc = "The flesh of a Templar, granting a boost to constitution."
    icon_state = "meatsteak"

/datum/status_effect/buff/watchmanmeat
    id = "watchmanmeat"
    alert_type = /atom/movable/screen/alert/status_effect/buff/watchmanmeat
    effectedstats = list("perception" = 1)
    duration = -1 // permanent

/atom/movable/screen/alert/status_effect/buff/watchmanmeat
    name = "Watchman Flesh"
    desc = "The flesh of a Watchman, granting an increase in perception."
    icon_state = "meatsteak"

/datum/status_effect/buff/vanguardmeat
    id = "vanguardmeat"
    alert_type = /atom/movable/screen/alert/status_effect/buff/vanguardmeat
    effectedstats = list("speed" = 1)
    duration = -1 // permanent

/atom/movable/screen/alert/status_effect/buff/vanguardmeat
    name = "Vanguard Flesh"
    desc = "The flesh of a Vanguard, granting a boost in speed."
    icon_state = "meatsteak"

/datum/status_effect/buff/knightmeat
    id = "knightmeat"
    alert_type = /atom/movable/screen/alert/status_effect/buff/knightmeat
    effectedstats = list("strength" = 1)
    duration = -1 // permanent

/atom/movable/screen/alert/status_effect/buff/knightmeat
    name = "Knight Flesh"
    desc = "The flesh of a Knight, granting an increase in strength."
    icon_state = "meatsteak"

/datum/status_effect/buff/priestmeat
    id = "priestmeat"
    alert_type = /atom/movable/screen/alert/status_effect/buff/priestmeat
    effectedstats = list("intelligence" = 2)
    duration = -1 // permanent

/atom/movable/screen/alert/status_effect/buff/priestmeat
    name = "Priest Flesh"
    desc = "The flesh of a Priest, granting a boost to intelligence."
    icon_state = "meatsteak"

/datum/status_effect/buff/royalmeat
    id = "royalmeat"
    alert_type = /atom/movable/screen/alert/status_effect/buff/royalmeat
    effectedstats = list("fortune" = 3)
    duration = -1 // permanent

/atom/movable/screen/alert/status_effect/buff/royalmeat
    name = "Royal Flesh"
    desc = "The flesh of royalty, granting an increase in luck."
    icon_state = "meatsteak"

/atom/movable/screen/alert/status_effect/buff/healing
	name = "Healing Miracle"
	desc = "Divine intervention relieves me of my ailments."
	icon_state = "buff"

/datum/status_effect/buff/healing
	id = "healing"
	alert_type = /atom/movable/screen/alert/status_effect/buff/healing
	duration = 10 SECONDS
	examine_text = "They are bathed in a restorative aura!"
	var/healing_on_tick = 1

/datum/status_effect/buff/healing/on_creation(mob/living/new_owner, new_healing_on_tick)
	healing_on_tick = new_healing_on_tick
	return ..()

/datum/status_effect/buff/healing/tick()
	var/obj/effect/temp_visual/heal_rogue/H = new /obj/effect/temp_visual/heal_rogue(get_turf(owner))
	H.color = "#FFD700"
	if(owner.blood_volume < BLOOD_VOLUME_NORMAL)
		owner.blood_volume = min(owner.blood_volume+10, BLOOD_VOLUME_NORMAL)
	if(length(owner.get_wounds()))
		owner.heal_wounds(healing_on_tick)
		owner.update_damage_overlays()
	owner.adjustBruteLoss(-healing_on_tick, 0)
	owner.adjustFireLoss(-healing_on_tick, 0)
	owner.adjustOxyLoss(-healing_on_tick, 0)
	owner.adjustToxLoss(-healing_on_tick, 0)
	owner.adjustOrganLoss(ORGAN_SLOT_BRAIN, -healing_on_tick)
	owner.adjustCloneLoss(-healing_on_tick, 0)

/datum/status_effect/buff/vitae
	id = "druqks"
	alert_type = /atom/movable/screen/alert/status_effect/buff/vitae
	effectedstats = list("fortune" = 2)
	duration = 10 SECONDS

/datum/status_effect/buff/vitae/on_apply()
	. = ..()
	owner.add_stress(/datum/stressevent/high)

/datum/status_effect/buff/vitae/on_remove()
	owner.remove_stress(/datum/stressevent/high)
	. = ..()

/atom/movable/screen/alert/status_effect/buff/vitae
	name = "Invigorated"
	desc = "I have supped on the finest of delicacies: life!"