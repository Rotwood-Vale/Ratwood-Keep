/obj/item/clothing/head/roguetown/helmet/heavy
	flags_inv = HIDEEARS|HIDEHAIR|HIDEFACIALHAIR|HIDEFACE

/obj/item/clothing/head/roguetown/grenzelhofthat
	armor = list("blunt" = 15, "slash" = 20, "stab" = 15, "bullet" = 1, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	var/picked = FALSE

/obj/item/clothing/head/roguetown/grenzelhofthat/attack_right(mob/user)
	..()
	if(!picked)
		var/list/colors = list(
		"Swan White"="#ffffff",
		"Lavender"="#865c9c",
		"Royal Purple"="#5E4687",
		"Wine Rouge"="#752B55",
		"Sow's skin"="#CE929F",
		"Knight's Red"="#933030",
		"Madroot Red"="#AD4545",
		"Marigold Orange"="#E2A844",
		"Politely, Yuck"="#685542",
		"Astrata's Yellow"="#FFFD8D",
		"Bog Green"="#375B48",
		"Seafoam Green"="#49938B",
		"Woad Blue"="#395480",
		"Cornflower Blue"="#749EE8",
		"Blacksteel Grey"="#404040",)

		var/choice = input(user, "Choose a color.", "Grenzelhoft colors") as anything in colors
		var/playerchoice = colors[choice]
		picked = TRUE
		detail_color = playerchoice
		detail_tag = "_detail"
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()

/obj/item/clothing/head/roguetown/grenzelhofthat/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/head/roguetown/helmet/heavy/footmanhelmet
	name = "footman helmet"
	desc = "A helmet worn in Grenzelhoft by rank and file soldiery. The color of the plume is often used to specify a soldier's batallion, making it easier to coordinate in battle."
	block2add = FOV_BEHIND
	flags_inv = HIDEHAIR
	icon_state = "footmanhelmet"
	item_state = "footmanhelmet"
	icon = 'modular_redmoon/icons/hats.dmi'
	mob_overlay_icon = 'modular_redmoon/icons/head_64x64.dmi'
	worn_x_dimension = 64
	worn_y_dimension = 64
	var/picked = FALSE
	smeltresult = /obj/item/ingot/iron

/obj/item/clothing/head/roguetown/helmet/heavy/footmanhelmet/attack_right(mob/user)
	..()
	if(!picked)
		var/list/colors = list(
		"Swan White"="#ffffff",
		"Lavender"="#865c9c",
		"Royal Purple"="#5E4687",
		"Wine Rouge"="#752B55",
		"Sow's skin"="#CE929F",
		"Knight's Red"="#933030",
		"Madroot Red"="#AD4545",
		"Marigold Orange"="#E2A844",
		"Politely, Yuck"="#685542",
		"Astrata's Yellow"="#FFFD8D",
		"Bog Green"="#375B48",
		"Seafoam Green"="#49938B",
		"Woad Blue"="#395480",
		"Cornflower Blue"="#749EE8",
		"Blacksteel Grey"="#404040",)

		var/choice = input(user, "Choose a color.", "Grenzelhoft colors") as anything in colors
		var/playerchoice = colors[choice]
		picked = TRUE
		detail_color = playerchoice
		detail_tag = "_detail"
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()

/obj/item/clothing/head/roguetown/helmet/heavy/footmanhelmet/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/head/roguetown/helmet/heavy/grenzknighthelmet
	name = "grenzelhoft knight helmet"
	desc = "A helmet worn by Grenzelhoft knights, made of black-steel. The feathers on the back of it can be colored to show off ones noble house or allegiance."
	block2add = FOV_BEHIND
	flags_inv = HIDEEARS|HIDEHAIR|HIDEFACE|HIDEFACIALHAIR
	icon_state = "grenzkhelm"
	item_state = "grenzkhelm"
	icon = 'modular_redmoon/icons/hats.dmi'
	mob_overlay_icon = 'modular_redmoon/icons/head_64x64.dmi'
	worn_x_dimension = 64
	worn_y_dimension = 64
	var/picked = FALSE
	smeltresult = /obj/item/ingot/iron

/obj/item/clothing/head/roguetown/helmet/heavy/grenzknighthelmet/attack_right(mob/user)
	..()
	if(!picked)
		var/list/colors = list(
		"Swan White"="#ffffff",
		"Lavender"="#865c9c",
		"Royal Purple"="#5E4687",
		"Wine Rouge"="#752B55",
		"Sow's skin"="#CE929F",
		"Knight's Red"="#933030",
		"Madroot Red"="#AD4545",
		"Marigold Orange"="#E2A844",
		"Politely, Yuck"="#685542",
		"Astrata's Yellow"="#FFFD8D",
		"Bog Green"="#375B48",
		"Seafoam Green"="#49938B",
		"Woad Blue"="#395480",
		"Cornflower Blue"="#749EE8",
		"Blacksteel Grey"="#404040",)

		var/choice = input(user, "Choose a color.", "Grenzelhoft colors") as anything in colors
		var/playerchoice = colors[choice]
		picked = TRUE
		detail_color = playerchoice
		detail_tag = "_detail"
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()

/obj/item/clothing/head/roguetown/helmet/heavy/grenzknighthelmet/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/head/roguetown/helmet/heavy/decoratedknighthelm
	name = "decorated knight helmet"
	desc = "A lavish knight's helmet which allows a crest to be mounted on top."
	block2add = FOV_BEHIND
	flags_inv = HIDEEARS|HIDEHAIR|HIDEFACIALHAIR|HIDEFACE
	icon_state = "decorated_knight"
	item_state = "decorated_knight"
	icon = 'modular_redmoon/icons/hats.dmi'
	mob_overlay_icon = 'modular_redmoon/icons/head_64x64.dmi'
	worn_x_dimension = 64
	worn_y_dimension = 64
	var/picked = FALSE
	smeltresult = /obj/item/ingot/steel

/obj/item/clothing/head/roguetown/helmet/heavy/decoratedknighthelm/attack_right(mob/user)
	..()
	if(!picked)
		var/list/icons = list(
		"Basic"="basic_decoration",
		"Blue"="blue_decoration",
		"Stripes"="stripes_decoration",
		"Red Castle"="castle_red_decoration",
		"White Castle"="castle_white_decoration",
		"Nyrnhe"="graggar_decoration",
		"Efreet"="efreet_decoration",
		"Sun"="sun_decoration",
		"Feathers"="feathers_decoration",
		"Lion"="lion_decoration",
		"Red Dragon"="dragon_red_decoration",
		"Green Dragon"="dragon_green_decoration",
		"Horns"="horns_decoration",
		"Swan"="swan_decoration",
		"Fish"="fish_decoration",
		"Oathtaker"="oathtaker_decoration",
		"Skull"="skull_decoration")

		var/choice = input(user, "Choose a crest.", "Knightly crests") as anything in icons
		var/playerchoice = icons[choice]
		picked = TRUE
		icon_state = playerchoice
		item_state = playerchoice
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()

/obj/item/clothing/head/roguetown/helmet/heavy/decoratedknighthelm/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/head/roguetown/helmet/heavy/decoratedhounskull
	name = "decorated hounskull"
	desc = "A lavish hounskull which allows a crest to be mounted on top."
	block2add = FOV_BEHIND
	flags_inv = HIDEEARS|HIDEHAIR|HIDEFACIALHAIR|HIDEFACE
	icon_state = "decorated_hounskull"
	item_state = "decorated_hounskull"
	icon = 'modular_redmoon/icons/hats.dmi'
	mob_overlay_icon = 'modular_redmoon/icons/head_64x64.dmi'
	worn_x_dimension = 64
	worn_y_dimension = 64
	var/picked = FALSE
	smeltresult = /obj/item/ingot/steel

/obj/item/clothing/head/roguetown/helmet/heavy/decoratedhounskull/attack_right(mob/user)
	..()
	if(!picked)
		var/list/icons = list(
		"Basic"="basic_houndecoration",
		"Blue"="blue_houndecoration",
		"Stripes"="stripes_houndecoration",
		"Red Castle"="castle_red_houndecoration",
		"White Castle"="castle_white_houndecoration",
		"Nyrnhe"="graggar_houndecoration",
		"Efreet"="efreet_houndecoration",
		"Sun"="sun_houndecoration",
		"Feathers"="feathers_houndecoration",
		"Lion"="lion_houndecoration",
		"Red Dragon"="dragon_red_houndecoration",
		"Green Dragon"="dragon_green_houndecoration",
		"Horns"="horns_houndecoration",
		"Swan"="swan_houndecoration",
		"Fish"="fish_houndecoration",
		"Oathtaker"="oathtaker_houndecoration",
		"Skull"="skull_houndecoration")

		var/choice = input(user, "Choose a crest.", "Knightly crests") as anything in icons
		var/playerchoice = icons[choice]
		picked = TRUE
		icon_state = playerchoice
		item_state = playerchoice
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()

/obj/item/clothing/head/roguetown/helmet/heavy/decoratedhounskull/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/head/roguetown/helmet/heavy/decoratedbucket
	name = "decorated greathelm"
	desc = "A lavish greathelm which allows a crest to be mounted on top."
	block2add = FOV_BEHIND
	flags_inv = HIDEEARS|HIDEHAIR|HIDEFACIALHAIR|HIDEFACE
	icon_state = "decorated_bucket"
	item_state = "decorated_bucket"
	icon = 'modular_redmoon/icons/hats.dmi'
	mob_overlay_icon = 'modular_redmoon/icons/head_64x64.dmi'
	worn_x_dimension = 64
	worn_y_dimension = 64
	var/picked = FALSE
	smeltresult = /obj/item/ingot/steel

/obj/item/clothing/head/roguetown/helmet/heavy/decoratedbucket/attack_right(mob/user)
	..()
	if(!picked)
		var/list/icons = list(
		"Basic"="basic_bucket",
		"Blue"="blue_bucket",
		"Stripes"="stripes_bucket",
		"Red Castle"="castle_red_bucket",
		"White Castle"="castle_white_bucket",
		"Nyrnhe"="graggar_bucket",
		"Efreet"="efreet_bucket",
		"Sun"="sun_bucket",
		"Feathers"="feathers_bucket",
		"Lion"="lion_bucket",
		"Red Dragon"="dragon_red_bucket",
		"Green Dragon"="dragon_green_bucket",
		"Horns"="horns_bucket",
		"Swan"="swan_bucket",
		"Fish"="fish_bucket",
		"Oathtaker"="oathtaker_bucket",
		"Skull"="skull_bucket")

		var/choice = input(user, "Choose a crest.", "Knightly crests") as anything in icons
		var/playerchoice = icons[choice]
		picked = TRUE
		icon_state = playerchoice
		item_state = playerchoice
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()

/obj/item/clothing/head/roguetown/helmet/heavy/decoratedbucket/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/head/roguetown/helmet/heavy/decoratedgbucket
	name = "decorated goldhelm"
	desc = "A lavish gold-trimmed greathelm which allows a crest to be mounted on top."
	block2add = FOV_BEHIND
	flags_inv = HIDEEARS|HIDEHAIR|HIDEFACIALHAIR|HIDEFACE
	icon_state = "decorated_gbucket"
	item_state = "decorated_gbucket"
	icon = 'modular_redmoon/icons/hats.dmi'
	mob_overlay_icon = 'modular_redmoon/icons/head_64x64.dmi'
	worn_x_dimension = 64
	worn_y_dimension = 64
	var/picked = FALSE
	smeltresult = /obj/item/ingot/steel

/obj/item/clothing/head/roguetown/helmet/heavy/decoratedgbucket/attack_right(mob/user)
	..()
	if(!picked)
		var/list/icons = list(
		"Basic"="basic_gbucket",
		"Blue"="blue_gbucket",
		"Stripes"="stripes_gbucket",
		"Red Castle"="castle_red_gbucket",
		"White Castle"="castle_white_gbucket",
		"Nyrnhe"="graggar_gbucket",
		"Efreet"="efreet_gbucket",
		"Sun"="sun_gbucket",
		"Feathers"="feathers_gbucket",
		"Lion"="lion_gbucket",
		"Red Dragon"="dragon_red_gbucket",
		"Green Dragon"="dragon_green_gbucket",
		"Horns"="horns_gbucket",
		"Swan"="swan_gbucket",
		"Fish"="fish_gbucket",
		"Oathtaker"="oathtaker_gbucket",
		"Skull"="skull_gbucket")

		var/choice = input(user, "Choose a crest.", "Knightly crests") as anything in icons
		var/playerchoice = icons[choice]
		picked = TRUE
		icon_state = playerchoice
		item_state = playerchoice
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()

/obj/item/clothing/head/roguetown/helmet/heavy/decoratedgbucket/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)
	clothing_flags = null
	salvage_amount = 1
	salvage_result = /obj/item/natural/hide

/obj/item/clothing/head/roguetown/helmet/heavy/xylixcagehelm
	name = "Xylix Cage Helmet"
	desc = "Headwear commonly worn by acolytes who worship Xylix. Life is a cage and we must all do our time."
	icon_state = "xylixcagehelm"
	item_state = "xylixcagehelm"
	icon = 'modular_redmoon/icons/hats.dmi'
	mob_overlay_icon = 'modular_redmoon/icons/head_64x64.dmi'
	worn_x_dimension = 64
	worn_y_dimension = 64
	emote_environment = 3
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel

/obj/item/clothing/head/roguetown/helmet/heavy/xylixhelm
	name = "Xylix Helmet"
	desc = "Headwear commonly worn by Templars in service to Xylix. Can you see it yet? If not it might be best to add more eyes."
	icon_state = "xylixhelm"
	item_state = "xylixhelm"
	icon = 'modular_redmoon/icons/hats.dmi'
	mob_overlay_icon = 'modular_redmoon/icons/head.dmi'
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	emote_environment = 3
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel

/obj/item/clothing/head/roguetown/helmet/heavy/abyssorhelm
	name = "Abyssor Helmet"
	desc = "Headwear commonly worn by Templars in service to Abyssor. This helmet somewhat resembles some of the stranger fish that have been dragged up from the depths of the ocean."
	icon_state = "abyssorhelm"
	item_state = "abyssorhelm"
	icon = 'modular_redmoon/icons/hats.dmi'
	mob_overlay_icon = 'modular_redmoon/icons/head.dmi'
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	emote_environment = 3
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel

/obj/item/clothing/head/roguetown/roguehood/abyssor
	name = "Abyssor Hood"
	desc = "A hood worn by the followers of Abyssor, with a unique, coral-shaped mask. How do they even see out of this?"
	color = null
	icon = 'modular_redmoon/icons/hats.dmi'
	mob_overlay_icon = 'modular_redmoon/icons/head.dmi'
	icon_state = "abyssorhood"
	item_state = "abyssorhood"
	body_parts_covered = HEAD|HAIR|NECK
	slot_flags = ITEM_SLOT_HEAD
	dynamic_hair_suffix = ""
	edelay_type = 1
	adjustable = CAN_CADJUST
	toggle_icon_state = TRUE
	max_integrity = 100

/obj/item/clothing/head/roguetown/helmet/heavy/pestrahelm
	name = "Pestra Helmet"
	desc = "Headwear commonly worn by Templars in service to Pestra. This helmet has a decorated mask attached to it, tears running down its eye slits. To some, Pestra's fate is a tragedy worthy of tears. To be both the disease and the cure.."
	icon_state = "pestrahelm"
	item_state = "pestrahelm"
	icon = 'modular_redmoon/icons/hats.dmi'
	mob_overlay_icon = 'modular_redmoon/icons/head.dmi'
	flags_inv = HIDEFACE|HIDEHAIR
	emote_environment = 3
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel

// /obj/item/clothing/head/roguetown/helmet/heavy/psyhelm
// 	name = "Cultist helmet"
// 	desc = "A helmet formerly worn by those who were templars in service to Dragon Cults."
// 	icon_state = "psydonhelm"
// 	item_state = "psydonhelm"
// 	icon = 'modular_redmoon/icons/hats.dmi'
// 	mob_overlay_icon = 'modular_redmoon/icons/head.dmi'
// 	emote_environment = 3
// 	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
// 	block2add = FOV_BEHIND

/obj/item/clothing/head/roguetown/helmet/heavy/eorahelm
	name = "Eora Helmet"
	desc = "Headwear commonly worn by Templars in service to Eora. The chained heart on its front demonstrates its wearer's commitment to protect unbound love, even at ones own expense."
	icon_state = "eorahelm"
	item_state = "eorahelm"
	icon = 'modular_redmoon/icons/hats.dmi'
	mob_overlay_icon = 'modular_redmoon/icons/head.dmi'
	emote_environment = 3
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel

/obj/item/clothing/head/roguetown/roguehood/flagellanthood
	name = "ravox hood"
	desc = "Headwear commonly worn by Acolytes who worship Ravox. The most fanatical of Ravox's followers are known to flagellate themselves, in an attempt to purge any weakness from their mortal body. As such, the robes help to hide the blood somewhat."
	icon_state = "ravoxhood"
	item_state = "ravoxhood"
	icon = 'modular_redmoon/icons/hats.dmi'
	mob_overlay_icon = 'modular_redmoon/icons/head.dmi'
	body_parts_covered = NECK
	color = null
	slot_flags = ITEM_SLOT_HEAD
	flags_inv = HIDEHAIR|HIDEEARS
	dynamic_hair_suffix = ""
	edelay_type = 1

/obj/item/clothing/head/roguetown/helmet/heavy/royalknight
	name = "royal guard's helmet"
	desc = "A helmet worn by those in the royal guard. Decorated with gold, its white feathers a sign of the oath made to protect the royals until death."
	icon_state = "royalh"
	item_state = "royalh"
	icon = 'modular_redmoon/icons/hats.dmi'
	mob_overlay_icon = 'modular_redmoon/icons/head.dmi'
	adjustable = CAN_CADJUST
	emote_environment = 3
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel

/obj/item/clothing/head/roguetown/helmet/heavy/royalknight/black
	color = CLOTHING_BLACK

/obj/item/clothing/head/roguetown/helmet/heavy/royalknight/AdjustClothes(mob/user)
	if(loc == user)
		playsound(user, "sound/items/visor.ogg", 100, TRUE, -1)
		if(adjustable == CAN_CADJUST)
			adjustable = CADJUSTED
			icon_state = "royalhum"
			body_parts_covered = HEAD|HAIR|EARS
			flags_inv = HIDEHAIR
			flags_cover = null
			emote_environment = 0
			update_icon()
			if(ishuman(user))
				var/mob/living/carbon/H = user
				H.update_inv_head()
			block2add = null
		else if(adjustable == CADJUSTED)
			ResetAdjust(user)
			emote_environment = 3
			update_icon()
			if(user)
				if(ishuman(user))
					var/mob/living/carbon/H = user
					H.update_inv_head()
		user.update_fov_angles()

/obj/item/clothing/head/roguetown/helmet/heavy/royalknight/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/head/roguetown/maidhead
	name = "maid headdress"
	desc = "A decorative cloth headband clearly indicating the wearer as a maid."
	icon = 'modular_redmoon/icons/hats.dmi'
	mob_overlay_icon = 'modular_redmoon/icons/head.dmi'
	icon_state = "maidhead"
	item_state = "maidhead"

/obj/item/clothing/head/roguetown/helmet/bascinet/shapel
	name = "Shapel Helmet"
	flags_inv = HIDEEARS
	icon = 'modular_redmoon/icons/hats.dmi'
	mob_overlay_icon = 'modular_redmoon/icons/head.dmi'
	icon_state = "ldgn_shapel"
