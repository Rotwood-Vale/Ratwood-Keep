/datum/anvil_recipe
	abstract_type = /datum/anvil_recipe
	var/name
	var/category = "Misc"
	var/list/additional_items = list()
	var/appro_skill = /datum/skill/craft/blacksmithing
	var/req_bar
	var/created_item
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
<<<<<<< HEAD
=======
	user.visible_message(span_info("[user] adds [needed_item_text]"))
	needed_item_text = null

/datum/anvil_recipe/proc/handle_creation(obj/item/I)
	numberofhits = ceil(numberofhits / num_of_materials) // Divide the hits equally among the number of bars required, rounded up.
	if(numberofbreakthroughs) // Hitting the bar the perfect way should be rewarding quality-wise
		numberofhits -= numberofbreakthroughs
	material_quality = floor(material_quality/num_of_materials)-4
	skill_quality = floor((skill_quality/num_of_materials)/1500)+material_quality
	// Finally, the more hits the thing required, the less quality it will be, to prevent low level smiths from dishing good stuff
	skill_quality -= floor(numberofhits * 0.25)
	var/modifier // Multiplier which will determine quality of final product depending on final skill_quality calculation
	switch(skill_quality)
		if(BLACKSMITH_LEVEL_MIN to BLACKSMITH_LEVEL_SPOIL)
			I.name = "ruined [I.name]"
			modifier = 0.3
		if(BLACKSMITH_LEVEL_AWFUL)
			I.name = "awful [I.name]"
			modifier = 0.5
		if(BLACKSMITH_LEVEL_CRUDE)
			I.name = "crude [I.name]"
			modifier = 0.8
		if(BLACKSMITH_LEVEL_ROUGH)
			I.name = "rough [I.name]"
			modifier = 0.9
		if(BLACKSMITH_LEVEL_COMPETENT)
			modifier = 1
		if(BLACKSMITH_LEVEL_FINE)
			I.name = "fine [I.name]"
			modifier = 1.1
		if(BLACKSMITH_LEVEL_FLAWLESS)
			I.name = "flawless [I.name]"
			modifier = 1.2
		if(BLACKSMITH_LEVEL_LEGENDARY to BLACKSMITH_LEVEL_MAX)
			I.name = "masterwork [I.name]"
			modifier = 1.3
			I.polished = 4
			I.AddComponent(/datum/component/metal_glint)

	if(!modifier) // Sanity.
		return

	I.sellprice *= modifier
	if(istype(I, /obj/item/lockpick))
		var/obj/item/lockpick/L = I
		L.picklvl = modifier

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

		<style>
			@import url('https://fonts.googleapis.com/css2?family=Charm:wght@700&display=swap');
			body {
				font-family: "Charm", cursive;
				font-size: 1em;
				text-align: center;
				margin: 20px;
				background-color: #f4efe6;
				color: #3e2723;
				background-color: rgb(31, 20, 24);
				background:
					url('book.png');
				background-repeat: no-repeat;
				background-attachment: fixed;
				background-size: 100% 100%;

			}
			h1 {
				text-align: center;
				font-size: 1.5em;
				border-bottom: 2px solid #3e2723;
				padding-bottom: 10px;
				margin-bottom: 20px;
			}
			.icon {
				width: 96px;
				height: 96px;
				vertical-align: middle;
				margin-right: 10px;
			}
		</style>
		<body>
		  <div>
		    <h1>[name]</h1>
		"}

	if(craftdiff > 0)
		html += "For those of [SSskills.level_names_plain[craftdiff]] skills<br>"
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

	if(createditem_num > 1)
		html += "<strong class=class='scroll'>and then you get</strong> <br> [createditem_num] [icon2html(new created_item, user)] <br> [initial(created_item.name)]<br>"
	else
		html += "<strong class=class='scroll'>and then you get</strong> <br> [icon2html(new created_item, user)] <br> [initial(created_item.name)]<br>"

	html += {"
		</div>
		</div>
	</body>
	</html>
	"}
	return html
>>>>>>> 8b5f2f9d6 (Merge pull request #2526 from WeNeedMorePhoron/recipe-book-2)
