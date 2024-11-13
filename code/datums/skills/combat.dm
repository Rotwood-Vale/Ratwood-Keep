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
		"...you dream of energy. Energy reaching the tips of your fingers, energy yearning for the tips of your toes, energy rushing through your veins, towards the tip of your knife. You find yourself on the roof of a building, a pouch of gold you didn't earn on your hip and a man with an authoritative voice shouting at your back. Something within you opens, like a valve, allowing the boundless energy to bubble up to your lips - and before you even realize what you've said, you reminisce on how *good* it felt to tell him to fuck off... and how nicely the dagger feels in your palm, primed to slip itself between his coif and his neck as he leers closer."
	)

/datum/skill/combat/swords
	name = "Sword-fighting"
	dreams = list(
		"...you dream of calm. A priceless commodity in Rockhill, you simply bask in it, meditating at the top of a great mountain. The azure skies stare down at the serene, rolling plains in front of you. The sword in the grass, pristine as the day it was made, shines radiant and guides your hand to it. You trace it along the sky, etching your name into the clouds, a painter at work with their brush - your sword is not just a tool of war, but a tool of creativity and status. And, as you slowly awake, you feel the world open up, and get just a little bit brighter - as long as you have your brush by your side."
	)

/datum/skill/combat/polearms
	name = "Polearms"
	dreams = list(
		"...you dream of safety. The grip of the staff in your hand never falters, and those at your back never, *ever* doubt you. Throughout your dream, which seems to stretch on and on forever, you lead hundreds of soldiers, or a flock of sheep, or no one at all - but regardless of who's at your back, all you need to feel safe is the staff at your side. The tip of your spear points you, like the north star. No matter what happens, no matter what natural disaster or thief of volf comes your way, you will never compromise, never waver, never rest. Stand tall, soldier."
	)

/datum/skill/combat/maces
	name = "Maces"
	dreams = list(
		"...you dream of power. Your body leaves and fails you, and still you hear the still creaking and slow snapping of bone and sinew. Something screams. Someone breaks. You bring the club down on it, anyways. Subdue the regret. Dust yourself off - keep going! You'll shirk your brutality in your next life, where you don't make mistakes. Do what you can with this one, while you're still alive. It's the least you can do, killer."
	)

/datum/skill/combat/axes
	name = "Axes"
	dreams = list(
		"...you dream of the wild. You bring your axe into a tree, and it bleeds. You bring your axe down into the earth, and it bleeds. You bring your axe down on a shape, and... everything slows down. Your senses sharpen. The deep, dark canopies of the bog suddenly seem... beautiful, in its own way. Like there's a whole life out there, waiting for you. The axe finishes its course, embedding itself in... something that matters less to you, now. Your instincts sharpen as you wake up. Your soul calls for something more."
	)

/datum/skill/combat/whipsflails
	name = "Whips & Flails"
	dreams = list(
		"..."
	)

/datum/skill/combat/bows
	name = "Archery"
	dreams = list(
		"...you dream of focus. You are the eye of the eye of the needle, letting your breathing down as you calculate distance. The line between you and your target shortens as you draw back the bowstring. You put a little bit of your soul into every shot you fire, a little bit of love sent with each great shock of grace and brutality in equal measure. The dream ends abruptly as it cracks and sputters, reeling from the shock of catching an arrow in its neck. If you can kill your own dream, you can kill *anything*. Just be sure to place your arrows carefully, hotshot."
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
		"..."
	)
