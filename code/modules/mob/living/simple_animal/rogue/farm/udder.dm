/obj/item/udder
	name = "udder"

/obj/item/udder/Initialize()
	create_reagents(100)
	reagents.add_reagent(/datum/reagent/consumable/milk, rand(0,20))
	. = ..()

/obj/item/udder/proc/generateMilk()
	reagents.add_reagent(/datum/reagent/consumable/milk, 1)

/obj/item/udder/proc/milkAnimal(obj/O, mob/living/user = usr)
	var/obj/item/reagent_containers/glass/G = O
	if(G.reagents.total_volume >= G.volume)
		to_chat(user, span_warning("[O] is full."))
		return
	if(!reagents.has_reagent(/datum/reagent/consumable/milk, 5))
		to_chat(user, span_warning("The udder is dry. Wait a bit longer..."))
		user.changeNext_move(10)
		return
	if(do_after(user, 1 SECONDS, target = src))
		reagents.trans_to(O, rand(5,10))
		user.visible_message(span_notice("[user] milks [src] using \the [O]"))
		playsound(O, pick('sound/vo/mobs/cow/milking (1).ogg', 'sound/vo/mobs/cow/milking (2).ogg'), 100, TRUE, -1)
		user.Immobilize(1 SECONDS)
		user.changeNext_move(10)
