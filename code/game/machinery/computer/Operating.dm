#define MENU_OPERATION 1
#define MENU_SURGERIES 2

/obj/machinery/computer/operating
	name = "operating computer"
	desc = ""
	icon_screen = "crew"
	icon_keyboard = "med_key"
	circuit = /obj/item/circuitboard/computer/operating
	ui_x = 350
	ui_y = 470

	var/mob/living/carbon/human/patient
	var/obj/structure/table/optable/table
	var/list/advanced_surgery_steps = list()
	var/datum/techweb/linked_techweb
	light_color = LIGHT_COLOR_BLUE
	var/list/linked_stasisbeds

/obj/machinery/computer/operating/Initialize()
	. = ..()
	linked_techweb = SSresearch.science_tech
	find_table()

/obj/machinery/computer/operating/Destroy()
	for(var/i in linked_stasisbeds)
		var/obj/machinery/stasis/SB = i
		SB.op_computer = null
	..()

/obj/machinery/computer/operating/attackby(obj/item/O, mob/user, params)
	if(istype(O, /obj/item/disk/surgery))
		user.visible_message(span_notice("[user] begins to load \the [O] in \the [src]..."), \
			span_notice("I begin to load a surgery protocol from \the [O]..."), \
			span_hear("I hear the chatter of a floppy drive."))
		var/obj/item/disk/surgery/D = O
		if(do_after(user, 10, target = src))
			advanced_surgery_steps |= D.surgery_steps
		return TRUE
	return ..()

/obj/machinery/computer/operating/proc/sync_surgeries()
	for(var/i in linked_techweb.researched_designs)
		var/datum/design/surgery/D = SSresearch.techweb_design_by_id(i)
		if(!istype(D))
			continue
		advanced_surgery_steps |= D.surgery_step

/obj/machinery/computer/operating/proc/find_table()
	for(var/direction in GLOB.cardinals)
		table = locate(/obj/structure/table/optable, get_step(src, direction))
		if(table)
			table.computer = src
			break
	if(!linked_stasisbeds)
		linked_stasisbeds = list()

	for(var/obj/machinery/stasis/SB in view(7,src))
		if(SB.op_computer)
			continue
		linked_stasisbeds |= SB
		SB.op_computer = src

/obj/machinery/computer/operating/ui_interact(mob/user, ui_key = "main", datum/tgui/ui = null, force_open = 0, datum/tgui/master_ui = null, datum/ui_state/state = GLOB.not_incapacitated_state)
	ui = SStgui.try_update_ui(user, src, ui_key, ui, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "operating_computer", name, ui_x, ui_y, master_ui, state)
		ui.open()

/obj/machinery/computer/operating/ui_data(mob/user)
	var/list/data = list()
	data["table"] = table

	var/list/surgeries = list()
	for(var/X in advanced_surgery_steps)
		var/datum/surgery/S = X
		var/list/surgery = list()
		surgery["name"] = initial(S.name)
		surgery["desc"] = initial(S.desc)
		surgeries += list(surgery)
	data["surgeries"] = surgeries
	if(table)
		if(table.check_patient())
			data["patient"] = list()
			patient = table.patient
			switch(patient.stat)
				if(CONSCIOUS)
					data["patient"]["stat"] = "Conscious"
					data["patient"]["statstate"] = "good"
				if(SOFT_CRIT)
					data["patient"]["stat"] = "Conscious"
					data["patient"]["statstate"] = "average"
				if(UNCONSCIOUS)
					data["patient"]["stat"] = "Unconscious"
					data["patient"]["statstate"] = "average"
				if(DEAD)
					data["patient"]["stat"] = "Dead"
					data["patient"]["statstate"] = "bad"
			data["patient"]["health"] = patient.health
			data["patient"]["blood_type"] = patient.dna.blood_type
			data["patient"]["maxHealth"] = patient.maxHealth
			data["patient"]["minHealth"] = HEALTH_THRESHOLD_DEAD
			data["patient"]["bruteLoss"] = patient.getBruteLoss()
			data["patient"]["fireLoss"] = patient.getFireLoss()
			data["patient"]["toxLoss"] = patient.getToxLoss()
			data["patient"]["oxyLoss"] = patient.getOxyLoss()
		else
			data["patient"] = null
	return data

/obj/machinery/computer/operating/ui_act(action, params)
	if(..())
		return
	switch(action)
		if("sync")
			sync_surgeries()
			. = TRUE
	. = TRUE

#undef MENU_OPERATION
#undef MENU_SURGERIES
