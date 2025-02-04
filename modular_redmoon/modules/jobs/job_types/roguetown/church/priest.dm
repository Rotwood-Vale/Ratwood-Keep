
/datum/job/roguetown/priest
	ru_title = "Жрец"
	ru_f_title = "Жрица"
	ru_tutorial = "Обитель Десяти в настоящее время управляется амбициозным жрецом. \
	Храм сосредоточен на осуществлении своего контроля над населением через страх, обаяние, \
	наказание и похвалу в различных импровизированных формах поклонения. Развратные праздники, \
	ужасные публичные порицания и неортодоксальный фанатизм привели к тому, что церковь балансирует \
	на грани ереси по мнению Верховного Жреца Святого Престола. Несмотря на вызывающие действия, люди терпимы, \
	поскольку церковь часто вмешивается в несправедливости, вызванные бессердечными институтами, что терзают Рокхилл."
	spells = list(/obj/effect/proc_holder/spell/self/convertrole/templar, /obj/effect/proc_holder/spell/self/convertrole/monk, /obj/effect/proc_holder/spell/invoked/solar_smite)

/obj/effect/proc_holder/spell/invoked/solar_smite
	name = "Solar Smite"
	overlay_state = "solarsmite"
	releasedrain = 100
	chargedrain = 0
	chargetime = 1 SECONDS
	range = 8
	warnie = "sydwarning"
	movement_interrupt = FALSE
	chargedloop = /datum/looping_sound/invokeholy
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	sound = 'sound/magic/churn.ogg'
	invocation = "ASTRATA SMITE YOU! BURN!!"
	invocation_type = "shout"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	charge_max = 90 SECONDS
	miracle = TRUE
	devotion_cost = 100
	//explosion values
	var/exp_heavy = 0
	var/exp_light = 4
	var/exp_flash = 8

/obj/effect/proc_holder/spell/invoked/solar_smite/cast(list/targets, mob/user = usr)
	. = ..()
	if(isliving(targets[1]))
		var/mob/living/L = targets[1]
		user.visible_message("<font color='yellow'>[user] points at [L]!</font>")
		explosion(L, -1, exp_heavy, exp_light, 8, 0, soundin = 'sound/misc/lava_death.ogg')
		L.adjust_fire_stacks(6)
		L.IgniteMob()
		L.adjustFireLoss(30)
		if(istype(get_area(L), /area/rogue/indoors/town/church))
			L.adjust_fire_stacks(9)
			L.adjustFireLoss(50)
			if(L.mob_biotypes & MOB_UNDEAD) //positive energy harms the undead
				L.visible_message(span_danger("[L] is unmade by holy light!"), span_userdanger("I'm unmade by holy light!"))
				L.gib()
		return TRUE
	else
		return FALSE
