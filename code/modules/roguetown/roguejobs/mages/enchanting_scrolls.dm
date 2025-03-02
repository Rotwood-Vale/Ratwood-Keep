/*Enchantment scrolls here. Here enchantment scroll has a component. Refer to magic_items.dm, and it's various subfolders for differant enchantment datums.
T1 Enchantments below here*/

/obj/item/enchantmentscroll
	name = "scroll of enchanting"
	desc = "A scroll imbued with an arcane enchantment. Can be used on certain items to imbue them."
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "enchantment"
	var/component
	possible_item_intents = list(/datum/intent/use)

/obj/item/enchantmentscroll/attack_obj(obj/item/O, mob/living/user)
//	if(O.enchanted = TRUE)
//		return
/obj/item/enchantmentscroll/woodcut
	name = "enchanting scroll of woodcutting"
	desc = "A scroll imbued with an enchantment of woodcutting. Good for cutting wood."
	component = /datum/magic_item/mundane/woodcut

/obj/item/enchantmentscroll/woodcut/attack_obj(obj/item/O, mob/living/user)
	.=..()
	if(istype(O,/obj/item/rogueweapon/stoneaxe))
		to_chat(user, span_notice("You open [src] and place [O] within. Moments later, it flashes blue with arcana, and [src] crumbles to dust."))
		var/magiceffect= new component
		O.AddComponent(/datum/component/magic_item, magiceffect)
		O.name += " of woodcutting"
		qdel(src)
		O.enchanted = TRUE
		O.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=2, color=rgb(rand(1,255),rand(1,255),rand(1,255)))
	else
		to_chat(user, span_notice("Nothing happens. Perhaps you can't enchant [O] with this?"))

/obj/item/enchantmentscroll/mining
	name = "enchanting scroll of mining"
	desc = "A scroll imbued with an enchantment of mining. Good for mining rock."
	component = /datum/magic_item/mundane/mining

obj/item/enchantmentscroll/mining/attack_obj(obj/item/O, mob/living/user)
	.=..()
	if(istype(O,/obj/item/rogueweapon/pick))
		to_chat(user, span_notice("You open [src] and place [O] within. Moments later, it flashes blue with arcana, and [src] crumbles to dust."))
		var/magiceffect= new component
		O.AddComponent(/datum/component/magic_item, magiceffect)
		O.name += " of mining"
		qdel(src)
		O.enchanted = TRUE
		O.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=2, color=rgb(rand(1,255),rand(1,255),rand(1,255)))
	else
		to_chat(user, span_notice("Nothing happens. Perhaps you can't enchant [O] with this?"))

/obj/item/enchantmentscroll/xylix
	name = "enchanting scroll of xylix's grace"
	desc = "A scroll imbued with an enchantment of luck. How fortunate!"
	component = /datum/magic_item/mundane/xylix

/obj/item/enchantmentscroll/xylix/attack_obj(obj/item/O, mob/living/user)
	.=..()
	if(istype(O,/obj/item/clothing))
		to_chat(user, span_notice("You open [src] and place [O] within. Moments later, it flashes blue with arcana, and [src] crumbles to dust."))
		var/magiceffect= new component
		O.AddComponent(/datum/component/magic_item, magiceffect)
		O.name += " of xylixs grace"
		qdel(src)
		O.enchanted = TRUE
		O.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=2, color=rgb(rand(1,255),rand(1,255),rand(1,255)))
	else
		to_chat(user, span_notice("Nothing happens. Perhaps you can't enchant [O] with this?"))

/obj/item/enchantmentscroll/light
	name = "enchanting scroll of unyielding light"
	desc = "A scroll imbued with an enchantment of unyielding light. provides light from the item."
	component = /datum/magic_item/mundane/unyieldinglight

/obj/item/enchantmentscroll/light/attack_obj(obj/item/O, mob/living/user)
	.=..()
	if(istype(O,/obj/item/clothing)|| istype(O,/obj/item/rogueweapon))
		to_chat(user, span_notice("You open [src] and place [O] within. Moments later, it flashes blue with arcana, and [src] crumbles to dust."))
		var/magiceffect= new component
		O.AddComponent(/datum/component/magic_item, magiceffect)
		O.name += " of unyielding light"
		qdel(src)
		O.enchanted = TRUE
		O.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=2, color=rgb(rand(1,255),rand(1,255),rand(1,255)))
	else
		to_chat(user, span_notice("Nothing happens. Perhaps you can't enchant [O] with this?"))

/obj/item/enchantmentscroll/holding
	name = "enchanting scroll of storage"
	desc = "A scroll imbued with an enchantment of storage. doubles storage space of container"
	component = /datum/magic_item/mundane/holding
	w_class = WEIGHT_CLASS_HUGE

/obj/item/enchantmentscroll/holding/attack_obj(obj/item/O, mob/living/user)
	.=..()
	if(istype(O,/obj/item/storage))
		to_chat(user, span_notice("You open [src] and place [O] within. Moments later, it flashes blue with arcana, and [src] crumbles to dust."))
		var/magiceffect= new component
		O.AddComponent(/datum/component/magic_item, magiceffect)
		O.name += " of storage"
		O.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=2, color=rgb(rand(1,255),rand(1,255),rand(1,255)))
		qdel(src)
	else
		to_chat(user, span_notice("Nothing happens. Perhaps you can't enchant [O] with this?"))

/obj/item/enchantmentscroll/revealing
	name = "enchanting scroll of revealing"
	desc = "A scroll imbued with an enchantment of revealing. Doubles range of lightsources."
	component = /datum/magic_item/mundane/revealing

/obj/item/enchantmentscroll/revealing/attack_obj(obj/item/O, mob/living/user)
	.=..()
	if(istype(O,/obj/item/flashlight/flare/torch))
		to_chat(user, span_notice("You open [src] and place [O] within. Moments later, it flashes blue with arcana, and [src] crumbles to dust."))
		var/magiceffect= new component
		O.AddComponent(/datum/component/magic_item, magiceffect)
		O.name += " of revealing"
		O.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=2, color=rgb(rand(1,255),rand(1,255),rand(1,255)))
		qdel(src)
	else
		to_chat(user, span_notice("Nothing happens. Perhaps you can't enchant [O] with this?"))

//T2 Enchantments below

/obj/item/enchantmentscroll/nightvision
	name = "enchanting scroll of darksight"
	desc = "A scroll imbued with an enchantment of dark vision. Good for seeing in the dark."
	component = /datum/magic_item/superior/nightvision

/obj/item/enchantmentscroll/nightvision/attack_obj(obj/item/O, mob/living/user)
	.=..()
	if(istype(O,/obj/item/clothing))
		to_chat(user, span_notice("You open [src] and place [O] within. Moments later, it flashes blue with arcana, and [src] crumbles to dust."))
		var/magiceffect= new component
		O.AddComponent(/datum/component/magic_item, magiceffect)
		O.name += " of dark sight"
		O.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=2, color=rgb(rand(1,255),rand(1,255),rand(1,255)))
		qdel(src)
	else
		to_chat(user, span_notice("Nothing happens. Perhaps you can't enchant [O] with this?"))

/obj/item/enchantmentscroll/featherstep
	name = "enchanting scroll of featherstep"
	desc = "A scroll imbued with an enchantment of featherstep. Good for moving silently."
	component = /datum/magic_item/superior/featherstep

/obj/item/enchantmentscroll/featherstep/attack_obj(obj/item/O, mob/living/user)
	.=..()
	if(istype(O,/obj/item/clothing/shoes)||istype(O,/obj/item/clothing/ring))
		to_chat(user, span_notice("You open [src] and place [O] within. Moments later, it flashes blue with arcana, and [src] crumbles to dust."))
		var/magiceffect= new component
		O.AddComponent(/datum/component/magic_item, magiceffect)
		O.name += " of featherstep"
		O.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=2, color=rgb(rand(1,255),rand(1,255),rand(1,255)))
		qdel(src)
	else
		to_chat(user, span_notice("Nothing happens. Perhaps you can't enchant [O] with this?"))

/obj/item/enchantmentscroll/fireresist
	name = "enchanting scroll of fire-resistance"
	desc = "A scroll imbued with an enchantment of fire resistance. Puts out flames upon you.."
	component = /datum/magic_item/superior/fireresist

/obj/item/enchantmentscroll/fireresist/attack_obj(obj/item/O, mob/living/user)
	.=..()
	if(istype(O,/obj/item/clothing))
		to_chat(user, span_notice("You open [src] and place [O] within. Moments later, it flashes blue with arcana, and [src] crumbles to dust."))
		var/magiceffect= new component
		O.AddComponent(/datum/component/magic_item, magiceffect)
		O.name += " of fire resistance"
		O.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=2, color=rgb(rand(1,255),rand(1,255),rand(1,255)))
		qdel(src)
	else
		to_chat(user, span_notice("Nothing happens. Perhaps you can't enchant [O] with this?"))

/obj/item/enchantmentscroll/climbing
	name = "enchanting scroll of spider's movement"
	desc = "A scroll imbued with an enchantment of climbing. Helps you clamber up difficult surfaces."
	component = /datum/magic_item/superior/climbing

/obj/item/enchantmentscroll/climbing/attack_obj(obj/item/O, mob/living/user)
	.=..()
	if(istype(O,/obj/item/clothing))
		to_chat(user, span_notice("You open [src] and place [O] within. Moments later, it flashes blue with arcana, and [src] crumbles to dust."))
		var/magiceffect= new component
		O.AddComponent(/datum/component/magic_item, magiceffect)
		O.name += " of fire resistance"
		O.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=2, color=rgb(rand(1,255),rand(1,255),rand(1,255)))
		qdel(src)
	else
		to_chat(user, span_notice("Nothing happens. Perhaps you can't enchant [O] with this?"))

/obj/item/enchantmentscroll/thievery
	name = "enchanting scroll of nimblefingers"
	desc = "A scroll imbued with an enchantment of thievery. Helps you steal and picklocks."
	component = /datum/magic_item/superior/thievery

/obj/item/enchantmentscroll/thievery/attack_obj(obj/item/O, mob/living/user)
	.=..()
	if(istype(O,/obj/item/clothing/gloves)||istype(O,/obj/item/clothing/ring))
		to_chat(user, span_notice("You open [src] and place [O] within. Moments later, it flashes blue with arcana, and [src] crumbles to dust."))
		var/magiceffect= new component
		O.AddComponent(/datum/component/magic_item, magiceffect)
		O.name += " of nimblefingers"
		O.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=2, color=rgb(rand(1,255),rand(1,255),rand(1,255)))
		qdel(src)
	else
		to_chat(user, span_notice("Nothing happens. Perhaps you can't enchant [O] with this?"))

/obj/item/enchantmentscroll/trekk
	name = "enchanting scroll of bog running"
	desc = "A scroll imbued with an enchantment of bog running. Provides easy movement through swamps."
	component = /datum/magic_item/superior/trekk

/obj/item/enchantmentscroll/trekk/attack_obj(obj/item/O, mob/living/user)
	.=..()
	if(istype(O,/obj/item/clothing/shoes)||istype(O,/obj/item/clothing/ring))
		to_chat(user, span_notice("You open [src] and place [O] within. Moments later, it flashes blue with arcana, and [src] crumbles to dust."))
		var/magiceffect= new component
		O.AddComponent(/datum/component/magic_item, magiceffect)
		O.name += " of bog running"
		O.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=2, color=rgb(rand(1,255),rand(1,255),rand(1,255)))
		qdel(src)
	else
		to_chat(user, span_notice("Nothing happens. Perhaps you can't enchant [O] with this?"))

/obj/item/enchantmentscroll/smithing
	name = "enchanting scroll of smithing"
	desc = "A scroll imbued with an enchantment of smithing. Provides better hammer strikes on anvils."
	component = /datum/magic_item/superior/smithing

/obj/item/enchantmentscroll/smithing/attack_obj(obj/item/O, mob/living/user)
	.=..()
	if(istype(O,/obj/item/rogueweapon/hammer))
		to_chat(user, span_notice("You open [src] and place [O] within. Moments later, it flashes blue with arcana, and [src] crumbles to dust."))
		var/magiceffect= new component
		O.AddComponent(/datum/component/magic_item, magiceffect)
		O.name += " of smithing"
		O.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=2, color=rgb(rand(1,255),rand(1,255),rand(1,255)))
		qdel(src)
	else
		to_chat(user, span_notice("Nothing happens. Perhaps you can't enchant [O] with this?"))
//T3 Enchantments below

/obj/item/enchantmentscroll/lifesteal
	name = "enchanting scroll of lyfestealing"
	desc = "A scroll imbued with an enchantment of lyfe stealing. Heals you occasionally when you hit a living foe."
	component = /datum/magic_item/greater/lifesteal

/obj/item/enchantmentscroll/lifesteal/attack_obj(obj/item/O, mob/living/user)
	.=..()
	if(istype(O,/obj/item/rogueweapon))
		to_chat(user, span_notice("You open [src] and place [O] within. Moments later, it flashes blue with arcana, and [src] crumbles to dust."))
		var/magiceffect= new component
		O.AddComponent(/datum/component/magic_item, magiceffect)
		O.name += " of lyfestealing"
		O.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=2, color=rgb(rand(1,255),rand(1,255),rand(1,255)))
		qdel(src)
	else
		to_chat(user, span_notice("Nothing happens. Perhaps you can't enchant [O] with this?"))

/obj/item/enchantmentscroll/frostveil
	name = "enchanting scroll of frostveil"
	desc = "A scroll imbued with an enchantment of frostveil. Slows enemies that hit you, or you hit."
	component = /datum/magic_item/greater/frostveil

/obj/item/enchantmentscroll/frostveil/attack_obj(obj/item/O, mob/living/user)
	.=..()
	if(istype(O,/obj/item/clothing)|| istype(O,/obj/item/rogueweapon))
		to_chat(user, span_notice("You open [src] and place [O] within. Moments later, it flashes blue with arcana, and [src] crumbles to dust."))
		var/magiceffect= new component
		O.AddComponent(/datum/component/magic_item, magiceffect)
		O.name += " of frostveil"
		O.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=2, color=rgb(rand(1,255),rand(1,255),rand(1,255)))
		qdel(src)
	else
		to_chat(user, span_notice("Nothing happens. Perhaps you can't enchant [O] with this?"))

/obj/item/enchantmentscroll/phoenixguard
	name = "enchanting scroll of phoenix guard"
	desc = "A scroll imbued with an enchantment of phoenixguard. Sets those that strike you on fire."
	component = /datum/magic_item/greater/phoenixguard

/obj/item/enchantmentscroll/phoenixguard/attack_obj(obj/item/O, mob/living/user)
	.=..()
	if(istype(O,/obj/item/clothing))
		to_chat(user, span_notice("You open [src] and place [O] within. Moments later, it flashes blue with arcana, and [src] crumbles to dust."))
		var/magiceffect= new component
		O.AddComponent(/datum/component/magic_item, magiceffect)
		O.name += " of phoenix guard"
		O.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=2, color=rgb(rand(1,255),rand(1,255),rand(1,255)))
		qdel(src)
	else
		to_chat(user, span_notice("Nothing happens. Perhaps you can't enchant [O] with this?"))

/obj/item/enchantmentscroll/shadowmeld
	name = "enchanting scroll of shadow melding"
	desc = "A scroll imbued with an enchantment of shadow melding. Slowly turns you invisible when you stay still."

/obj/item/enchantmentscroll/woundclosing
	name = "enchanting scroll of woundclosure"
	desc = "A scroll imbued with an enchantment of woundclosure. Allows you to periodically seal wounds."
	component = /datum/magic_item/greater/woundclosing

/obj/item/enchantmentscroll/woundclosing/attack_obj(obj/item/O, mob/living/user)
	.=..()
	if(istype(O,/obj/item/clothing/ring))
		to_chat(user, span_notice("You open [src] and place [O] within. Moments later, it flashes blue with arcana, and [src] crumbles to dust."))
		var/magiceffect= new component
		O.AddComponent(/datum/component/magic_item, magiceffect)
		O.name += " of wound closing"
		qdel(src)
		O.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=2, color=rgb(rand(1,255),rand(1,255),rand(1,255)))
	else
		to_chat(user, span_notice("Nothing happens. Perhaps you can't enchant [O] with this?"))

/obj/item/enchantmentscroll/returningweapon
	name = "enchanting scroll of returning weapon"
	desc = "A scroll imbued with an enchantment of returning. Enables you to summon an existing weapon to you."
	component = /datum/magic_item/greater/returningweapon

/obj/item/enchantmentscroll/returningweapon/attack_obj(obj/item/O, mob/living/user)
	.=..()
	if(istype(O,/obj/item/clothing/ring)||istype(O,/obj/item/clothing/gloves))
		to_chat(user, span_notice("You open [src] and place [O] within. Moments later, it flashes blue with arcana, and [src] crumbles to dust."))
		var/magiceffect= new component
		O.AddComponent(/datum/component/magic_item, magiceffect)
		O.name += " of returning weapon"
		O.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=2, color=rgb(rand(1,255),rand(1,255),rand(1,255)))
		qdel(src)
	else
		to_chat(user, span_notice("Nothing happens. Perhaps you can't enchant [O] with this?"))

/obj/item/enchantmentscroll/archery
	name = "enchanting scroll of archery"
	desc = "A scroll imbued with an enchantment of archery. Provides better archery skill"
	component = /datum/magic_item/greater/archery

/obj/item/enchantmentscroll/archery/attack_obj(obj/item/O, mob/living/user)
	.=..()
	if(istype(O,/obj/item/clothing/ring)||istype(O,/obj/item/clothing/gloves)|| istype(O, /obj/item/clothing/wrists/roguetown/bracers))
		to_chat(user, span_notice("You open [src] and place [O] within. Moments later, it flashes blue with arcana, and [src] crumbles to dust."))
		var/magiceffect= new component
		O.AddComponent(/datum/component/magic_item, magiceffect)
		O.name += " of archery"
		O.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=2, color=rgb(rand(1,255),rand(1,255),rand(1,255)))
		qdel(src)
	else
		to_chat(user, span_notice("Nothing happens. Perhaps you can't enchant [O] with this?"))

/obj/item/enchantmentscroll/leaping
	name = "enchanting scroll of leaping"
	desc = "A scroll imbued with an enchantment of leaping. allows those to leap up a surface."
	component = /datum/magic_item/greater/leaping

/obj/item/enchantmentscroll/leaping/attack_obj(obj/item/O, mob/living/user)
	.=..()
	if(istype(O,/obj/item/clothing/ring)|| istype(O, /obj/item/clothing/wrists/roguetown/bracers))
		to_chat(user, span_notice("You open [src] and place [O] within. Moments later, it flashes blue with arcana, and [src] crumbles to dust."))
		var/magiceffect= new component
		O.AddComponent(/datum/component/magic_item, magiceffect)
		O.name += " of archery"
		O.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=2, color=rgb(rand(1,255),rand(1,255),rand(1,255)))
		qdel(src)
	else
		to_chat(user, span_notice("Nothing happens. Perhaps you can't enchant [O] with this?"))
//T4 Enchantments below

/obj/item/enchantmentscroll/infernalflame
	name = "enchanting scroll of infernalflame"
	desc = "A scroll imbued with an enchantment of infernalflame. hitting an opponent sets them on fire."
	component = /datum/magic_item/mythic/infernalflame

/obj/item/enchantmentscroll/infernalflame/attack_obj(obj/item/O, mob/living/user)
	.=..()
	if(istype(O,/obj/item/gun/ballistic/revolver/grenadelauncher)|| istype(O,/obj/item/rogueweapon)|| istype(O,/obj/item/clothing))	//bow and crossbows included
		to_chat(user, span_notice("You open [src] and place [O] within. Moments later, it flashes blue with arcana, and [src] crumbles to dust."))
		var/magiceffect= new component
		O.AddComponent(/datum/component/magic_item, magiceffect)
		O.name += " of infernal flame"
		O.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=2, color=rgb(rand(1,255),rand(1,255),rand(1,255)))
		qdel(src)
	else
		to_chat(user, span_notice("Nothing happens. Perhaps you can't enchant [O] with this?"))

/obj/item/enchantmentscroll/freeze
	name = "enchanting scroll of freezing"
	desc = "A scroll imbued with an enchantment of freezing. freezes your foe in a block of ice"
	component = /datum/magic_item/mythic/freezing

/obj/item/enchantmentscroll/freeze/attack_obj(obj/item/O, mob/living/user)
	.=..()
	if(istype(O,/obj/item/gun/ballistic/revolver/grenadelauncher)||istype(O,/obj/item/clothing)|| istype(O,/obj/item/rogueweapon))//bow and crossbows included
		to_chat(user, span_notice("You open [src] and place [O] within. Moments later, it flashes blue with arcana, and [src] crumbles to dust."))
		var/magiceffect= new component
		O.AddComponent(/datum/component/magic_item, magiceffect)
		O.name += " of freezing"
		O.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=2, color=rgb(rand(1,255),rand(1,255),rand(1,255)))
		qdel(src)
	else
		to_chat(user, span_notice("Nothing happens. Perhaps you can't enchant [O] with this?"))


/obj/item/enchantmentscroll/briars
	name = "enchanting scroll of briars curse"
	desc = "A scroll imbued with an enchantment of briars curse. Extra damage to weapon, but self inflicted damage."
	component = /datum/magic_item/mythic/briarcurse

/obj/item/enchantmentscroll/briars/attack_obj(obj/item/O, mob/living/user)
	.=..()
	if(istype(O,/obj/item/rogueweapon))
		to_chat(user, span_notice("You open [src] and place [O] within. Moments later, it flashes blue with arcana, and [src] crumbles to dust."))
		var/magiceffect= new component
		O.AddComponent(/datum/component/magic_item, magiceffect)
		O.name += " of briars curse"
		O.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=2, color=rgb(rand(1,255),rand(1,255),rand(1,255)))
		qdel(src)
	else
		to_chat(user, span_notice("Nothing happens. Perhaps you can't enchant [O] with this?"))

/obj/item/enchantmentscroll/rewind
	name = "enchanting scroll of temporal rewind"
	desc = "A scroll imbued with an enchantment of temporal. Teleports you back where were hit, a few seconds after being hit."
	component = /datum/magic_item/mythic/rewind

/obj/item/enchantmentscroll/rewind/attack_obj(obj/item/O, mob/living/user)
	.=..()
	if(istype(O,/obj/item/clothing)|| istype(O,/obj/item/rogueweapon))
		to_chat(user, span_notice("You open [src] and place [O] within. Moments later, it flashes blue with arcana, and [src] crumbles to dust."))
		var/magiceffect= new component
		O.AddComponent(/datum/component/magic_item, magiceffect)
		O.name += " of temporal rewind"
		O.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=2, color=rgb(rand(1,255),rand(1,255),rand(1,255)))
		qdel(src)
	else
		to_chat(user, span_notice("Nothing happens. Perhaps you can't enchant [O] with this?"))