/obj/structure/roguemachine/atm
	name = "NERVELOCK"
	desc = "Stores and withdraws currency for accounts managed by the Duchy of Rockhill."
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "atm"
	density = FALSE
	blade_dulling = DULLING_BASH
	pixel_y = 32
	var/created_by_kit = FALSE

/obj/structure/roguemachine/atm/attack_hand(mob/user)
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/H = user
	if(H.mind?.special_role == "Bandit")
		to_chat(H, span_warning("The idea of giving hard won coin to nobles repulses me!"))
		return

	if(HAS_TRAIT(user, TRAIT_MATTHIOS_CURSE))
		to_chat(H, span_warning("The idea repulses me!"))
		H.cursed_freak_out()
		return

	if(HAS_TRAIT(H, TRAIT_MATTHIOS_BRAND))
		to_chat(H, span_warning("The inhumen sigil on my temple scalds me!"))
		say("Your social value is NEGATIVE. Restitution is in order. You are [HAS_TRAIT(H, TRAIT_NOBLE) ? 200 : 100] MAMMON in debt.")

	if(H in SStreasury.bank_accounts)
		var/amt = SStreasury.bank_accounts[H]
		if(!amt)
			say("Your balance is nothing.")
			return
		if(amt < 0)
			say("Your balance is NEGATIVE.")
			return
		var/list/choicez = list()
		if(amt > 10)
			choicez += "GOLD"
		if(amt > 5)
			choicez += "SILVER"
		choicez += "BRONZE"
		var/selection = input(user, "Make a Selection", src) as null|anything in choicez
		if(!selection)
			return
		amt = SStreasury.bank_accounts[H]
		var/mod = 1
		if(selection == "GOLD")
			mod = 10
		if(selection == "SILVER")
			mod = 5
		var/coin_amt = input(user, "There is [SStreasury.treasury_value] mammon in the treasury. You may withdraw [floor(amt/mod)] [selection] COINS from your account.", src) as null|num
		coin_amt = round(coin_amt)
		if(coin_amt < 1)
			return
		amt = SStreasury.bank_accounts[H]
		if(!Adjacent(user))
			return
		if((coin_amt*mod) > amt)
			playsound(src, 'sound/misc/machineno.ogg', 100, FALSE, -1)
			return
		if(!SStreasury.withdraw_money_account(coin_amt*mod, H))
			playsound(src, 'sound/misc/machineno.ogg', 100, FALSE, -1)
			return
		budget2change(coin_amt*mod, user, selection)
	else
		var/consent = alert(user, "Submit your fealty to this land upon my mouth place in your hand...", "NERVELOCK", "Yes", "No")
		if(consent != "Yes")
			to_chat(user, span_danger("You pull your hand away."))
			return

		if(H in SStreasury.bank_accounts)
			say("The machine already knows your blood.")
			return

		to_chat(user, span_warning("The machine bites my finger."))
		icon_state = "atm-b"
		H.flash_fullscreen("redflash3")
		playsound(H, 'sound/combat/hits/bladed/genstab (1).ogg', 100, FALSE, -1)
		SStreasury.create_bank_account(H)
		spawn(5)
			say("New account created.")
			playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)

/obj/structure/roguemachine/atm/attackby(obj/item/P, mob/user, params)
	if(ishuman(user))

		if(HAS_TRAIT(user, TRAIT_MATTHIOS_CURSE))
			var/mob/living/carbon/human/H = user
			to_chat(H, "<span class='warning'>The idea repulses me!</span>")
			H.cursed_freak_out()
			return

		if(istype(P, /obj/item/roguecoin))
			var/mob/living/carbon/human/H = user
			if(HAS_TRAIT(H, TRAIT_MATTHIOS_BRAND))
				var/debt = HAS_TRAIT(H, TRAIT_NOBLE) ? 200 : 100
				if(P.get_real_price() >= debt)
					REMOVE_TRAIT(H, TRAIT_MATTHIOS_BRAND, TRAIT_GENERIC)
					H.remove_status_effect(/datum/status_effect/matthiosbrand)
					ADD_TRAIT(H, TRAIT_MATTHIOS_BRAND_OLD, TRAIT_GENERIC)
					to_chat(H, span_warning("The inhumen sigil on my temple slowly fades away, but not completely."))
					say("Debt has been sated. Society welcomes you once more.")
					qdel(P)
					return
				else
					say("Not enough. Debt must be paid in full.")
					return
			if(H in SStreasury.bank_accounts)
				SStreasury.generate_money_account(P.get_real_price(), H)
				if(!(H.job in GLOB.noble_positions) && !HAS_TRAIT(H, TRAIT_NOBLE))
					var/T = round(P.get_real_price() * SStreasury.tax_value)
					say("Your deposit was taxed [T] mammon.")
				qdel(P)
				playsound(src, 'sound/misc/coininsert.ogg', 100, FALSE, -1)
				return
			else
				say("No account found. Submit your fingers for inspection.")
	return ..()

/obj/structure/roguemachine/atm/examine(mob/user)
	. += ..()
	. += span_info("The current tax rate on deposits is [SStreasury.tax_value * 100] percent. Nobles exempt.")

/obj/item/nervelock_kit
    name = "Nervelock Kit"
    desc = "A heavy crate containing the parts to assemble a Nervelock with ease. How handy! (Right-Click to disassemble.)"
    icon = 'icons/roguetown/misc/structure.dmi'
    icon_state = "woodchest"
    w_class = 4
    color = "#0029a5"

/obj/item/nervelock_kit
    attack_self(mob/user)
        var/turf/T = get_turf(user)
        var/turf/T_wall = get_step(T, user.dir)
        // Require the user to be facing a wall
        if(isopenturf(T_wall))
            to_chat(user, span_warning("You need to assemble this on a wall."))
            return
        if(locate(/obj/structure/roguemachine/atm) in T)
            to_chat(user, span_warning("There is already a Nervelock here!"))
            return
        user.visible_message(span_notice("[user] begins assembling a Nervelock."))
        if(do_after(user, 20 SECONDS, TRUE, src))
            var/obj/structure/roguemachine/atm/N = new /obj/structure/roguemachine/atm(T)
            N.created_by_kit = TRUE
            // Set pixel offset based on facing direction
            N.pixel_x = 0
            N.pixel_y = 0
            switch(user.dir)
                if(NORTH)
                    N.pixel_y = 32
                if(SOUTH)
                    N.pixel_y = -32
                if(EAST)
                    N.pixel_x = 32
                if(WEST)
                    N.pixel_x = -32
            to_chat(user, span_notice("You finish assembling the Nervelock!"))
            del(src)

/obj/structure/roguemachine/atm/attack_right(mob/user)
    if(!created_by_kit)
        return
    if(!HAS_TRAIT(user, TRAIT_NOBLE))
        user.visible_message("<span class='danger'>[user] tries to pack up the Nervelock, but it snaps at their fingers!</span>")
        user.flash_fullscreen("redflash3")
        playsound(user, 'sound/combat/hits/bladed/genstab (1).ogg', 100, FALSE, -1)
        return
    user.visible_message("<span class='notice'>[user] begins packing up the Nervelock into a kit.</span>")
    if(do_after(user, 50 SECONDS, TRUE, src))
        new /obj/item/nervelock_kit(get_turf(src))
        to_chat(user, "<span class='notice'>You finish packing up the Nervelock!</span>")
        del(src)
