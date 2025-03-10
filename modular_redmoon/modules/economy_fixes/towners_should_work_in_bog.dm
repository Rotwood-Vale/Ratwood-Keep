#define BOG_AREA_ENDING_Y 194 // НУЖНО ОБСЛУЖИВАТЬ ПРИ ИЗМЕНЕНИИ КАРТЫ! Выше этого значения, деревья лес перестаёт считать себя болотным. Такой подход позволяет не трогать карту.

// Охота в окрестностях города - бесполезная затея
/obj/item/bait/attack_self(mob/user)
	if(y > BOG_AREA_ENDING_Y) // деревья в окрестностях Рокхилла приносят мало древисины
		to_chat(user, span_warning(user.client.prefs.be_russian ? "В окрестностях Рокхилла не осталось живности... В болотах шансов приманить кого-нибудь больше." : "There will not be enought wildlife here. I should place [src] in the bog..."))
		return FALSE
	. = ..()

// С деревьев у рокхилла доходность леса очень сильно падает
/obj/structure/flora/newtree
	var/tree_not_in_bog = FALSE // оповещение для дровосека, чтобы шёл рубить болото

/obj/structure/flora/newtree/Initialize()
	if(!is_centcom_level(z)) // Чтобы бандиты и вампиры могли добывать у себя спокойно
		if(y > BOG_AREA_ENDING_Y) // деревья в окрестностях Рокхилла приносят мало древисины
			static_debris = list(/obj/item/grown/log/tree/small = 1)
			tree_not_in_bog = TRUE
			desc += " Seems like this tree is very old. The one in the Bog would have better wood."
			if(istype(get_turf(src), /turf/open/transparent/openspace))
				static_debris = list() // отсутствие древесины в целом, фармите болото, дровосеки
				tree_not_in_bog = FALSE // некому показывать
	. = ..()

/obj/structure/flora/newtree/obj_destruction(damage_flag)
	if(tree_not_in_bog)
		if(prob(20))
			visible_message(span_info("The tree was too old. The one the Bog have better wood."), vision_distance = 2)
	. = ..()

/obj/structure/flora/roguetree
	var/tree_not_in_bog = FALSE // оповещение для дровосека, чтобы шёл рубить болото

/obj/structure/flora/roguetree/Initialize()
	if(!is_centcom_level(z)) // Чтобы бандиты и вампиры могли добывать у себя спокойно
		if(y > BOG_AREA_ENDING_Y) // деревья в окрестностях Рокхилла приносят мало древисины
			static_debris = list(/obj/item/grown/log/tree/small = 1)
			tree_not_in_bog = TRUE
			desc += " Seems like this tree is very old. The one in the Bog would have better wood."
			stump_type = null
	. = ..()

/obj/structure/flora/roguetree/obj_destruction(damage_flag)
	if(tree_not_in_bog)
		if(prob(20))
			visible_message(span_info("The tree was too old and rotten. The one the Bog would have better wood."), vision_distance = 2)

	. = ..()

// Проверка на bog-зону для пенька. Если в боге, то старое количество леса с 1 пня
/obj/structure/table/roguetree/stump/proc/check_for_bog_area(mob/living/user)
	if(y > BOG_AREA_ENDING_Y) // деревья в окрестностях Рокхилла приносят мало древисины
		return 1
	else
		var/skill_level = user.mind.get_skill_level(/datum/skill/labor/lumberjacking)
		return  rand(1, max(1, round(skill_level / 2)))

// Добыча в шахтах рокхилла - не особо прибыльное дело, но кузнец явно скажет спасибо. Золото и другие ценные руды можно добыть за городом
/turf/closed/mineral/random/rogue/Initialize()
	check_for_bog_area()
	. = ..()

/turf/closed/mineral/random/rogue
    mineralChance = 20
    mineralSpawnChanceList = list(
		/turf/closed/mineral/rogue/salt = 5, // 10%
		/turf/closed/mineral/rogue/iron = 15, // 30%
		/turf/closed/mineral/rogue/copper = 10, // 20%
		/turf/closed/mineral/rogue/coal = 20) // 40%

/turf/closed/mineral/random/rogue/med
    mineralChance = 30 // 1430 у лавы, 4097 в пещере, 14400 в шахте, 1254 в месте бойни
    mineralSpawnChanceList = list(
		/turf/closed/mineral/rogue/salt = 5, // 8%
		/turf/closed/mineral/rogue/gold = 3, // 5%
		/turf/closed/mineral/rogue/silver = 1, // 2%
		/turf/closed/mineral/rogue/iron = 25, // 41%
		/turf/closed/mineral/rogue/copper = 5, // 8%
		/turf/closed/mineral/rogue/tin = 5, // 8%
		/turf/closed/mineral/rogue/coal = 5, // 8%
		/turf/closed/mineral/rogue/cinnabar = 10, //16%
		/turf/closed/mineral/rogue/gem = 1) // 2%

/turf/closed/mineral/random/rogue/high // 701 у лавы всего, 111 в месте бойни
    mineralChance = 50 
    mineralSpawnChanceList = list(
		/turf/closed/mineral/rogue/gold = 2, // 8%
		/turf/closed/mineral/rogue/silver = 1,  // 4%
		/turf/closed/mineral/rogue/iron = 10,  // 43%
		/turf/closed/mineral/rogue/copper = 3,  // 13%
		/turf/closed/mineral/rogue/tin = 3,  // 13%
		/turf/closed/mineral/rogue/cinnabar = 3, // 13%
		/turf/closed/mineral/rogue/gem = 1) // 4%

/turf/closed/mineral/random/proc/check_for_bog_area()
	return TRUE

/turf/closed/mineral/random/rogue/med/check_for_bog_area()
	if(SSmapping.config.map_file == "rockhill.dmm") // На тестовой карте можно иметь где угодно
		if(!istype(get_area(src), /area/rogue/under/cavewet/bogcaves)) // Только болотные пещеры
			mineralChance = 20
			mineralSpawnChanceList = list(
				/turf/closed/mineral/rogue/salt = 5, // 10%
				/turf/closed/mineral/rogue/iron = 15, // 30%
				/turf/closed/mineral/rogue/copper = 10, // 20%
				/turf/closed/mineral/rogue/coal = 20) // 40%

/turf/closed/mineral/random/rogue/high/check_for_bog_area()
	if(SSmapping.config.map_file == "rockhill.dmm")
		if(!istype(get_area(src), /area/rogue/under/cavewet/bogcaves))
			mineralChance = 20
			mineralSpawnChanceList = list(
				/turf/closed/mineral/rogue/salt = 5, // 10%
				/turf/closed/mineral/rogue/iron = 15, // 30%
				/turf/closed/mineral/rogue/copper = 10, // 20%
				/turf/closed/mineral/rogue/coal = 20) // 40%

/turf/closed/mineral/rogue
	var/ore_overlay = null
	var/ore_overlay_icon = 'icons/roguetown/items/ore.dmi'

/turf/closed/mineral/rogue/proc/update_ore_overlay()
	var/ore_overlay_icon_state = get_ore_overlay_icon_state()
	var/mutable_appearance/M = mutable_appearance(ore_overlay_icon, ore_overlay_icon_state, layer = ABOVE_NORMAL_TURF_LAYER)
	M.pixel_y = rand(-12, 12)
	M.pixel_x = rand(-12, 12)

	var/matrix/M_matrix = new
	M_matrix.Scale(0.3,rand(0.3, 0.6))
	M_matrix.Turn(rand(1,360))
	M.transform = M_matrix
	add_overlay(M)

/turf/closed/mineral/rogue/proc/get_ore_overlay_icon_state()
	return "[ore_overlay][rand(1,3)]"

/turf/closed/mineral/rogue/Initialize()
	. = ..()
	if(ore_overlay)
		update_ore_overlay()

/turf/closed/mineral/rogue/gold
	ore_overlay = "oregold"

/turf/closed/mineral/rogue/silver
	ore_overlay = "oresilv"

/turf/closed/mineral/rogue/salt
	ore_overlay = "salt"
	ore_overlay_icon = 'icons/roguetown/items/produce.dmi'

/turf/closed/mineral/rogue/salt/get_ore_overlay_icon_state()
	return ore_overlay // нет рандомных иконок

/turf/closed/mineral/rogue/copper
	ore_overlay = "orecop"

/turf/closed/mineral/rogue/tin
	ore_overlay = "oretin"

/turf/closed/mineral/rogue/iron
	ore_overlay = "oreiron"

/turf/closed/mineral/rogue/coal
	ore_overlay = "orecoal"

/turf/closed/mineral/rogue/cinnabar
	ore_overlay = "orecinnabar"

/turf/closed/mineral/rogue/cinnabar/get_ore_overlay_icon_state()
	return ore_overlay // нет рандомных иконок

/turf/closed/mineral/rogue/gem
	ore_overlay = "saphire"
	ore_overlay_icon = 'icons/roguetown/items/gems.dmi'

/turf/closed/mineral/rogue/gem/get_ore_overlay_icon_state()
	return pick("saphire", "ruby", "emerald", "topaz", "diamond", "quartz") // нет рандомных иконок, но есть множество всяких иконок

// Рыбаку ловить у города для удачного подъёма смысла мало
/obj/item/proc/check_for_bait_location()
	return FALSE

/obj/item/natural/worms/check_for_bait_location()
	if(!istype(get_area(src), /area/rogue/under/cavewet/bogcaves))
		fishloot = list(\
			/obj/item/trash/applecore = 50,
			/obj/item/trash/pearcore = 25, //Pears, in Rockhill? Perish the thought.
			/obj/item/natural/fibers = 15, //It's pretty hard to hook a fiber.
			/obj/item/grown/log/tree/stick = 2, //Single stick
			/obj/item/reagent_containers/food/snacks/fish/carp = 214,
			/obj/item/reagent_containers/food/snacks/fish/eel = 214,
			/obj/item/reagent_containers/food/snacks/fish/angler = 214,
			/obj/item/reagent_containers/food/snacks/fish/shrimp = 180, //Shrimp man gone. Life bad.
			/obj/item/reagent_containers/food/snacks/fish/clownfish = 214,
			/obj/item/natural/bundle/stick = 15, //Bundle of sticks
			/obj/item/natural/stone = 15, //Hard to catch stones!
			/obj/item/clothing/head/roguetown/helmet/tricorn = 25,
			/obj/item/clothing/head/roguetown/helmet/bandana = 25,
			/obj/item/clothing/head/roguetown/roguehood = 25,
			/obj/item/clothing/under/roguetown/loincloth/brown = 25,
			/obj/item/clothing/shoes/roguetown/sandals = 25,
			/obj/item/clothing/shoes/roguetown/simpleshoes = 25,
			/obj/item/clothing/gloves/roguetown/fingerless = 25,
			/obj/item/clothing/gloves/roguetown/leather = 25,
			/obj/item/clothing/shoes/roguetown/armor/leather = 25,
			/obj/item/reagent_containers/syringe = 1, //These are terrifyingly powerful.
			/obj/item/reagent_containers/glass/cup/wooden = 27,
			/obj/item/ammo_casing/caseless/rogue/arrow = 45,
			/obj/item/roguecoin/copper = 45,
			/obj/item/leash = 15,
			/obj/item/customlock = 35,
			/obj/item/shard = 1, //Bait is smaller
			/obj/item/natural/feather = 15,
			/obj/item/natural/cloth = 15,
			/obj/item/kitchen/spoon = 1,)
		return TRUE
	return FALSE

/obj/item/natural/worms/grubs/check_for_bait_location()
	if(!istype(get_area(src), /area/rogue/under/cavewet/bogcaves))
		fishloot = list(\
			/obj/item/trash/applecore = 625,
			/obj/item/trash/pearcore = 625,
			/obj/item/natural/fibers = 625,
			/obj/item/grown/log/tree/stick = 625,
			/obj/item/reagent_containers/food/snacks/fish/carp = 214,
			/obj/item/reagent_containers/food/snacks/fish/eel = 214,
			/obj/item/reagent_containers/food/snacks/fish/angler = 214,
			/obj/item/reagent_containers/food/snacks/fish/shrimp = 214,
			/obj/item/reagent_containers/food/snacks/fish/clownfish = 214,
			/obj/item/natural/bundle/stick = 214,
			/obj/item/natural/stone = 214,
			/obj/item/clothing/head/roguetown/helmet/tricorn = 45,
			/obj/item/clothing/head/roguetown/helmet/bandana = 45,
			/obj/item/clothing/head/roguetown/roguehood = 45,
			/obj/item/clothing/under/roguetown/loincloth/brown = 45,
			/obj/item/clothing/shoes/roguetown/sandals = 45,
			/obj/item/clothing/shoes/roguetown/simpleshoes = 45,
			/obj/item/clothing/gloves/roguetown/fingerless = 45,
			/obj/item/clothing/gloves/roguetown/leather = 45,
			/obj/item/clothing/shoes/roguetown/armor/leather = 45,
			/obj/item/reagent_containers/syringe = 1,
			/obj/item/reagent_containers/glass/cup/wooden = 45,
			/obj/projectile/bullet/reusable/bolt = 45,
			/obj/item/ammo_casing/caseless/rogue/arrow = 45,
			/obj/item/roguecoin/copper = 45,
			/obj/item/leash = 45,
			/obj/item/customlock = 45,
			/obj/item/shard = 45,
			/obj/item/natural/feather = 45,
			/obj/item/natural/cloth = 45,
			/obj/item/kitchen/spoon = 45,)
		return TRUE
	return FALSE

#undef BOG_AREA_ENDING_Y
