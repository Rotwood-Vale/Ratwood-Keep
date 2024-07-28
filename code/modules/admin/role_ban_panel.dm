/datum/role_ban_instance
	var/apply_date
	var/duration
	var/permanent
	var/applied_by
	var/applies_to_admins
	var/reason
	var/list/roles
	var/list/migrants
	var/list/advclasses
	var/list/antags
	var/list/traits
	var/list/misc

/datum/role_ban_panel
	var/datum/admins/holder

	var/selected_ckey = null
	var/selected_duration = 0
	var/selected_reason = null
	var/selected_applies_to_admins = FALSE
	var/selected_is_permanent = FALSE

	var/list/selected_roles = list()
	var/list/selected_migrants = list()
	var/list/selected_advclasses = list()
	var/list/selected_antags = list()
	var/list/selected_traits = list()
	var/list/selected_misc = list()

/datum/role_ban_panel/New(datum/admins/passed_holder)
	holder = passed_holder
	return ..()

/datum/role_ban_panel/proc/show_ui(mob/user)
	var/list/dat = list()
	dat += "<center><a href='?src=[REF(src)];task=apply'>APPLY BAN TO CKEY</a> - <a href='?src=[REF(src)];task=reset'>Reset</a> - <a href='?src=[REF(src)];task=check_bans'>Check Role Bans</a> </center>"
	dat += "<BR><b>CKEY:</b> [selected_ckey] <a href='?src=[REF(src)];task=ckey'>Change</a>"
	dat += "<BR><b>Permanent:</b> <a href='?src=[REF(src)];task=permanent'>[selected_is_permanent ? "Yes": "No"]</a>"
	if(!selected_is_permanent)
		dat += "<BR><b>Duration:</b> [selected_duration] minutes <a href='?src=[REF(src)];task=duration'>Change</a>"
	dat += "<BR><b>Reason:</b> [selected_reason] <a href='?src=[REF(src)];task=reason'>Change</a>"
	dat += "<BR><b>Applies to admins:</b> <a href='?src=[REF(src)];task=apply_to_admins'>[selected_applies_to_admins ? "Yes": "No"]</a>"
	dat += "<HR>"
	dat += "<b>Banned Roles:</b> <a href='?src=[REF(src)];task=add_role'>Add</a>"
	for(var/role_name in selected_roles)
		dat += "<BR> - [role_name] <a href='?src=[REF(src)];task=remove_role;role_name=[role_name]'>Remove</a>"

	dat += "<BR><BR><b>Banned Migrants:</b> <a href='?src=[REF(src)];task=add_migrant'>Add</a>"
	for(var/migrant_name in selected_migrants)
		dat += "<BR> - [migrant_name] <a href='?src=[REF(src)];task=remove_migrant;migrant_name=[migrant_name]'>Remove</a>"

	dat += "<BR><BR><b>Banned Adv Classes:</b> <a href='?src=[REF(src)];task=add_advclass'>Add</a>"
	for(var/adv_name in selected_advclasses)
		dat += "<BR> - [adv_name] <a href='?src=[REF(src)];task=remove_advclass;advclass_name=[adv_name]'>Remove</a>"

	dat += "<BR><BR><b>Banned Antags:</b> <a href='?src=[REF(src)];task=add_antag'>Add</a>"
	for(var/antag_name in selected_antags)
		dat += "<BR> - [antag_name] <a href='?src=[REF(src)];task=remove_antag;antag_name=[antag_name]'>Remove</a>"

	dat += "<BR><BR><b>Applied Ban Traits:</b> <a href='?src=[REF(src)];task=add_trait'>Add From Preset</a> <a href='?src=[REF(src)];task=add_trait_any'>Add Any</a>"
	for(var/trait_name in selected_traits)
		dat += "<BR> - [trait_name] <a href='?src=[REF(src)];task=remove_trait;trait_name=[trait_name]'>Remove</a>"

	dat += "<BR><BR><b>Applied Misc Bans:</b> <a href='?src=[REF(src)];task=add_misc'>Add</a>"
	for(var/misc_ban in selected_misc)
		dat += "<BR> - [misc_ban] <a href='?src=[REF(src)];task=remove_misc;misc_ban=[misc_ban]'>Remove</a>"

	var/datum/browser/popup = new(user, "role_ban_panel", "Role Ban Panel", 500, 400)
	popup.set_content(dat.Join())
	popup.open()

/datum/role_ban_panel/Topic(href, list/href_list)
	. = ..()
	if(!holder)
		return
	var/mob/user = usr
	if(holder.owner != user.client)
		return
	if(check_rights_for(user.client, R_BAN))
		to_chat(user, span_boldwarning("No +BAN permission"))
		return
	switch(href_list["task"])
		if("apply")
			apply_ban(user)
		if("reset")
			var/alert = alert(user, "Reset the panel and clear all of the values?", "Reset", "Yes", "No")
			if(alert != "Yes")
				return
			reset_panel(user)
		if("check_bans")
			check_bans(user)
		if("ckey")
			var/chosen_ckey = input(user, "Choose ckey", "CKEY", selected_ckey) as text|null
			if(!chosen_ckey)
				return
			chosen_ckey = ckey(chosen_ckey)
			selected_ckey = chosen_ckey
		if("permanent")
			selected_is_permanent = !selected_is_permanent
		if("duration")
			var/duration_type = input(user, "Choose duration type", "Duration", null) as null|anything in list("Minutes", "Hours", "Days")
			if(!duration_type)
				return
			var/chosen_amount = input(user, "Choose amount (in [duration_type])", "Duration", 0) as num|null
			if(!chosen_amount)
				return
			selected_duration = chosen_amount
		if("reason")
			var/chosen_reason = input(user, "Input reason", "Reason", selected_reason) as message|null
			if(!chosen_reason)
				return
			selected_reason = chosen_reason
		if("apply_to_admins")
			selected_applies_to_admins = !selected_applies_to_admins

		if("add_role")
			var/selected_role = input(user, "Choose Role", "Role", null) as null|anything in SSjob.name_occupations
			if(!selected_role)
				return
			selected_roles |= selected_role
		if("remove_role")
			var/to_remove = href_list["role_name"]
			selected_roles -= to_remove

		if("add_migrant")
			var/selected_migrant = input(user, "Choose Migrant", "Migrant", null) as null|anything in get_all_migrant_role_names()
			if(!selected_migrant)
				return
			selected_migrants |= selected_migrant
		if("remove_migrant")
			var/to_remove = href_list["migrant_name"]
			selected_migrants -= to_remove

		if("add_advclass")
			var/selected_advclass = input(user, "Choose Adv Class", "Adv Class", null) as null|anything in SSrole_class_handler.get_all_advclass_names()
			if(!selected_advclass)
				return
			selected_advclasses |= selected_advclass
		if("remove_advclass")
			var/to_remove = href_list["advclass_name"]
			selected_advclasses -= to_remove

		if("add_antag")
			var/selected_antag = input(user, "Choose antag", "Antags", null) as null|anything in ALL_ANTAG_BANS
			if(!selected_antag)
				return
			selected_antags |= selected_antag
		if("remove_antag")
			var/to_remove = href_list["antag_name"]
			selected_antags -= to_remove

		if("add_trait")
			var/selected_trait = input(user, "Choose trait", "Traits", null) as null|anything in ALL_PRESET_TRAIT_BANS
			if(!selected_trait)
				return
			selected_traits |= selected_trait
		if("add_trait_any")
			var/input_trait = input(user, "Input custom trait \nMake sure it matches its name precisely!", "Traits", "") as text|null
			if(!input_trait)
				return
			selected_traits |= input_trait
		if("remove_trait")
			var/to_remove = href_list["trait_name"]
			selected_traits -= to_remove

		if("add_misc")
			var/selected_misc_thing = input(user, "Choose a Misc Ban", "Misc Bans", null) as null|anything in ALL_MISC_BANS
			if(!selected_misc_thing)
				return
			selected_misc |= selected_misc_thing
		if("remove_misc")
			var/to_remove = href_list["misc_ban"]
			selected_misc -= to_remove

	show_ui(user)

/datum/role_ban_panel/proc/check_bans(mob/user)
	var/chosen_ckey = input(user, "Choose ckey to check role bans", "Check Role Bans", "") as text|null
	if(!chosen_ckey)
		return
	chosen_ckey = ckey(chosen_ckey)
	

/datum/role_ban_panel/proc/apply_ban(mob/user)
	if(holder.owner != user.client)
		return
	if(check_rights_for(user.client, R_BAN))
		to_chat(user, span_boldwarning("No +BAN permission"))
		return
	return

/datum/role_ban_panel/proc/reset_panel(mob/user)
	selected_ckey = null
	selected_reason = null
	selected_duration = 0
	selected_applies_to_admins = FALSE
	selected_is_permanent = FALSE
	selected_roles.Cut()
	selected_migrants.Cut()
	selected_advclasses.Cut()
	selected_antags.Cut()
	selected_traits.Cut()
	selected_misc.Cut()

/proc/get_all_migrant_role_names()
	var/list/compiled = list()
	for(var/migrant_type in GLOB.migrant_roles)
		var/datum/migrant_role/role = MIGRANT_ROLE(migrant_type)
		compiled += role.name
	return compiled
