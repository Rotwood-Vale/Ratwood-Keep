/obj/item/udder
	name = "udder"

/obj/item/udder/Initialize()
	create_reagents(100)
	reagents.add_reagent(/datum/reagent/consumable/milk, rand(0,20))
	. = ..()

/obj/item/udder/proc/generateMilk()
	reagents.add_reagent(/datum/reagent/consumable/milk, 1)

/obj/item/udder/proc/milkAnimal(obj/item/reagent_containers/glass/container, mob/user)
	var/space_left = container.volume - container.reagents.total_volume
	if(space_left < 0.01) //These are floating point values, I'm not sure space_left <= 0 would work here?
		to_chat(user, span_warning("[container] is full."))
		return
	if(reagents.total_volume < 5)
		user.visible_message(span_notice("The udder is dry! Wait a bit longer..."))
		return
	if(do_after(user, 20, target = src))
		reagents.trans_to(container, min(rand(15,25), space_left))
		user.visible_message(span_notice("[user] milks [src] using \the [container]."), span_notice("I milk [src] using \the [container]."))
