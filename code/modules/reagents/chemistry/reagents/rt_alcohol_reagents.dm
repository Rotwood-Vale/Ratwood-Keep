// Just store all of the alcohol reagents that isn't base tg here
/datum/reagent/consumable/ethanol/beer
	name = "Beer"
	description = ""
	color = "#a17c10" // rgb: 102, 67, 0
	nutriment_factor = 0.1
	boozepwr = 25
	taste_description = "ale"
	glass_name = "glass of beer"
	glass_desc = ""

/datum/reagent/consumable/ethanol/rum
	name = "Rum"
	description = ""
	color = "#5f3b23" // rgb: 102, 67, 0
	boozepwr = 40
	taste_description = "sweetness with hint of caramel and vanilla"

/datum/reagent/consumable/ethanol/cider
	name = "Apple Cider"
	boozepwr = 40
	taste_description = "cider"
	glass_name = "glass of cider"
	color = "#6aa945"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/cider/pear
	name = "Pear Cider"

/datum/reagent/consumable/ethanol/cider/strawberry
	name = "Strawberry Cider"
	color = "#da4d4d"
	taste_description = "strawberry cider"

/datum/reagent/consumable/ethanol/aqua_vitae
	name = "Aqua Vitae"
	boozepwr = 150
	taste_description = "death"
	color = "#6e6e6e"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/brandy
	name = "Apple Brandy"
	boozepwr = 60
	taste_description = "brandy"
	glass_name = "glass of brandy"
	color = "#6aa945"
	quality = DRINK_VERYGOOD

/datum/reagent/consumable/ethanol/brandy/pear
	name = "Pear Brandy"

/datum/reagent/consumable/ethanol/brandy/strawberry
	name = "Strawberry Brandy"
	color = "#bb1a1a"

/datum/reagent/consumable/ethanol/brandy/tangerine
	name = "Tangerine Brandy"
	color = "#bb751a"

/datum/reagent/consumable/ethanol/brandy/plum
	name = "Plum Brandy"
	color = "#5c0449"

/datum/reagent/consumable/ethanol/wine
	name = "Wine"
	boozepwr = 30
	taste_description = "wine"
	glass_name = "glass of wine"
	color = "#8a0b0b"

/datum/reagent/consumable/ethanol/light
	name = "Light Beer"
	description = "An alcoholic beverage brewed since ancient times on Old Earth. This variety has reduced calorie and alcohol content."
	boozepwr = 5 //Space Europeans hate it
	taste_description = "dish water"
	glass_name = "glass of light beer"
	glass_desc = ""

/datum/reagent/consumable/ethanol/green
	name = "Green Beer"
	description = "An alcoholic beverage brewed since ancient times on Old Earth. This variety is dyed a festive green."
	color = "#A8E61D"
	taste_description = "green piss water"
	glass_icon_state = "greenbeerglass"
	glass_name = "glass of green beer"
	glass_desc = ""

/datum/reagent/consumable/ethanol/green/on_mob_life(mob/living/carbon/M)
	if(M.color != color)
		M.add_atom_colour(color, TEMPORARY_COLOUR_PRIORITY)
	return ..()

/datum/reagent/consumable/ethanol/green/on_mob_end_metabolize(mob/living/M)
	M.remove_atom_colour(TEMPORARY_COLOUR_PRIORITY, color)

/datum/reagent/consumable/ethanol/ale
	name = "Ale"
	description = "A dark alcoholic beverage made with malted barley and yeast."
	color = "#664300" // rgb: 102, 67, 0
	boozepwr = 25
	taste_description = "hearty barley ale"
	glass_icon_state = "aleglass"
	glass_name = "glass of ale"
	glass_desc = ""


// BEERS - Imported for now, later the styles will be 'mockable', if and when I get to brewing.

// Humen Production - Underwhelming, but cheap.

/datum/reagent/consumable/ethanol/zagul
	name = "Zagul Brew"
	boozepwr = 15
	taste_description = "cheap pisswater"
	color = "#DBD77F"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/gin
	name = "Gin"
	boozepwr = 65
	taste_description = "strong, piney flavor"
	color = "#809978"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/spottedhen
	name = "Spotted Hen"
	boozepwr = 15
	taste_description = "cheap pisswater"
	color = "#DBD77F"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/hagwoodbitter
	name = "Hagwood Bitter"
	boozepwr = 25
	taste_description = "dull crispness"
	color = "#BBB525"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/blackgoat
	name = "Black Gote Kriek"
	boozepwr = 25
	taste_description = "overwhelming sourness"
	color = "#401806"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/onion
	name = "Onion Cognac"
	boozepwr = 10
	taste_description = "spicy sweet malty overtones"
	color = "#683e00"
	quality = DRINK_NICE

// Elf Production - LEAF-LOVERS MOTHERFUCKER

/datum/reagent/consumable/ethanol/aurorian
	name = "Aurorian"
	boozepwr = 5
	taste_description = "subtle herbacious undertones"
	color = "#5D8A8A"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/fireleaf // cabbbage
	name = "Fireleaf"
	boozepwr = 2
	taste_description = "bland liquor"
	color = "#475e45"
	quality = DRINK_NICE

// Dwarven Production - Best in the Realms

/datum/reagent/consumable/ethanol/butterhairs
	name = "Butterhairs"
	boozepwr = 30
	taste_description = "buttery richness"
	color = "#5D8A8A"
	quality = DRINK_GOOD

/datum/reagent/consumable/ethanol/stonebeards
	name = "Stonebeard Reserve"
	boozepwr = 40
	taste_description = "potent oatlike liquor"
	color = "#5D8A8A"
	quality = DRINK_GOOD

/datum/reagent/consumable/ethanol/voddena // Not vodka. Trust me.
	name = "Voddena"
	boozepwr = 55  // holy shit
	taste_description = "burning starchy wet dirt"
	color = "#a1a1a1"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/limoncello
	name = "Limoncello"
	boozepwr = 45  // holy shit
	taste_description = "burning and lemony"
	color = "#d2da63"
	quality = DRINK_GOOD

// Generic Rice
/datum/reagent/consumable/ethanol/ricewine
	name = "Rice Wine"
	taste_description = "floral sweetness with a subtle umami taste."
	color = "#F5E6C4" // rgb: 210, 218, 99
	boozepwr = 30

/datum/reagent/consumable/ethanol/ricespirit
	name = "Rice Spirit"
	taste_description = "clean heat and dry finish."
	color = "#F8FDFC" // rgb: 210, 218, 99
	boozepwr = 55
	quality = DRINK_NICE

// WINE - Fancy.

// Humen Production - Grape Based

/datum/reagent/consumable/ethanol/sourwine // Peasant grade shit.
	name = "Sour Wine"
	boozepwr = 20
	taste_description = "sour wine"
	color = "#552b4b"

/datum/reagent/consumable/ethanol/whitewine
	name = "White Wine"
	boozepwr = 30
	taste_description = "sweet white wine"
	color = "#F3ED91"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/redwine
	name = "Red Wine"
	boozepwr = 30
	taste_description = "tannin-stricken wine"
	color = "#571111"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/jackberrywine
	name = "Jackberry Wine"
	boozepwr = 15
	taste_description = "sickly sweet young wine"
	color = "#3b2342"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/jackberrywine/aged
	name = "Aged Jackberry Wine"
	boozepwr = 30
	taste_description = "sickly sweet aged wine"
	color = "#402249"
	quality = DRINK_GOOD

/datum/reagent/consumable/ethanol/jackberrywine/delectable
	name = "Delectable Jackberry Wine"
	boozepwr = 30
	taste_description = "sickly sweet delectably aged wine"
	color = "#652679"
	quality = DRINK_VERYGOOD

/datum/reagent/consumable/ethanol/plum_wine
	name = "Umeshu"
	boozepwr = 15
	taste_description = "sickly sweet young wine"
	color = "#c997d8"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/plum_wine/aged
	name = "Aged Umeshu"
	boozepwr = 30
	taste_description = "sickly sweet aged wine"
	color = "#c27cd8"
	quality = DRINK_GOOD

/datum/reagent/consumable/ethanol/plum_wine/delectable
	name = "Delectable Umeshu"
	boozepwr = 30
	taste_description = "sickly sweet delectably aged wine"
	color = "#a854c2"
	quality = DRINK_VERYGOOD

/datum/reagent/consumable/ethanol/tangerine
	name = "Tangerine Wine"
	boozepwr = 15
	taste_description = "bittersweet, citrusy young wine"
	color = "#e7aa59"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/tangerine/aged
	name = "Aged Tangerine Wine"
	boozepwr = 30
	taste_description = "bittersweet, citrusy aged wine"
	color = "#d68d2d"
	quality = DRINK_GOOD

/datum/reagent/consumable/ethanol/tangerine/delectable
	name = "Delectable Tangerine Wine"
	boozepwr = 30
	taste_description = "bittersweet, citrusy delectably aged wine"
	color = "#eb9321"
	quality = DRINK_VERYGOOD

/datum/reagent/consumable/ethanol/raspberry
	name = "Raspberry Wine"
	boozepwr = 15
	taste_description = "bitter sweet young wine"
	color = "#ee5ea6"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/raspberry/aged
	name = "Aged Raspberry Wine"
	boozepwr = 30
	taste_description = "bitter sweet aged wine"
	color = "#d83788"
	quality = DRINK_GOOD

/datum/reagent/consumable/ethanol/raspberry/delectable
	name = "Delectable Raspberry Wine"
	boozepwr = 30
	taste_description = "bitter sweet delectably aged wine"
	color = "#db0d74"
	quality = DRINK_VERYGOOD

/datum/reagent/consumable/ethanol/blackberry
	name = "Blackberry Wine"
	boozepwr = 15
	taste_description = "bitter tart young wine"
	color = "#861491"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/blackberry/aged
	name = "Aged Blackberry Wine"
	boozepwr = 30
	taste_description = "bitter tart aged wine"
	color = "#58065f"
	quality = DRINK_GOOD

/datum/reagent/consumable/ethanol/blackberry/delectable
	name = "Delectable Blackberry Wine"
	boozepwr = 30
	taste_description = "bitter tart delectably aged wine"
	color = "#330038"
	quality = DRINK_VERYGOOD

// Elf Production - Berries & Herbal

/datum/reagent/consumable/ethanol/elfred
	name = "Elven Red"
	boozepwr = 15
	taste_description = "delectable fruity notes"
	color = "#6C0000"
	quality = DRINK_GOOD

/datum/reagent/consumable/ethanol/elfblue
	name = "Valmora Blue"
	boozepwr = 50
	taste_description = "saintly sweetness"
	color = "#2C9DAF"
	quality = DRINK_FANTASTIC

// Azure Drinks
/datum/reagent/consumable/ethanol/jagdtrunk // JÄGERMEISTER!!!!
	name = "Jagdtrunk"
	boozepwr = 55  // gotta be stronk
	taste_description = "spicy herbal remedy"
	color = "#331f18"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/apfelweinheim
	name = "Appelheimer"
	boozepwr = 45
	taste_description = "tart crispness and mellow sweetness"
	color = "#e0cb55"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/rtoper
	name = "Lirvas Toper"
	boozepwr = 40
	taste_description = "overwhelming tartness"
	color = "#e0a400"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/nred
	name = "Norwardine Red"
	boozepwr = 30
	taste_description = "heavy caramel note and slight bitterness"
	color = "#543633"
	quality = DRINK_GOOD

/datum/reagent/consumable/ethanol/gronnmead
	name = "Ragnar's Brew"
	boozepwr = 35
	taste_description = "notes of honey and red berries" //I love red mead ok...
	color = "#772C48"
	quality = DRINK_GOOD

//Avar boozes

/datum/reagent/consumable/ethanol/avarmead
	name = "Zögiin bal"
	boozepwr = 30
	taste_description = "spicy honey"
	color = "#e0a400"
	quality = DRINK_GOOD

/datum/reagent/consumable/ethanol/avarrice
	name = "Makkolir"
	boozepwr = 30
	taste_description = "tangy sweetness"
	color = "#ddcbc9"
	quality = DRINK_GOOD

/datum/reagent/consumable/ethanol/saigamilk //No way, kumys from avar!!!
	name = "Bökhiin Arkhi"
	boozepwr = 15
	taste_description = "bubbly, sour salt"
	color = "#dddddd"

//Kazengun boozes

/datum/reagent/consumable/ethanol/kgunlager
	name = "Yamaguchi Pale"
	boozepwr = 10 //A PALE imitation actual beer...
	taste_description = "mellow bitterness and a hint of green tea"
	color = "#d7dbbc"

/datum/reagent/consumable/ethanol/kgunsake
	name = "Junmai-ginjo"
	boozepwr = 50
	taste_description = "dry sweetness"
	color = "#ccd7e0"
	quality = DRINK_VERYGOOD

/datum/reagent/consumable/ethanol/kgunshochu
	name = "Shochu"
	boozepwr = 60
	taste_description = "dry, clean finish"
	color = "#F8FDFC"
	quality = DRINK_VERYGOOD

/datum/reagent/consumable/ethanol/kgunplum
	name = "Umeshu"
	boozepwr = 30
	taste_description = "a mix of sweet and sour"
	color = "#ddb99b"
	quality = DRINK_GOOD

// Zhongese
/datum/reagent/consumable/ethanol/huangjiu
	name = "Huangjiu"
	boozepwr = 30
	taste_description = "a mix of sweet and sour"
	color = "#d8b84c"

/datum/reagent/consumable/ethanol/baijiu
	name = "Baijiu"
	boozepwr = 60
	taste_description = "fiery and pungent alcohol with a hint of sweetness"
	color = "#f8fdfc"
	quality = DRINK_GOOD

/datum/reagent/consumable/ethanol/yaojiu
	name = "Yaojiu"
	boozepwr = 50
	taste_description = "bittersweet alcohol with deep herbal notes"
	color = "#8C4B1F"
	quality = DRINK_VERYGOOD

/datum/reagent/consumable/ethanol/shejiu
	name = "Shejiu"
	boozepwr = 50
	taste_description = "musky and strong alcohol with a hint of gameiness"
	color = "#C49A6C"
	quality = DRINK_VERYGOOD

// Mead 
/datum/reagent/consumable/ethanol/mead
	name = "Mead"
	description = "A warriors drink, though a cheap one."
	color = "#664300" // rgb: 102, 67, 0
	nutriment_factor = 1 * REAGENTS_METABOLISM
	boozepwr = 30
	quality = DRINK_NICE
	taste_description = "sweet, sweet alcohol"
	glass_icon_state = "meadglass"
	glass_name = "Mead"
	glass_desc = ""

/datum/reagent/consumable/ethanol/mead/spider
	color = "#660061"

// Special Drugs
/datum/reagent/consumable/ethanol/murkwine // not Toilet wine
	name = "mürkwine"
	boozepwr = 50  // bubba's best
	taste_description = "hints of questionable choices--a bouqet of murkwater and pure ethanol"
	color = "#4b1e00"

/datum/reagent/consumable/ethanol/murkwine/on_mob_life(mob/living/carbon/M)
	M.apply_status_effect(/datum/status_effect/buff/murkwine)
	//M.rogfat_add(0.1) //fix it
	..()
	. = 1

/datum/reagent/consumable/ethanol/murkwine/on_mob_end_metabolize(mob/living/M)
	M.remove_status_effect(/datum/status_effect/buff/murkwine)

/datum/reagent/consumable/ethanol/nocshine // wait, no, NOCSHINE
	name = "noc's shine"
	boozepwr = 70  // YEEEEEHAAAWWWWWW
	taste_description = "what might be my throat melting and nose hair burning"
	color = "#d8fbfd63"
	quality = DRINK_NICE


/datum/reagent/consumable/ethanol/nocshine/on_mob_life(mob/living/carbon/M)
	M.apply_status_effect(/datum/status_effect/buff/nocshine)
	if(HAS_TRAIT(M, TRAIT_CRACKHEAD))
		M.adjustToxLoss(0.1, 0)
	else
		M.adjustToxLoss(0.75, 0)
	..()
	. = 1

/datum/reagent/consumable/ethanol/nocshine/on_mob_end_metabolize(mob/living/M)
	M.remove_status_effect(/datum/status_effect/buff/nocshine)
