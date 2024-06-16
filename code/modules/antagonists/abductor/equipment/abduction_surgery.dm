/* RETARDED
/datum/surgery_step/extract_organ
	name = "remove heart"
	accept_hand = 1
	time = 32
	var/obj/item/organ/IC = null
	var/list/organ_types = list(/obj/item/organ/heart)

/datum/surgery_step/extract_organ/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	for(var/atom/A in target.internal_organs)
		if(A.type in organ_types)
			IC = A
			break
	user.visible_message("<span class='notice'>[user] starts to remove [target]'s organs.</span>", "<span class='notice'>I start to remove [target]'s organs...</span>")

/datum/surgery_step/extract_organ/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(IC)
		user.visible_message("<span class='notice'>[user] pulls [IC] out of [target]'s [target_zone]!</span>", "<span class='notice'>I pull [IC] out of [target]'s [target_zone].</span>")
		user.put_in_hands(IC)
		IC.Remove(target)
		return 1
	else
		to_chat(user, "<span class='warning'>I don't find anything in [target]'s [target_zone]!</span>")
		return 1

/datum/surgery_step/gland_insert
	name = "insert gland"
	implements = list(/obj/item/organ/heart/gland = 100)
	time = 32

/datum/surgery_step/gland_insert/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	user.visible_message("<span class='notice'>[user] starts to insert [tool] into [target].</span>", "<span class='notice'>I start to insert [tool] into [target]...</span>")

/datum/surgery_step/gland_insert/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	user.visible_message("<span class='notice'>[user] inserts [tool] into [target].</span>", "<span class='notice'>I insert [tool] into [target].</span>")
	user.temporarilyRemoveItemFromInventory(tool, TRUE)
	var/obj/item/organ/heart/gland/gland = tool
	gland.Insert(target, 2)
	return 1
*/
