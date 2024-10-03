

/datum/supply_pack/rogue/luxury
	group = "Luxury"
	crate_name = "merchant guild's crate"
	crate_type = /obj/structure/closet/crate/chest/merchant


/datum/supply_pack/rogue/luxury/sigs
	name = "Pipe Weed Zig"
	cost = 3
	contains = list(/obj/item/clothing/mask/cigarette/rollie/nicotine)

/datum/supply_pack/rogue/luxury/moondust
	name = "Moon Dust"
	cost = 5
	contains = list(/obj/item/reagent_containers/powder/moondust)

/datum/supply_pack/rogue/luxury/sublimate // Far cheaper to make your own.
	name = "Arcyne Sublimate"
	cost = 80
	contains = list(
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
	)

/datum/supply_pack/rogue/luxury/spice
	name = "Spice"
	cost = 50
	contains = list(/obj/item/reagent_containers/powder)

/datum/supply_pack/rogue/luxury/mbox
	name = "Music Box"
	cost = 500
	contains = list(/obj/item/dmusicbox)

/datum/supply_pack/rogue/luxury/flute
	name = "Flute"
	cost = 10
	contains = list(/obj/item/rogue/instrument/flute)

/datum/supply_pack/rogue/luxury/harp
	name = "Harp"
	cost = 20
	contains = list(/obj/item/rogue/instrument/harp)

/datum/supply_pack/rogue/luxury/guitar
	name = "Guitar"
	cost = 30
	contains = list(/obj/item/rogue/instrument/guitar)

/datum/supply_pack/rogue/luxury/accord
	name = "Accordion"
	cost = 30
	contains = list(/obj/item/rogue/instrument/accord)

/datum/supply_pack/rogue/luxury/lute
	name = "Lute"
	cost = 20
	contains = list(/obj/item/rogue/instrument/lute)

/datum/supply_pack/rogue/luxury/drum
	name = "Drum"
	cost = 10
	contains = list(/obj/item/rogue/instrument/drum)

/datum/supply_pack/rogue/luxury/nomag
	name = "Ring of Null Magic"
	cost = 300
	contains = list(/obj/item/clothing/ring/active/nomag)

/datum/supply_pack/rogue/luxury/scrying
	name = "Scrying Orb"
	cost = 250
	contains = list(/obj/item/scrying)

/datum/supply_pack/rogue/luxury/listenst
	name = "Emerald Choker"
	cost = 250
	contains = list(/obj/item/listenstone)

/datum/supply_pack/rogue/luxury/riddleofsteel
	name = "Riddle of Steel"
	cost = 400
	contains = list(/obj/item/riddleofsteel)
// Flavor Packages - For region specific gear; mostly for flavor, also to buy and LARP I guess.
// Yeah, it's weapons and armor and clothes but sue me. It's overpriced for the LARP.

//Desert Rider / Desert Warrior pack; very good helm, decent medium armor, unique sword from rider.
/datum/supply_pack/rogue/luxury/zybantine
	name = "Zybantine Arms & Armor Import"
	cost = 300
	contains = list(/obj/item/rogueweapon/sword/long/rider,
					/obj/item/clothing/head/roguetown/roguehood/shalal,
					/obj/item/clothing/head/roguetown/helmet/heavy/zybantinehelm,
					/obj/item/clothing/suit/roguetown/armor/plate/zybantinearmor,
					/obj/item/clothing/under/roguetown/chainlegs
					)

//Grenzel pack; decent medium armor, no helmet, but whole clothing loadout and the two meme weapons.
/datum/supply_pack/rogue/luxury/grenzelhoft
	name = "Grenzelhoft Landsknecht Arms & Armor Import"
	cost = 300
	contains = list(/obj/item/clothing/suit/roguetown/armor/plate/half/grenzelhoft,
					/obj/item/clothing/shoes/roguetown/grenzelhoft,
					/obj/item/clothing/gloves/roguetown/grenzelgloves,
					/obj/item/clothing/head/roguetown/grenzelhofthat,
					/obj/item/clothing/under/roguetown/grenzelpants,
					/obj/item/clothing/suit/roguetown/shirt/grenzelhoft,
					/obj/item/rogueweapon/greatsword/zwei,
					/obj/item/rogueweapon/halberd
					)

//Grenzel musketeer pack; EXPENSIVE as shit but hey funni Grenzelhoft musketeer. Pike n' shot.
/datum/supply_pack/rogue/luxury/grenzelhoftmusket
	name = "Grenzelhoft Musketeer Arms & Armor Import"
	cost = 600		//Lol, lmao. Not worth it, remotely.
	contains = list(/obj/item/clothing/suit/roguetown/armor/plate/half/footmanchestplate,	//Cheaper armor because moosket.
					/obj/item/clothing/shoes/roguetown/grenzelhoft,
					/obj/item/clothing/gloves/roguetown/grenzelgloves,
					/obj/item/clothing/head/roguetown/grenzelhofthat,
					/obj/item/clothing/under/roguetown/grenzelpants,
					/obj/item/clothing/suit/roguetown/shirt/grenzelhoft,
					/obj/item/gun/ballistic/revolver/grenadelauncher/matchlock,
					/obj/item/ammopouch/bullets
					)


/datum/supply_pack/rogue/luxury/acrobat
	name = "Fragment of the Acrobat"
	cost = 200
	contains = list(/obj/item/book/granter/trait/acrobat)
/*/datum/supply_pack/rogue/luxury/swamp
	name = "Fragment of the Swamp"
	cost = 750
	contains = list(/obj/item/book/granter/trait/mobility/bogtrek) */
/datum/supply_pack/rogue/luxury/kneestinger
	name = "Fragment of Dendor"
	cost = 100
	contains = list(/obj/item/book/granter/trait/mobility/kneestinger)
/datum/supply_pack/rogue/luxury/mediumarmor
	name = "Fragment of the Old Guard"
	cost = 200
	contains = list(/obj/item/book/granter/trait/defense/mediumarmor)
/*/datum/supply_pack/rogue/luxury/heavyarmor
	name = "Fragment of the Forgotten Knight"
	cost = 200
	contains = list(/obj/item/book/granter/trait/defense/heavyarmor) */
/datum/supply_pack/rogue/luxury/succubus
	name = "Fragment of the Succubus"
	cost = 50
	contains = list(/obj/item/book/granter/trait/succubus)
/datum/supply_pack/rogue/luxury/north
	name = "Fragment of the North"
	cost = 200
	contains = list(/obj/item/book/granter/trait/north)
/*/datum/supply_pack/rogue/luxury/undying
	name = "Fragment of the Undying"
	cost = 500
	contains = list(/obj/item/book/granter/trait/war/undying)
/datum/supply_pack/rogue/luxury/relentless
	name = "Fragment of the Relentless"
	cost = 1000
	contains = list(/obj/item/book/granter/trait/war/relentless) */



/datum/supply_pack/rogue/luxury/acidsplash5e
	name = "Acid Splash"
	cost = 60
	contains = list(/obj/item/book/granter/spell/spells5e/acidsplash5e)
/datum/supply_pack/rogue/luxury/bladeward5e
	name = "Scroll of Blade Ward"
	cost = 60
	contains = list(/obj/item/book/granter/spell/spells5e/bladeward5e)
/datum/supply_pack/rogue/luxury/bladeward5e
	name = "Scroll of Booming Blade"
	cost = 60
	contains = list(/obj/item/book/granter/spell/spells5e/boomingblade5e)
/datum/supply_pack/rogue/luxury/createbonfire5e
	name = "Scroll of Create Bonfire"
	cost = 30
	contains = list(/obj/item/book/granter/spell/spells5e/createbonfire5e)
/datum/supply_pack/rogue/luxury/chilltouch5e
	name = "Scroll of Chill Touch"
	cost = 60
	contains = list(/obj/item/book/granter/spell/spells5e/chilltouch5e)
/datum/supply_pack/rogue/luxury/decompose5e
	name = "Scroll of Decompose"
	cost = 30
	contains = list(/obj/item/book/granter/spell/spells5e/decompose5e)
/datum/supply_pack/rogue/luxury/eldritchblast5e
	name = "Scroll of Eldritch Blast"
	cost = 60
	contains = list(/obj/item/book/granter/spell/spells5e/eldritchblast5e)
/datum/supply_pack/rogue/luxury/encodethoughts5e
	name = "Scroll of Encode Thoughts"
	cost = 30
	contains = list(/obj/item/book/granter/spell/spells5e/encodethoughts5e)
/datum/supply_pack/rogue/luxury/firebolt5e
	name = "Scroll of Fire Bolt"
	cost = 30
	contains = list(/obj/item/book/granter/spell/spells5e/firebolt5e)
/datum/supply_pack/rogue/luxury/frostbite5e
	name = "Scroll of Frostbite"
	cost = 60
	contains = list(/obj/item/book/granter/spell/spells5e/frostbite5e)
/datum/supply_pack/rogue/luxury/greenflameblade5e
	name = "Scroll of Green-Flame Blade"
	cost = 60
	contains = list(/obj/item/book/granter/spell/spells5e/greenflameblade5e)
/datum/supply_pack/rogue/luxury/guidance5e
	name = "Scroll of Guidance"
	cost = 30
	contains = list(/obj/item/book/granter/spell/spells5e/guidance5e)

/datum/supply_pack/rogue/luxury/infestation5e
	name = "Scroll of Infestation"
	cost = 60
	contains = list(/obj/item/book/granter/spell/spells5e/infestation5e)
/datum/supply_pack/rogue/luxury/light5e
	name = "Scroll of Light"
	cost = 30
	contains = list(/obj/item/book/granter/spell/spells5e/light5e)
/datum/supply_pack/rogue/luxury/lightninglure5e
	name = "Scroll of Lightning Lure"
	cost = 60
	contains = list(/obj/item/book/granter/spell/spells5e/lightninglure5e)
/datum/supply_pack/rogue/luxury/magicstone5e
	name = "Scroll of Magic Stone"
	cost = 25
	contains = list(/obj/item/book/granter/spell/spells5e/magicstone5e)
/datum/supply_pack/rogue/luxury/mending5e
	name = "Scroll of Mending"
	cost = 50
	contains = list(/obj/item/book/granter/spell/spells5e/mending5e)



//p2
/datum/supply_pack/rogue/luxury/mindsliver5e
	name = "Scroll of Mind Sliver"
	cost = 50
	contains = list(/obj/item/book/granter/spell/spells5e/mindsliver5e)
/datum/supply_pack/rogue/luxury/poisonspray5e
	name = "Scroll of Poison Spray"
	cost = 50
	contains = list(/obj/item/book/granter/spell/spells5e/poisonspray5e)
/datum/supply_pack/rogue/luxury/primalsavagery5e
	name = "Scroll of Primal Savagery"
	cost = 50
	contains = list(/obj/item/book/granter/spell/spells5e/primalsavagery5e)
/datum/supply_pack/rogue/luxury/mending5e
	name = "Scroll of Ray of Frost"
	cost = 50
	contains = list(/obj/item/book/granter/spell/spells5e/rayoffrost5e)
