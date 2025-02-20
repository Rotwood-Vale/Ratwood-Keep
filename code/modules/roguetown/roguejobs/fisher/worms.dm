/obj/item
	var/baitpenalty = 100 // Using this as bait will incurr a penalty to fishing chance. 100 makes it useless as bait. Lower values are better, but Never make it past 10.
	var/isbait = FALSE	// Is the item in question bait to be used?
	var/list/freshfishloot = null
	var/list/seafishloot = null
	var/list/mudfishloot = null
	var/list/fishloot = null	
/obj/item/natural/worms
	name = "worm"
	desc = "The favorite bait of the courageous fishermen who venture these dark waters."
	icon_state = "worm1"
	throwforce = 10
	baitpenalty = 10
	isbait = TRUE
	color = "#985544"
	w_class = WEIGHT_CLASS_TINY
	freshfishloot = list(
		/obj/item/reagent_containers/food/snacks/fish/carp = 225,
		/obj/item/reagent_containers/food/snacks/fish/sunny = 325,
		/obj/item/reagent_containers/food/snacks/fish/salmon = 190,
		/obj/item/reagent_containers/food/snacks/fish/eel = 140,
		/obj/item/grown/log/tree/stick = 3,
		/obj/item/storage/belt/rogue/pouch/coins/poor = 1,
		/obj/item/natural/cloth = 1,
		/obj/item/ammo_casing/caseless/rogue/arrow = 1,
		/obj/item/clothing/ring/gold = 1,
		/obj/item/reagent_containers/food/snacks/smallrat = 1, //That's not a fish...?
		/obj/item/reagent_containers/glass/bottle/rogue/wine = 1,
		/obj/item/reagent_containers/glass/bottle/rogue = 1,	
		/mob/living/simple_animal/hostile/retaliate/rogue/mudcrab = 20,			
	)
	seafishloot = list(
		/obj/item/reagent_containers/food/snacks/fish/cod = 190,
		/obj/item/reagent_containers/food/snacks/fish/plaice = 210,
		/obj/item/reagent_containers/food/snacks/fish/sole = 340,
		/obj/item/reagent_containers/food/snacks/fish/angler = 140,
		/obj/item/reagent_containers/food/snacks/fish/lobster = 150,
		/obj/item/reagent_containers/food/snacks/fish/bass = 210,
		/obj/item/reagent_containers/food/snacks/fish/clam = 40,
		/obj/item/reagent_containers/food/snacks/fish/clownfish = 20,
		/obj/item/grown/log/tree/stick = 3,
		/obj/item/storage/belt/rogue/pouch/coins/poor = 1,
		/obj/item/natural/cloth = 1,
		/obj/item/ammo_casing/caseless/rogue/arrow = 1,
		/obj/item/clothing/ring/gold = 1,
		/obj/item/reagent_containers/food/snacks/smallrat = 1, //That's not a fish...?
		/obj/item/reagent_containers/glass/bottle/rogue/wine = 1,
		/obj/item/reagent_containers/glass/bottle/rogue = 1,	
		/mob/living/carbon/human/species/goblin/npc/sea = 25,
		/mob/living/simple_animal/hostile/rogue/deepone = 30,
		/mob/living/simple_animal/hostile/rogue/deepone/spit = 30,			
	)
	mudfishloot = list(
		/obj/item/reagent_containers/food/snacks/fish/mudskipper = 200,
		/obj/item/natural/worms/leech = 50,
		/obj/item/clothing/ring/gold = 1,
		/mob/living/simple_animal/hostile/retaliate/rogue/mudcrab = 25,				
	)	
	drop_sound = 'sound/foley/dropsound/food_drop.ogg'
	var/amt = 1

/obj/item/natural/worms/grubs
	name = "grub"
	desc = "Bait for the desperate, or the daring."
	baitpenalty = 5
	isbait = TRUE
	color = null
	freshfishloot = list(
		/obj/item/reagent_containers/food/snacks/fish/carp = 200,
		/obj/item/reagent_containers/food/snacks/fish/sunny = 305,
		/obj/item/reagent_containers/food/snacks/fish/salmon = 210,
		/obj/item/reagent_containers/food/snacks/fish/eel = 160,
		/obj/item/grown/log/tree/stick = 3,
		/obj/item/storage/belt/rogue/pouch/coins/poor = 1,
		/obj/item/natural/cloth = 1,
		/obj/item/ammo_casing/caseless/rogue/arrow = 1,
		/obj/item/clothing/ring/gold = 1,
		/obj/item/reagent_containers/food/snacks/smallrat = 1, //That's not a fish...?
		/obj/item/reagent_containers/glass/bottle/rogue/wine = 1,
		/obj/item/reagent_containers/glass/bottle/rogue = 1,
		/mob/living/simple_animal/hostile/retaliate/rogue/mudcrab = 20,				
	)
	seafishloot = list(
		/obj/item/reagent_containers/food/snacks/fish/cod = 230,
		/obj/item/reagent_containers/food/snacks/fish/plaice = 180,
		/obj/item/reagent_containers/food/snacks/fish/sole = 250,
		/obj/item/reagent_containers/food/snacks/fish/angler = 170,
		/obj/item/reagent_containers/food/snacks/fish/lobster = 180,
		/obj/item/reagent_containers/food/snacks/fish/bass = 230,
		/obj/item/reagent_containers/food/snacks/fish/clam = 50,
		/obj/item/reagent_containers/food/snacks/fish/clownfish = 40,
		/obj/item/grown/log/tree/stick = 3,
		/obj/item/storage/belt/rogue/pouch/coins/poor = 1,
		/obj/item/natural/cloth = 1,
		/obj/item/ammo_casing/caseless/rogue/arrow = 1,
		/obj/item/clothing/ring/gold = 1,
		/obj/item/reagent_containers/food/snacks/smallrat = 1, //That's not a fish...?
		/obj/item/reagent_containers/glass/bottle/rogue/wine = 1,
		/obj/item/reagent_containers/glass/bottle/rogue = 1,		
		/mob/living/carbon/human/species/goblin/npc/sea = 25,
		/mob/living/simple_animal/hostile/rogue/deepone = 30,
		/mob/living/simple_animal/hostile/rogue/deepone/spit = 30,		
	)
	mudfishloot = list(
		/obj/item/reagent_containers/food/snacks/fish/mudskipper = 200,
		/obj/item/natural/worms/leech = 50,
		/obj/item/clothing/ring/gold = 1,
		/mob/living/simple_animal/hostile/retaliate/rogue/mudcrab = 25,				
	)	
/obj/item/natural/worms/grubs/attack_right(mob/user)
	return

/obj/item/natural/worms/Initialize()
	. = ..()
	dir = rand(0,8)
