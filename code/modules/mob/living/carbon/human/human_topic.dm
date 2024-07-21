/mob/living/carbon/human/Topic(href, href_list)
	var/observer_privilege = isobserver(usr)

	if(href_list["task"] == "view_headshot")
		if(!ismob(usr))
			return
		if(!valid_headshot_link(null, headshot_link, TRUE))
			return
		var/mob/user = usr
		var/list/dat = list("<img src='[headshot_link]' width='250px' height='250px'>")
		var/datum/browser/popup = new(user, "headshot", "<div align='center'>[src]'s Headshot</div>", 310, 320)
		popup.set_content(dat.Join())
		popup.open(FALSE)
		return

	if(href_list["inspect_limb"] && (observer_privilege || usr.canUseTopic(src, BE_CLOSE, NO_DEXTERITY)))
		var/list/msg = list()
		var/mob/user = usr
		var/checked_zone = check_zone(href_list["inspect_limb"])
		var/obj/item/bodypart/bodypart = get_bodypart(checked_zone)
		if(bodypart)
			var/list/bodypart_status = bodypart.inspect_limb(user)
			if(length(bodypart_status))
				msg += bodypart_status
			else
				msg += "<B>[capitalize(bodypart.name)]:</B>"
				msg += "[bodypart] is healthy."
		else
			msg += "<B>[capitalize(parse_zone(checked_zone))]:</B>"
			msg += span_dead("Limb is missing!")
		to_chat(usr, span_info("[msg.Join("\n")]"))

	if(href_list["embedded_object"] && usr.canUseTopic(src, BE_CLOSE, NO_DEXTERITY))
		var/obj/item/bodypart/L = locate(href_list["embedded_limb"]) in bodyparts
		if(!L)
			return
		var/obj/item/I = locate(href_list["embedded_object"]) in L.embedded_objects
		if(!I) //no item, no limb, or item is not in limb or in the person anymore
			return
		var/time_taken = I.embedding.embedded_unsafe_removal_time*I.w_class
		if(usr == src)
			usr.visible_message(span_warning("[usr] attempts to remove [I] from [usr.p_their()] [L.name]."),span_warning("I attempt to remove [I] from my [L.name]..."))
		else
			usr.visible_message(span_warning("[usr] attempts to remove [I] from [src]'s [L.name]."),span_warning("I attempt to remove [I] from [src]'s [L.name]..."))
		if(do_after(usr, time_taken, needhand = TRUE, target = src))
			if(QDELETED(I) || QDELETED(L) || !L.remove_embedded_object(I))
				return
			L.receive_damage(I.embedding.embedded_unsafe_removal_pain_multiplier*I.w_class)//It hurts to rip it out, get surgery you dingus.
			usr.put_in_hands(I)
			emote("pain", TRUE)
			playsound(loc, 'sound/foley/flesh_rem.ogg', 100, TRUE, -2)
			if(usr == src)
				usr.visible_message(span_notice("[usr] rips [I] out of [usr.p_their()] [L.name]!"), span_notice("I successfully remove [I] from my [L.name]."))
			else
				usr.visible_message(span_notice("[usr] rips [I] out of [src]'s [L.name]!"), span_notice("I successfully remove [I] from [src]'s [L.name]."))

	if(href_list["bandage"] && usr.canUseTopic(src, BE_CLOSE, NO_DEXTERITY))
		var/obj/item/bodypart/L = locate(href_list["bandaged_limb"]) in bodyparts
		if(!L)
			return
		var/obj/item/I = L.bandage
		if(!I)
			return
		if(usr == src)
			usr.visible_message(span_warning("[usr] starts unbandaging [usr.p_their()] [L.name]."),span_warning("I start unbandaging [L.name]..."))
		else
			usr.visible_message(span_warning("[usr] starts unbandaging [src]'s [L.name]."),span_warning("I start unbandaging [src]'s [L.name]..."))
		if(do_after(usr, 50, needhand = TRUE, target = src))
			if(QDELETED(I) || QDELETED(L) || (L.bandage != I))
				return
			L.remove_bandage()
			usr.put_in_hands(I)

	if(href_list["item"]) //canUseTopic check for this is handled by mob/Topic()
		var/slot = text2num(href_list["item"])
		if(slot in check_obscured_slots(TRUE))
			to_chat(usr, span_warning("I can't reach that! Something is covering it."))
			return

	if(href_list["undiesthing"]) //canUseTopic check for this is handled by mob/Topic()
		if(!get_location_accessible(src, BODY_ZONE_PRECISE_GROIN, skipundies = TRUE))
			to_chat(usr, span_warning("I can't reach that! Something is covering it."))
			return
		if(underwear == "Nude")
			return
		if(do_after(usr, 50, needhand = 1, target = src))
			cached_underwear = underwear
			underwear = "Nude"
			update_body()
			var/obj/item/undies/U
			if(gender == MALE)
				U = new/obj/item/undies(get_turf(src))
			else
				U = new/obj/item/undies/f(get_turf(src))
			U.color = underwear_color
			if(iscarbon(usr))
				var/mob/living/carbon/C = usr
				C.put_in_hands(U)

	if(href_list["pockets"] && usr.canUseTopic(src, BE_CLOSE, NO_DEXTERITY)) //TODO: Make it match (or intergrate it into) strippanel so you get 'item cannot fit here' warnings if mob_can_equip fails
		var/pocket_side = href_list["pockets"]
		var/pocket_id = (pocket_side == "right" ? SLOT_R_STORE : SLOT_L_STORE)
		var/obj/item/pocket_item = (pocket_id == SLOT_R_STORE ? r_store : l_store)
		var/obj/item/place_item = usr.get_active_held_item() // Item to place in the pocket, if it's empty

		var/delay_denominator = 1
		if(pocket_item && !(pocket_item.item_flags & ABSTRACT))
			if(HAS_TRAIT(pocket_item, TRAIT_NODROP))
				to_chat(usr, span_warning("I try to empty [src]'s [pocket_side] pocket, it seems to be stuck!"))
			to_chat(usr, span_notice("I try to empty [src]'s [pocket_side] pocket."))
		else if(place_item && place_item.mob_can_equip(src, usr, pocket_id, 1) && !(place_item.item_flags & ABSTRACT))
			to_chat(usr, span_notice("I try to place [place_item] into [src]'s [pocket_side] pocket."))
			delay_denominator = 4
		else
			return

		if(do_mob(usr, src, POCKET_STRIP_DELAY/delay_denominator)) //placing an item into the pocket is 4 times faster
			if(pocket_item)
				if(pocket_item == (pocket_id == SLOT_R_STORE ? r_store : l_store)) //item still in the pocket we search
					dropItemToGround(pocket_item)
			else
				if(place_item)
					if(place_item.mob_can_equip(src, usr, pocket_id, FALSE, TRUE))
						usr.temporarilyRemoveItemFromInventory(place_item, TRUE)
						equip_to_slot(place_item, pocket_id, TRUE)
					//do nothing otherwise
				//updating inv screen after handled by living/Topic()
		else
			// Display a warning if the user mocks up
			to_chat(src, span_warning("I feel your [pocket_side] pocket being fumbled with!"))

	if(href_list["task"] == "view_erp_preferences") //To know if they want to ERP
		switch (client.prefs.sexable)
			if(TRUE)
				to_chat(usr, span_love("They allowed to use ERP Panel on them!"))
			else
				to_chat(usr, span_warning("They DID NOT ALLOW to use ERP Panel on them!"))

///////HUDs///////
	if(href_list["hud"])
		if(!ishuman(usr))
			return
		var/mob/living/carbon/human/H = usr
		var/perpname = get_face_name(get_id_name(""))
		if(!HAS_TRAIT(H, TRAIT_SECURITY_HUD) && !HAS_TRAIT(H, TRAIT_MEDICAL_HUD))
			return
		var/datum/data/record/R = find_record("name", perpname, GLOB.data_core.general)
		if(href_list["photo_front"] || href_list["photo_side"])
			if(!R)
				return
			if(!H.canUseHUD())
				return
			if(!HAS_TRAIT(H, TRAIT_SECURITY_HUD) && !HAS_TRAIT(H, TRAIT_MEDICAL_HUD))
				return
			var/obj/item/photo/P = null
			if(href_list["photo_front"])
				P = R.fields["photo_front"]
			else if(href_list["photo_side"])
				P = R.fields["photo_side"]
			if(P)
				P.show(H)
			return

		if(href_list["hud"] == "m")
			if(!HAS_TRAIT(H, TRAIT_MEDICAL_HUD))
				return
			if(href_list["evaluation"])
				if(!getBruteLoss() && !getFireLoss() && !getOxyLoss() && getToxLoss() < 20)
					to_chat(usr, "<span class='notice'>No external injuries detected.</span><br>")
					return
				var/span = "notice"
				var/status = ""
				if(getBruteLoss())
					to_chat(usr, "<b>Physical trauma analysis:</b>")
					for(var/X in bodyparts)
						var/obj/item/bodypart/BP = X
						var/brutedamage = BP.brute_dam
						if(brutedamage > 0)
							status = "received minor physical injuries."
							span = "notice"
						if(brutedamage > 20)
							status = "been seriously damaged."
							span = "danger"
						if(brutedamage > 40)
							status = "sustained major trauma!"
							span = "danger"
						if(brutedamage)
							to_chat(usr, "<span class='[span]'>[BP] appears to have [status]</span>")
				if(getFireLoss())
					to_chat(usr, "<b>Analysis of skin burns:</b>")
					for(var/X in bodyparts)
						var/obj/item/bodypart/BP = X
						var/burndamage = BP.burn_dam
						if(burndamage > 0)
							status = "signs of minor burns."
							span = "notice"
						if(burndamage > 20)
							status = "serious burns."
							span = "danger"
						if(burndamage > 40)
							status = "major burns!"
							span = "danger"
						if(burndamage)
							to_chat(usr, "<span class='[span]'>[BP] appears to have [status]</span>")
				if(getOxyLoss())
					to_chat(usr, span_danger("Patient has signs of suffocation, emergency treatment may be required!"))
				if(getToxLoss() > 20)
					to_chat(usr, span_danger("Gathered data is inconsistent with the analysis, possible cause: poisoning."))
			if(!H.wear_ring) //You require access from here on out.
				to_chat(H, span_warning("ERROR: Invalid access"))
				return
			var/list/access = H.wear_ring.GetAccess()
			if(!(ACCESS_MEDICAL in access))
				to_chat(H, span_warning("ERROR: Invalid access"))
				return
			if(href_list["p_stat"])
				var/health_status = input(usr, "Specify a new physical status for this person.", "Medical HUD", R.fields["p_stat"]) in list("Active", "Physically Unfit", "*Unconscious*", "*Deceased*", "Cancel")
				if(!R)
					return
				if(!H.canUseHUD())
					return
				if(!HAS_TRAIT(H, TRAIT_MEDICAL_HUD))
					return
				if(health_status && health_status != "Cancel")
					R.fields["p_stat"] = health_status
				return
			if(href_list["m_stat"])
				var/health_status = input(usr, "Specify a new mental status for this person.", "Medical HUD", R.fields["m_stat"]) in list("Stable", "*Watch*", "*Unstable*", "*Insane*", "Cancel")
				if(!R)
					return
				if(!H.canUseHUD())
					return
				if(!HAS_TRAIT(H, TRAIT_MEDICAL_HUD))
					return
				if(health_status && health_status != "Cancel")
					R.fields["m_stat"] = health_status
				return
			return //Medical HUD ends here.

		if(href_list["hud"] == "s")
			if(!HAS_TRAIT(H, TRAIT_SECURITY_HUD))
				return
			if(usr.stat || usr == src) //|| !usr.canmove || usr.restrained()) Fluff: Sechuds have eye-tracking technology and sets 'arrest' to people that the wearer looks and blinks at.
				return													  //Non-fluff: This allows sec to set people to arrest as they get disarmed or beaten
			// Checks the user has security clearence before allowing them to change arrest status via hud, comment out to enable all access
			var/allowed_access = null
			var/obj/item/clothing/glasses/hud/security/G = H.glasses
			if(istype(G) && (G.obj_flags & EMAGGED))
				allowed_access = "@%&ERROR_%$*"
			else //Implant and standard glasses check access
				if(H.wear_ring)
					var/list/access = H.wear_ring.GetAccess()
					if(ACCESS_SEC_DOORS in access)
						allowed_access = H.get_authentification_name()

			if(!allowed_access)
				to_chat(H, span_warning("ERROR: Invalid access."))
				return

			if(!perpname)
				to_chat(H, span_warning("ERROR: Can not identify target."))
				return
			R = find_record("name", perpname, GLOB.data_core.security)
			if(!R)
				to_chat(usr, span_warning("ERROR: Unable to locate data core entry for target."))
				return
			if(href_list["status"])
				var/setcriminal = input(usr, "Specify a new criminal status for this person.", "Security HUD", R.fields["criminal"]) in list("None", "*Arrest*", "Incarcerated", "Paroled", "Discharged", "Cancel")
				if(setcriminal != "Cancel")
					if(!R)
						return
					if(!H.canUseHUD())
						return
					if(!HAS_TRAIT(H, TRAIT_SECURITY_HUD))
						return
					investigate_log("[key_name(src)] has been set from [R.fields["criminal"]] to [setcriminal] by [key_name(usr)].", INVESTIGATE_RECORDS)
					R.fields["criminal"] = setcriminal
					sec_hud_set_security_status()
				return

			if(href_list["view"])
				if(!H.canUseHUD())
					return
				if(!HAS_TRAIT(H, TRAIT_SECURITY_HUD))
					return
				to_chat(usr, "<b>Name:</b> [R.fields["name"]]	<b>Criminal Status:</b> [R.fields["criminal"]]")
				to_chat(usr, "<b>Minor Crimes:</b>")
				for(var/datum/data/crime/c in R.fields["mi_crim"])
					to_chat(usr, "<b>Crime:</b> [c.crimeName]")
					to_chat(usr, "<b>Details:</b> [c.crimeDetails]")
					to_chat(usr, "Added by [c.author] at [c.time]")
					to_chat(usr, "----------")
					to_chat(usr, "<b>Major Crimes:</b>")
				for(var/datum/data/crime/c in R.fields["ma_crim"])
					to_chat(usr, "<b>Crime:</b> [c.crimeName]")
					to_chat(usr, "<b>Details:</b> [c.crimeDetails]")
					to_chat(usr, "Added by [c.author] at [c.time]")
					to_chat(usr, "----------")
				to_chat(usr, "<b>Notes:</b> [R.fields["notes"]]")
				return

			if(href_list["add_crime"])
				switch(alert("What crime would you like to add?","Security HUD","Minor Crime","Major Crime","Cancel"))
					if("Minor Crime")
						var/t1 = stripped_input("Please input minor crime names:", "Security HUD", "", null)
						var/t2 = stripped_multiline_input("Please input minor crime details:", "Security HUD", "", null)
						if(!R || !t1 || !t2 || !allowed_access)
							return
						if(!H.canUseHUD())
							return
						if(!HAS_TRAIT(H, TRAIT_SECURITY_HUD))
							return
						var/crime = GLOB.data_core.createCrimeEntry(t1, t2, allowed_access, station_time_timestamp())
						GLOB.data_core.addMinorCrime(R.fields["id"], crime)
						investigate_log("New Minor Crime: <strong>[t1]</strong>: [t2] | Added to [R.fields["name"]] by [key_name(usr)]", INVESTIGATE_RECORDS)
						to_chat(usr, span_notice("Successfully added a minor crime."))
						return
					if("Major Crime")
						var/t1 = stripped_input("Please input major crime names:", "Security HUD", "", null)
						var/t2 = stripped_multiline_input("Please input major crime details:", "Security HUD", "", null)
						if(!R || !t1 || !t2 || !allowed_access)
							return
						if(!H.canUseHUD())
							return
						if(!HAS_TRAIT(H, TRAIT_SECURITY_HUD))
							return
						var/crime = GLOB.data_core.createCrimeEntry(t1, t2, allowed_access, station_time_timestamp())
						GLOB.data_core.addMajorCrime(R.fields["id"], crime)
						investigate_log("New Major Crime: <strong>[t1]</strong>: [t2] | Added to [R.fields["name"]] by [key_name(usr)]", INVESTIGATE_RECORDS)
						to_chat(usr, span_notice("Successfully added a major crime."))
				return

			if(href_list["view_comment"])
				if(!H.canUseHUD())
					return
				if(!HAS_TRAIT(H, TRAIT_SECURITY_HUD))
					return
				to_chat(usr, "<b>Comments/Log:</b>")
				var/counter = 1
				while(R.fields[text("com_[]", counter)])
					to_chat(usr, R.fields[text("com_[]", counter)])
					to_chat(usr, "----------")
					counter++
				return

			if(href_list["add_comment"])
				var/t1 = stripped_multiline_input("Add Comment:", "Secure. records", null, null)
				if (!R || !t1 || !allowed_access)
					return
				if(!H.canUseHUD())
					return
				if(!HAS_TRAIT(H, TRAIT_SECURITY_HUD))
					return
				var/counter = 1
				while(R.fields[text("com_[]", counter)])
					counter++
				R.fields[text("com_[]", counter)] = text("Made by [] on [] [], []<BR>[]", allowed_access, station_time_timestamp(), time2text(world.realtime, "MMM DD"), GLOB.year_integer+540, t1)
				to_chat(usr, span_notice("Successfully added comment."))
				return

	return ..() //end of this massive fucking chain. TODO: make the hud chain not spooky. - Yeah, great job doing that.
