/datum/anvil_recipe/weapons
	i_type = "Оружие"
/datum/anvil_recipe/ammo
	i_type = "Боеприпасы"

/datum/anvil_recipe/weapons
	appro_skill = /datum/skill/craft/blacksmithing  // inheritance yay !!
	skill_level = 1

/// IRON WEAPONS

/datum/anvil_recipe/weapons/iron/sword
	name = "Меч"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/rogueweapon/sword/iron

/datum/anvil_recipe/weapons/iron/swordshort
	name = "Короткий меч"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/rogueweapon/sword/iron/short

/datum/anvil_recipe/weapons/iron/messer
	name = "Мессер"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/rogueweapon/sword/iron/messer

/datum/anvil_recipe/weapons/iron/dagger
	name = "Кинжал"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/rogueweapon/huntingknife/idagger

/datum/anvil_recipe/weapons/iron/flail
	name = "Цеп"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/rogueweapon/flail

/datum/anvil_recipe/weapons/iron/huntingknife
	name = "Охотничий нож"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/rogueweapon/huntingknife

/datum/anvil_recipe/weapons/iron/axe
	name = "Топор (+1 Палка)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/stoneaxe/woodcut
	skill_level = 0

/datum/anvil_recipe/weapons/iron/cudgel
	name = "Дубинка (+1 Палка)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/mace/cudgel
	skill_level = 0

/datum/anvil_recipe/weapons/iron/mace
	name = "Булава (+1 Палка)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/mace
	skill_level = 0

/datum/anvil_recipe/weapons/iron/spear
	name = "Копье (+1 Маленькое бревно)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/spear
	skill_level = 0

/datum/anvil_recipe/weapons/iron/bardiche
	name = "Бердыш (+1 Железо) (+1 Маленькое бревно)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron, /obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/halberd/bardiche
	skill_level = 2

/datum/anvil_recipe/weapons/iron/zweihander
	name = "Цвайхендер (+2 Железа)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron, /obj/item/ingot/iron)
	created_item = /obj/item/rogueweapon/greatsword/zwei
	skill_level = 3

/datum/anvil_recipe/weapons/iron/axe
	name = "Топор (+1 Палка)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/stoneaxe/woodcut

/datum/anvil_recipe/weapons/iron/mace
	name = "Булава (+1 Палка)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/mace

/datum/anvil_recipe/weapons/iron/warhammer
	name = "Боевой молот (+1 Палка)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/mace/warhammer

/datum/anvil_recipe/weapons/iron/polemace
	name = "Боевая дубинка (+1 Маленькое бревно)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/mace/goden

/// STEEL

/datum/anvil_recipe/weapons/steel/messer
	name = "Мессер"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/sword/iron/messer/steel

/datum/anvil_recipe/weapons/iron/dagger
	name = "Кинжал"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/huntingknife/idagger/steel

/datum/anvil_recipe/weapons/steel/flail
	name = "Цеп"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/flail/sflail

/datum/anvil_recipe/weapons/steel/sword
	name = "Меч"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/sword

/datum/anvil_recipe/weapons/steel/swordshort
	name = "Короткий меч"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/sword/short

/datum/anvil_recipe/weapons/steel/saber
	name = "Сабля"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/sword/sabre

/datum/anvil_recipe/weapons/steel/rapier
	name = "Рапира"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/sword/rapier

/datum/anvil_recipe/weapons/steel/cutlass
	name = "Абордажная сабля"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/sword/cutlass

/datum/anvil_recipe/weapons/steel/katar
	name = "Катар"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/katar

/datum/anvil_recipe/weapons/steel/cleaver
	name = "Тесак"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/huntingknife/cleaver

/datum/anvil_recipe/weapons/steel/combatknife
	name = "Боевой нож"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/huntingknife/cleaver/combat
	skill_level = 2

/datum/anvil_recipe/weapons/steel/bastardsword
	name = "Полуторный меч (Бастард) (+1 Сталь)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/sword/long
	skill_level = 2

/datum/anvil_recipe/weapons/steel/battleaxe
	name = "Боевой топор (+1 Сталь)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/stoneaxe/battle
	skill_level = 2

/datum/anvil_recipe/weapons/steel/mace
	name = "Булава (+1 Сталь)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/mace/steel
	skill_level = 2

/datum/anvil_recipe/weapons/steel/warhammer
	name = "Боевой молот (+1 Сталь)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/mace/warhammer/steel
	skill_level = 2

/datum/anvil_recipe/weapons/steel/langesmesser
	name = "Лангмессер (+1 Сталь)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/sword/long/rider/messer
	skill_level = 2

/datum/anvil_recipe/weapons/steel/estoc
	name = "Эсток (+2 Стали)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/estoc
	skill_level = 4

/datum/anvil_recipe/weapons/steel/greatsword
	name = "Большой меч (+2 Стали)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/greatsword
	skill_level = 3

/datum/anvil_recipe/weapons/steel/lucerne
	name = "Люцеранский молот (+1 Сталь) (+1 Маленькое бревно)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/steel, /obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/eaglebeak/lucerne
	skill_level = 2

/datum/anvil_recipe/weapons/steel/billhook
	name = "Биллхук (+1 Маленькое бревно)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/spear/billhook

/datum/anvil_recipe/weapons/steel/axe
	name = "Топор (+1 Палка)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/stoneaxe/woodcut/steel

/datum/anvil_recipe/weapons/steel/halberd
	name = "Алебарда (+1 Сталь) (+1 Маленькое бревно)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/halberd
	skill_level = 2

/datum/anvil_recipe/weapons/steel/eaglebeak
	name = "Клевец (+1 Сталь) (+1 Маленькое бревно)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/eaglebeak
	skill_level = 2

/datum/anvil_recipe/weapons/steel/grandmace
	name = "Большая булава (+1 Маленькое бревно)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/mace/goden/steel

/datum/anvil_recipe/weapons/steel/execution
	name = "Меч палача (+1 Сталь) (+1 Железо)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/iron, /obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/sword/long/exe

/// SILVER 

/datum/anvil_recipe/weapons/silver/dagger
	name = "Кинжал"
	req_bar = /obj/item/ingot/silver
	created_item = /obj/item/rogueweapon/huntingknife/idagger/silver

/datum/anvil_recipe/weapons/silver/elfsaber
	name = "Эльфийская сабля"
	req_bar = /obj/item/ingot/silver
	additional_items = list(/obj/item/ingot/silver)
	created_item = /obj/item/rogueweapon/sword/sabre/elf
	skill_level = 3

/datum/anvil_recipe/weapons/silver/elfdagger
	name = "Эльфийский кинжал"
	req_bar = /obj/item/ingot/silver
	created_item = /obj/item/rogueweapon/huntingknife/elvish
	skill_level = 3

//GOLD

/datum/anvil_recipe/weapons/gold/decsword_steel
	name = "Украшенный меч (+1 Золото)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/gold)
	created_item = /obj/item/rogueweapon/sword/decorated
	skill_level = 2

/datum/anvil_recipe/weapons/gold/decsword_gold
	name = "Украшенный меч (+1 Стальной меч)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/rogueweapon/sword)
	created_item = /obj/item/rogueweapon/sword/decorated
	skill_level = 2

/datum/anvil_recipe/weapons/gold/decsaber_steel
	name = "Украшенная сабля (+1 Золото)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/gold)
	created_item = /obj/item/rogueweapon/sword/sabre/dec
	skill_level = 2

/datum/anvil_recipe/weapons/gold/decsaber_gold
	name = "Украшенная сабля (+1 Стальная сабля)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/rogueweapon/sword/sabre)
	created_item = /obj/item/rogueweapon/sword/sabre/dec
	skill_level = 2

/datum/anvil_recipe/weapons/gold/decrapier_steel
	name = "Украшенная рапира (+1 Золото)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/gold)
	created_item = /obj/item/rogueweapon/sword/rapier/dec
	skill_level = 2

/datum/anvil_recipe/weapons/gold/decrapier_gold
	name = "Украшенная рапира (+1 Стальная рапира)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/rogueweapon/sword/rapier)
	created_item = /obj/item/rogueweapon/sword/rapier/dec
	skill_level = 2

/datum/anvil_recipe/weapons/terminus
	name = "Terminus Est (+1 Золотой слиток) (+1 Сталь) (+1 Ронтц)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/ingot/gold, /obj/item/ingot/steel, /obj/item/roguegem)	
	created_item = /obj/item/rogueweapon/sword/long/exe/cloth
	skill_level = 3

// BRONZE

/datum/anvil_recipe/weapons/gladius
	name = "Гладиус"
	req_bar = /obj/item/ingot/bronze
	created_item = /obj/item/rogueweapon/sword/gladius
	skill_level = 2

/datum/anvil_recipe/weapons/bronze/spear
	name = "Бронзовое копье (+1 Бронза) (+1 Маленькое бревно)"
	req_bar = /obj/item/ingot/bronze
	additional_items = list(/obj/item/ingot/bronze, /obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/spear/bronze
	skill_level = 0


/// SHIELDS
/datum/anvil_recipe/weapons/steel/kiteshield
	name = "Геральдический щит (+1 Сталь) (+1 Выделанная кожа)"
	appro_skill = /datum/skill/craft/blacksmithing
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/natural/hide/cured)
	created_item = /obj/item/rogueweapon/shield/tower/metal
	skill_level = 2

/datum/anvil_recipe/weapons/iron/towershield
	name = "Башенный щит (+1 Маленькое бревно)"
	appro_skill = /datum/skill/craft/blacksmithing
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/shield/tower

/datum/anvil_recipe/weapons/steel/buckler
	name = "Баклер"
	appro_skill = /datum/skill/craft/blacksmithing
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/shield/buckler
	skill_level = 3

/datum/anvil_recipe/ammo/musketball
	name = "Мушкетные пули 8x"
	appro_skill = /datum/skill/craft/blacksmithing
	req_bar = /obj/item/ingot/iron
	created_item = list(/obj/item/ammo_casing/caseless/lead,
						/obj/item/ammo_casing/caseless/lead,
						/obj/item/ammo_casing/caseless/lead,
						/obj/item/ammo_casing/caseless/lead,
						/obj/item/ammo_casing/caseless/lead,
						/obj/item/ammo_casing/caseless/lead,
						/obj/item/ammo_casing/caseless/lead,
						/obj/item/ammo_casing/caseless/lead
					)

	skill_level = 1

/datum/anvil_recipe/ammo/grapeshot
	name = "Картечь 8x"
	appro_skill = /datum/skill/craft/blacksmithing
	req_bar = /obj/item/ingot/iron
	created_item = list(/obj/item/ammo_casing/caseless/grapeshot,
						/obj/item/ammo_casing/caseless/grapeshot,
						/obj/item/ammo_casing/caseless/grapeshot,
						/obj/item/ammo_casing/caseless/grapeshot,
						/obj/item/ammo_casing/caseless/grapeshot,
						/obj/item/ammo_casing/caseless/grapeshot,
						/obj/item/ammo_casing/caseless/grapeshot,
						/obj/item/ammo_casing/caseless/grapeshot
					)

	skill_level = 1

/datum/anvil_recipe/ammo/arrows
	name = "Стрелы 20x"
	appro_skill = /datum/skill/craft/blacksmithing
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron, /obj/item/grown/log/tree/small, /obj/item/grown/log/tree/small)
	created_item = list(/obj/item/ammo_casing/caseless/rogue/arrow/iron,
						/obj/item/ammo_casing/caseless/rogue/arrow/iron,
						/obj/item/ammo_casing/caseless/rogue/arrow/iron, 
						/obj/item/ammo_casing/caseless/rogue/arrow/iron, 
						/obj/item/ammo_casing/caseless/rogue/arrow/iron, 
						/obj/item/ammo_casing/caseless/rogue/arrow/iron,
						/obj/item/ammo_casing/caseless/rogue/arrow/iron,
						/obj/item/ammo_casing/caseless/rogue/arrow/iron, 
						/obj/item/ammo_casing/caseless/rogue/arrow/iron, 
						/obj/item/ammo_casing/caseless/rogue/arrow/iron, 
						/obj/item/ammo_casing/caseless/rogue/arrow/iron,
						/obj/item/ammo_casing/caseless/rogue/arrow/iron,
						/obj/item/ammo_casing/caseless/rogue/arrow/iron, 
						/obj/item/ammo_casing/caseless/rogue/arrow/iron, 
						/obj/item/ammo_casing/caseless/rogue/arrow/iron, 
						/obj/item/ammo_casing/caseless/rogue/arrow/iron,
						/obj/item/ammo_casing/caseless/rogue/arrow/iron,
						/obj/item/ammo_casing/caseless/rogue/arrow/iron, 
						/obj/item/ammo_casing/caseless/rogue/arrow/iron, 
						/obj/item/ammo_casing/caseless/rogue/arrow/iron
					)
	skill_level_1
	
/datum/anvil_recipe/ammo/bolts
	name = "Болты 20x"
	appro_skill = /datum/skill/craft/blacksmithing
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron, /obj/item/grown/log/tree/small, /obj/item/grown/log/tree/small)
	created_item = list(/obj/item/ammo_casing/caseless/rogue/bolt, 
						/obj/item/ammo_casing/caseless/rogue/bolt, 
						/obj/item/ammo_casing/caseless/rogue/bolt, 
						/obj/item/ammo_casing/caseless/rogue/bolt, 
						/obj/item/ammo_casing/caseless/rogue/bolt, 
						/obj/item/ammo_casing/caseless/rogue/bolt, 
						/obj/item/ammo_casing/caseless/rogue/bolt, 
						/obj/item/ammo_casing/caseless/rogue/bolt, 
						/obj/item/ammo_casing/caseless/rogue/bolt, 
						/obj/item/ammo_casing/caseless/rogue/bolt, 
						/obj/item/ammo_casing/caseless/rogue/bolt, 
						/obj/item/ammo_casing/caseless/rogue/bolt, 
						/obj/item/ammo_casing/caseless/rogue/bolt, 
						/obj/item/ammo_casing/caseless/rogue/bolt, 
						/obj/item/ammo_casing/caseless/rogue/bolt, 
						/obj/item/ammo_casing/caseless/rogue/bolt, 
						/obj/item/ammo_casing/caseless/rogue/bolt, 
						/obj/item/ammo_casing/caseless/rogue/bolt, 
						/obj/item/ammo_casing/caseless/rogue/bolt
					)
	skill_level_1
