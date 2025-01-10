/datum/subclass/newmoon
	name = "New Moon Spellblade"
	tutorial = "Заклинатели Новолуния Зибантии - остатки погибшего монастыря последователей Нока в неизвестном регионе Лалвестина, \
	последнего крупного оплота Десяти в Зибантийской империи. \
	Их монашеский образ жизни и набожность быстро рухнули под тяжестью крупнейшей войны между Зибантии и Грензельхофтом, \
	и из жизни благочестивого уединения они превратились в обычных наемников; \
	благословения Нока оказались весьма полезными при убийстве как монстров, так и людей. \
	По какой-то причине вы оказались в Рокхилле, предлагая свои навыки тому, кто больше заплатит. Знание - сила, так говорит Она."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_TOLERATED_UP
	outfit = /datum/outfit/job/roguetown/mercenary/newmoon
	maximum_possible_slots = 10
	min_pq = 10
	torch = FALSE
	cmode_music = 'sound/music/combat_desertrider.ogg'
	category_tags = list(CTAG_MERCENARY)

/datum/outfit/job/roguetown/mercenary/newmoon/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/armor
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	head = /obj/item/clothing/head/roguetown/roguehood/reinforced/newmoon
	gloves = /obj/item/clothing/gloves/roguetown/fingerless
	belt = /obj/item/storage/belt/rogue/leather
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/tunic/newmoon
	armor = /obj/item/clothing/suit/roguetown/armor/leather/newmoon_jacket
	beltr = /obj/item/storage/keyring/mercenary
	beltl = /obj/item/rogueweapon/huntingknife/idagger
	backr = /obj/item/storage/backpack/rogue/satchel
	backl = /obj/item/rogueweapon/sword/sabre_freeze
	wrists = /obj/item/clothing/neck/roguetown/psicross/noc

	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/arcane, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 1, TRUE)
		H.mind.adjust_spellpoints(4)
		if(H.age == AGE_OLD)
			head = /obj/item/clothing/head/roguetown/wizhat/gen
			H.change_stat("intelligence", 4)
			H.change_stat("strength", -2)
			H.mind.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)
		H.change_stat("intelligence", 3)
		H.change_stat("constitution", -2)
		H.change_stat("endurance", 2)
		H.change_stat("speed", 2)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/learnspell)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
