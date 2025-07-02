/datum/skill/combat
	abstract_type = /datum/skill/combat
	name = "Combat"
	desc = ""
	dream_cost_base = 2
	dream_cost_per_level = 1

/datum/skill/combat/proc/get_skill_parry_modifier(level) //added parry drain/neg in parries and dodges
	switch(level)
		if(SKILL_LEVEL_NONE)
			return 0
		if(SKILL_LEVEL_NOVICE)
			return 5
		if(SKILL_LEVEL_APPRENTICE)
			return 10
		if(SKILL_LEVEL_JOURNEYMAN)
			return 15
		if(SKILL_LEVEL_EXPERT)
			return 20
		if(SKILL_LEVEL_MASTER)
			return 25
		if(SKILL_LEVEL_LEGENDARY)
			return 35

/datum/skill/combat/proc/get_skill_dodge_drain(level) //added parry drain/neg in parries and dodges
	switch(level)
		if(SKILL_LEVEL_NONE)
			return 30
		if(SKILL_LEVEL_NOVICE)
			return 60
		if(SKILL_LEVEL_APPRENTICE)
			return 90
		if(SKILL_LEVEL_JOURNEYMAN)
			return 120
		if(SKILL_LEVEL_EXPERT)
			return 180
		if(SKILL_LEVEL_MASTER)
			return 240
		if(SKILL_LEVEL_LEGENDARY)
			return 300

/datum/skill/combat/knives
	name = "Knife-fighting"
	dreams = list(
		"...your heart beats as swift as your knife strikes that reached their legs, groin and above, throwing daggers and in a devious move kicking them from the floor towards ones that tried to dodge and parry to catch them by surprise, at times when timed right with attacking them directly go through as they recover their parry, draining chipping slowly at their armor and making them slowly short of breathe, while dodging which made it even worse and feinting their parry attempts to begin unleashing a fury of stabs through their leather armor before flipping the knife over to start picking through chained and plated armor alike, fully ignoring its protection opponent's surface, with great haste and ease of precision little stood chance against your swift devious might..."
	)

/datum/skill/combat/swords
	name = "Sword-fighting"
	dreams = list(
		"...your heart beats wildly as your swords strike eachothers, you parry your opponent and finish him off with a decisive slash..."
	)

/datum/skill/combat/polearms
	name = "Polearms"
	dreams = list(
		"...the air blows against your body in the open field, as your opponent's whole body is at range with the polearm's great length, regaining your focus you'd start to pull the polearm with a firm grip to ready up for a proper instead of a half-hearted hasty half-forced strike and thrusting it forth, keeping your opponent at a distance, striking where they move or at when close and with proper precision when they're at range, with double the said range came the advantage when chasing and tactically falling back from them, piercing through padded-cloth and leather armor like they were nothing with the spear, throwing it towards someone unarmored before rolling towards an heavier polearm and reaching for the heavens and with the added polearm range unleashed a slow but crashing blow through that plated armor making them scream for pain and slowly crawl towards and away, never being able to reach you back until they were properly subdued..."
	)

/datum/skill/combat/maces
	name = "Maces"
	dreams = list(
		"...maces maces maces, they're all around, striking to slow, unleashing a hefty, delayed smash to fully punch though its protection, stunning them briefly and staggering them after, making their retreats and advances more than futile, smashing them when they're down, making them too meek to stand on their legs, what an amusing sight." 
	)

/datum/skill/combat/axes
	name = "Axes"
	dreams = list(
		"...grabbing a random axe, using it to cut and chop, getting a feel for it and finally realizing that they are not half bad one handed with barely any added heft when wielded, be it iron or steel, until picking up the battle axe and the effect inverted, what a cumbersome weapon to wield in one-hand, with a mighty fine one in two, chopping through limps like, shattering shields into splinters and bending steel one to ones will, reaching the legs, groin and above, what a handy thing to axe folk a few questions..."
	)

/datum/skill/combat/whipsflails
	name = "Whips & Flails"
	dreams = list(
		"..."
	)

/datum/skill/combat/bows
	name = "Archery"
	dreams = list(
		"...you stand in an open field, a straw target in your sights, pulling a arrow from your quiver with your gloved hand and loading it to aim and let it loose at the target missing, this cycle continued for a bit until your aim steadied proper, muscles building up strength making it easier to draw the bow, skills slowly refining aiding the task at hand, a new trick that pop to mind is to curl the arm back and grab the arrow with the bow holding hand to draw it in the air before aiming proper, tilting the head, squinting an eye, taking a deep breath and finally letting it loose, bullseye, probably want to run just about now, that bull looks quite angry..."
	)

/datum/skill/combat/crossbows
	name = "Crossbows"
	dreams = list(
		"..."
	)

/datum/skill/combat/wrestling
	name = "Wrestling"
	dreams = list(
		"..."
	)

/datum/skill/combat/unarmed
	name = "Fist-fighting"
	dreams = list(
		"...your body is bruised, your breathe haggers, but your harden fists and lower-legs refused to give in, going into actions with punches that landed furied blows from their groin to the top that managed to fractured several bones before dealing a decisive knockout that was followed up by a hefty punch that snapped the spine, refocusing your efforts towards another, deciding to use an delayed kick against the unarmored leg, avoiding the neck and above that can't be reached, knocking one by the wall, another on the table, a third against a few objects and a fourth against fifth, moving into a stomp that dislocated and later shattered bone, you stood there, gasping for air, all bruised and beaten up, yet victories..."
	)

/datum/skill/combat/firearms
	name = "Firearms"
	dreams = list(
		"..."
	)
