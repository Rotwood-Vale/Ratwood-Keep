/obj/structure/roguemachine/bounty
	name = "Excidium"
	desc = "A machine that sets and collects bounties. Its bloodied maw could easily fit a human head."
	icon = 'icons/roguetown/misc/machinesbig.dmi'
	icon_state = "excidium"
	density = FALSE
	blade_dulling = DULLING_BASH
	anchored = TRUE

/datum/bounty
	var/target
	var/amount
	var/reason
	var/employer
	var/number

	/// Whats displayed when consulting the bounties
	var/banner
	///Is this a bandit bounty?
	var/bandit
	///Is this bounty withdrawable by the guild clerk?
	var/withdrawable

/obj/structure/roguemachine/bounty/attack_hand(mob/user)

	if(!ishuman(user)) return

	// We need to check the user's bank account later
	var/mob/living/carbon/human/H = user

	// Main Menu
	var/list/choices = list("Consult bounties", "Set bounty")
	if(user.mind.assigned_role == "Guild Clerk")
		choices += "Withdraw bounty reward"
	var/selection = input(user, "The Excidium listens", src) as null|anything in choices

	switch(selection)

		if("Consult bounties")
			consult_bounties(H)

		if("Set bounty")
			set_bounty(H)
		
		if("Withdraw bounty reward")
			withdraw_bounty(H)
		
/obj/structure/roguemachine/bounty/attackby(obj/item/P, mob/user, params)

	if(!(ishuman(user))) return

	// Only heads are allowed
	if(P.type != /obj/item/bodypart/head && P.type != /obj/item/bodypart/head/goblin) return

	var/machine_location = get_turf(src)
	var/obj/item/bodypart/head/stored_head = P
	var/correct_head = FALSE

	var/reward_amount = 0
	for(var/datum/bounty/b in GLOB.head_bounties)
		if(b.target == stored_head.real_name)
			correct_head = TRUE
			say("A bounty has been sated.")
			flick("excidium_talk", src)
			reward_amount += b.amount
			GLOB.head_bounties -= b
			qdel(b)
			message_admins("[ADMIN_LOOKUPFLW(user)] has completed the bounty on [ADMIN_LOOKUPFLW(b.target)] by delivering the severed head.")

	if(P.type == /obj/item/bodypart/head/goblin)
		correct_head = TRUE
		say("A bounty has been sated.")
		reward_amount += P.sellprice

	if(correct_head)
		qdel(P)
	else // No valid bounty for this head?
		say("This skull carries no reward.")
		flick("excidium_talk", src)
		playsound(src, 'sound/misc/machineno.ogg', 100, FALSE, -1)
		return

	say(pick(list("Performing intra-cranial inspection...", "Analyzing skull structure...", "Commencing cephalic dissection...")))

	sleep(1 SECONDS)

	flick("excidium_eat", src)
	var/list/headcrush = list('sound/combat/fracture/headcrush (2).ogg', 'sound/combat/fracture/headcrush (3).ogg', 'sound/combat/fracture/headcrush (4).ogg')
	playsound(src, pick_n_take(headcrush), 100, FALSE, -1)
	sleep(1 SECONDS)
	playsound(src, pick(headcrush), 100, FALSE, -1)

	sleep(2 SECONDS)

	if(correct_head)
		budget2change(reward_amount, user)

	// Head has been "analyzed". Return it.
	sleep(2 SECONDS)
	playsound(src, 'sound/combat/vite.ogg', 100, FALSE, -1)
	flick("excidium_talk", src)
	stored_head = new /obj/item/bodypart/head(machine_location)
	stored_head.name = "mutilated head"
	stored_head.desc = "This head has been violated beyond recognition, the work of a horrific machine."

///Shows all active bounties to the user.
/obj/structure/roguemachine/bounty/proc/consult_bounties(mob/living/carbon/human/user)
	var/bounty_found = FALSE
	var/consult_menu
	consult_menu += "<center>BOUNTIES<BR>"
	consult_menu += "--------------<BR>"
	for(var/datum/bounty/saved_bounty in GLOB.head_bounties)
		consult_menu += saved_bounty.banner
		bounty_found = TRUE

	if(bounty_found)
		var/datum/browser/popup = new(user, "BOUNTIES", "", 500, 300)
		popup.set_content(consult_menu)
		popup.open()
	else
		say("No bounties are currently active.")
		flick("excidium_talk", src)

///Sets a bounty on a target player through user input.
///@param user: The player setting the bounty.
/obj/structure/roguemachine/bounty/proc/set_bounty(mob/living/carbon/human/user)
	var/list/eligible_players = list()

	if(user.mind.known_people.len)
		for(var/guys_name in user.mind.known_people)
			eligible_players += guys_name
	else
		to_chat(user, span_warning("I don't know anyone."))
		return
	var/target = input(user, "Whose name shall be etched on the wanted list? (Cancel for a custom bounty)", src) as null|anything in eligible_players
	var/reason
	var/withdrawable
	if(isnull(target))
		withdrawable = "Yes"
		reason = input(user, "What work do you desire to be done?", src) as null|text
		if(isnull(reason) || reason == "")
			say("No task given.")
			return
	else
		withdrawable = input(user, "Shall you allow rewards to those that complete this task without the beheading of the hunted?", src) as null|anything in list("Yes", "No")
		if(isnull(withdrawable)) return
		reason = input(user, "For what sins do you summon the hounds of hell?", src) as null|text
		if(isnull(reason) || reason == "")
			say("No reason given.")
			return

	var/amount = input(user, "How many mammons shall be rewarded for this task to be carried out?", src) as null|num
	if(isnull(amount))
		say("Invalid amount.")
		return
	if(target && amount < 20)
		say("Insufficient amount. Bounty must be at least 20 mammons.")
		return

	// Has user a bank account?
	if(!(user in SStreasury.bank_accounts))
		say("You have no bank account.")
		return

	// Has user enough money?
	if(SStreasury.bank_accounts[user] < amount)
		say("Insufficient balance funds.")
		return

	var/confirm = input(user, "Do you dare unleash this task upon the world? Your name will be known.", src) as null|anything in list("Yes", "No")	
	if(isnull(confirm) || confirm == "No") return
	var/number = rand(10000, 99999)
	// Deduct money from user
	SStreasury.bank_accounts[user] -= round(amount)

	//Deduct royal tax from amount
	var/royal_tax = round(amount * SStreasury.tax_value)
	SStreasury.treasury_value += royal_tax
	SStreasury.log_entries += "+[royal_tax] to treasury (bounty tax)"

	amount -= royal_tax

	// Finally create bounty
	add_bounty(target, amount, FALSE, reason, user.real_name, withdrawable, number)

	//Announce it locally and on scomm
	playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
	flick("excidium_talk", src)
	var/bounty_announcement 
	if(target)
		bounty_announcement = "The Excidium hungers for the head of [target]."
	else
		bounty_announcement = "The Excidium offers [amount] mammon for a new deed."
	say(bounty_announcement)
	scom_announce(bounty_announcement)

	message_admins("[ADMIN_LOOKUPFLW(user)] has set a bounty [target ? "on [ADMIN_LOOKUPFLW(target)] with the reason of: '[reason]'" : "with the task to [reason]"]")

/proc/add_bounty(target_realname, amount, bandit_status, reason, employer_name, withdrawable, number)
	var/datum/bounty/new_bounty = new /datum/bounty
	new_bounty.amount = amount
	new_bounty.target = target_realname
	new_bounty.bandit = bandit_status
	new_bounty.reason = reason
	new_bounty.employer = employer_name
	new_bounty.number = number
	new_bounty.withdrawable = withdrawable
	compose_bounty(new_bounty)
	GLOB.head_bounties += new_bounty

///Composes a random bounty banner based on the given bounty info.
///@param new_bounty:  The bounty datum.
/proc/compose_bounty(datum/bounty/new_bounty)
	if(new_bounty.target)
		switch(rand(1, 3))
			if(1)
				new_bounty.banner += "A dire bounty hangs upon the head of [new_bounty.target], for '[new_bounty.reason]'.<BR>"
				new_bounty.banner += "The patron, [new_bounty.employer], offers [new_bounty.amount] mammons for the task.<BR>"
			if(2)
				new_bounty.banner += "The head of [new_bounty.target] is wanted for '[new_bounty.reason]''.<BR>"
				new_bounty.banner += "The employer, [new_bounty.employer], offers [new_bounty.amount] mammons for the deed.<BR>"
			if(3)
				new_bounty.banner += "[new_bounty.employer] hath offered to pay [new_bounty.amount] mammons for the head of [new_bounty.target].<BR>"
				new_bounty.banner += "By reason of the following: '[new_bounty.reason]'.<BR>"
		if(new_bounty.withdrawable == "Yes")
			new_bounty.banner += "This bounty is able to be completed without the beheading of [new_bounty.target], talk to an authorized member of the mercenaries guild for the reward.<BR>"
			new_bounty.banner += "BOUNTY NUMBER: [new_bounty.number].<BR>"
		new_bounty.banner += "--------------<BR>"
	else 
		switch(rand(1, 3))
			if(1)
				new_bounty.banner += "[new_bounty.employer] hath offered to pay [new_bounty.amount] mammons to carry out a task.<BR>"
				new_bounty.banner += "Said task is to: '[new_bounty.reason]'.<BR>"
			if(2)
				new_bounty.banner += "The employer [new_bounty.employer] is offering [new_bounty.amount] mammons to accomplish a certain deed.<BR>"
				new_bounty.banner += "The deed is the following: '[new_bounty.reason]'.<BR>"
			if(3)
				new_bounty.banner += "[new_bounty.amount] mammons are being offered to whoever can '[new_bounty.reason]'.<BR>"
				new_bounty.banner += "The patron, [new_bounty.employer] will pay the first to complete it.<BR>"
		new_bounty.banner += "The reward for this task shall be given when verified by an authorized member of the mercenaries guild.<BR>"
		new_bounty.banner += "BOUNTY NUMBER: [new_bounty.number].<BR>"
		new_bounty.banner += "--------------<BR>"

/obj/structure/roguemachine/bounty/proc/withdraw_bounty(mob/user)
	var/bounty_number = input(user, "What is the number of the bounty whose reward is to be withdrawn?", src) as null|num
	if(isnull(bounty_number))
		say("No number given.")
		return
	for(var/datum/bounty/b in GLOB.head_bounties)
		if(b.number == bounty_number && b.withdrawable == "Yes")
			var/confirm = input(user, "Are you sure you would like to to withdraw the reward [b.target ? "on [b.target]'s head" : "of this task"] and mark it as completed? There will be punisment from the guild for any reported inproper use.", src) as null|anything in list("Yes", "No")
			if(isnull(confirm) || confirm == "No") return
			budget2change(b.amount, user)
			GLOB.head_bounties -= b
			say("Bounty successfully marked as completed and reward withdrawn.")
			message_admins("[ADMIN_LOOKUPFLW(user)] has withdrawn the bounty of [ADMIN_LOOKUPFLW(b.employer)] [b.target ? "on [ADMIN_LOOKUPFLW(b.target)]'s head non-lethally" : ""] the terms of the bounty was: [b.reason]")
		else 
			say("There are no withdrawable bounties with that number. Please confirm that the bounty is withdrawable, and deliver head for cranial inspection otherwise.")
	flick("excidium_talk", src)
	//Please for the love of god anyone that can properly do menus should fix this. This is the best i could do considering how i know nothing about them. 
