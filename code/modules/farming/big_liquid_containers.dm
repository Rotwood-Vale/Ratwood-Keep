// For storing roguebin and fermenting barrel or something

// Bin
/obj/item/roguebin/water/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/water,500)
	update_icon()

/obj/item/roguebin/water/gross/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/water/gross,500)
	update_icon()

// Water
/obj/structure/fermentation_keg/random/water
	name = "water barrel"

/obj/structure/fermentation_keg/random/water/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/water, rand(0,900))

/obj/structure/fermentation_keg/random/beer/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/consumable/ethanol/beer, rand(0,900))

/obj/structure/fermentation_keg/water
	name = "water barrel"

/obj/structure/fermentation_keg/water/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/water,900)

/obj/structure/fermentation_keg/beer
	desc = "A barrel containing a generic housebrewed small-beer."

/obj/structure/fermentation_keg/beer/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/consumable/ethanol/beer, 900)


// Alcohol 
/obj/structure/fermentation_keg/zagul
	desc = "A barrel marked with a coastal zagul. An extremely cheap lager hailing from a local brewery."

/obj/structure/fermentation_keg/zagul/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/consumable/ethanol/zagul,900)

/obj/structure/fermentation_keg/blackgoat
	desc = "A barrel marked with the Black Goat Kriek emblem. A fruit-sour beer brewed with jackberries for a tangy taste."

/obj/structure/fermentation_keg/blackgoat/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/consumable/ethanol/blackgoat,900)

/obj/structure/fermentation_keg/hagwoodbitter
	desc = "A barrel marked with the Hagwood Bitters emblem. The least bitter thing to be exported from the Grenzelhoft occupied state of Zorn."

/obj/structure/fermentation_keg/hagwoodbitter/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/consumable/ethanol/hagwoodbitter,900)



/obj/structure/fermentation_keg/jagt
	desc = "A barrel with a Saigabuck mark. This dark liquid is the strongest alcohol coming out of Grenzelhoft available. A herbal schnapps, sure to burn out any disease."

/obj/structure/fermentation_keg/jagt/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/consumable/ethanol/jagdtrunk,900)

/obj/structure/fermentation_keg/sourwine
	desc = "A barrel that contains a Grenzelhoftian classic. An extremely sour wine that is watered down with mineral water."

/obj/structure/fermentation_keg/sourwine/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/consumable/ethanol/sourwine,900)


/obj/structure/fermentation_keg/onion
	desc = "A barrel with surprisingly no maker's mark. On the wood is carved the word \"ONI-N\", the 'O' seems to have been scratched out completely. Dubious. On the barrel is a paper glued to it showing an illustration of rats guarding a cellar filled with bottles against a hoard of beggars."

/obj/structure/fermentation_keg/onion/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/consumable/ethanol/onion,900)

/obj/structure/fermentation_keg/saigamilk
	desc = "A barrel with a Running Saiga mark. A form of alcohol brewed from the milk of a saiga and salt. Common drink of the nomads living in the steppe."

/obj/structure/fermentation_keg/saigamilk/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/consumable/ethanol/saigamilk,900)

/obj/structure/fermentation_keg/kgsunsake
	desc = "A barrel with a Golden Swan mark. A translucient, pale-blue liquid made from rice. A favourite drink of the warlords and nobles of Kazengun."

/obj/structure/fermentation_keg/kgsunsake/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/consumable/ethanol/kgunsake,900)


/obj/structure/fermentation_keg/avarrice
	desc = "A barrel with a simple mark. A murky, white wine made from rice grown in the steppes of Avar."

/obj/structure/fermentation_keg/avarrice/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/consumable/ethanol/avarrice,900)


/obj/structure/fermentation_keg/gronmead
	desc = "A barrel with a Shieldmaiden Brewery mark. A deep red honey-wine, refined with the red berries native to Gronns highlands."

/obj/structure/fermentation_keg/gronmead/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/consumable/ethanol/gronnmead,900)

/obj/structure/fermentation_keg/coffee
	desc = "A barrel with the mark of a brewed cup of coffee.  A strong, bitter drink that rejuvenates the body and mind."

/obj/structure/fermentation_keg/coffee/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/consumable/caffeine/coffee, 900)

/obj/structure/fermentation_keg/tea
	desc = "A barrel with several Kazengunese characters on it indicating the vintage of the tea within. A mild, refreshing drink that calms the mind and body. Hopefully its quality is \
	still intact after being stored in a barrel."

/obj/structure/fermentation_keg/tea/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/consumable/caffeine/tea, 900)

/obj/structure/fermentation_keg/rose_tea
	desc = "A barrel with a mark of a rose over it. Generic rose tea brewed with rose. Refreshing and calming, with minor restorative effects."

/obj/structure/fermentation_keg/rose_tea/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/water/rosewater, 900)
