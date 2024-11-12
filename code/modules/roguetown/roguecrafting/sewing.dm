//Removing sell prices, if one wishes to sell these things, just scavenge them for parts and sell that.
//Exempt lordly cloak due to it being a luxury item, for the vault or merchant to sell. (sticky fingers)
//Kingsfield decrees, "All holy items are now barred from vault scrying and merchant guild selling."

/datum/crafting_recipe/roguetown/sewing
	tools = list(/obj/item/needle)
	skillcraft = /datum/skill/misc/sewing
	verbage_simple = "sew"
	verbage = "sews"

/* craftdif of 0 = NONE */

/datum/crafting_recipe/roguetown/sewing/cloth
	name = "cloth (2 fibers; NONE)"
	result = /obj/item/natural/cloth
	reqs = list(/obj/item/natural/fibers = 2)
	craftdiff = 0

/datum/crafting_recipe/roguetown/sewing/headband
	name = "headband (cloth; NONE)"
	result = list(/obj/item/clothing/head/roguetown/headband)
	reqs = list(/obj/item/natural/cloth = 1)
	craftdiff = 0

/datum/crafting_recipe/roguetown/sewing/loincloth
	name = "loincloth (cloth; NONE)"
	result = list(/obj/item/clothing/under/roguetown/loincloth)
	reqs = list(/obj/item/natural/cloth = 1)
	craftdiff = 0

/datum/crafting_recipe/roguetown/sewing/rags
	name = "rags (2 cloths; NONE)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/rags)
	reqs = list(/obj/item/natural/cloth = 2)
	craftdiff = 0

/datum/crafting_recipe/roguetown/sewing/bag
	name = "sack (cloth, fiber; NONE)"
	result = /obj/item/storage/roguebag/crafted
	reqs = list(/obj/item/natural/fibers = 1,
				/obj/item/natural/cloth = 1)
	craftdiff = 0

/* craftdif of 1 = NOVICE */

/datum/crafting_recipe/roguetown/sewing/knitcap
	name = "cap (knit) - (2 cloths, fiber; NOVICE)"
	result = list(/obj/item/clothing/head/roguetown/knitcap)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/sewing/Leyepatch
	name = "eye patch (left) - (cloth, fiber; NOVICE)"
	result = list(/obj/item/clothing/mask/rogue/eyepatch/left)
	reqs = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/sewing/Reyepatch
	name = "eye patch (right) - (cloth, fiber; NOVICE)"
	result = list(/obj/item/clothing/mask/rogue/eyepatch)
	reqs = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/sewing/clothgloves
	name = "gloves (fingerless) - (cloth, fiber; NOVICE)"
	result = list(/obj/item/clothing/gloves/roguetown/fingerless)
	reqs = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/sewing/strawhat
	name = "hat (straw) - (5 fibers; NOVICE)"
	result = list(/obj/item/clothing/head/roguetown/strawhat)
	reqs = list(/obj/item/natural/fibers = 3)
	craftdiff = 1

/datum/crafting_recipe/roguetown/sewing/basichood
	name = "hood (2 cloths, fiber; NOVICE)"
	result = list(/obj/item/clothing/head/roguetown/roguehood)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/sewing/sack
	name = "hood (sack) - (2 cloths; NOVICE)"
	result = list(/obj/item/clothing/head/roguetown/menacing)
	reqs = list(/obj/item/natural/cloth = 2,)
	craftdiff = 1

/datum/crafting_recipe/roguetown/sewing/clothtrou
	name = "trousers (2 cloths, fiber; NOVICE)"
	result = list(/obj/item/clothing/under/roguetown/trou)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/sewing/workervest
	name = "tunic (striped) - (2 cloths, 2 fibers; NOVICE)"
	result = list(/obj/item/clothing/suit/roguetown/armor/workervest)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 2)
	craftdiff = 1

/datum/crafting_recipe/roguetown/sewing/clothshirt
	name = "shirt (cloth) - (2 cloths, fiber; NOVICE)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/undershirt)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/sewing/burial_shroud
	name = "winding sheet (2 cloths; NOVICE)"
	result = list(/obj/item/burial_shroud)
	reqs = list(/obj/item/natural/cloth = 2)
	craftdiff = 1

/* craftdif of 2 = APPRENTICE */

/datum/crafting_recipe/roguetown/sewing/nocwrappings
	name = "wrappings (moon/Noc) - (2 cloths; APPRENTICE)"
	result = list(/obj/item/clothing/wrists/roguetown/nocwrappings)
	reqs = list(/obj/item/natural/cloth = 2)
	craftdiff = 2

/datum/crafting_recipe/roguetown/sewing/wrappings
	name = "wrappings (solar/Astrata) (2 cloths; APPRENTICE)"
	result = list(/obj/item/clothing/wrists/roguetown/wrappings)
	reqs = list(/obj/item/natural/cloth = 2)
	craftdiff = 2

/datum/crafting_recipe/roguetown/sewing/sleepingbag
	name = "sleep-cloth/sleeping-bag (2 cloths, fiber; APPRENTICE)"
	result = list(/obj/item/sleepingbag)
	reqs =  list(/obj/item/natural/cloth = 2,
                /obj/item/natural/fibers = 1)
	craftdiff = 2

/* craftdif of 3 = JOURNEYMAN */

/datum/crafting_recipe/roguetown/sewing/armingjacket
	name = "arming jacket (4 cloths, fiber; JOURNEYMAN)"
	result = /obj/item/clothing/suit/roguetown/armor/gambeson/lord
	reqs = list(/obj/item/natural/cloth = 4,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/bedsheet
	name = "bedsheet (2 cloths; fiber; JOURNEYMAN)"
	result = list(/obj/item/bedsheet/rogue/cloth)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/bedsheetpelt
	name = "bedsheet (leather) - (2 hides, fiber; JOURNEYMAN)"
	result = list(/obj/item/bedsheet/rogue/pelt)
	reqs = list(/obj/item/natural/hide/cured = 2,
            	/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/paddedcap
	name = "cap (padded) - (5 fibers; JOURNEYMAN)"
	result = /obj/item/clothing/head/roguetown/paddedcap
	reqs = list(/obj/item/natural/fibers = 5)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/cape
	name = "cape (2 cloths, fiber; JOURNEYMAN)"
	result = list(/obj/item/clothing/cloak/cape)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/coif
	name = "coif (2 cloths, fiber; JOURNEYMAN)"
	result = list(/obj/item/clothing/neck/roguetown/coif)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/armordress
	name = "dress (padded) - (5 cloths, fiber; JOURNEYMAN)"
	result = /obj/item/clothing/suit/roguetown/armor/armordress
	reqs = list(/obj/item/natural/cloth = 5,
				/obj/item/natural/fibers = 2)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/strapless_dress
	name = "dress (strapless) - (2 cloths, fiber; JOURNEYMAN)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/dress/gen/strapless)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/wizhatblue
	name = "hat (wizard) - (2 cloths, fiber; JOURNEYMAN)"
	result = list(/obj/item/clothing/head/roguetown/wizhat)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/gambeson
	name = "gambeson (4 cloths, fiber; JOURNEYMAN)"
	result = /obj/item/clothing/suit/roguetown/armor/gambeson
	reqs = list(/obj/item/natural/cloth = 4,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/robe
	name = "robes (3 cloths, fiber; JOURNEYMAN)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/robe)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/stockings_white
	name = "stockings (cloth, fiber; JOURNEYMAN)"
	result = list(/obj/item/clothing/under/roguetown/tights/stockings/white)
	reqs = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/stockings_white_fishnet
	name = "stockings (fishnet) - (2 fibers; JOURNEYMAN)"
	result = list(/obj/item/clothing/under/roguetown/tights/stockings/fishnet/white)
	reqs = list(/obj/item/natural/fibers = 2)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/stabard
	name = "surcoat (2 cloths, fiber; JOURNEYMAN)"
	result = list(/obj/item/clothing/cloak/stabard)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/stabard/guard
	name = "surcoat (guard) - (2 cloths, fiber; JOURNEYMAN)"
	result = list(/obj/item/clothing/cloak/stabard/guard)

/datum/crafting_recipe/roguetown/sewing/cloak/vanguard
	name = "cloak (vanguard) - (2 cloths, fiber; JOURNEYMAN)"
	result = list(/obj/item/clothing/cloak/raincloak/vanguard)

/datum/crafting_recipe/roguetown/sewing/tabard
	name = "tabard (2 cloths, fiber; JOURNEYMAN)"
	result = list(/obj/item/clothing/cloak/tabard)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/tabard/crusader
	name = "tabard (crusader) - (2 cloths, fiber; JOURNEYMAN)"
	result = list(/obj/item/clothing/cloak/tabard/crusader)

/* craftdif of 4 EXPERT */

/datum/crafting_recipe/roguetown/sewing/stockdress
	name = "dress (3 cloths, fiber; EXPERT)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/dress/gen)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 4

/datum/crafting_recipe/roguetown/sewing/fancyhat
	name = "hat (fancy) - (2 cloths, fiber; EXPERT)"
	result = list(/obj/item/clothing/head/roguetown/fancyhat)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 4

/datum/crafting_recipe/roguetown/sewing/bardhat
	name = "hat (bard) - (2 cloths, fiber; EXPERT)"
	result = list(/obj/item/clothing/head/roguetown/bardhat)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 4

/datum/crafting_recipe/roguetown/sewing/chaperon
	name = "hat (chaperon) - (2 cloths, fiber; EXPERT)"
	result = list(/obj/item/clothing/head/roguetown/chaperon)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 4

/datum/crafting_recipe/roguetown/sewing/jupon
	name = "jupon (2 cloths, fiber; EXPERT)"
	result = list(/obj/item/clothing/cloak/stabard/surcoat)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 4

/* craftdif of 5 = MASTER */

/datum/crafting_recipe/roguetown/sewing/lordcloak
	name = "lordly cloak (2 furs, 4 hides; MASTER)"
	result = list(/obj/item/clothing/cloak/lordcloak)
	reqs = list(/obj/item/natural/fur = 2,
				/obj/item/natural/hide/cured = 4)
	craftdiff = 5
	sellprice = 85

/datum/crafting_recipe/roguetown/sewing/stockings_white_silk
	name = "stockings (silk) - (fiber, silk; MASTER)"
	result = list(/obj/item/clothing/under/roguetown/tights/stockings/silk/white)
	reqs = list(/obj/item/natural/silk = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 5

/* craftdif of 6 = LEGENDARY */

/datum/crafting_recipe/roguetown/sewing/sexydress
	name = "sexy dress of legendary sewists (6 cloths, 3 fibers; LEGENDARY)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/dress/gen/sexy)
	reqs = list(/obj/item/natural/cloth = 6,
				/obj/item/natural/fibers = 3)
	craftdiff = 6

/// LEATHER ///

/datum/crafting_recipe/roguetown/sewing/belt
	name = "leather belt"
	result = /obj/item/storage/belt/rogue/leather
	reqs = list(/obj/item/natural/hide/cured = 1)
	craftdiff = 2

/datum/crafting_recipe/roguetown/sewing/bandana
	name = "leather bandana"
	result = /obj/item/clothing/head/roguetown/helmet/bandana
	reqs = list(/obj/item/natural/hide/cured = 1)
	craftdiff = 2

/datum/crafting_recipe/roguetown/sewing/hood
	name = "leather hood"
	result = /obj/item/clothing/head/roguetown/roguehood
	reqs = list(/obj/item/natural/hide/cured = 1)
	craftdiff = 2

/datum/crafting_recipe/roguetown/sewing/tricorn
	name = "leather tricorn"
	result = /obj/item/clothing/head/roguetown/helmet/tricorn
	reqs = list(/obj/item/natural/hide/cured = 1)
	craftdiff = 2

/datum/crafting_recipe/roguetown/sewing/cloak
	name = "leather cloak"
	result = /obj/item/clothing/cloak/raincloak
	reqs = list(/obj/item/natural/hide/cured = 2)
	craftdiff = 2

/datum/crafting_recipe/roguetown/sewing/vest
	name = "leather vest"
	result = /obj/item/clothing/suit/roguetown/armor/leather/vest
	reqs = list(/obj/item/natural/hide/cured = 2)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/vest/sailor
	name = "leather sea jacket"
	result = /obj/item/clothing/suit/roguetown/armor/leather/vest/sailor
	reqs = list(/obj/item/natural/hide/cured = 2)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/apron/blacksmith
	name = "leather apron"
	result = /obj/item/clothing/cloak/apron/blacksmith
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 2

/datum/crafting_recipe/roguetown/sewing/hidearmor
	name = "hide armor"
	result = /obj/item/clothing/suit/roguetown/armor/leather/hide
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fur = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/heavygloves
	name = "hide gloves"
	result = /obj/item/clothing/gloves/roguetown/angle
	reqs = list(/obj/item/natural/fur = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/cloakfur
	name = "fur cloak"
	result = /obj/item/clothing/cloak/raincloak/furcloak/crafted
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fur = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/shoes
	name = "simple shoes"
	result = list(/obj/item/clothing/shoes/roguetown/simpleshoes)
	reqs = list(/obj/item/natural/hide/cured = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/sewing/pouch
	name = "leather pouch"
	result = list(/obj/item/storage/belt/rogue/pouch)
	reqs = list(/obj/item/natural/hide/cured = 1)
	craftdiff = 2

/datum/crafting_recipe/roguetown/sewing/satchel
	name = "leather satchel"
	result = list(/obj/item/storage/backpack/rogue/satchel)
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/backpack
	name = "leather backpack"
	result = /obj/item/storage/backpack/rogue/backpack
	reqs = list(/obj/item/natural/hide/cured = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 4

/// ADVANCED LEATHER

/datum/crafting_recipe/roguetown/sewing/leather/boots
	name = "hardened leather boots"
	result = /obj/item/clothing/shoes/roguetown/armor/leather/advanced
	reqs = list(/obj/item/natural/hide/cured = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 4

/datum/crafting_recipe/roguetown/sewing/leather/gloves
	name = "hardened leather gloves"
	result = /obj/item/clothing/gloves/roguetown/leather/advanced
	reqs = list(/obj/item/natural/hide/cured = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 4

/datum/crafting_recipe/roguetown/sewing/leather/braces
	name = "hardened leather braces"
	result = /obj/item/clothing/wrists/roguetown/bracers/leather/advanced
	reqs = list(/obj/item/natural/hide/cured = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 4

/datum/crafting_recipe/roguetown/sewing/leather/coat
	name = "hardened leather coat"
	result = /obj/item/clothing/suit/roguetown/armor/leather/advanced
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 4

/datum/crafting_recipe/roguetown/sewing/leather/helmet
	name = "hardened leather helmet"
	result = /obj/item/clothing/head/roguetown/helmet/leather/advanced
	reqs = list(/obj/item/natural/hide/cured = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 4

/datum/crafting_recipe/roguetown/sewing/leather/neck
	name = "hardened leather gorget"
	result = /obj/item/clothing/neck/roguetown/leather
	reqs = list(/obj/item/natural/hide/cured = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 4

/datum/crafting_recipe/roguetown/sewing/leather/chausses
	name = "hardened leather chausses"
	result = /obj/item/clothing/under/roguetown/trou/leather/advanced
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 4

/// MASTERWORK

/datum/crafting_recipe/roguetown/sewing/leather/boots/masterwork
	name = "masterwork leather boots"
	result = /obj/item/clothing/shoes/roguetown/armor/leather/masterwork
	reqs = list(/obj/item/clothing/shoes/roguetown/armor/leather = 1,
				/obj/item/natural/cured/essence = 1,
				/obj/item/natural/fibers = 1)
	blacklist = (/obj/item/clothing/shoes/roguetown/armor/leather/advanced)
	craftdiff = 5

/datum/crafting_recipe/roguetown/sewing/leather/gloves/masterwork
	name = "masterwork leather gloves"
	result = /obj/item/clothing/gloves/roguetown/leather/masterwork
	reqs = list(/obj/item/clothing/gloves/roguetown/leather = 1,
				/obj/item/natural/cured/essence = 1,
				/obj/item/natural/fibers = 1)
	blacklist = (/obj/item/clothing/gloves/roguetown/leather/advanced)
	craftdiff = 5

/datum/crafting_recipe/roguetown/sewing/leather/bracers/masterwork
	name = "masterwork leather bracers"
	result = /obj/item/clothing/wrists/roguetown/bracers/leather/masterwork
	reqs = list(/obj/item/clothing/wrists/roguetown/bracers/leather = 1,
				/obj/item/natural/cured/essence = 1,
				/obj/item/natural/fibers = 1)
	blacklist = (/obj/item/clothing/wrists/roguetown/bracers/leather/advanced)
	craftdiff = 5

/datum/crafting_recipe/roguetown/sewing/leather/coat/masterwork
	name = "masterwork leather coat"
	result = /obj/item/clothing/suit/roguetown/armor/leather/masterwork
	reqs = list(/obj/item/clothing/suit/roguetown/armor/leather = 1,
				/obj/item/natural/cured/essence = 1,
				/obj/item/natural/fibers = 1)
	blacklist = (/obj/item/clothing/suit/roguetown/armor/leather/advanced)
	craftdiff = 5

/datum/crafting_recipe/roguetown/sewing/leather/helmet/masterwork
	name = "masterwork leather helmet"
	result = /obj/item/clothing/head/roguetown/helmet/leather/masterwork
	reqs = list(/obj/item/clothing/head/roguetown/helmet/leather = 1,
				/obj/item/natural/cured/essence = 1,
				/obj/item/natural/fibers = 1)
	blacklist = (/obj/item/clothing/head/roguetown/helmet/leather/advanced)
	craftdiff = 5

/datum/crafting_recipe/roguetown/sewing/leather/chausses/masterwork
	name = "masterwork leather chausses"
	result = /obj/item/clothing/under/roguetown/trou/leather/masterwork
	reqs = list(/obj/item/clothing/under/roguetown/trou/leather = 1,
				/obj/item/natural/cured/essence = 1,
				/obj/item/natural/fibers = 1)
	blacklist = (/obj/item/clothing/under/roguetown/trou/leather/advanced)
	craftdiff = 5

/// SILKS

/* craftdif of 1 = NOVICE */

/datum/crafting_recipe/roguetown/sewing/shepardmask
	name = "half-mask (cloth, silk; LOOM, NOVICE)"
	result = list(/obj/item/clothing/mask/rogue/shepherd)
	reqs = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/silk = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/sewing/rags
	name = "shirt (webbed) - (silk; LOOM, NOVICE)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/undershirt/webs)
	reqs = list(/obj/item/natural/silk = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/sewing/webbing
	name = "trousers (webbed) - (2 silks; LOOM, NOVICE)"
	result = list(/obj/item/clothing/under/roguetown/webs)
	reqs = list(/obj/item/natural/silk = 2)
	craftdiff = 1

/* craftdif of 2 = APPRENTICE */

/* craftdif of 3 = JOURNEYMAN */

/datum/crafting_recipe/roguetown/sewing/cloak
	name = "cloak (half, silk) - (cloth, silk; LOOM, JOURNEYMAN)"
	result = list(/obj/item/clothing/cloak/half)
	reqs = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/silk = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/nochood
	name = "hood (moon/Noc) - (2 cloths, silk; LOOM, JOURNEYMAN)"
	result = list(/obj/item/clothing/head/roguetown/roguehood/nochood)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/silk = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/necrahood
	name = "hood (Necra) - (2 cloths, silk; LOOM, JOURNEYMAN)"
	result = list(/obj/item/clothing/head/roguetown/necrahood)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/silk = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/astratahood
	name = "hood (solar/Astrata) - (2 cloths, silk; LOOM, JOURNEYMAN)"
	result = list(/obj/item/clothing/head/roguetown/roguehood/astrata)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/silk = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/shirt
	name = "shirt (formal silks) - (5 silks; LOOM, JOURNEYMAN)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/undershirt/puritan)
	reqs = list(/obj/item/natural/silk = 5)
	craftdiff = 3

/* craftdif of 4 = EXPERT */

/datum/crafting_recipe/roguetown/sewing/astratarobe
	name = "robes (Astrata) - (3 cloths, silk; LOOM, EXPERT)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/robe/astrata)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/silk = 1)
	craftdiff = 4

/datum/crafting_recipe/roguetown/sewing/dendorrobe
	name = "robes (Dendor) - (3 cloths, silk; LOOM, EXPERT)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/robe/dendor)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/silk = 1)
	craftdiff = 4

/datum/crafting_recipe/roguetown/sewing/necrarobe
	name = "robes (Necra) - (3 cloths, silk; LOOM, EXPERT)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/robe/necra)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/silk = 1)
	craftdiff = 4

/datum/crafting_recipe/roguetown/sewing/nocrobe
	name = "robes (Noc) - (3 cloths, silk; LOOM, EXPERT)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/robe/noc)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/silk = 1)
	craftdiff = 4

/* craftdif of 5 = MASTER */

/datum/crafting_recipe/roguetown/sewing/silkcoat
	name = "coat (silk) - (cloth, 2 furs, 3 silks; LOOM, MASTER)"
	result = list (/obj/item/clothing/suit/roguetown/armor/silkcoat)
	reqs = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/silk = 3,
				/obj/item/natural/fur = 2)
	craftdiff = 5
	sellprice = 60

/datum/crafting_recipe/roguetown/sewing/barkeep
	name = "dress (bar, silk) - (2 cloths, 2 silks; LOOM, MASTER)"
	result = list (/obj/item/clothing/suit/roguetown/shirt/dress)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/silk = 2)
	craftdiff = 5

/datum/crafting_recipe/roguetown/sewing/silkdress
	name = "dress (chemise, silk) - (2 fibers, 3 silks; LOOM, MASTER)"
	result = list (/obj/item/clothing/suit/roguetown/shirt/dress/silkdress/random)
	reqs = list(/obj/item/natural/fibers = 2,
				/obj/item/natural/silk = 3)
	craftdiff = 5
