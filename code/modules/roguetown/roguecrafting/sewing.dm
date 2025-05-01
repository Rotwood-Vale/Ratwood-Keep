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
	skill_level = 0

/datum/crafting_recipe/roguetown/sewing/headband
	name = "headband (cloth; NONE)"
	result = list(/obj/item/clothing/head/roguetown/headband)
	reqs = list(/obj/item/natural/cloth = 1)
	skill_level = 0

/datum/crafting_recipe/roguetown/sewing/loincloth
	name = "loincloth (cloth; NONE)"
	result = list(/obj/item/clothing/under/roguetown/loincloth)
	reqs = list(/obj/item/natural/cloth = 1)
	skill_level = 0

/datum/crafting_recipe/roguetown/sewing/rags
	name = "rags (2 cloths; NONE)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/rags)
	reqs = list(/obj/item/natural/cloth = 2)
	skill_level = 0

/datum/crafting_recipe/roguetown/sewing/ragmask
	name = "half-mask (rag) - (cloth; NONE)"
	result = list(/obj/item/clothing/mask/rogue/rag)
	reqs = list(/obj/item/natural/cloth = 1)
	skill_level = 0

/datum/crafting_recipe/roguetown/sewing/ragglove
	name = "hand wrappings - (cloth; NONE)"
	result = list(/obj/item/clothing/gloves/roguetown/wrap)
	reqs = list(/obj/item/natural/cloth = 1)
	skill_level = 0

/datum/crafting_recipe/roguetown/sewing/bag
	name = "sack (cloth, fiber; NONE)"
	result = /obj/item/storage/roguebag/crafted
	reqs = list(/obj/item/natural/fibers = 1,
				/obj/item/natural/cloth = 1)
	skill_level = 0

/datum/crafting_recipe/roguetown/sewing/leash
	name = "rope leash (rope) - (1 rope; NONE)"
	result = list(/obj/item/leash = 1)
	reqs = list(/obj/item/rope = 1)
	skill_level = 0

/* craftdif of 1 = NOVICE */

/datum/crafting_recipe/roguetown/sewing/knitcap
	name = "cap (knit) - (2 cloths, fiber; NOVICE)"
	result = list(/obj/item/clothing/head/roguetown/knitcap)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	skill_level = 1

/datum/crafting_recipe/roguetown/sewing/armingcap
	name = "arming cap - (2 cloths, fiber; NOVICE)"
	result = list(/obj/item/clothing/head/roguetown/armingcap)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	skill_level = 1

/datum/crafting_recipe/roguetown/sewing/Leyepatch
	name = "eye patch (left) - (cloth, fiber; NOVICE)"
	result = list(/obj/item/clothing/mask/rogue/eyepatch/left)
	reqs = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/fibers = 1)
	skill_level = 1

/datum/crafting_recipe/roguetown/sewing/Reyepatch
	name = "eye patch (right) - (cloth, fiber; NOVICE)"
	result = list(/obj/item/clothing/mask/rogue/eyepatch)
	reqs = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/fibers = 1)
	skill_level = 1

/datum/crafting_recipe/roguetown/sewing/clothgloves
	name = "gloves (fingerless) - (cloth, fiber; NOVICE)"
	result = list(/obj/item/clothing/gloves/roguetown/fingerless)
	reqs = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/fibers = 1)
	skill_level = 1

/datum/crafting_recipe/roguetown/sewing/strawhat
	name = "hat (straw) - (5 fibers; NOVICE)"
	result = list(/obj/item/clothing/head/roguetown/strawhat)
	reqs = list(/obj/item/natural/fibers = 3)
	skill_level = 1

/datum/crafting_recipe/roguetown/sewing/basichood
	name = "hood (2 cloths, fiber; NOVICE)"
	result = list(/obj/item/clothing/head/roguetown/roguehood)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	skill_level = 1

/datum/crafting_recipe/roguetown/sewing/sack
	name = "hood (sack) - (2 cloths; NOVICE)"
	result = list(/obj/item/clothing/head/roguetown/menacing)
	reqs = list(/obj/item/natural/cloth = 2,)
	skill_level = 1

/datum/crafting_recipe/roguetown/sewing/clothtrou
	name = "trousers (2 cloths, fiber; NOVICE)"
	result = list(/obj/item/clothing/under/roguetown/trou)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	skill_level = 1

/datum/crafting_recipe/roguetown/sewing/tights
	name = "tights (2 cloths, fiber; NOVICE)"
	result = list(/obj/item/clothing/under/roguetown/tights)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	skill_level = 1

/datum/crafting_recipe/roguetown/sewing/workervest
	name = "tunic (striped) - (2 cloths, 2 fibers; NOVICE)"
	result = list(/obj/item/clothing/suit/roguetown/armor/workervest)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 2)
	skill_level = 1

/datum/crafting_recipe/roguetown/sewing/clothshirt
	name = "shirt (cloth) - (2 cloths, fiber; NOVICE)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/undershirt)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	skill_level = 1

/datum/crafting_recipe/roguetown/sewing/lowcut
	name = "lowcut shirt - (2 cloths, fiber; NOVICE)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/undershirt/lowcut)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers= 1)
	skill_level = 1

/datum/crafting_recipe/roguetown/sewing/tunic
	name = "tunic (cloth) - (2 cloths, fiber; NOVICE)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/tunic)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	skill_level = 1

/datum/crafting_recipe/roguetown/sewing/tunic
	name = "tunic (cloth) - (2 cloths, fiber; NOVICE)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/tunic)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	skill_level = 1

/datum/crafting_recipe/roguetown/sewing/burial_shroud
	name = "winding sheet (2 cloths; NOVICE)"
	result = list(/obj/item/burial_shroud)
	reqs = list(/obj/item/natural/cloth = 2)
	skill_level = 1

/* craftdif of 2 = APPRENTICE */

/datum/crafting_recipe/roguetown/sewing/nocwrappings
	name = "wrappings (Lunar/Noc) - (2 cloths; APPRENTICE)"
	result = list(/obj/item/clothing/wrists/roguetown/nocwrappings)
	reqs = list(/obj/item/natural/cloth = 2)
	skill_level = 2

/datum/crafting_recipe/roguetown/sewing/wrappings
	name = "wrappings (solar/Astrata) (2 cloths; APPRENTICE)"
	result = list(/obj/item/clothing/wrists/roguetown/wrappings)
	reqs = list(/obj/item/natural/cloth = 2)
	skill_level = 2

/datum/crafting_recipe/roguetown/sewing/sleepingbag
	name = "sleep-cloth/sleeping-bag (2 cloths, fiber; APPRENTICE)"
	result = list(/obj/item/sleepingbag)
	reqs =  list(/obj/item/natural/cloth = 2,
                /obj/item/natural/fibers = 1)
	skill_level = 2

/datum/crafting_recipe/roguetown/sewing/fauld
	name = "fauld - (2 cloths, fiber; APPRENTICE)"
	result = list(/obj/item/clothing/cloak/fauld)
	reqs =  list(/obj/item/natural/cloth = 2,
                /obj/item/natural/fibers = 1)
	skill_level = 2

/datum/crafting_recipe/roguetown/sewing/desertgown
	name = "desert gown (cloth, 2 silks; APPRENTICE)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/robe/hierophant)
	reqs = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/silk = 2)

/datum/crafting_recipe/roguetown/sewing/skirt
	name = "battle skirt - (2 cloths, fiber; APPRENTICE)"
	result = list(/obj/item/clothing/cloak/fauld/battleskirt)
	reqs =  list(/obj/item/natural/cloth = 2,
                /obj/item/natural/fibers = 1)
	skill_level = 2

/datum/crafting_recipe/roguetown/sewing/cskirt
	name = "skirt- (3 cloths; APPRENTICE)"
	result = list(/obj/item/clothing/under/roguetown/skirt)
	reqs = list(/obj/item/natural/cloth = 3)
	skill_level = 2

/datum/crafting_recipe/roguetown/sewing/lgambeson
    name = "light gambeson (3 cloths, fiber; APPRENTICE)"
    result = list(/obj/item/clothing/suit/roguetown/armor/gambeson/light)
    reqs = list(/obj/item/natural/cloth = 3,
                /obj/item/natural/fibers = 1)
    skill_level = 2

/datum/crafting_recipe/roguetown/sewing/desertrobe
	name = "desert robe (2 cloths, silk; APPRENTICE)"
	result = list(/obj/item/clothing/suit/roguetown/armor/gambeson/hierophant)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/silk = 1)
	skill_level = 2

/datum/crafting_recipe/roguetown/sewing/apron
	name = "apron (2 cloths, fibers; APPRENTICE)"
	result = list(/obj/item/clothing/cloak/apron)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	skill_level = 2

/datum/crafting_recipe/roguetown/sewing/waistapron
	name = "waist apron (cloth, fibers; APPRENTICE)"
	result = list(/obj/item/clothing/cloak/apron/waist)
	reqs = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/fibers = 1)
	skill_level = 2

/* craftdif of 3 = JOURNEYMAN */

/datum/crafting_recipe/roguetown/sewing/armingjacket
	name = "arming jacket (4 cloths, fiber; JOURNEYMAN)"
	result = /obj/item/clothing/suit/roguetown/armor/gambeson/lord
	reqs = list(/obj/item/natural/cloth = 4,
				/obj/item/natural/fibers = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/sewing/silksash
	name = "Silk sash (2 cloths, 3 silk; JOURNEYMAN)"
	result = /obj/item/clothing/cloak/hierophant
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/silk = 3)
	skill_level = 3

/datum/crafting_recipe/roguetown/sewing/longcoat
	name = "longcoat (3 cloths, 2 fiber; JOURNEYMAN)"
	result = /obj/item/clothing/suit/roguetown/armor/longcoat
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 2)
	skill_level = 3

/datum/crafting_recipe/roguetown/sewing/bedsheet
	name = "bedsheet (2 cloths; fiber; JOURNEYMAN)"
	result = list(/obj/item/bedsheet/rogue/cloth)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/sewing/bedsheetpelt
	name = "bedsheet (leather) - (2 leather, fiber; JOURNEYMAN)"
	result = list(/obj/item/bedsheet/rogue/pelt)
	reqs = list(/obj/item/natural/hide/cured = 2,
            	/obj/item/natural/fibers = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/sewing/paddedcap
	name = "cap (padded) - (5 fibers; JOURNEYMAN)"
	result = /obj/item/clothing/head/roguetown/paddedcap
	reqs = list(/obj/item/natural/fibers = 5)
	skill_level = 3

/datum/crafting_recipe/roguetown/sewing/cape
	name = "cape (2 cloths, fiber; JOURNEYMAN)"
	result = list(/obj/item/clothing/cloak/cape)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/sewing/coif
	name = "coif (2 cloths, fiber; JOURNEYMAN)"
	result = list(/obj/item/clothing/neck/roguetown/coif)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/sewing/strapless_dress
	name = "dress (strapless) - (2 cloths, fiber; JOURNEYMAN)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/dress/gen/strapless)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/sewing/wizardhatblue
	name = "wizard hat (blue) - (2 cloths, fiber; JOURNEYMAN)"
	result = list(/obj/item/clothing/head/roguetown/wizhat)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/sewing/wizardhatred
	name = "wizard hat (red) - (2 cloths, fiber; JOURNEYMAN)"
	result = list(/obj/item/clothing/head/roguetown/wizhat/red)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/sewing/wizardhatyellow
	name = "wizard hat (yellow) - (2 cloths, fiber; JOURNEYMAN)"
	result = list(/obj/item/clothing/head/roguetown/wizhat/yellow)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/sewing/wizardhatgreen
	name = "wizard hat (green) - (2 cloths, fiber; JOURNEYMAN)"
	result = list(/obj/item/clothing/head/roguetown/wizhat/green)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/sewing/wizardhatblack
	name = "wizard hat (black) - (2 cloths, fiber; JOURNEYMAN)"
	result = list(/obj/item/clothing/head/roguetown/wizhat/black)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/sewing/gambeson
	name = "gambeson (4 cloths, fiber; JOURNEYMAN)"
	result = /obj/item/clothing/suit/roguetown/armor/gambeson
	reqs = list(/obj/item/natural/cloth = 4,
				/obj/item/natural/fibers = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/sewing/robe
	name = "robes (3 cloths, fiber; JOURNEYMAN)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/robe)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/sewing/wizrobeblue
	name = "robe (wizard) - (3 silk, fiber; JOURNEYMAN)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/robe/wizard)
	reqs = list(/obj/item/natural/silk = 3,
				/obj/item/natural/fibers = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/sewing/mageadept
	name = "adept robe (mage) - (3 cloths, fiber; JOURNEYMAN)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/robe/newmage/adept)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/sewing/warlock
	name = "warlock robe (mage) - (3 cloths, fiber; JOURNEYMAN)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/robe/newmage/warlock)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/sewing/magesorcerer
	name = "sorcerer robe (mage) - (3 cloths, fiber; JOURNEYMAN)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/robe/newmage/sorcerer)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/sewing/stockings_white
	name = "stockings (cloth, fiber; JOURNEYMAN)"
	result = list(/obj/item/clothing/under/roguetown/tights/stockings/white)
	reqs = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/fibers = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/sewing/stockings_white_fishnet
	name = "stockings (fishnet) - (2 fibers; JOURNEYMAN)"
	result = list(/obj/item/clothing/under/roguetown/tights/stockings/fishnet/white)
	reqs = list(/obj/item/natural/fibers = 2)
	skill_level = 3

/datum/crafting_recipe/roguetown/sewing/stabard
	name = "surcoat (2 cloths, fiber; JOURNEYMAN)"
	result = list(/obj/item/clothing/cloak/stabard)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/sewing/stabard/guard
	name = "surcoat (guard) - (2 cloths, fiber; JOURNEYMAN)"
	result = list(/obj/item/clothing/cloak/stabard/guard)

/datum/crafting_recipe/roguetown/sewing/tabard
	name = "tabard (2 cloths, fiber; JOURNEYMAN)"
	result = list(/obj/item/clothing/cloak/tabard)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/sewing/tabard/crusader
	name = "tabard (crusader) - (2 cloths, fiber; JOURNEYMAN)"
	result = list(/obj/item/clothing/cloak/tabard/crusader)

/datum/crafting_recipe/roguetown/sewing/templar/astratan
	name = "astrata tabard (templar) - (3 cloths, fiber; JOURNEYMAN)"
	result = list(/obj/item/clothing/cloak/templar/astratan)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/sewing/crusader/noc
	name = "noc tabard (templar) - (3 cloths, fiber; JOURNEYMAN)"
	result = list(/obj/item/clothing/cloak/tabard/crusader/noc)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/sewing/crusader/dendor
	name = "dendor tabard (templar) - (3 cloths, fiber; JOURNEYMAN)"
	result = list(/obj/item/clothing/cloak/tabard/crusader/dendor)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/sewing/crusader/necra
	name = "necra tabard (templar) - (3 cloths, fiber; JOURNEYMAN)"
	result = list(/obj/item/clothing/cloak/templar/necran)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/sewing/templar/malummite
	name = "malum tabard (templar) - (3 cloths, fiber; JOURNEYMAN)"
	result = list(/obj/item/clothing/cloak/templar/malummite)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/sewing/crusader/eora
	name = "eora tabard (templar) - (3 cloths, fiber; JOURNEYMAN)"
	result = list(/obj/item/clothing/cloak/tabard/crusader/eora)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/sewing/crusader/pestra
	name = "pestra tabard (templar) - (3 cloths, fiber; JOURNEYMAN)"
	result = list(/obj/item/clothing/cloak/tabard/crusader/pestra)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/sewing/crusader/ravox
	name = "ravox tabard (templar) - (3 cloths, fiber; JOURNEYMAN)"
	result = list(/obj/item/clothing/cloak/tabard/crusader/ravox)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/sewing/bardhat
	name = "hat (bard) - (2 leather, fiber, feather; JOURNEYMAN)"
	result = list(/obj/item/clothing/head/roguetown/bardhat)
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fibers = 1,
				/obj/item/natural/feather = 1)
	skill_level = 3

/* craftdif of 4 EXPERT */

/datum/crafting_recipe/roguetown/sewing/stockdress
	name = "dress (3 cloths, fiber; EXPERT)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/dress/gen)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	skill_level = 4

/datum/crafting_recipe/roguetown/sewing/fancyhat
	name = "hat (fancy) - (2 cloths, fiber, feather; EXPERT)"
	result = list(/obj/item/clothing/head/roguetown/fancyhat)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1,
				/obj/item/natural/feather = 1)
	skill_level = 4

/datum/crafting_recipe/roguetown/sewing/chaperon
	name = "hat (chaperon) - (2 cloths, fiber; EXPERT)"
	result = list(/obj/item/clothing/head/roguetown/chaperon)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	skill_level = 4

/datum/crafting_recipe/roguetown/sewing/rhood
	name = "hat (reinforced hood) - (2 fur, hood; EXPERT)"
	result = list(/obj/item/clothing/head/roguetown/roguehood/reinforced)
	reqs = list(/obj/item/clothing/head/roguetown/roguehood = 2,
				/obj/item/natural/fibers = 1,
				/obj/item/natural/fur = 2)
	skill_level = 4

/datum/crafting_recipe/roguetown/sewing/jupon
	name = "jupon (2 cloths, fiber; EXPERT)"
	result = list(/obj/item/clothing/cloak/stabard/surcoat)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	skill_level = 4

/datum/crafting_recipe/roguetown/sewing/hgambeson
    name = "padded gambeson (6 cloths, 4 fibers; EXPERT)"
    result = list(/obj/item/clothing/suit/roguetown/armor/gambeson/heavy)
    reqs = list(/obj/item/natural/cloth = 6,
                /obj/item/natural/fibers = 4)
    skill_level = 4

/datum/crafting_recipe/roguetown/sewing/fancygamb
	name = "fencer gambeson (6 cloths, 2 fibers, 2 silk; EXPERT)"
	result = list(/obj/item/clothing/suit/roguetown/armor/gambeson/otavan)
	reqs = list(/obj/item/natural/cloth = 6,
				/obj/item/natural/fibers = 2,
				/obj/item/natural/silk = 2)
	skill_level = 4
/datum/crafting_recipe/roguetown/sewing/armordress
	name = "dress (padded) - (6 cloths, 4 fibers; EXPERT)"
	result = /obj/item/clothing/suit/roguetown/armor/armordress
	reqs = list(/obj/item/natural/cloth = 6,
				/obj/item/natural/fibers = 4)
	skill_level = 3

/* craftdif of 5 = MASTER */

/datum/crafting_recipe/roguetown/sewing/lordcloak
	name = "lordly cloak (2 furs, 4 leather; MASTER)"
	result = list(/obj/item/clothing/cloak/lordcloak)
	reqs = list(/obj/item/natural/fur = 2,
				/obj/item/natural/hide/cured = 4)
	skill_level = 5
	sellprice = 85

/datum/crafting_recipe/roguetown/sewing/stockings_white_silk
	name = "stockings (silk) - (fiber, silk; MASTER)"
	result = list(/obj/item/clothing/under/roguetown/tights/stockings/silk/white)
	reqs = list(/obj/item/natural/silk = 1,
				/obj/item/natural/fibers = 1)
	skill_level = 5

/datum/crafting_recipe/roguetown/sewing/nobledress
	name = "dress (noble) (4 cloths, 2 silk, 3 fibers; MASTER)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/dress/nobledress)
	reqs = list(/obj/item/natural/cloth = 4,
				/obj/item/natural/fibers = 3,
				/obj/item/natural/silk = 2)
	skill_level = 5

/* craftdif of 6 = LEGENDARY */

/datum/crafting_recipe/roguetown/sewing/sexydress
	name = "sexy dress of legendary sewists (6 cloths, 3 fibers; LEGENDARY)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/dress/gen/sexy)
	reqs = list(/obj/item/natural/cloth = 6,
				/obj/item/natural/fibers = 3)
	skill_level = 6

/// LEATHER ///

/datum/crafting_recipe/roguetown/sewing/belt
	name = "leather belt (leather; APPRENTICE)"
	result = /obj/item/storage/belt/rogue/leather
	reqs = list(/obj/item/natural/hide/cured = 1)
	skill_level = 2

/datum/crafting_recipe/roguetown/sewing/leathertights
	name = "leather tights (2 leather; APPRENTICE)"
	result = /obj/item/clothing/under/roguetown/trou/leathertights
	reqs = list(/obj/item/natural/hide/cured = 2)
	skill_level = 2

/datum/crafting_recipe/roguetown/sewing/collarleather
	name = "leather collar (1 leather; NONE)"
	result = /obj/item/clothing/neck/roguetown/collar/leather
	reqs = list(/obj/item/natural/hide/cured = 1)
	skill_level = 0

/datum/crafting_recipe/roguetown/sewing/leashleather
	name = "leather leash (1 leather; NONE)"
	result = /obj/item/leash/leather
	reqs = list(/obj/item/natural/hide/cured = 1)
	skill_level = 0

/datum/crafting_recipe/roguetown/sewing/bandana
	name = "leather bandana (leather; APPRENTICE)"
	result = /obj/item/clothing/head/roguetown/helmet/bandana
	reqs = list(/obj/item/natural/hide/cured = 1)
	skill_level = 2

/datum/crafting_recipe/roguetown/sewing/hood
	name = "leather hood (leather; APPRENTICE)"
	result = /obj/item/clothing/head/roguetown/roguehood
	reqs = list(/obj/item/natural/hide/cured = 1)
	skill_level = 2

/datum/crafting_recipe/roguetown/sewing/tricorn
	name = "leather tricorn (leather; APPRENTICE)"
	result = /obj/item/clothing/head/roguetown/helmet/tricorn
	reqs = list(/obj/item/natural/hide/cured = 1)
	skill_level = 2

/datum/crafting_recipe/roguetown/sewing/cloak
	name = "leather cloak (2 leather; APPRENTICE)"
	result = /obj/item/clothing/cloak/raincloak
	reqs = list(/obj/item/natural/hide/cured = 2)
	skill_level = 2

/datum/crafting_recipe/roguetown/sewing/vest
	name = "leather vest (2 leather; JOURNEYMAN)"
	result = /obj/item/clothing/suit/roguetown/armor/leather/vest
	reqs = list(/obj/item/natural/hide/cured = 2)
	skill_level = 3

/datum/crafting_recipe/roguetown/sewing/leathershorts
	name = "leather shorts (2 leather; JOURNEYMAN)"
	result = /obj/item/clothing/under/roguetown/heavy_leather_pants/shorts
	reqs = list(/obj/item/natural/hide/cured = 2)
	skill_level = 3

/datum/crafting_recipe/roguetown/sewing/corset 
	name = "leather corset (2 leather, fiber; JOURNEYMAN)"
	result = /obj/item/clothing/suit/roguetown/armor/corset
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fibers = 1)
	skill_level = 3
	
/datum/crafting_recipe/roguetown/sewing/vest/sailor
	name = "leather sea jacket (2 leather; JOURNEYMAN)"
	result = /obj/item/clothing/suit/roguetown/armor/leather/vest/sailor
	reqs = list(/obj/item/natural/hide/cured = 2)
	skill_level = 3

/datum/crafting_recipe/roguetown/sewing/apron/blacksmith
	name = "leather apron (2 leather, fiber; APPRENTICE)"
	result = /obj/item/clothing/cloak/apron/blacksmith
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fibers = 1)
	skill_level = 2

/datum/crafting_recipe/roguetown/sewing/hidearmor
	name = "hide armor (2 leather, fur; JOURNEYMAN)"
	result = /obj/item/clothing/suit/roguetown/armor/leather/hide
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fur = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/sewing/heavygloves
	name = "hide gloves (fur; JOURNEYMAN)"
	result = /obj/item/clothing/gloves/roguetown/leather/angle
	reqs = list(/obj/item/natural/fur = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/sewing/cloakfur
	name = "fur cloak (2 leather, fur; JOURNEYMAN)"
	result = /obj/item/clothing/cloak/raincloak/furcloak/crafted
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fur = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/sewing/shoes
	name = "simple shoes"
	result = list(/obj/item/clothing/shoes/roguetown/simpleshoes)
	reqs = list(/obj/item/natural/hide/cured = 1)
	skill_level = 1

/datum/crafting_recipe/roguetown/sewing/pouch
	name = "leather pouch (leather; APPRENTICE)"
	result = list(/obj/item/storage/belt/rogue/pouch)
	reqs = list(/obj/item/natural/hide/cured = 1)
	skill_level = 2

/datum/crafting_recipe/roguetown/sewing/satchel
	name = "leather satchel (2 leather, fiber; JOURNEYMAN)"
	result = list(/obj/item/storage/backpack/rogue/satchel)
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fibers = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/sewing/backpack
	name = "leather backpack (3 leather, fiber; EXPERT)"
	result = /obj/item/storage/backpack/rogue/backpack
	reqs = list(/obj/item/natural/hide/cured = 3,
				/obj/item/natural/fibers = 1)
	skill_level = 4

/datum/crafting_recipe/roguetown/sewing/leathercoat
	name = "leather coat (3 leather, fur, fiber; JOURNEYMAN)"
	result = /obj/item/clothing/suit/roguetown/armor/leathercoat
	reqs = list(/obj/item/natural/hide/cured = 3,
				/obj/item/natural/fur = 1,
				/obj/item/natural/fibers = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/sewing/leathercoat/heavy
	name = "heavy leather coat (2 furs, 2 leather, fiber; EXPERT)"
	result = /obj/item/clothing/suit/roguetown/armor/leathercoat/heavy
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fur = 2,
				/obj/item/natural/fibers = 1)
	skill_level = 4

/datum/crafting_recipe/roguetown/sewing/shoes
	name = "simple shoes (leather; NOVICE)"
	result = list(/obj/item/clothing/shoes/roguetown/simpleshoes)
	reqs = list(/obj/item/natural/hide/cured = 1)
	skill_level = 1

/datum/crafting_recipe/roguetown/sewing/shortboots
	name = "shortboots (leather, cloth; NOVICE)"
	result = /obj/item/clothing/shoes/roguetown/shortboots
	reqs = list(/obj/item/natural/hide/cured = 1,
				/obj/item/natural/cloth = 1)
	skill_level = 1

/datum/crafting_recipe/roguetown/sewing/sandals
	name = "sandals (leather, fiber; NOVICE)"
	result = /obj/item/clothing/shoes/roguetown/sandals
	reqs = list(/obj/item/natural/hide/cured = 1,
				/obj/item/natural/fibers = 1)
	skill_level = 1

/datum/crafting_recipe/roguetown/sewing/gladiator
	name = "caligae (leather, fiber; APPRENTICE)"
	result = /obj/item/clothing/shoes/roguetown/gladiator
	reqs = list(/obj/item/natural/hide/cured = 1,
				/obj/item/natural/fibers = 1)
	skill_level = 2

/datum/crafting_recipe/roguetown/sewing/ridingboots
	name = "riding boots (leather, cloth, 2 fiber; APPRENTICE)"
	result = /obj/item/clothing/shoes/roguetown/ridingboots
	reqs = list(/obj/item/natural/hide/cured = 1,
				/obj/item/natural/fibers = 2,
				/obj/item/natural/cloth = 1)
	skill_level = 2

/datum/crafting_recipe/roguetown/sewing/blackboots
	name = "black boots (2 leather, cloth, 2 fiber; JOURNEYMAN)"
	result = /obj/item/clothing/shoes/roguetown/armor
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fibers = 2,
				/obj/item/natural/cloth = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/sewing/furlinedboots
	name = "fur lined boots (2 leather, fur, 2 fiber; JOURNEYMAN)"
	result = /obj/item/clothing/shoes/roguetown/boots/furlinedboots
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fur = 1,
				/obj/item/natural/fibers = 2)
	skill_level = 3

/datum/crafting_recipe/roguetown/sewing/furlinedanklets
	name = "fur lined anklets (1 leather, fur, 2 fiber; JOURNEYMAN)"
	result = /obj/item/clothing/shoes/roguetown/boots/furlinedanklets
	reqs = list(/obj/item/natural/hide/cured = 1,
				/obj/item/natural/fur = 1,
				/obj/item/natural/fibers = 2)
	skill_level = 3

/datum/crafting_recipe/roguetown/sewing/fencerpants
	name = "fencer leather pants (4 leather, 3 fibers; EXPERT)"
	result = /obj/item/clothing/under/roguetown/trou/otavan
	reqs = list(/obj/item/natural/hide/cured = 4,
				/obj/item/natural/fibers = 3)
	skill_level = 4

/datum/crafting_recipe/roguetown/sewing/fencergloves
	name = "fencer leather gloves (3 leather, 3 fur; EXPERT)"
	result = /obj/item/clothing/gloves/roguetown/otavan
	reqs = list(/obj/item/natural/hide/cured = 3,
				/obj/item/natural/fur = 3)
	skill_level = 4

/datum/crafting_recipe/roguetown/sewing/nobleboot
	name = "noble boots (2 leather, 2 cloth, 2 fiber; MASTER)"
	result = /obj/item/clothing/shoes/roguetown/armor/nobleboot
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fibers = 2,
				/obj/item/natural/cloth = 2)
	skill_level = 5

/// ADVANCED LEATHER

/datum/crafting_recipe/roguetown/sewing/leather/boots
	name = "hardened leather boots (leather, fiber; MASTER)"
	result = /obj/item/clothing/shoes/roguetown/armor/leather/advanced
	reqs = list(/obj/item/natural/hide/cured = 1,
				/obj/item/natural/fibers = 1)
	skill_level = 4

/datum/crafting_recipe/roguetown/sewing/leather/gloves
	name = "hardened leather gloves (leather, fiber; MASTER)"
	result = /obj/item/clothing/gloves/roguetown/leather/advanced
	reqs = list(/obj/item/natural/hide/cured = 1,
				/obj/item/natural/fibers = 1)
	skill_level = 4

/datum/crafting_recipe/roguetown/sewing/leather/braces
	name = "hardened leather braces (leather, fiber; MASTER)"
	result = /obj/item/clothing/wrists/roguetown/bracers/leather/advanced
	reqs = list(/obj/item/natural/hide/cured = 1,
				/obj/item/natural/fibers = 1)
	skill_level = 4

/datum/crafting_recipe/roguetown/sewing/leather/coat
	name = "hardened leather coat (2 leather, fiber; MASTER)"
	result = /obj/item/clothing/suit/roguetown/armor/leather/advanced
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fibers = 1)
	skill_level = 4

/datum/crafting_recipe/roguetown/sewing/leather/helmet
	name = "hardened leather helmet (leather, fiber; MASTER)"
	result = /obj/item/clothing/head/roguetown/helmet/leather/advanced
	reqs = list(/obj/item/natural/hide/cured = 1,
				/obj/item/natural/fibers = 1)
	skill_level = 4

/datum/crafting_recipe/roguetown/sewing/leather/neck
	name = "hardened leather gorget (leather, fiber; MASTER)"
	result = /obj/item/clothing/neck/roguetown/leather
	reqs = list(/obj/item/natural/hide/cured = 1,
				/obj/item/natural/fibers = 1)
	skill_level = 4

/datum/crafting_recipe/roguetown/sewing/leather/chausses
	name = "hardened leather chausses (2 leather, fiber; MASTER)"
	result = /obj/item/clothing/under/roguetown/trou/leather/advanced
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fibers = 1)
	skill_level = 4

/// MASTERWORK

/datum/crafting_recipe/roguetown/sewing/leather/boots/masterwork
	name = "masterwork leather boots"
	result = /obj/item/clothing/shoes/roguetown/armor/leather/masterwork
	reqs = list(/obj/item/clothing/shoes/roguetown/armor/leather = 1,
				/obj/item/natural/cured/essence = 1,
				/obj/item/natural/fibers = 1)
	skill_level = 5

/datum/crafting_recipe/roguetown/sewing/leather/gloves/masterwork
	name = "masterwork leather gloves"
	result = /obj/item/clothing/gloves/roguetown/leather/masterwork
	reqs = list(/obj/item/clothing/gloves/roguetown/leather = 1,
				/obj/item/natural/cured/essence = 1,
				/obj/item/natural/fibers = 1)
	skill_level = 5

/datum/crafting_recipe/roguetown/sewing/leather/bracers/masterwork
	name = "masterwork leather bracers"
	result = /obj/item/clothing/wrists/roguetown/bracers/leather/masterwork
	reqs = list(/obj/item/clothing/wrists/roguetown/bracers/leather = 1,
				/obj/item/natural/cured/essence = 1,
				/obj/item/natural/fibers = 1)
	skill_level = 5

/datum/crafting_recipe/roguetown/sewing/leather/coat/masterwork
	name = "masterwork leather coat"
	result = /obj/item/clothing/suit/roguetown/armor/leather/masterwork
	reqs = list(/obj/item/clothing/suit/roguetown/armor/leather = 1,
				/obj/item/natural/cured/essence = 1,
				/obj/item/natural/fibers = 1)
	skill_level = 5

/datum/crafting_recipe/roguetown/sewing/leather/helmet/masterwork
	name = "masterwork leather helmet"
	result = /obj/item/clothing/head/roguetown/helmet/leather/masterwork
	reqs = list(/obj/item/clothing/head/roguetown/helmet/leather = 1,
				/obj/item/natural/cured/essence = 1,
				/obj/item/natural/fibers = 1)
	skill_level = 5

/datum/crafting_recipe/roguetown/sewing/leather/chausses/masterwork
	name = "masterwork leather chausses"
	result = /obj/item/clothing/under/roguetown/trou/leather/masterwork
	reqs = list(/obj/item/clothing/under/roguetown/trou/leather = 1,
				/obj/item/natural/cured/essence = 1,
				/obj/item/natural/fibers = 1)
	skill_level = 5

/// SILKS

/* craftdif of 1 = NOVICE */

/datum/crafting_recipe/roguetown/sewing/shepardmask
	name = "half-mask (cloth, silk; LOOM, NOVICE)"
	result = list(/obj/item/clothing/mask/rogue/shepherd)
	reqs = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/silk = 1)
	skill_level = 1

/datum/crafting_recipe/roguetown/sewing/rags
	name = "shirt (webbed) - (silk; LOOM, NOVICE)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/undershirt/webs)
	reqs = list(/obj/item/natural/silk = 1)
	skill_level = 1

/datum/crafting_recipe/roguetown/sewing/webbing
	name = "trousers (webbed) - (2 silks; LOOM, NOVICE)"
	result = list(/obj/item/clothing/under/roguetown/webs)
	reqs = list(/obj/item/natural/silk = 2)
	skill_level = 1

/datum/crafting_recipe/roguetown/sewing/shadowgloves
	name = "gloves (silk) - (cloth, silk; LOOM, NOVICE)"
	result = list(/obj/item/clothing/gloves/roguetown/shadow)
	reqs = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/silk = 1)
	skill_level = 1

/* craftdif of 2 = APPRENTICE */

/* craftdif of 3 = JOURNEYMAN */

/datum/crafting_recipe/roguetown/sewing/cloak
	name = "cloak (half, silk) - (cloth, silk; LOOM, JOURNEYMAN)"
	result = list(/obj/item/clothing/cloak/half)
	reqs = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/silk = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/sewing/shadowcloak
	name = "vanguard cloak - (cloth, 3 silk; LOOM, JOURNEYMAN)"
	result = list(/obj/item/clothing/cloak/shadow)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/silk = 3)
	skill_level = 4

/datum/crafting_recipe/roguetown/sewing/shadowrobe
	name = "vanguard uniform - (2 cloths, 3 silk; LOOM, JOURNEYMAN)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/shadow)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/silk = 3)
	skill_level = 4

/datum/crafting_recipe/roguetown/sewing/nochood
	name = "hood (moon/Noc) - (2 cloths, silk; LOOM, JOURNEYMAN)"
	result = list(/obj/item/clothing/head/roguetown/roguehood/nochood)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/silk = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/sewing/necrahood
	name = "hood (Necra) - (2 cloths, silk; LOOM, JOURNEYMAN)"
	result = list(/obj/item/clothing/head/roguetown/necrahood)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/silk = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/sewing/astratahood
	name = "hood (solar/Astrata) - (2 cloths, silk; LOOM, JOURNEYMAN)"
	result = list(/obj/item/clothing/head/roguetown/roguehood/astrata)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/silk = 1)
	skill_level = 3

/datum/crafting_recipe/roguetown/sewing/shirt
	name = "shirt (formal silks) - (5 silks; LOOM, JOURNEYMAN)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/grenzelhoft)
	reqs = list(/obj/item/natural/silk = 5)
	skill_level = 3

/* craftdif of 4 = EXPERT */

/datum/crafting_recipe/roguetown/sewing/shadowpant
	name = "pants (silk) - (cloth, 3 silk; LOOM, EXPERT)"
	result = list(/obj/item/clothing/under/roguetown/shadow)
	reqs = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/silk = 3)
	skill_level = 4

/datum/crafting_recipe/roguetown/sewing/astratarobe
	name = "robes (Astrata) - (3 cloths, silk; LOOM, EXPERT)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/robe/astrata)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/silk = 1)
	skill_level = 4

/datum/crafting_recipe/roguetown/sewing/dendorrobe
	name = "robes (Dendor) - (3 cloths, silk; LOOM, EXPERT)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/robe/dendor)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/silk = 1)
	skill_level = 4

/datum/crafting_recipe/roguetown/sewing/necrarobe
	name = "robes (Necra) - (3 cloths, silk; LOOM, EXPERT)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/robe/necra)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/silk = 1)
	skill_level = 4

/datum/crafting_recipe/roguetown/sewing/nocrobe
	name = "robes (Noc) - (3 cloths, silk; LOOM, EXPERT)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/robe/noc)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/silk = 1)
	skill_level = 4

/datum/crafting_recipe/roguetown/sewing/nobletunic
	name = "fancy coat - (4 silks, fiber; LOOM, EXPERT)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/tunic/noblecoat)
	reqs = list(/obj/item/natural/silk = 4,
				/obj/item/natural/fibers = 1)
	skill_level = 4

/* craftdif of 5 = MASTER */

/datum/crafting_recipe/roguetown/sewing/silkcoat
	name = "coat (silk) - (cloth, 2 furs, 3 silks; LOOM, MASTER)"
	result = list (/obj/item/clothing/suit/roguetown/armor/silkcoat)
	reqs = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/silk = 3,
				/obj/item/natural/fur = 2)
	skill_level = 5
	sellprice = 60

/datum/crafting_recipe/roguetown/sewing/barkeep
	name = "dress (bar, silk) - (2 cloths, 2 silks; LOOM, MASTER)"
	result = list (/obj/item/clothing/suit/roguetown/shirt/dress)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/silk = 2)
	skill_level = 5

/datum/crafting_recipe/roguetown/sewing/silkdress
	name = "dress (chemise, silk) - (2 fibers, 3 silks; LOOM, MASTER)"
	result = list (/obj/item/clothing/suit/roguetown/shirt/dress/silkdress/random)
	reqs = list(/obj/item/natural/fibers = 2,
				/obj/item/natural/silk = 3)
	skill_level = 5

/datum/crafting_recipe/roguetown/sewing/nmjacket
	name = "newmoon coat - (2 leather, 2 cloth, 2 silk, amulet of noc, LOOM, EXPERT)"
	result = list (/obj/item/clothing/suit/roguetown/armor/leather/newmoon_jacket)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/silk = 2,
				/obj/item/natural/hide/cured = 2,
				/obj/item/clothing/neck/roguetown/psicross/noc = 1)
	skill_level = 4

/datum/crafting_recipe/roguetown/sewing/eoramask
	name = "eora mask - (3 silk, silver ingot; EXPERT)"
	result = list(/obj/item/clothing/head/roguetown/eoramask)
	reqs = list(/obj/item/ingot/silver = 1,
				/obj/item/natural/silk = 3)
	skill_level = 3
	sellprice = 75

/datum/crafting_recipe/roguetown/sewing/eorarobes
	name = "eora robes - (3 cloth, silk; EXPERT)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/robe/eora)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/silk = 1)
	skill_level = 3


/* craftdif of 6 = LEGENDARY */

/datum/crafting_recipe/roguetown/sewing/velvetdress
	name = "dress (velvet) (2 cloths, 4 silk, 3 fibers; LOOM, LEGENDARY)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/dress/velvetdress)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 3,
				/obj/item/natural/silk = 4)
	skill_level = 6

/datum/crafting_recipe/roguetown/sewing/exoticsilkbra
	name = "exotic silk bra - (4 silk, 1 gold ring; MASTER)"
	result = list (/obj/item/clothing/suit/roguetown/shirt/exoticsilkbra)
	reqs = list(/obj/item/natural/silk = 3,
				/obj/item/clothing/ring/gold = 1)
	skill_level = 6

/datum/crafting_recipe/roguetown/sewing/exoticsilkmask
	name = "exotic silk mask - (1 silk, 1 gold ring; MASTER)"
	result = list (/obj/item/clothing/mask/rogue/exoticsilkmask)
	reqs = list(/obj/item/natural/silk = 2,
				/obj/item/clothing/ring/gold = 1)
	skill_level = 6

/datum/crafting_recipe/roguetown/sewing/exoticsilkbelt
	name = "exotic silk belt - (2 silk, 1 gold ring; MASTER)"
	result = list (/obj/item/storage/belt/rogue/leather/exoticsilkbelt)
	reqs = list(/obj/item/natural/silk = 3,
				/obj/item/clothing/ring/gold = 1)
	skill_level = 6
