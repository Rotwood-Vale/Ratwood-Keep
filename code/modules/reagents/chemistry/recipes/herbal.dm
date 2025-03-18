
// one alchemical hourglass turn = 20 degrees

// chamomile variants

/datum/chemical_reaction/chamomile/good
	name = "Boiled chamomile"
	id = /datum/reagent/herb/nettle/good
	results = list(/datum/reagent/herb/chamomile/good = 1)
	required_reagents = list(/datum/reagent/herb/nettle = 1)
	required_temp = 313

/datum/chemical_reaction/chamomile/bad
	name = "Burnt chamomile"
	id = /datum/reagent/herb/chamomile/bad
	results = list(/datum/reagent/herb/chamomile/bad = 1)
	required_reagents = list(/datum/reagent/herb/chamomile/good = 1)
	required_temp = 340

// nettle variants

/datum/chemical_reaction/nettle/good
	name = "Boiled nettles"
	id = /datum/reagent/herb/nettle/good
	results = list(/datum/reagent/herb/nettle/good = 1)
	required_reagents = list(/datum/reagent/herb/nettle = 1)
	required_temp = 333

/datum/chemical_reaction/nettle/bad
	name = "Burnt nettles"
	id = /datum/reagent/herb/nettle/bad
	results = list(/datum/reagent/herb/nettle/bad = 1)
	required_reagents = list(/datum/reagent/herb/nettle/good = 1)
	required_temp = 360

// sage variants

/datum/chemical_reaction/sage/good
	name = "Boiled sage"
	id = /datum/reagent/herb/sage/good
	results = list(/datum/reagent/herb/sage/good = 1)
	required_reagents = list(/datum/reagent/herb/sage = 1)
	required_temp = 333

/datum/chemical_reaction/sage/bad
	name = "Burnt sage"
	id = /datum/reagent/herb/sage/bad
	results = list(/datum/reagent/herb/sage/bad = 1)
	required_reagents = list(/datum/reagent/herb/sage/good = 1)
	required_temp = 360

// belladonna variants

/datum/chemical_reaction/belladonna/good
	name = "Boiled belladonna"
	id = /datum/reagent/herb/belladonna/good
	results = list(/datum/reagent/herb/sage/good = 1)
	required_reagents = list(/datum/reagent/herb/belladonna = 1)
	required_temp = 353

/datum/chemical_reaction/belladonna/bad
	name = "Burnt belladonna"
	id = /datum/reagent/herb/belladonna/bad
	results = list(/datum/reagent/herb/belladonna/bad = 1)
	required_reagents = list(/datum/reagent/herb/belladonna/good = 1)
	required_temp = 370

// herb drow variants

/datum/chemical_reaction/herbdrow/good
	name = "Boiled herb drow"
	id = /datum/reagent/herb/herbdrow/good
	results = list(/datum/reagent/herb/sage/good = 1)
	required_reagents = list(/datum/reagent/herb/herbdrow = 1)
	required_temp = 353

/datum/chemical_reaction/herbdrow/bad
	name = "Burnt herbdrow"
	id = /datum/reagent/herb/herbdrow/bad
	results = list(/datum/reagent/herb/herbdrow/bad = 1)
	required_reagents = list(/datum/reagent/herb/herbdrow/good = 1)
	required_temp = 370

// poppy variants

/datum/chemical_reaction/poppy/good
	name = "Boiled poppy"
	id = /datum/reagent/herb/poppy/good
	results = list(/datum/reagent/herb/sage/good = 1)
	required_reagents = list(/datum/reagent/herb/poppy = 1)
	required_temp = 313

/datum/chemical_reaction/poppy/bad
	name = "Burnt poppy"
	id = /datum/reagent/herb/poppy/bad
	results = list(/datum/reagent/herb/poppy/bad = 1)
	required_reagents = list(/datum/reagent/herb/poppy/good = 1)
	required_temp = 330

// thistle variants

/datum/chemical_reaction/thistle/good
	name = "Boiled thistle"
	id = /datum/reagent/herb/thistle/good
	results = list(/datum/reagent/herb/sage/good = 1)
	required_reagents = list(/datum/reagent/herb/thistle = 1)
	required_temp = 313

/datum/chemical_reaction/thistle/bad
	name = "Burnt thistle"
	id = /datum/reagent/herb/thistle/bad
	results = list(/datum/reagent/herb/thistle/bad = 1)
	required_reagents = list(/datum/reagent/herb/thistle/good = 1)
	required_temp = 330

// thistle variants

/datum/chemical_reaction/eyebright/good
	name = "Boiled eyebright"
	id = /datum/reagent/herb/eyebright/good
	results = list(/datum/reagent/herb/sage/good = 1)
	required_reagents = list(/datum/reagent/herb/eyebright = 1)
	required_temp = 353

/datum/chemical_reaction/eyebright/bad
	name = "Burnt eyebright"
	id = /datum/reagent/herb/eyebright/bad
	results = list(/datum/reagent/herb/eyebright/bad = 1)
	required_reagents = list(/datum/reagent/herb/eyebright/good = 1)
	required_temp = 370

// remedies

	// marigolddec

/datum/chemical_reaction/marigolddec
	name = "Marigold infusion"
	id = /datum/reagent/medicine/marigolddec
	results = list(/datum/reagent/medicine/marigolddec = 3)
	required_reagents = list(/datum/reagent/water = 1, /datum/reagent/herb/nettle/good = 1, /datum/reagent/herb/marigold/ground = 2)

/datum/chemical_reaction/marigolddec/ruined
	name = "Ruined Marigold infusion"
	id = /datum/reagent/medicine/marigolddec
	results = list(/datum/reagent/medicine/marigolddec/ruined = 3)
	required_reagents = list(/datum/reagent/water = 1, /datum/reagent/herb/nettle/bad = 1, /datum/reagent/herb/marigold/ground = 2)

	// chamomiledec

/datum/chemical_reaction/chamomiledec
	name = "Chamomile infusion"
	id = /datum/reagent/medicine/chamomiledec
	results = list(/datum/reagent/medicine/chamomiledec = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/beer/wine = 1, /datum/reagent/herb/sage/ground = 1, /datum/reagent/herb/chamomile/good = 2)

/datum/chemical_reaction/chamomiledec/ruined
	name = "Ruined Chamomile infusion"
	id = /datum/reagent/medicine/chamomiledec
	results = list(/datum/reagent/medicine/chamomiledec/ruined = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/beer/wine = 1, /datum/reagent/herb/sage/ground = 1, /datum/reagent/herb/chamomile/bad = 2)

	// nighthawk

/datum/chemical_reaction/nighthawk
	name = "Nighthawk infusion"
	id = /datum/reagent/medicine/nighthawk
	results = list(/datum/reagent/medicine/nighthawk = 3)
	required_reagents = list(/datum/reagent/water = 1, /datum/reagent/herb/eyebright/ground = 2, /datum/reagent/herb/chamomile/ground = 1, /datum/reagent/herb/belladonna/good = 1)

/datum/chemical_reaction/nighthawk/ruined
	name = "Ruined Nighthawk infusion"
	id = /datum/reagent/medicine/nighthawk
	results = list(/datum/reagent/medicine/nighthawk/ruined = 3)
	required_reagents = list(/datum/reagent/water = 1, /datum/reagent/herb/eyebright/ground = 2, /datum/reagent/herb/chamomile/ground = 1, /datum/reagent/herb/belladonna/bad = 1)

	// schnapps

/datum/chemical_reaction/schnapss
	name = "Schnapps infusion"
	id = /datum/reagent/consumable/ethanol/schnapps
	results = list(/datum/reagent/consumable/ethanol/schnapps = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/beer/wine = 1, /datum/reagent/herb/nettle/good = 1, /datum/reagent/herb/belladonna/good = 2)

/datum/chemical_reaction/schnapss/ruined
	name = "Ruined Schnapps infusion"
	id = /datum/reagent/consumable/ethanol/schnapps
	results = list(/datum/reagent/consumable/ethanol/schnapps/ruined = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/beer/wine = 1, /datum/reagent/herb/nettle/good = 1, /datum/reagent/herb/belladonna/bad = 2)

/datum/chemical_reaction/schnapss/ruined
	name = "Ruined Schnapps infusion"
	id = /datum/reagent/consumable/ethanol/schnapps
	results = list(/datum/reagent/consumable/ethanol/schnapps/ruined = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/beer/wine = 1, /datum/reagent/herb/nettle/bad = 1, /datum/reagent/herb/belladonna/good = 2)

/datum/chemical_reaction/schnapss/ruined
	name = "Ruined Schnapps infusion"
	id = /datum/reagent/consumable/ethanol/schnapps
	results = list(/datum/reagent/consumable/ethanol/schnapps/ruined = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/beer/wine = 1, /datum/reagent/herb/nettle/bad = 1, /datum/reagent/herb/belladonna/bad = 2)

	// quickfinger

/datum/chemical_reaction/quickfinger
	name = "Quickfinger infusion"
	id = /datum/reagent/medicine/quickfinger
	results = list(/datum/reagent/medicine/quickfinger = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/beer/wine = 1, /datum/reagent/herb/valerian/good = 2, /datum/reagent/herb/eyebright/good = 2)

/datum/chemical_reaction/quickfinger/ruined
	name = "Ruined Quickfinger infusion"
	id = /datum/reagent/medicine/quickfinger
	results = list(/datum/reagent/medicine/quickfinger/ruined = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/beer/wine = 1, /datum/reagent/herb/valerian/good = 2, /datum/reagent/herb/eyebright/bad = 2)

/datum/chemical_reaction/quickfinger/ruined
	name = "Ruined Quickfinger infusion"
	id = /datum/reagent/medicine/quickfinger
	results = list(/datum/reagent/medicine/quickfinger/ruined = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/beer/wine = 1, /datum/reagent/herb/valerian/bad = 2, /datum/reagent/herb/eyebright/good = 2)

/datum/chemical_reaction/quickfinger/ruined
	name = "Ruined Quickfinger infusion"
	id = /datum/reagent/medicine/quickfinger
	results = list(/datum/reagent/medicine/quickfinger/ruined = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/beer/wine = 1, /datum/reagent/herb/valerian/bad = 2, /datum/reagent/herb/eyebright/bad = 2)

	//artemisia

/datum/chemical_reaction/artemisia
	name = "artemisia infusion"
	id = /datum/reagent/medicine/artemisia
	results = list(/datum/reagent/medicine/artemisia = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/beer/wine = 1, /datum/reagent/herb/herbdrow/good = 2, /datum/reagent/herb/sage/good = 2)

/datum/chemical_reaction/artemisia/ruined
	name = "Ruined artemisia infusion"
	id = /datum/reagent/medicine/artemisia
	results = list(/datum/reagent/medicine/artemisia/ruined = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/beer/wine = 1, /datum/reagent/herb/herbdrow/good = 2, /datum/reagent/herb/sage/bad = 2)

/datum/chemical_reaction/artemisia/ruined
	name = "Ruined artemisia infusion"
	id = /datum/reagent/medicine/artemisia
	results = list(/datum/reagent/medicine/artemisia/ruined = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/beer/wine = 1, /datum/reagent/herb/herbdrow/bad = 2, /datum/reagent/herb/sage/good = 2)

/datum/chemical_reaction/artemisia/ruined
	name = "Ruined artemisia infusion"
	id = /datum/reagent/medicine/artemisia
	results = list(/datum/reagent/medicine/artemisia/ruined = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/beer/wine = 1, /datum/reagent/herb/herbdrow/bad = 2, /datum/reagent/herb/sage/bad = 2)
// poisons

	// dollmaker

/datum/chemical_reaction/dollmaker
	name = "Dollmaker poison"
	id = /datum/reagent/poison/dollmaker
	results = list(/datum/reagent/poison/dollmaker = 3)
	required_reagents = list(/datum/reagent/water = 1, /datum/reagent/herb/valerian/good = 1, /datum/reagent/herb/herbdrow/good = 2)

/datum/chemical_reaction/dollmaker/ruined
	name = "Ruined Dollmaker poison"
	id = /datum/reagent/poison/dollmaker
	results = list(/datum/reagent/poison/dollmaker/ruined = 3)
	required_reagents = list(/datum/reagent/water = 1, /datum/reagent/herb/valerian/bad = 1, /datum/reagent/herb/herbdrow/bad = 2)

/datum/chemical_reaction/dollmaker/ruined
	name = "Ruined Dollmaker poison"
	id = /datum/reagent/poison/dollmaker
	results = list(/datum/reagent/poison/dollmaker/ruined = 3)
	required_reagents = list(/datum/reagent/water = 1, /datum/reagent/herb/valerian/good = 1, /datum/reagent/herb/herbdrow/bad = 2)

/datum/chemical_reaction/dollmaker/ruined
	name = "Ruined Dollmaker poison"
	id = /datum/reagent/poison/dollmaker
	results = list(/datum/reagent/poison/dollmaker/ruined = 3)
	required_reagents = list(/datum/reagent/water = 1, /datum/reagent/herb/valerian/bad = 1, /datum/reagent/herb/herbdrow/good = 2)

	// lullaby

/datum/chemical_reaction/lullaby
	name = "Lullaby poison"
	id = /datum/reagent/poison/lullaby
	results = list(/datum/reagent/poison/lullaby = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/beer/wine = 1, /datum/reagent/herb/poppy/good = 1, /datum/reagent/herb/thistle/good = 1, /datum/reagent/herb/herbdrow/ground = 1)

/datum/chemical_reaction/lullaby/ruined
	name = "Ruined Lullaby poison"
	id = /datum/reagent/poison/lullaby
	results = list(/datum/reagent/poison/lullaby/ruined = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/beer/wine = 1, /datum/reagent/herb/poppy/bad = 1, /datum/reagent/herb/thistle/bad = 1, /datum/reagent/herb/herbdrow/ground = 1)

/datum/chemical_reaction/lullaby/ruined
	name = "Ruined Lullaby poison"
	id = /datum/reagent/poison/lullaby
	results = list(/datum/reagent/poison/lullaby/ruined = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/beer/wine = 1, /datum/reagent/herb/poppy/good = 1, /datum/reagent/herb/thistle/bad = 1, /datum/reagent/herb/herbdrow/ground = 1)

/datum/chemical_reaction/lullaby/ruined
	name = "Ruined Lullaby poison"
	id = /datum/reagent/poison/lullaby
	results = list(/datum/reagent/poison/lullaby/ruined = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/beer/wine = 1, /datum/reagent/herb/poppy/bad = 1, /datum/reagent/herb/thistle/good = 1, /datum/reagent/herb/herbdrow/ground = 1)

