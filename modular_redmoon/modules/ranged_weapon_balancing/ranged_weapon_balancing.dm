// ranged_weapon_balancing - смотрите по этому тэгу

/obj/item/ammo_casing/caseless/rogue/bolt
	randomspread = TRUE // Добавляем разброс по дефолту
	variance = 15 // Стандартный разброс, который снижается с наличием навыка и стоянием на месте

/obj/item/ammo_casing/caseless/rogue/arrow
	randomspread = TRUE
	variance = 18

/mob/living/bullet_act(obj/projectile/P, def_zone = BODY_ZONE_CHEST)
// Это стоило бы перенести в глобальные дефайны?
// добавляем разброс при стрельбе по частям тела
#define upper_body_parts 	BODY_ZONE_HEAD, BODY_ZONE_PRECISE_SKULL, BODY_ZONE_PRECISE_EARS, BODY_ZONE_PRECISE_R_EYE,\
							BODY_ZONE_PRECISE_L_EYE, BODY_ZONE_PRECISE_NOSE, BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_PRECISE_NECK
#define middle_body_parts 	BODY_ZONE_CHEST, BODY_ZONE_PRECISE_STOMACH, BODY_ZONE_PRECISE_GROIN, BODY_ZONE_PRECISE_L_HAND,\
											BODY_ZONE_L_ARM, BODY_ZONE_PRECISE_R_HAND, BODY_ZONE_R_ARM
#define lower_body_parts 	BODY_ZONE_L_LEG, BODY_ZONE_R_LEG, BODY_ZONE_PRECISE_L_FOOT, BODY_ZONE_PRECISE_R_FOOT

	if(get_dist(src, P.firer) > 3) // Стреляя дальше 3 тайлов, есть шанс промазать
		var/check_for_luck_was_successful = FALSE
		if(isliving(P.firer))
			var/mob/living/shooter = P.firer
			if(shooter.goodluck(3))
				check_for_luck_was_successful = TRUE
		if(!check_for_luck_was_successful)
			switch(def_zone)
				if(upper_body_parts) // целится в голову
					def_zone = pick(upper_body_parts)
					if(prob(70)) // в голову попасть тяжело
						def_zone = pick(middle_body_parts)
				if(middle_body_parts) // целится в руки или в торс
					def_zone = pick(middle_body_parts)
					if(prob(20)) // попадёт в голову или в ноги, если не повезёт
						def_zone = pick(upper_body_parts)
						if(prob(50))
							def_zone = pick(lower_body_parts)
				if(lower_body_parts) // целится в ноги
					def_zone = pick(lower_body_parts)
					if(prob(30)) // в ноги попасть проще
						def_zone = pick(middle_body_parts)

#undef upper_body_parts
#undef middle_body_parts
#undef lower_body_parts
	. = ..()
