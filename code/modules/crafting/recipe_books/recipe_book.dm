

/obj/item/recipe_book
	icon = 'icons/roguetown/items/books.dmi'

	grid_width = 32
	grid_height = 32
	var/list/types = list()
	var/mob/current_reader
	var/open
	var/base_icon_state
	var/can_spawn = TRUE


/obj/item/recipe_book/dropped(mob/user, silent)
	. = ..()
	if(current_reader)
		current_reader << browse(null,"window=recipe")
		current_reader = null

/obj/item/recipe_book/attack_self(mob/user)
	. = ..()
	current_reader = user
	current_reader << browse(generate_html(user),"window=recipe;size=500x810")

/obj/item/recipe_book/proc/generate_html(mob/user)
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
				font-size: 1.2em;
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
				font-size: 2.5em;
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
		"}

	var/first = TRUE
	for(var/atom/path as anything in types)
		if(is_abstract(path))
			if(!first)
				html += "<br>"
			first = FALSE
			var/list/sorted_types = sortNames(subtypesof(path))
			for(var/atom/sub_path as anything in sorted_types)
				if(is_abstract(sub_path))
					continue
				if(!sub_path.name)
					continue
				html += "<a href='byond://?src=\ref[src];pick_recipe=[sub_path]'>[initial(sub_path.name)]</a> <br>"
		else
			html += "<a href='byond://?src=\ref[src];pick_recipe=[path]'>[initial(path.name)]</a> <br>"

	html += {"
	</body>
	</html>
	"}
	return html

/obj/item/recipe_book/Topic(href, href_list)
	. = ..()
	if(href_list["pick_recipe"])
		var/datum/path = text2path(href_list["pick_recipe"])
		if(ispath(path, /datum/crafting_recipe))
			var/datum/crafting_recipe/real_path = new path
			real_path.show_menu(current_reader)
		else if(ispath(path, /datum/anvil_recipe))
			var/datum/anvil_recipe/real_path = new path
			real_path.show_menu(current_reader)
		// if(ispath(path, /datum/repeatable_crafting_recipe))
		// 	var/datum/repeatable_crafting_recipe/real_path = new path
		// 	real_path.show_menu(current_reader)
		// else if(ispath(path, /datum/orderless_slapcraft))
		// 	var/datum/orderless_slapcraft/real_path = new path
		// 	real_path.show_menu(current_reader)
		// else if(ispath(path, /datum/slapcraft_recipe))
		// 	var/datum/slapcraft_recipe/real_path = new path
		// 	real_path.show_menu(current_reader)
		// else if(ispath(path, /datum/pot_recipe))
		// 	var/datum/pot_recipe/real_path = new path
		// 	real_path.show_menu(current_reader)
		// else if(ispath(path, /datum/molten_recipe))
		// 	var/datum/molten_recipe/real_path = new path
		// 	real_path.show_menu(current_reader)
		// else if(ispath(path, /datum/pottery_recipe))
		// 	var/datum/pottery_recipe/real_path = new path
		// 	real_path.show_menu(current_reader)
		// else if(ispath(path, /datum/brewing_recipe))
		// 	var/datum/brewing_recipe/real_path = new path
		// 	real_path.show_menu(current_reader)
		// else if(ispath(path, /datum/runerituals))
		// 	var/datum/runerituals/real_path = new path
		// 	real_path.show_menu(current_reader)
		// else if(ispath(path, /datum/book_entry))
		// 	var/datum/book_entry/real_path = new path
		// 	real_path.show_menu(current_reader)

/obj/item/recipe_book/getonmobprop(tag)
	. = ..()
	if(tag)
		if(open)
			switch(tag)
				if("gen")
					return list("shrink" = 0.4,
	"sx" = -2,
	"sy" = -3,
	"nx" = 10,
	"ny" = -2,
	"wx" = 1,
	"wy" = -3,
	"ex" = 5,
	"ey" = -3,
	"northabove" = 0,
	"southabove" = 1,
	"eastabove" = 1,
	"westabove" = 0,
	"nturn" = 0,
	"sturn" = 0,
	"wturn" = 0,
	"eturn" = 0,
	"nflip" = 0,
	"sflip" = 0,
	"wflip" = 0,
	"eflip" = 0)
				if("onbelt")
					return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)
		else
			switch(tag)
				if("gen")
					return list("shrink" = 0.4,
	"sx" = -2,
	"sy" = -3,
	"nx" = 10,
	"ny" = -2,
	"wx" = 1,
	"wy" = -3,
	"ex" = 5,
	"ey" = -3,
	"northabove" = 0,
	"southabove" = 1,
	"eastabove" = 1,
	"westabove" = 0,
	"nturn" = 0,
	"sturn" = 0,
	"wturn" = 0,
	"eturn" = 0,
	"nflip" = 0,
	"sflip" = 0,
	"wflip" = 0,
	"eflip" = 0)
				if("onbelt")
					return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)
