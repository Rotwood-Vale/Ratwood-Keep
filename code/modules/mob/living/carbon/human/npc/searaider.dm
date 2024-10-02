GLOBAL_LIST_INIT(searaider_quotes, world.file2list("strings/rt/searaiderlines.txt"))
GLOBAL_LIST_INIT(searaider_aggro, world.file2list("strings/rt/searaideraggrolines.txt"))

/mob/living/carbon/human/species/human/northern/searaider
	aggressive=1
	mode = AI_IDLE
	faction = list("viking", "station")
	ambushable = FALSE
	dodgetime = 30
	flee_in_pain = TRUE
	possible_rmb_intents = list()


/mob/living/carbon/human/species/human/northern/searaider/ambush
	aggressive=1

	wander = TRUE

/mob/living/carbon/human/species/human/northern/searaider/brute

/mob/living/carbon/human/species/human/northern/searaider/brute/after_creation()
	equipOutfit(new /datum/outfit/job/roguetown/human/species/human/northern/searaider/brute)


/mob/living/carbon/human/species/human/northern/searaider/retaliate(mob/living/L)
	var/newtarg = target
	.=..()
	if(target)
		aggressive=1
		wander = TRUE
		if(target != newtarg)
			say(pick(GLOB.searaider_aggro))
			linepoint(target)

/mob/living/carbon/human/species/human/northern/searaider/should_target(mob/living/L)
	if(L.stat != CONSCIOUS)
		return FALSE
	. = ..()

/mob/living/carbon/human/species/human/northern/searaider/Initialize()
	. = ..()
	set_species(/datum/species/human/northern)
	spawn(10)
		after_creation()
	//addtimer(CALLBACK(src, PROC_REF(after_creation)), 10)


/mob/living/carbon/human/species/human/northern/searaider/after_creation()
	..()
	job = "Sea Raider"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOROGSTAM, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/roguetown/human/species/human/northern/searaider)
	var/obj/item/organ/eyes/organ_eyes = getorgan(/obj/item/organ/eyes)
	if(organ_eyes)
		organ_eyes.eye_color = pick("27becc", "35cc27", "000000")
	update_hair()
	update_body()

/mob/living/carbon/human/species/human/northern/searaider/npc_idle()
	if(m_intent == MOVE_INTENT_SNEAK)
		return
	if(world.time < next_idle)
		return
	next_idle = world.time + rand(30, 70)
	if((mobility_flags & MOBILITY_MOVE) && isturf(loc) && wander)
		if(prob(20))
			var/turf/T = get_step(loc,pick(GLOB.cardinals))
			if(!istype(T, /turf/open/transparent/openspace))
				Move(T)
		else
			face_atom(get_step(src,pick(GLOB.cardinals)))
	if(!wander && prob(10))
		face_atom(get_step(src,pick(GLOB.cardinals)))
	if(prob(12))
		say(pick(GLOB.searaider_quotes))
	if(prob(12))
		emote(pick("laugh","burp","yawn","grumble","mumble","blink_r","clap"))

/mob/living/carbon/human/species/human/northern/searaider/handle_combat()
	if(mode == AI_HUNT)
		if(prob(50))
			emote("rage")
	. = ..()

/datum/outfit/job/roguetown/human/species/human/northern/searaider/pre_equip(mob/living/carbon/human/H)
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	if(prob(50))
		wrists = /obj/item/clothing/wrists/roguetown/bracers
	armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant
	if(prob(50))
		shirt = /obj/item/clothing/suit/roguetown/shirt/tunic
	pants = /obj/item/clothing/under/roguetown/tights
	head = /obj/item/clothing/head/roguetown/helmet/leather
	if(prob(50))
		head = /obj/item/clothing/head/roguetown/helmet/horned
	H.STASPD = 8
	H.STACON = 4
	H.STAEND = 15
	H.STAINT = 1
	H.STASTR = rand(11,16)
	if(prob(50))
		r_hand = /obj/item/rogueweapon/sword
	else
		r_hand = /obj/item/rogueweapon/stoneaxe/battle
	l_hand = /obj/item/rogueweapon/shield/wood
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	if(prob(30))
		neck = /obj/item/clothing/neck/roguetown/chaincoif
		H.eye_color = pick("27becc", "35cc27", "000000")
	H.hair_color = pick ("4f4f4f", "61310f", "faf6b9")
	H.facial_hair_color = H.hair_color
	if(H.gender == MALE)
		H.name = pick( world.file2list("strings/rt/names/human/vikingnamesm.txt") )
		H.real_name = H.name
	else
		H.name = pick( world.file2list("strings/rt/names/human/vikingnamesf.txt") )
		H.real_name = H.name

/datum/outfit/job/roguetown/human/species/human/northern/searaider/brute/pre_equip(mob/living/carbon/human/H)
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
	shirt = /obj/item/clothing/suit/roguetown/shirt/tunic
	pants = /obj/item/clothing/under/roguetown/chainlegs
	head = /obj/item/clothing/head/roguetown/helmet
	if(prob(50))
		head = /obj/item/clothing/head/roguetown/helmet/horned
	if(prob(60))
		mask = /obj/item/clothing/mask/rogue/facemask
	gloves = /obj/item/clothing/gloves/roguetown/chain
	H.STASPD = 9
	H.STACON = 8
	H.STAEND = 15
	H.STAINT = 1
	H.STASTR = rand(15,18)
	if(prob(50))
		r_hand = /obj/item/rogueweapon/halberd/bardiche
	else
		r_hand = /obj/item/rogueweapon/greatsword
	shoes = /obj/item/clothing/shoes/roguetown/boots/armoriron
	neck = /obj/item/clothing/neck/roguetown/chaincoif
	if(H.gender == MALE)
		H.name = pick( world.file2list("strings/rt/names/human/vikingnamesm.txt") )
		H.real_name = H.name
	else
		H.name = pick( world.file2list("strings/rt/names/human/vikingnamesf.txt") )
		H.real_name = H.name


/mob/living/simple_animal/hostile/retaliate/rogue/searaider
	name = "northern archer"
	desc = ""
	icon = 'modular_hearthstone/icons/mob/simple_orcs.dmi'
	icon_state = "northarcher"
	icon_living = "northarcher"
	icon_dead = "northarcher_dead"
	gender = MALE
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID|MOB_BEAST
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES
	robust_searching = 1
	speak_chance = 5
	turns_per_move = 1
	move_to_delay = 3
	STACON = 9
	STASTR = 14
	STASPD = 13
	maxHealth = 120
	health = 120
	harm_intent_damage = 15
	melee_damage_lower = 25
	melee_damage_upper = 30
	vision_range = 7
	aggro_vision_range = 9
	projectiletype = /obj/projectile/bullet/reusable/arrow/orc
	projectilesound = 'sound/combat/Ranged/flatbow-shot-01.ogg'
	ranged = 1
	retreat_distance = 2
	minimum_distance = 5
	check_friendly_fire = 1
	base_intents = list(/datum/intent/simple/axe)
	attack_verb_continuous = "hacks"
	attack_verb_simple = "hack"
	attack_sound = 'sound/blank.ogg'
	canparry = TRUE
	d_intent = INTENT_PARRY
	defprob = 50
	defdrain = 20
	obj_damage = 1
	speak_emote = list("grunts")
	loot = list(/obj/effect/mob_spawn/human/searaider/archer,
			/obj/item/gun/ballistic/revolver/grenadelauncher/bow,
			/obj/item/quiver/arrows,
			/obj/effect/decal/cleanable/blood)
	faction = list("viking")
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	del_on_death = TRUE
	butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 3,
						/obj/item/natural/hide = 2, /obj/item/natural/bundle/bone/full = 1)
	aggressive = 1
	patron = /datum/patron/inhumen/graggar


/mob/living/simple_animal/hostile/retaliate/rogue/searaider/simple_limb_hit(zone)
	if(!zone)
		return ""
	switch(zone)
		if(BODY_ZONE_PRECISE_R_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_L_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_NOSE)
			return "nose"
		if(BODY_ZONE_PRECISE_MOUTH)
			return "mouth"
		if(BODY_ZONE_PRECISE_SKULL)
			return "head"
		if(BODY_ZONE_PRECISE_EARS)
			return "head"
		if(BODY_ZONE_PRECISE_NECK)
			return "neck"
		if(BODY_ZONE_PRECISE_L_HAND)
			return "foreleg"
		if(BODY_ZONE_PRECISE_R_HAND)
			return "foreleg"
		if(BODY_ZONE_PRECISE_L_FOOT)
			return "leg"
		if(BODY_ZONE_PRECISE_R_FOOT)
			return "leg"
		if(BODY_ZONE_PRECISE_STOMACH)
			return "stomach"
		if(BODY_ZONE_PRECISE_GROIN)
			return "tail"
		if(BODY_ZONE_HEAD)
			return "head"
		if(BODY_ZONE_R_LEG)
			return "leg"
		if(BODY_ZONE_L_LEG)
			return "leg"
		if(BODY_ZONE_R_ARM)
			return "foreleg"
		if(BODY_ZONE_L_ARM)
			return "foreleg"
	return ..()

/mob/living/simple_animal/hostile/retaliate/rogue/searaider/get_sound(input)
	switch(input)
		if("aggro")
			return pick('sound/vo/male/gen/rage (1).ogg','sound/vo/male/gen/rage (2).ogg', 'sound/vo/male/gen/maleconqrah.ogg', 'sound/vo/attn.ogg')
		if("pain")
			return pick('sound/vo/male/gen/pain (1).ogg','sound/vo/male/gen/pain (2).ogg','sound/vo/male/gen/pain (3).ogg', 'sound/vo/male/gen/painmoan (2).ogg', 'sound/vo/male/gen/painmoan (1).ogg')
		if("death")
			return pick('sound/vo/mobs/northman/northman_death (1).ogg','sound/vo/mobs/northman/northman_death (2).ogg','sound/vo/mobs/northman/northman_death (3).ogg',
			'sound/vo/mobs/northman/northman_death (4).ogg')
		if("idle")
			return pick('sound/vo/male/gen/hum (1).ogg','sound/vo/male/gen/hum (2).ogg', 'sound/vo/male/gen/laugh (1).ogg','sound/vo/male/gen/laugh (3).ogg', 'sound/vo/male/gen/yawn (1).ogg')


/mob/living/simple_animal/hostile/retaliate/rogue/searaider/Life()
	. = ..()
	if(!target)
		if(prob(3))
			emote(pick("idle"), TRUE)


/mob/living/simple_animal/hostile/retaliate/rogue/searaider/taunted(mob/user)
	emote("aggro")
	GiveTarget(user)
	return