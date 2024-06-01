/mob/living/carbon/human/Topic(href, href_list)
	var/observer_privilege = isobserver(usr)
	if(href_list["task"] == "view_headshot")
		if(!ismob(usr))
			return
		if(!valid_headshot_link(null, headshot_link, TRUE))
			return
		var/mob/user = usr
		var/list/dat = list("<img src='[headshot_link]' width='250px' height='250px'>")
		var/datum/browser/popup = new(user, "headshot", "<div align='center'>[src]'s Headshot</div>", 260, 260)
		popup.set_content(dat.Join())
		popup.open(FALSE)
		return
	if(href_list["inspect_limb"] && (observer_privilege || usr.canUseTopic(src, BE_CLOSE, NO_DEXTERITY)))
		var/list/msg = list()
		var/mob/user = usr
		var/checked_zone = check_zone(href_list["inspect_limb"])
		var/obj/item/bodypart/BP = get_bodypart(checked_zone)
		msg += "<B>[capitalize(parse_zone(checked_zone))]:</B>"
		if(BP)
			var/bodypart_status = list()
			if(BP.disabled)
				switch(BP.disabled)
					if(BODYPART_DISABLED_DAMAGE)
						bodypart_status += "[BP] is numb to touch."
					if(BODYPART_DISABLED_PARALYSIS)
						bodypart_status += "[BP] is limp."
					else
						bodypart_status += "[BP] is crippled."
			if(BP.has_wound(/datum/wound/fracture))
				bodypart_status += "[BP] is fractured."
			if(BP.has_wound(/datum/wound/dislocation))
				bodypart_status += "[BP] is dislocated."
			var/location_accessible = get_location_accessible(src, checked_zone)
			if(!location_accessible)
				bodypart_status += "Obscured by clothing."
			if(observer_privilege || location_accessible)
				if(BP.skeletonized)
					bodypart_status += "[BP] is skeletonized."
				else if(BP.rotted)
					bodypart_status += "[BP] is necrotic."
				
				var/brute = BP.brute_dam
				var/burn = BP.burn_dam
				if(user.hallucinating())
					if(prob(30))
						brute += rand(20,40)
					if(prob(30))
						burn += rand(20,40)

				if(brute >= DAMAGE_PRECISION)
					switch(brute/BP.max_damage)
						if(0.75 to INFINITY)
							bodypart_status += "[BP] is [BP.heavy_brute_msg]."
						if(0.25 to 0.75)
							bodypart_status += "[BP] is [BP.medium_brute_msg]."
						else
							bodypart_status += "[BP] is [BP.light_brute_msg]."
				if(burn >= DAMAGE_PRECISION)
					switch(burn/BP.max_damage)
						if(0.75 to INFINITY)
							bodypart_status += "[BP] is [BP.heavy_burn_msg]."
						if(0.25 to 0.75)
							bodypart_status += "[BP] is [BP.medium_burn_msg]."
						else
							bodypart_status += "[BP] is [BP.light_burn_msg]."

				if(BP.bandage || length(BP.wounds))
					bodypart_status += "<B>Wounds:</B>"
					if(BP.bandage)
						var/usedclass = "notice"
						if(BP.bandage.return_blood_DNA())
							usedclass = "bloody"
						bodypart_status += "<a href='?src=[REF(src)];bandage=[REF(BP.bandage)];bandaged_limb=[REF(BP)]' class='[usedclass]'>Bandaged</a>"
					if(!BP.bandage || observer_privilege)
						for(var/datum/wound/wound as anything in BP.wounds)
							bodypart_status += wound.get_visible_name()
				
			if(length(bodypart_status))
				msg += bodypart_status
			else
				msg += "[BP] is healthy."

			if(length(BP.embedded_objects))
				msg += "<B>Embedded objects:</B>"
				for(var/obj/item/embedded in BP.embedded_objects)
					msg += "<a href='?src=[REF(src)];embedded_object=[REF(embedded)];embedded_limb=[REF(BP)]'>[embedded.name]</a>"
		else
			msg += "<span class='dead'>Limb is missing!</span>"
		to_chat(usr, "<span class='info'>[msg.Join("\n")]</span>")

	if(href_list["embedded_object"] && usr.canUseTopic(src, BE_CLOSE, NO_DEXTERITY))
		var/obj/item/bodypart/L = locate(href_list["embedded_limb"]) in bodyparts
		if(!L)
			return
		var/obj/item/I = locate(href_list["embedded_object"]) in L.embedded_objects
		if(!I) //no item, no limb, or item is not in limb or in the person anymore
			return
		var/time_taken = I.embedding.embedded_unsafe_removal_time*I.w_class
		if(usr == src)
			usr.visible_message("<span class='warning'>[usr] attempts to remove [I] from [usr.p_their()] [L.name].</span>","<span class='warning'>I attempt to remove [I] from my [L.name]...</span>")
		else
			usr.visible_message("<span class='warning'>[usr] attempts to remove [I] from [src]'s [L.name].</span>","<span class='warning'>I attempt to remove [I] from [src]'s [L.name]...</span>")
		if(do_after(usr, time_taken, needhand = TRUE, target = src))
			if(QDELETED(I) || QDELETED(L) || !L.remove_embedded_object(I))
				return
			L.receive_damage(I.embedding.embedded_unsafe_removal_pain_multiplier*I.w_class)//It hurts to rip it out, get surgery you dingus.
			usr.put_in_hands(I)
			emote("pain", TRUE)
			playsound(loc, 'sound/foley/flesh_rem.ogg', 100, TRUE, -2)
			if(usr == src)
				usr.visible_message("<span class='notice'>[usr] rips [I] out of [usr.p_their()] [L.name]!</span>", "<span class='notice'>I successfully remove [I] from my [L.name].</span>")
			else
				usr.visible_message("<span class='notice'>[usr] rips [I] out of [src]'s [L.name]!</span>", "<span class='notice'>I successfully remove [I] from [src]'s [L.name].</span>")

	if(href_list["bandage"] && usr.canUseTopic(src, BE_CLOSE, NO_DEXTERITY))
		var/obj/item/bodypart/L = locate(href_list["bandaged_limb"]) in bodyparts
		if(!L)
			return
		var/obj/item/I = L.bandage
		if(!I)
			return
		if(usr == src)
			usr.visible_message("<span class='warning'>[usr] starts unbandaging [usr.p_their()] [L.name].</span>","<span class='warning'>I start unbandaging [L.name]...</span>")
		else
			usr.visible_message("<span class='warning'>[usr] starts unbandaging [src]'s [L.name].</span>","<span class='warning'>I start unbandaging [src]'s [L.name]...</span>")
		if(do_after(usr, 50, needhand = TRUE, target = src))
			if(QDELETED(I) || QDELETED(L) || (L.bandage != I))
				return
			L.remove_bandage()
			usr.put_in_hands(I)

	if(href_list["item"]) //canUseTopic check for this is handled by mob/Topic()
		var/slot = text2num(href_list["item"])
		if(slot in check_obscured_slots(TRUE))
			to_chat(usr, "<span class='warning'>I can't reach that! Something is covering it.</span>")
			return

	if(href_list["undiesthing"]) //canUseTopic check for this is handled by mob/Topic()
		if(!get_location_accessible(src, BODY_ZONE_PRECISE_GROIN, skipundies = TRUE))
			to_chat(usr, "<span class='warning'>I can't reach that! Something is covering it.</span>")
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
				to_chat(usr, "<span class='warning'>I try to empty [src]'s [pocket_side] pocket, it seems to be stuck!</span>")
			to_chat(usr, "<span class='notice'>I try to empty [src]'s [pocket_side] pocket.</span>")
		else if(place_item && place_item.mob_can_equip(src, usr, pocket_id, 1) && !(place_item.item_flags & ABSTRACT))
			to_chat(usr, "<span class='notice'>I try to place [place_item] into [src]'s [pocket_side] pocket.</span>")
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
			to_chat(src, "<span class='warning'>I feel your [pocket_side] pocket being fumbled with!</span>")

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
					to_chat(usr, "<span class='danger'>Patient has signs of suffocation, emergency treatment may be required!</span>")
				if(getToxLoss() > 20)
					to_chat(usr, "<span class='danger'>Gathered data is inconsistent with the analysis, possible cause: poisoning.</span>")
			if(!H.wear_ring) //You require access from here on out.
				to_chat(H, "<span class='warning'>ERROR: Invalid access</span>")
				return
			var/list/access = H.wear_ring.GetAccess()
			if(!(ACCESS_MEDICAL in access))
				to_chat(H, "<span class='warning'>ERROR: Invalid access</span>")
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
				to_chat(H, "<span class='warning'>ERROR: Invalid access.</span>")
				return

			if(!perpname)
				to_chat(H, "<span class='warning'>ERROR: Can not identify target.</span>")
				return
			R = find_record("name", perpname, GLOB.data_core.security)
			if(!R)
				to_chat(usr, "<span class='warning'>ERROR: Unable to locate data core entry for target.</span>")
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
						to_chat(usr, "<span class='notice'>Successfully added a minor crime.</span>")
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
						to_chat(usr, "<span class='notice'>Successfully added a major crime.</span>")
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
				to_chat(usr, "<span class='notice'>Successfully added comment.</span>")
				return

	return ..() //end of this massive fucking chain. TODO: make the hud chain not spooky. - Yeah, great job doing that.
