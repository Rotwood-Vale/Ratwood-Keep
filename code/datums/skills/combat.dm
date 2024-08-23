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
		"...A barkeep whistles as he cleans glasses and a drunkard snores, passed out on the counter. The rest of the tavern is focussed on you with bated breath as your dagger darts between your fingers in an impressive display of legerdemain...",
		"...a flash of steel through the sky, and another, and another. Blades pass between your juggling hands as if you were pulling on singular, thick rope...",
		"...you tuck the blade away in your cloak, and offer yourself up for inspection. While small, the invisible blade cannot be parried..."
	)


/datum/skill/combat/swords
	name = "Sword-fighting"
	dreams = list(
		"...your heart beats wildly as your swords clash, you parry your opponent and finish him off with a decisive slash...",
		"...a shining length of ivory steel. A token. A symbol. More than just a weapon. Blood runs thick in the wash-bin. Sparks fly from the grinding stone. You maintain the blade, and it maintains your honour..."
	)

/datum/skill/combat/polearms
	name = "Polearms"
	dreams = list(
	"...the pale volf snaps its jaws, but to no avail. Your weapon has the superior reach, and you jab at it until it bleeds and retreats back into the woods...",
	"...the only thing that makes the humid, fetid bogs tolerable is your trusty polearm. You hook it behind rocks, pull yourself from the mud, and keep up your pace..."
	)

/datum/skill/combat/maces
	name = "Maces"
	dreams = list(
	"...darkness envelops you. You smash, smash and smash again against the walls, terrible banging seizing your hearing. Light cracks through the walls, and with another smash, you are free....",
	"...'I am ineffable. I am unpiercable.' The wicked white gaurdian says. And so, you shatter its skull with your mace, for it was not unbludgeonable...",
	"...The air shakes and buckles under the ever incessant ringing from your harmonic bell toll of death. This is your symphony. Revel in its beauty, and simplicity...",
	"...'This blade is a masterwork of Malum's craftsmanship.' Said the elf, before his head underwent the sudden transformation from brain to pavement decor under the sheer mass of your primordial tool..."
	)

/datum/skill/combat/axes
	name = "Axes"
	dreams = list(
	"...like trees, like bones, the bigger they are, the harder they fall. With a monstrous swing, the skeleton is decapitated and you have saved the town from its evil...",
	"...stuck in the flesh, you rip away at your weapon. It comes loose. Blood splatters across your armor and cloak and the side of your face. Hunting is no easy job, but the old man's teachings are effective...",
	"...your axe comes down, and another tree falls. Sap runs down your face. You are cutting through the forest until it is a thicket, and through the thicket until it is a plains. Only when you look down do you see the cracked bones, the cut flesh, and the mangled faces. The town square has turned crimson...",
	"...The heft of Iron pulls upon your arm. It knows where it wishes to be, all you have to do is guide its fall. Knowing this, your axe feels lighter than you remember...",
	"...despite the insurmountable challenge, you fear nothing, for the axe is thy companion eternal. Problem solving is quite simple, really..."
	)

/datum/skill/combat/whipsflails
	name = "Whips & Flails"
	dreams = list(
	"...the sing-song of your flail through the air awakens something primal, but the down swing of your hand quickly puts it to sleep...",
	"...with a whistle and a snap and a crack, another bruise is left on flesh. You pull the whip back, and strike down again. You will tame them..."
	)

/datum/skill/combat/bows
	name = "Archery"
	dreams = list(
	"...the cold wind on the balcony bristles against your left, so you adjust your aim towards it. Your fingers relax and your bow exhales. Your mark drops to the cobblestone streets below, dead...",
	"...your fingers sting as you let loose another arrow, and it glances off the pale knight's breastplate. You aim at their visor, and pray to whatever gods you hold dear that this one will make it through...",
	"...it takes half a minute for an experienced soldier to reload a crossbow, with the use of specialised pulley systems. You could kill 5 men with 3 arrows in a third of the time..."
	)

/datum/skill/combat/crossbows
	name = "Crossbows"
	dreams = list(
	"...you put your foot down and pull on the string. You give winding the crossbow all your might. It feels like the thing is mocking you, impossible to pull taut. Only when a librarian reminds you to pull from your back, and not your knees, do you make progress...",
	"...this weapon is a deadly marvel of engineering, and all you need to do is aim. You steady your breath and lay your finger upon its trigger, your shot becoming surer by the second..."
	)

/datum/skill/combat/wrestling
	name = "Wrestling"
	dreams = list(
	"...you grab him by the shirt and twist your hand with a mighty shove, working your opponent to the ground. He coughs as he impacts the floor, with an approving smile on his face...",
	"...the dirt gets in your lungs and you can feel your legs quiver. You can't stand. You hear the clanking of plate, and see mighty boots stop in front of you. With a yank at their leg, your would-be killer is brought to the ground..."
	)

/datum/skill/combat/unarmed
	name = "Unarmed"
	dreams = list(
	"...the wet and harsh sound of skin against bone and clattering teeth reaches your ears before your mind processes what just happened. You got knocked out with a mighty blow to the jaw...",
	"...your nails are claws, your hands are weapons, your bones are blades. A silent watcher in pale plate armor nods approvingly at your ferocity..."
	)

/datum/skill/combat/shields
	name = "Shields"
	dreams = list(
	"...a terrible lizard spews fire unto you. And yet, you stand fast, for you wield a tower's worth of metal...",
	"...the half-moon crest upon your shield shines, even in the bright of Astrata's day. You catch a gleam on it, and reflexively pull it upwards. An arrow bounces off..."
	)
