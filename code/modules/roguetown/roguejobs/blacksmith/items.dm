
/obj/item/roguestatue
	icon = 'icons/roguetown/items/valuable.dmi'
	name = "statue"
	icon_state = ""
	w_class = WEIGHT_CLASS_NORMAL
	smeltresult = null

/obj/item/roguestatue/gold
	name = "gold statue"
	desc = "Made of heavy, gleaming gold!"
	icon_state = "gstatue1"
	smeltresult = /obj/item/ingot/gold
	sellprice = 120

/obj/item/roguestatue/gold/Initialize()
	. = ..()
	icon_state = "gstatue[pick(1,2)]"

/obj/item/roguestatue/gold/loot
	name = "gold statuette"
	desc = "Made of heavy, gleaming gold!"
	icon_state = "lstatue1"
	sellprice = 45

/obj/item/roguestatue/gold/loot/Initialize()
	. = ..()
	sellprice = rand(45,100)
	icon_state = "lstatue[pick(1,2)]"

/obj/item/roguestatue/silver
	name = "silver statue"
	desc = "Made of pure, shimmering silver!"
	icon_state = "sstatue1"
	smeltresult = /obj/item/ingot/silver
	sellprice = 90

/obj/item/roguestatue/silver/Initialize()
	. = ..()
	icon_state = "sstatue[pick(1,2)]"

/obj/item/roguestatue/steel
	name = "steel statue"
	desc = "An unyielding statue of resilient steel."
	icon_state = "ststatue1"
	smeltresult = /obj/item/ingot/steel
	sellprice = 60

/obj/item/roguestatue/steel/Initialize()
	. = ..()
	icon_state = "ststatue[pick(1,2)]"

/obj/item/roguestatue/iron
	name = "iron statue"
	desc = "A forged statue of cast iron!"
	icon_state = "istatue1"
	smeltresult = /obj/item/ingot/iron
	sellprice = 40

/obj/item/roguestatue/iron/Initialize()
	. = ..()
	icon_state = "istatue[pick(1,2)]"


//000000000000000000000000000--

/obj/item/roguegear
	icon = 'icons/roguetown/items/misc.dmi'
	name = "cog"
	desc = "A cog with teeth meticulously crafted for tight interlocking."
	icon_state = "gear"
	w_class = WEIGHT_CLASS_SMALL
	smeltresult = null
	var/obj/structure/linking

/obj/item/roguegear/Destroy()
	if(linking)
		linking = null
	. = ..()

/obj/item/roguegear/attack_self(mob/user)
	if(linking)
		linking = null
		to_chat(user, span_warning("Linking halted."))
		return

/obj/item/roguegear/attack_obj(obj/O, mob/living/user)
	if(!istype(O, /obj/structure))
		return ..()
	var/obj/structure/S = O
	if(linking)
		if(linking == O)
			to_chat(user, span_warning("You cannot link me to myself."))
			return
		if(linking in S.redstone_attached)
			to_chat(user, span_warning("Already linked."))
			linking = null
			return
		S.redstone_attached |= linking
		linking.redstone_attached |= S
		linking = null
		to_chat(user, span_notice("Link complete."))
		return
	else
		linking = S
		to_chat(user, span_info("Link beginning..."))
		return
	..()

/obj/item/var/polished = FALSE

/obj/item/examine(mob/user)
	. = ..()
	switch(polished)
		if(1)
			. += span_info("It has some polishing compound on it.")
		if(2 || 3)
			. += span_info("It's been thoroughly brushed.")
		if(4)
			. += span_green("It's been nicely polished.")

/obj/item/polishing_cream
	icon = 'icons/roguetown/items/misc.dmi'
	name = "polishing cream"
	desc = "A pure silver compound made for making the best metals shine."
	icon_state = "cream"
	w_class = WEIGHT_CLASS_SMALL
	smeltresult = /obj/item/ingot/silver
	var/uses = 5

/obj/item/polishing_cream/examine(mob/user)
	. = ..()
	. += span_info("It has [uses] uses left.")

/obj/item/polishing_cream/attack_obj(obj/O, mob/living/user)
	if(!isitem(O) || !uses)
		return ..()
	var/obj/item/thing = O
	if(!thing.anvilrepair)
		return ..()
	if((HAS_TRAIT(user, TRAIT_SQUIRE_REPAIR) || user.mind.get_skill_level(thing.anvilrepair)) && thing.polished == 0)
		to_chat(user, span_info("I start applying some compound to \the [thing]..."))
		if(do_after(user, 50 - user.STASPD*2, target = O))
			thing.polished = 1
			uses--
			thing.remove_atom_colour(FIXED_COLOUR_PRIORITY)
			thing.add_atom_colour("#635e6571", FIXED_COLOUR_PRIORITY)
			RegisterSignal(thing, COMSIG_COMPONENT_CLEAN_ACT, PROC_REF(remove_polish))
			if(!uses)
				icon_state = "empty_cream"

/obj/item/armor_brush
	icon = 'icons/roguetown/items/misc.dmi'
	name = "armor brush"
	desc = "A coarse brush for scrubbing armor thoroughly. Made of "
	icon_state = "brush"
	w_class = WEIGHT_CLASS_SMALL
	smeltresult = null
	var/roughness = 0 // 0  for a fine brush, 1 for a coarse brush

/obj/item/armor_brush/attack_self(mob/user)
	roughness = 1 - roughness
	if(roughness)
		to_chat(user, span_info("I flip the brush to the coarse side."))
	else
		to_chat(user, span_info("I flip the brush to the fine side."))

/obj/item/armor_brush/attack_obj(obj/O, mob/living/user)
	if(!isitem(O))
		return ..()
	var/obj/item/thing = O
	if(thing.polished == 1 && roughness)
		if((HAS_TRAIT(user, TRAIT_SQUIRE_REPAIR) || user.mind.get_skill_level(thing.anvilrepair)))
			to_chat(user, span_info("I start roughly scrubbing the compound on \the [thing]..."))
			playsound(loc,"sound/foley/scrubbing[pick(1,2)].ogg", 100, TRUE)
			if(do_after(user, 50 - user.STASTR*1.5, target = O))
				thing.polished = 2
				thing.remove_atom_colour(FIXED_COLOUR_PRIORITY)
				thing.add_atom_colour("#6b6a6b", FIXED_COLOUR_PRIORITY)

	else if(thing.polished == 2 && !roughness)
		if((HAS_TRAIT(user, TRAIT_SQUIRE_REPAIR) || user.mind.get_skill_level(thing.anvilrepair)))
			to_chat(user, span_info("I start gently scrubbing the edges of \the [thing]..."))
			playsound(loc,"sound/foley/scrubbing[pick(1,2)].ogg", 100, TRUE)
			if(do_after(user, 50 - user.STASTR*1.5, target = O))
				thing.polished = 3
				thing.remove_atom_colour(FIXED_COLOUR_PRIORITY)
				thing.add_atom_colour("#838283", FIXED_COLOUR_PRIORITY)

/obj/item/take_damage(damage_amount, damage_type, damage_flag, sound_effect, attack_dir, armor_penetration)
	. = ..()
	if(src)
		if(polished)
			polished = 0
			force -= 2
			force_wielded -= 3
			remove_atom_colour(FIXED_COLOUR_PRIORITY)
			UnregisterSignal(src, COMSIG_COMPONENT_CLEAN_ACT)


/obj/item/proc/remove_polish(datum/source, strength) // kill polska
	if(polished == 3 && obj_integrity == max_integrity)
		polished = 4
		remove_atom_colour(FIXED_COLOUR_PRIORITY)
		add_atom_colour("#98a4bd", FIXED_COLOUR_PRIORITY)
		obj_integrity += 50
		force += 2
		force_wielded += 3

	else if(polished < 4)
		polished = 0
		remove_atom_colour(FIXED_COLOUR_PRIORITY)
	UnregisterSignal(src, COMSIG_COMPONENT_CLEAN_ACT)
