

/mob/living/carbon/human/proc/magicreport()
	set name = "Check Points"
	set category = "Magic"

	var/mob/living/carbon/human/H = src

	to_chat(H,"My current spell points are [H.mind.spell_points - H.mind.used_spell_points].")

/mob/living/carbon/human/proc/magiclearn()
	set name = "Learn Spells"
	set category = "Magic"

	var/mob/living/carbon/human/H = src

	if(H.mind.used_spell_points >= H.mind.spell_points)
		to_chat(H,"I do not have enough points to learn any new spells!")

	// TODO: GLOBAL LISTS OF SPELLS, THIS IS PAINFUL
	var/list/combat_spells = list(/obj/effect/proc_holder/spell/invoked/projectile/fireball,/obj/effect/proc_holder/spell/invoked/projectile/lightningbolt,/obj/effect/proc_holder/spell/invoked/projectile/eldritchblast5e,/obj/effect/proc_holder/spell/invoked/projectile/fetch,/obj/effect/proc_holder/spell/invoked/projectile/spitfire,/obj/effect/proc_holder/spell/invoked/projectile/firebolt5e,/obj/effect/proc_holder/spell/invoked/projectile/rayoffrost5e,/obj/effect/proc_holder/spell/invoked/projectile/acidsplash5e,/obj/effect/proc_holder/spell/invoked/blade_burst,/obj/effect/proc_holder/spell/invoked/frostbite5e,/obj/effect/proc_holder/spell/invoked/poisonspray5e,/obj/effect/proc_holder/spell/invoked/arcyne_storm,/obj/effect/proc_holder/spell/invoked/chilltouch5e,/obj/effect/proc_holder/spell/invoked/infestation5e,/obj/effect/proc_holder/spell/invoked/mindsliver5e,/obj/effect/proc_holder/spell/targeted/lightninglure5e,/obj/effect/proc_holder/spell/invoked/greenflameblade5e,)
	var/list/defense_spells = list(/obj/effect/proc_holder/spell/invoked/forcewall_weak,/obj/effect/proc_holder/spell/self/bladeward5e,)
	var/list/utility_spells = list(/obj/effect/proc_holder/spell/invoked/slowdown_spell_aoe,/obj/effect/proc_holder/spell/invoked/message,/obj/effect/proc_holder/spell/invoked/push_spell,/obj/effect/proc_holder/spell/invoked/longjump,/obj/effect/proc_holder/spell/aoe_turf/conjure/Wolf,/obj/effect/proc_holder/spell/targeted/guidance5e,/obj/effect/proc_holder/spell/targeted/encodethoughts5e,/obj/effect/proc_holder/spell/invoked/magicstone5e,/obj/effect/proc_holder/spell/invoked/mending5e,/obj/effect/proc_holder/spell/self/light5e,/obj/effect/proc_holder/spell/aoe_turf/conjure/createbonfire5e,)
	
	var/categories = list("Combat", "Defense", "Utility", "Exit Spell Selection")
	
	while(H.mind.used_spell_points < H.mind.spell_points)
		var/magichoice = input("Choose your spells", "Available categories") as anything in categories
		switch(magichoice)
			if("Combat")
				choose_magic(combat_spells,H)

			if("Defense")
				choose_magic(defense_spells,H)

			if("Utility")
				choose_magic(utility_spells,H)
					
			if("Exit Spell Selection") // In case someone doesn't want to spend every point they have, for whatever reason
				break // Unelegant, but I can't find a better way to stop this loop without losing spell points

/mob/living/carbon/human/proc/choose_magic(list/category, mob/living/carbon/human/H)
	var/list/choices = list()
	for(var/i = 1, i <= category.len, i++)
		choices["[category[i].name]: [category[i].cost]"] = category[i]

	var/choice = input("Choose a spell, points left: [H.mind.spell_points - H.mind.used_spell_points]") as null|anything in choices
	var/obj/effect/proc_holder/spell/item = choices[choice]
	if(!item)
		return     // user canceled; 
	if(item.cost > H.mind.spell_points - H.mind.used_spell_points)
		to_chat(H,span_warning("You do not have enough experience to learn a new spell"))
		return		// not enough spell points
	else
		H.mind.used_spell_points += item.cost
		H.mind.AddSpell(new item)
