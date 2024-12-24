/obj/item/book/granter/spell/spells5e/
	desc = "A scroll of potential known only to those that can decipher its secrets."
	icon = 'icons/roguetown/items/misc.dmi'
	oneuse = TRUE
	drop_sound = 'sound/foley/dropsound/paper_drop.ogg'
	pickup_sound =  'sound/blank.ogg'
	remarks = list("Fascinating!", "Is that so...", "Like this?", "Really now...", "There's a little schmutz on this section...")
	sellprice = 30

/obj/item/book/granter/spell/spells5e/onlearned(mob/living/carbon/user)
	..()
	if(oneuse == TRUE)
		qdel(src) //no need this trash.
		user.visible_message(span_warning("[src] has had its magic ink ripped from the scroll, it disintegrates to dust!"))

//backpack prepacked with scrolls for testing
/obj/item/storage/backpack/rogue/backpack/spells5e/PopulateContents()
	new /obj/item/book/granter/spell/spells5e/acidsplash5e(src)
	new /obj/item/book/granter/spell/spells5e/bladeward5e(src)
	new /obj/item/book/granter/spell/spells5e/createbonfire5e(src)
	new /obj/item/book/granter/spell/spells5e/chilltouch5e(src)
	new /obj/item/book/granter/spell/spells5e/frostbite5e(src)
	new /obj/item/book/granter/spell/spells5e/guidance5e(src)
	new /obj/item/book/granter/spell/spells5e/infestation5e(src)
	new /obj/item/book/granter/spell/spells5e/light5e(src)
	new /obj/item/book/granter/spell/spells5e/lightninglure5e(src)

//cantrips
/obj/item/book/granter/spell/spells5e/acidsplash5e
	name = "Scroll of Acid Splash"
	spell = /obj/effect/proc_holder/spell/invoked/projectile/acidsplash5e
	spellname = "acid splash"
	icon_state ="scrollred"

/obj/item/book/granter/spell/spells5e/bladeward5e
	name = "Scroll of Blade Ward"
	spell = /obj/effect/proc_holder/spell/self/bladeward5e
	spellname = "blade ward"
	icon_state ="scrollred"

/obj/item/book/granter/spell/spells5e/boomingblade5e
	name = "Scroll of Booming Blade"
	spell = /obj/effect/proc_holder/spell/invoked/boomingblade5e
	spellname = "booming blade"
	icon_state ="scrollred"

/obj/item/book/granter/spell/spells5e/createbonfire5e
	name = "Scroll of Create Bonfire"
	spell = /obj/effect/proc_holder/spell/aoe_turf/conjure/createbonfire5e
	spellname = "create bonfire"
	icon_state ="scrollred"

/obj/item/book/granter/spell/spells5e/chilltouch5e
	name = "Scroll of Chill Touch"
	spell = /obj/effect/proc_holder/spell/invoked/chilltouch5e
	spellname = "chill touch"
	icon_state ="scrollred"

/obj/item/book/granter/spell/spells5e/eldritchblast5e
	name = "Scroll of Eldritch Blast"
	spell = /obj/effect/proc_holder/spell/invoked/projectile/eldritchblast5e
	spellname = "eldritch blast"
	icon_state ="scrollred"

/obj/item/book/granter/spell/spells5e/encodethoughts5e
	name = "Scroll of Encode Thoughts"
	spell = /obj/effect/proc_holder/spell/targeted/encodethoughts5e
	spellname = "encode thoughts"
	icon_state ="scrollred"

/obj/item/book/granter/spell/spells5e/firebolt5e
	name = "Scroll of Fire Bolt"
	spell = /obj/effect/proc_holder/spell/invoked/projectile/firebolt5e
	spellname = "fire bolt"
	icon_state ="scrollred"

/obj/item/book/granter/spell/spells5e/frostbite5e
	name = "Scroll of Frostbite"
	spell = /obj/effect/proc_holder/spell/invoked/frostbite5e
	spellname = "frostbite"
	icon_state ="scrollred"

/obj/item/book/granter/spell/spells5e/greenflameblade5e
	name = "Scroll of Green-Flame Blade"
	spell = /obj/effect/proc_holder/spell/invoked/greenflameblade5e
	spellname = "green-flame blade"
	icon_state ="scrollred"

/obj/item/book/granter/spell/spells5e/guidance5e
	name = "Scroll of Guidance"
	spell = /obj/effect/proc_holder/spell/targeted/guidance5e
	spellname = "guidance"
	icon_state ="scrollred"

/obj/item/book/granter/spell/spells5e/infestation5e
	name = "Scroll of Infestation"
	spell = /obj/effect/proc_holder/spell/invoked/infestation5e
	spellname = "infestation"
	icon_state ="scrollred"

/obj/item/book/granter/spell/spells5e/light5e
	name = "Scroll of Light"
	spell = /obj/effect/proc_holder/spell/self/light5e
	spellname = "light"
	icon_state ="scrollred"

/obj/item/book/granter/spell/spells5e/lightninglure5e
	name = "Scroll of Lightning Lure"
	spell = /obj/effect/proc_holder/spell/targeted/lightninglure5e
	spellname = "lightning lure"
	icon_state ="scrollred"

/obj/item/book/granter/spell/spells5e/mending5e
	name = "Scroll of Mending"
	spell = /obj/effect/proc_holder/spell/invoked/mending5e
	spellname = "mending"
	icon_state ="scrollred"

/obj/item/book/granter/spell/spells5e/mindsliver5e
	name = "Scroll of Mind Sliver"
	spell = /obj/effect/proc_holder/spell/invoked/mindsliver5e
	spellname = "mind sliver"
	icon_state ="scrollred"

/obj/item/book/granter/spell/spells5e/poisonspray5e
	name = "Scroll of Poison Spray"
	spell = /obj/effect/proc_holder/spell/invoked/poisonspray5e
	spellname = "poison spray"
	icon_state ="scrollred"

/obj/item/book/granter/spell/spells5e/primalsavagery5e
	name = "Scroll of Primal Savagery"
	spell = /obj/effect/proc_holder/spell/self/primalsavagery5e
	spellname = "primal savagery"
	icon_state ="scrollred"

/obj/item/book/granter/spell/spells5e/rayoffrost5e
	name = "Scroll of Ray of Frost"
	spell = /obj/effect/proc_holder/spell/invoked/projectile/rayoffrost5e
	spellname = "ray of frost"
	icon_state ="scrollred"
