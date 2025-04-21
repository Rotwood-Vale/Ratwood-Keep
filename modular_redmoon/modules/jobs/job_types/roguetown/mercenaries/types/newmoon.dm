/datum/subclass/newmoon
	ru_name = "Наёмник Новолуния Зибантии"
	ru_tutorial = "Заклинатели Новолуния Зибантии - остатки погибшего монастыря ноцитов в неизвестном регионе Лалвестина, \
	последнего крупного оплота Десяти в Зибантийской империи. Их монашеский образ жизни и набожность быстро рухнули под тяжестью Гнили, \
	и жизни их превратились из благочестивого уединения в жизнь обычного наёмника, в которой благословения Нока оказались весьма полезными \
	при отпоре как монстрами, так и людям. По какой-то причине вы оказались в Рокхилле, предлагая свои навыки тому, кто больше заплатит. Знание - сила, так они говорят..."

// fixes_for_ancestory_skintones
/datum/outfit/job/roguetown/mercenary/newmoon/pre_equip(mob/living/carbon/human/H)
	..()
	var/accessories_color_changing = 0

	if(iself(H))
		var/list/skin_slop = H.dna.species.get_skin_list()
		accessories_color_changing = skin_slop["Timberborn"]

	if(isdemihuman(H))
		var/list/skin_slop = H.dna.species.get_skin_list()
		accessories_color_changing = skin_slop["Lavestine"]

	if(accessories_color_changing)
		var/obj/item/organ/breasts/breasts = H.getorganslot(ORGAN_SLOT_BREASTS)
		if(breasts)
			breasts.accessory_colors = "#[accessories_color_changing]"
		var/obj/item/organ/penis/penis = H.getorganslot(ORGAN_SLOT_PENIS)
		if(penis)
			penis.accessory_colors = "#[accessories_color_changing]"
		var/obj/item/organ/testicles/testicles = H.getorganslot(ORGAN_SLOT_TESTICLES)
		if(testicles)
			testicles.accessory_colors = "#[accessories_color_changing]"
		var/obj/item/organ/butt/butt = H.getorganslot(ORGAN_SLOT_BUTT)
		if(butt)
			butt.accessory_colors ="#[accessories_color_changing]"
		var/obj/item/organ/ears/ears = H.getorganslot(ORGAN_SLOT_EARS)
		if(ears)
			ears.accessory_colors = "#[accessories_color_changing]"
		H.update_body()
