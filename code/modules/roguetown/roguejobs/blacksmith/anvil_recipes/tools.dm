/datum/anvil_recipe/tools
	i_type = "Tools"

/datum/anvil_recipe/tools/steel
	skill_level = 3

/datum/anvil_recipe/general
	i_type = "General"

// --------- IRON -----------
/datum/anvil_recipe/general/torch
	name = "Torches 5x (+1 Coal)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/rogueore/coal)
	created_item = list(/obj/item/flashlight/flare/torch/metal, /obj/item/flashlight/flare/torch/metal, /obj/item/flashlight/flare/torch/metal, /obj/item/flashlight/flare/torch/metal, /obj/item/flashlight/flare/torch/metal)

/datum/anvil_recipe/general/locks
	name = "Locks 2x"
	req_bar = /obj/item/ingot/iron
	created_item = list(/obj/item/customlock, /obj/item/customlock)

/datum/anvil_recipe/general/keys
	name = "Keys 2x"
	req_bar = /obj/item/ingot/iron
	created_item = list(/obj/item/key_custom_blank, /obj/item/key_custom_blank)

/datum/anvil_recipe/tools/iron/scissors
	name = "Scissors"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/rogueweapon/huntingknife/scissors

/datum/anvil_recipe/tools/iron/pan
	name = "Skillet"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/cooking/pan

/datum/anvil_recipe/general/catbell
	name = "Catbell x3"
	req_bar = /obj/item/ingot/iron
	created_item = list(/obj/item/catbell,
						/obj/item/catbell,
						/obj/item/catbell)

/datum/anvil_recipe/general/iron/keyring
	name = "Keyrings 3x"
	req_bar = /obj/item/ingot/iron
	created_item = list(/obj/item/storage/keyring, /obj/item/storage/keyring, /obj/item/storage/keyring)

/datum/anvil_recipe/general/iron/sewingneedle
	name = "Sewing Needles 5x"
	req_bar = /obj/item/ingot/iron
	created_item = list(/obj/item/needle, /obj/item/needle, /obj/item/needle, /obj/item/needle, /obj/item/needle)

/datum/anvil_recipe/tools/iron/shovel
	name = "Shovel (+2 Sticks)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick,/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/shovel

/datum/anvil_recipe/tools/iron/hammer
	name = "Hammer (+1 Stick)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/hammer/iron

/datum/anvil_recipe/tools/iron/handsaw
	name = "Handsaw (+1 Stick)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/handsaw

/datum/anvil_recipe/tools/iron/chisel
	name = "Chisel"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/rogueweapon/chisel

/datum/anvil_recipe/tools/iron/tongs
	name = "Tongs"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/rogueweapon/tongs

/datum/anvil_recipe/tools/iron/sickle
	name = "Sickle (+1 Stick)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/sickle

/datum/anvil_recipe/tools/iron/pick
	name = "Pickaxe (+1 Stick)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/pick

/datum/anvil_recipe/tools/iron/hoe
	name = "Hoe (+2 Sticks)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick,/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/hoe

/datum/anvil_recipe/tools/iron/pitchfork
	name = "Pitchfork (+2 Sticks)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick,/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/pitchfork

/datum/anvil_recipe/general/iron/lamptern
	name = "Lamptern"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/flashlight/flare/torch/lantern

/datum/anvil_recipe/tools/iron/thresher
	name = "Thresher (+1 Stick)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/thresher

/datum/anvil_recipe/general/chain
	name = "Chain"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/rope/chain

/datum/anvil_recipe/general/chainleash
	name = "Chain Leash"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/leash/chain

/datum/anvil_recipe/general/iron/ramrod
	name = "Replacement Ramrods x3"
	req_bar = /obj/item/ingot/iron
	created_item = list(/obj/item/ramrod,
						/obj/item/ramrod,
						/obj/item/ramrod
						)

	skill_level = 0

/datum/anvil_recipe/tools/lockpicks
	name = "Lockpicks x3"
	req_bar = /obj/item/ingot/iron
	created_item = list(/obj/item/lockpick,
						/obj/item/lockpick,
						/obj/item/lockpick
						)

/datum/anvil_recipe/tools/lockpickring
	name = "Lockpickrings x3"
	req_bar = /obj/item/ingot/iron
	created_item = list(/obj/item/lockpickring,
						/obj/item/lockpickring,
						/obj/item/lockpickring
						)


/datum/anvil_recipe/tools/alembic
	name = "Alembic"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/reagent_containers/glass/alembic
	i_type = "Tools"

// --------- Steel -----------

/datum/anvil_recipe/tools/steel/hammer
	name = "Claw hammer (+1 Stick)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/hammer/steel

/datum/anvil_recipe/tools/steel/pick
	name = "Pickaxe (+1 Stick)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/pick/steel

/datum/anvil_recipe/tools/steel/scissors
	name = "Scissors"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/huntingknife/scissors/steel

/datum/anvil_recipe/tools/surgery/steel/scalpel
	name = "Scalpel"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/surgery/scalpel

/datum/anvil_recipe/tools/surgery/steel/saw
	name = "Surgical Saw"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/surgery/saw

/datum/anvil_recipe/tools/surgery/steel/hemostat
	name = "Forceps"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/surgery/hemostat

/datum/anvil_recipe/tools/surgery/steel/retractor
	name = "Speculum"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/surgery/retractor

/datum/anvil_recipe/tools/surgery/steel/bonesetter
	name = "Bone Forceps"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/surgery/bonesetter

/datum/anvil_recipe/tools/surgery/steel/cautery
	name = "Cautery Iron"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/surgery/cautery

/datum/anvil_recipe/general/cowbell
	name = "Cowbell x3"
	req_bar = /obj/item/ingot/copper
	created_item = list(/obj/item/catbell/cow,
						/obj/item/catbell/cow,
						/obj/item/catbell/cow)

