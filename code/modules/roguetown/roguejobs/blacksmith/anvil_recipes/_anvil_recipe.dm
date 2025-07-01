/datum/anvil_recipe
	abstract_type = /datum/anvil_recipe
	var/name
	var/category = "Misc"
	var/list/additional_items = list()
	var/appro_skill = /datum/skill/craft/blacksmithing
	var/atom/req_bar
	var/atom/movable/created_item
	var/skill_level = 2
	var/obj/item/needed_item
	var/quality_mod = 0
	var/progress
	var/i_type

	var/datum/parent

/datum/anvil_recipe/New(datum/P, ...)
	parent = P
	. = ..()

/datum/anvil_recipe/proc/advance(mob/user, breakthrough = FALSE)
	if(progress == 100)
		to_chat(user, span_info("It's ready."))
		user.visible_message(span_warning("[user] strikes the bar!"))
		return FALSE
	if(needed_item)
		to_chat(user, span_info("Now it's time to add \a [initial(needed_item.name)]."))
		user.visible_message(span_warning("[user] strikes the bar!"))
		return FALSE
	var/moveup = 1
	var/user_skill = user.mind.get_skill_level(appro_skill)
	var/proab = max((skill_level - user_skill)*7, 1)
	if(user.mind)
		moveup += round((user_skill * 6) * (breakthrough == 1 ? 1.5 : 1))
		moveup -= 3 * skill_level

	if(!user_skill)
		proab = max(proab, 25)

	if(prob(proab))
		moveup = 0
	progress = min(progress + moveup, 100)
	if(progress == 100 && additional_items.len)
		needed_item = pick(additional_items)
		additional_items -= needed_item
		progress = 0
	if(!moveup)
		if(prob(round(proab)))
			user.visible_message(span_warning("[user] spoils the bar!"))
			if(parent)
				var/obj/item/P = parent
				qdel(P)
			return FALSE
		else
			user.visible_message(span_warning("[user] fumbles with the bar!"))
			progress -= skill_level * 2 - user_skill //Lose progress when you make mistakes
			return FALSE
	else
		if(user.mind)
			if(isliving(user))
				var/mob/living/L = user
				var/amt2raise = L.STAINT/3 // (L.STAINT+L.STASTR)/4 optional: add another stat that isn't int
				//i feel like leveling up takes forever regardless, this would just make it faster
				if(amt2raise > 0 && moveup > 0) //Can't raise the skill if you aren't making any progress
					user.mind.add_sleep_experience(appro_skill, amt2raise, FALSE)
				else if (prob(20)) //Might take a few hits to realize you're wasting your time
					to_chat(user, span_warning("This is too complicated for my current skill level, I'm not making any progress."))
		if(breakthrough)
			user.visible_message(span_warning("[user] strikes the bar!"))
		else
			user.visible_message(span_info("[user] strikes the bar!"))
		return TRUE

/datum/anvil_recipe/proc/item_added(mob/user)
	user.visible_message(span_info("[user] adds [initial(needed_item.name)]."))
	needed_item = null

/datum/anvil_recipe/proc/show_menu(mob/user)
	user << browse(generate_html(user),"window=new_recipe;size=500x810")

/datum/anvil_recipe/proc/generate_html(mob/user)
	var/client/client = user
	if(!istype(client))
		client = user.client
	user << browse_rsc('html/book.png')
	var/html = {"
		<!DOCTYPE html>
		<html lang="en">
		<meta charset='UTF-8'>
		<meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1'/>
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'/>
		<body>
		  <div>
		    <h1>[name]</h1>
		"}

	if(skill_level > 0)
		html += "For those of Good [skill_level] skills<br>"
	else
		html += "Suitable for all skills<br>"

	if(appro_skill == /datum/skill/craft/engineering) // SNOWFLAKE!!!
		html += "in Engineering<br>"

	html += {"<div>
		      <strong>Requirements</strong>
			  <br>"}

	html += "[icon2html(new req_bar, user)] Start with [initial(req_bar.name)] on an anvil.<br>"
	html += "Hammer the material.<br>"
	for(var/atom/path as anything in additional_items)
		html += "[icon2html(new path, user)] then add [initial(path.name)]<br>"
		html += "Hammer the material.<br>"
	html += "<br>"

	html += {"
		</div>
		<div>
		"}

	var/atom/movable/item_to_show = created_item // this is important, otherwise it would runetime when item we crate is a list, like for 5x arrows
	if(islist(created_item))
		item_to_show = pick(created_item)
	if(item_to_show)
		html += "<strong class='scroll'>and then you get</strong> <br> [icon2html(new item_to_show, user)] <br> [initial(item_to_show.name)]<br>"
/*
	if(created_item.sellprice)
		html += "<strong class=class='scroll'>You can sell this for [created_item.sellprice] mammons at a normal quality</strong> <br>"
	else
		html += "<strong class=class='scroll'>This is worthless for export</strong> <br>"
*/
	html += {"
		</div>
		</div>
	</body>
	</html>
	"}
	return html
