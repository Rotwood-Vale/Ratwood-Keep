/mob/living/simple_animal/hostile/retaliate/rogue/bigrat/gethsmane
	name = "fretensis"
	health = 100
	maxHealth = 100
	STASTR = 8
	retreat_health = 0
	defprob = 90
	color = "#485775"

/mob/living/simple_animal/hostile/retaliate/rogue/bigrat/gethsmane/AttackingTarget()
	. = ..()
	if(. && isliving(target))
		var/mob/living/L = target
		if(L.reagents)
			L.reagents.add_reagent(/datum/reagent/toxin/spewium, 3) //this won't do much til u get 29u then uhhh bye lol

