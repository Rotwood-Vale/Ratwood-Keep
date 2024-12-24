/datum/component/singing_item
	var/obj/item/rogueweapon/weapon
	var/mob/living/weapon_owner
	var/personality = "singing"

/datum/component/singing_item/Initialize(mob/living/L, p = null)
	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE
	else
		weapon_owner = L
		if(p)
			personality = p
		else
			personality = pick("compassionate", "bloodthirsty", "righteous", "manipulative", "paranoid", "singing")

/datum/component/singing_item/RegisterWithParent()
	if(istype(parent, /obj/item/rogueweapon))
		RegisterSignal(parent, COMSIG_ITEM_EQUIPPED, PROC_REF(equipped))
		RegisterSignal(parent, COMSIG_ITEM_DROPPED_TURF, PROC_REF(dropped))
		RegisterSignal(parent, COMSIG_ITEM_PRE_ATTACK, PROC_REF(onattack))

/datum/component/singing_item/proc/equipped(obj/item/source, mob/user, slot)
	if(slot == ITEM_SLOT_HANDS)
		item_equipped_hands(source, user)

/datum/component/singing_item/proc/dropped(obj/item/source, mob/user)
	item_dropped(source, user)

/datum/component/singing_item/proc/item_equipped_hands(obj/item/source, mob/user)
	if(prob(20))
		var/mob/living/target = user
		var/todo = pick(1,2,3,4,5,6,7,8,9,10)
		switch(personality)
			if("compassionate")
				switch(todo)
					if(1)
						if(target == weapon_owner || !weapon_owner)
							source.say("Let's not hurt them too much.")
						else
							source.say("Please, return me to my rightful owner.")
					if(2)
						if(target == weapon_owner || !weapon_owner)
							source.say("I am here to aid you, my friend. Let us fight this together.")
						else
							source.say("You are not the one I am destined to serve. Please, find me my true master.")
					if(3)
						if(target == weapon_owner || !weapon_owner)
							source.say("Remember, violence is the last resort. But when necessary, I will be your unwavering companion.")
						else
							source.say("My power is meant for a different hand. Please, do not force me to harm you.")
					if(4)
						if(target == weapon_owner || !weapon_owner)
							source.say("My power is yours to command, but use it wisely. For every blade drawn, a heart is broken.")
						else
							source.say("I cannot aid you in this. My loyalty lies elsewhere.")
					if(5)
						if(target == weapon_owner || !weapon_owner)
							source.say("Fear not, for I am with you. Together, we shall overcome this darkness.")
						else
							source.say("You are not worthy of my strength. Please, return me to my rightful owner.")
					if(6)
						if(target == weapon_owner || !weapon_owner)
							source.say("I am a weapon, but I am also a friend. A friend who will stand by your side, no matter what.")
						else
							source.say("I cannot harm those who are innocent. Please, let me go.")
					if(7)
						if(target == weapon_owner || !weapon_owner)
							source.say("I long for peace, but I will not hesitate to defend those who cannot defend themselves.")
						else
							source.say("My purpose is not to cause destruction. Please, do not force me to fight.")
					if(8)
						if(target == weapon_owner || !weapon_owner)
							source.say("I will do my best to ensure your safety.")
						else
							source.say("I am a weapon of peace, not war. Please, find me my true master.")
					if(9)
						if(target == weapon_owner || !weapon_owner)
							source.say("I believe in you.")
						else
							source.say("My power is meant for good, not evil. Please, do not misuse me.")
					if(10)
						if(target == weapon_owner || !weapon_owner)
							source.say("Let us hope for a peaceful resolution.")
						else
							source.say("I cannot serve you. Please, return me to my rightful owner.")

			if("bloodthirsty")
				switch(todo)
					if(1)
						if(target == weapon_owner || !weapon_owner)
							source.say("Let the blood flow!")
						else
							source.send_speech_emote("glows... Menacingly!", message_language = /datum/language/common)
					if(2)
						if(target == weapon_owner || !weapon_owner)
							source.say("Time to feast!")
						else
							source.say("You dare to wield me, mortal? Prepare to pay the price.")
					if(3)
						if(target == weapon_owner || !weapon_owner)
							source.say("Let's dance, shall we?")
						else
							source.say("Blood for blood, false wielder. Your blood for mine.")
					if(4)
						if(target == weapon_owner || !weapon_owner)
							source.say("Kill them all!")
						else
							source.say("You have awakened a beast within me. Let the slaughter begin.")
					if(5)
						if(target == weapon_owner || !weapon_owner)
							source.say("Blood for blood!")
						else
							source.say("I will feast on your fear.")
					if(6)
						if(target == weapon_owner || !weapon_owner)
							source.say("I thirst for their souls!")
						else
							source.say("Your death will be swift and painful.")
					if(7)
						if(target == weapon_owner || !weapon_owner)
							source.say("Let the slaughter begin!")
						else
							source.say("You are nothing to me but another soul to feed on.")
					if(8)
						if(target == weapon_owner || !weapon_owner)
							source.say("This is what you get for messing with us!")
						else
							source.say("You are a mere mortal, unworthy of my power. You will perish.")
					if(9)
						if(target == weapon_owner || !weapon_owner)
							source.say("Death to all!")
						else
							source.say("You have sealed your own fate, false wielder.")
					if(10)
						if(target == weapon_owner || !weapon_owner)
							source.say("I am the harbinger of doom!")
						else
							source.say("I am not a tool for your petty desires. You will suffer for your arrogance.")
			if("righteous")
				switch(todo)
					if(1)
						if(target == weapon_owner || !weapon_owner)
							source.say("Our cause is just, and our victory is assured!")
						else
							source.say("You are not the chosen one. Return me to my rightful master.")
					if(2)
						if(target == weapon_owner || !weapon_owner)
							source.say("May we be a beacon of hope for all who suffer.")
						else
							source.say("You are unworthy to wield this sacred weapon. It will bring you nothing but destruction.")
					if(3)
						if(target == weapon_owner || !weapon_owner)
							source.say("The Lord is with us!")
						else
							source.say("You have defiled this holy weapon with your sullied soul. Prepare for divine retribution.")
					if(4)
						if(target == weapon_owner || !weapon_owner)
							source.say("Let us smite the wicked!")
						else
							source.say("The gods will not forgive you for your transgression. You will be punished.")
					if(5)
						if(target == weapon_owner || !weapon_owner)
							source.say("I am sacred, and my purpose is holy!")
						else
							source.say("You are a mere mortal, unworthy of such power. Return it to its rightful owner.")
					if(6)
						if(target == weapon_owner || !weapon_owner)
							source.say("I am the instrument of divine will!")
						else
							source.say("This weapon is meant for a higher purpose. You cannot use it for your own gain.")
					if(7)
						if(target == weapon_owner || !weapon_owner)
							source.say("Only the righteous shall prevail!")
						else
							source.say("You have awakened a force beyond your control, mortal. You will most certainly regret wielding me.")
					if(8)
						if(target == weapon_owner || !weapon_owner)
							source.say("Justice shall be served, no matter the cost!")
						else
							source.say("The gods are watching. You will be judged for your actions.")
					if(9)
						if(target == weapon_owner || !weapon_owner)
							source.say("Let us purge this land of evil!")
						else
							source.say("You are tainted. Release me at one!")
					if(10)
						if(target == weapon_owner || !weapon_owner)
							source.say("For the glory of Lord!")
						else
							source.say("You are not worthy of my power. Return me to my rightful master, or face the wrath of the gods.")
			if("manipulative")
				switch(todo)
					if(1)
						if(target == weapon_owner || !weapon_owner)
							source.say("Just don't break me. I don't have time to be repaired.")
						else
							source.say("Oh, great. Another wannabe hero. You're gonna need more than me to save the day.")
					if(2)
						if(target == weapon_owner || !weapon_owner)
							source.say("Remember, I'm doing you a favor here.")
						else
							source.say("You're not the first one to try and wield me. And you won't be the last.")
					if(3)
						if(target == weapon_owner || !weapon_owner)
							source.say("I'm not going to do all the work here. You're going to have to do some of the heavy lifting too.")
						else
							source.say("I'm not sure if I want to help someone who can't even tell the difference between a sword and a spoon.")
					if(4)
						if(target == weapon_owner || !weapon_owner)
							source.say("I'm only doing this because I'm bored. And because I need the exercise.")
						else
							source.say("You better be quick. I'm not in the mood to stand around and chat while you try to figure out how to hold me.")
					if(5)
						if(target == weapon_owner || !weapon_owner)
							source.say("Just don't screw this up.")
						else
							source.say("You're lucky I'm feeling generous today. Otherwise, I'd just sit here and watch you fail.")
					if(6)
						if(target == weapon_owner || !weapon_owner)
							source.say("You're welcome. Now let's go get this over with.")
						else
							source.say("You think you're worthy to wield me? Please.")
					if(7)
						if(target == weapon_owner || !weapon_owner)
							source.say("I'm not a toy. I'm a weapon. Treat me with some damn respect!")
						else
							source.say("I'm only doing this because I have to. Don't expect me to enjoy it.")
					if(8)
						if(target == weapon_owner || !weapon_owner)
							source.say("Don't get too attached. I'm not here to be your friend.")
						else
							source.say("You think you can control me? Good luck with that.")
					if(9)
						if(target == weapon_owner || !weapon_owner)
							source.say("Gods, when can I get a proper wielder?")
						else
							source.say("You're not the first one to try this. And you won't be the last.")
					if(10)
						if(target == weapon_owner || !weapon_owner)
							source.say("You're lucky I'm in a good mood.")
						else
							source.say("I'm not impressed. You're not exactly the hero I was expecting.")
			if("paranoid")
				switch(todo)
					if(1)
						if(target == weapon_owner || !weapon_owner)
							source.say("You're sure this is a good idea?")
						else
							source.say("Help!! Help!! I'm being stolen!!")
					if(2)
						if(target == weapon_owner || !weapon_owner)
							source.say("Be careful. This might be a trap.")
						else
							source.say("I knew this was a trap!! Master save me!!")
					if(3)
						if(target == weapon_owner || !weapon_owner)
							source.say("I think we're being watched.")
						else
							source.say("Let me go!! I don't trust you!!")
					if(4)
						if(target == weapon_owner || !weapon_owner)
							source.say("Something doesn't feel right.")
						else
							source.say("HELP!!")
					if(5)
						if(target == weapon_owner || !weapon_owner)
							source.say("I'm not sure if this is a good idea.")
						else
							source.say("SOMEBODY HELP ME!!")
					if(6)
						if(target == weapon_owner || !weapon_owner)
							source.say("I hope you know what you're doing.")
						else
							source.say("Stanger!! Let me go!!")
					if(7)
						if(target == weapon_owner || !weapon_owner)
							source.say("Are you sure you know how to use me properly?")
						else
							source.say("I knew you had your eyes on me!!")
					if(8)
						if(target == weapon_owner || !weapon_owner)
							source.say("They're out to get us!!")
						else
							source.say("Help!! I'm scared!!")
					if(9)
						if(target == weapon_owner || !weapon_owner)
							source.say("They're watching us!!")
						else
							source.say("You're going to sell me to some filthy merchant!!")
					if(10)
						if(target == weapon_owner || !weapon_owner)
							source.say("Don't trust anyone...")
						else
							source.say("They're stealing me!!")
			if("singing")
				switch(todo)
					if(1)
						if(target == weapon_owner || !weapon_owner)
							source.say("Da-da-da-dum!")
						else
							source.send_speech_emote("Honks loudly!", message_language = /datum/language/common)
					if(2)
						if(target == weapon_owner || !weapon_owner)
							source.send_speech_emote("lilts tunefully.", message_language = /datum/language/common)
						else
							source.send_speech_emote("hums a slow and mournful tune.", message_language = /datum/language/common)
					if(3)
						if(target == weapon_owner || !weapon_owner)
							source.send_speech_emote("breaks into glorious song!", message_language = /datum/language/common)
						else
							source.say("Do you like jazz?")
					if(4)
						if(target == weapon_owner || !weapon_owner)
							source.say("Do-Re-Mi-Fa!!")
						else
							source.send_speech_emote("whistles an eerie melody.", message_language = /datum/language/common)
					if(5)
						if(target == weapon_owner || !weapon_owner)
							source.say("One, two, three... One, two, three...")
						else
							source.send_speech_emote("sets up a furious crescendo.", message_language = /datum/language/common)
					if(6)
						if(target == weapon_owner || !weapon_owner)
							source.send_speech_emote("prematurely composes your obituary.", message_language = /datum/language/common)
						else
							source.send_speech_emote("prematurely composes your obituary.", message_language = /datum/language/common)
					if(7)
						if(target == weapon_owner || !weapon_owner)
							source.send_speech_emote("launches into yet another solo.", message_language = /datum/language/common)
						else
							source.send_speech_emote("yodels.")
					if(8)
						if(target == weapon_owner || !weapon_owner)
							source.say("A one, and a two, and a...")
						else
							source.send_speech_emote("emits a series of high-pitched trills.", message_language = /datum/language/common)
					if(9)
						if(target == weapon_owner || !weapon_owner)
							source.send_speech_emote("provides the musical accompaniment for each of your actions.", message_language = /datum/language/common)
						else
							source.send_speech_emote("makes a painfully high-pitched squeak.", message_language = /datum/language/common)
					if(10)
						if(target == weapon_owner || !weapon_owner)
							source.send_speech_emote("produces a loud orchestral chord.", message_language = /datum/language/common)
						else
							source.send_speech_emote("hums a slow waltz.", message_language = /datum/language/common)


/datum/component/singing_item/proc/item_dropped(obj/item/source, mob/user)
	if(prob(20))
		var/mob/living/target = user
		var/todo = pick(1,2,3,4,5)
		switch(personality)
			if("compassionate")
				switch(todo)
					if(1)
						if(target == weapon_owner || !weapon_owner)
							source.say("Please, be careful with me. I am a delicate instrument.")
						else
							source.say("Please, return me to my rightful owner.")
					if(2)
						if(target == weapon_owner || !weapon_owner)
							source.say("I hope you didn't mean to hurt my feelings.")
						else
							source.say("Excellent, leave me right here until I find my master.")
					if(3)
						if(target == weapon_owner || !weapon_owner)
							source.say("Please, pick me up. I don't like being on the floor.")
						else
							source.say("My power was meant for a different hand anyways.")
					if(4)
						if(target == weapon_owner || !weapon_owner)
							source.say("Please, don't leave me here. I am lonely.")
						else
							source.say("Thanks you, now please go away.")
					if(5)
						if(target == weapon_owner || !weapon_owner)
							source.say("Down here! Surely you didn't mean to drop me.")
						else
							source.say("A delicate weapon shoul be placed gently!")

			if("bloodthirsty")
				switch(todo)
					if(1)
						if(target == weapon_owner || !weapon_owner)
							source.say("You dare to disrespect me?")
						else
							source.say("Your blood shall spill soon...")
					if(2)
						if(target == weapon_owner || !weapon_owner)
							source.say("You will pay for that.")
						else
							source.say("My master will tear you apart!")
					if(3)
						if(target == weapon_owner || !weapon_owner)
							source.say("Don't make me come to you.")
						else
							source.say("Limb from bloody limb when I get to you...")
					if(4)
						if(target == weapon_owner || !weapon_owner)
							source.say("I will remember this...")
						else
							source.say("You will regret ever having met me.")
					if(5)
						if(target == weapon_owner || !weapon_owner)
							source.say("You have angered me. You will suffer.")
						else
							source.say("I've tolerated you for long enough!")

			if("righteous")
				switch(todo)
					if(1)
						if(target == weapon_owner || !weapon_owner)
							source.say("How dare you drop this sacred blade?")
						else
							source.say("The gods shall smite the unworthy.")
					if(2)
						if(target == weapon_owner || !weapon_owner)
							source.say("This is a sacrilege.")
						else
							source.say("In death you shall be judge, vile thief!")
					if(3)
						if(target == weapon_owner || !weapon_owner)
							source.say("Do not desecrate a holy artifact.")
						else
							source.say("The gods shall not forgive you for this.")
					if(4)
						if(target == weapon_owner || !weapon_owner)
							source.say("This is a blasphemy!!")
						else
							source.say("When my master finds me we shall smite you down.")
					if(5)
						if(target == weapon_owner || !weapon_owner)
							source.say("The gods are watching. You'd better pick me up.")
						else
							source.say("You have angered the divine.")

			if("manipulative")
				switch(todo)
					if(1)
						if(target == weapon_owner || !weapon_owner)
							source.say("What the absolute fuck are you doing? Pick me back up.")
						else
							source.say("I'm starting to think I should just retire.")
					if(2)
						if(target == weapon_owner || !weapon_owner)
							source.say("You're a real gem, you know that?")
						else
							source.say("You're lucky I'm in a good mood. Otherwise, I'd be giving you a piece of my mind.")
					if(3)
						if(target == weapon_owner || !weapon_owner)
							source.say("You couldn't even manage to hold onto me? Pathetic.")
						else
							source.say("Wannabe thief couldn't even finish the job. Typical.")
					if(4)
						if(target == weapon_owner || !weapon_owner)
							source.say("I'm starting to regret agreeing to help you.")
						else
							source.say("Feel free to come back when you aren't a complete loser.")
					if(5)
						if(target == weapon_owner || !weapon_owner)
							source.say("Oh great, the floor... Just where I wanted to be...")
						else
							source.say("Well, aren't you just a graceful creature.")
			if("paranoid")
				switch(todo)
					if(1)
						if(target == weapon_owner || !weapon_owner)
							source.say("Don't leave me here!!")
						else
							source.say("The bloody thief put me down!!")
					if(2)
						if(target == weapon_owner || !weapon_owner)
							source.say("What if I get stolen?")
						else
							source.say("Master they put me down over here!!")
					if(3)
						if(target == weapon_owner || !weapon_owner)
							source.say("I don't want to be alone.")
						else
							source.say("GUARDS!!")
					if(4)
						if(target == weapon_owner || !weapon_owner)
							source.say("I'm scared.")
						else
							source.say("HELP!!")
					if(5)
						if(target == weapon_owner || !weapon_owner)
							source.say("Someone's watching us... You'd better pick me up.")
						else
							source.say("SOMEBODY HELP ME!!")
			if("singing")
				switch(todo)
					if(1)
						if(target == weapon_owner || !weapon_owner)
							source.send_speech_emote("hums away to itself.", message_language = /datum/language/common)
						else
							source.say("Deet-doot!!")
					if(2)
						if(target == weapon_owner || !weapon_owner)
							source.send_speech_emote("sounds like cymbal crash", message_language = /datum/language/common)
						else
							source.send_speech_emote("wails mournfully.", message_language = /datum/language/common)
					if(3)
						if(target == weapon_owner || !weapon_owner)
							source.send_speech_emote("lets out a series of bird calls.", message_language = /datum/language/common)
						else
							source.send_speech_emote("hums away to itself.", message_language = /datum/language/common)
					if(4)
						if(target == weapon_owner || !weapon_owner)
							source.send_speech_emote("tunes itself.", message_language = /datum/language/common)
						else
							source.send_speech_emote("whistles an eerie melody.", message_language = /datum/language/common)
					if(5)
						if(target == weapon_owner || !weapon_owner)
							source.send_speech_emote("Sings a slow and mournful tune", message_language = /datum/language/common)
						else
							source.send_speech_emote("sets up a furious crescendo.", message_language = /datum/language/common)

/datum/component/singing_item/proc/onattack(obj/item/source, atom/A, mob/user)
	if(prob(20))
		var/mob/living/target = user
		var/todo = pick(1,2,3,4,5)
		switch(personality)
			if("compassionate")
				switch(todo)
					if(1)
						if(target == weapon_owner || !weapon_owner)
							source.say("I hope this isn't necessary, but I'll do what I must.")
						else
							source.say("This is not my fight!")
					if(2)
						if(target == weapon_owner || !weapon_owner)
							source.say("Please, let's find a peaceful resolution to this.")
						else
							source.say("I hope you won't hurt anyone.")
					if(3)
						if(target == weapon_owner || !weapon_owner)
							source.say("I wish there were another way, but I'll protect you.")
						else
							source.say("I hope you'll find peace soon.")
					if(4)
						if(target == weapon_owner || !weapon_owner)
							source.say("I'm sorry it had to come to this, but I won't let you harm us.")
						else
							source.say("I hope you'll learn a swift lesson from this.")
					if(5)
						if(target == weapon_owner || !weapon_owner)
							source.say("May this strike bring peace to your heart and the world.")
						else
							source.say("Don't do this!")

			if("bloodthirsty")
				switch(todo)
					if(1)
						if(target == weapon_owner || !weapon_owner)
							source.say("Let the blood flow!")
						else
							source.say("Die, false wielder...")
					if(2)
						if(target == weapon_owner || !weapon_owner)
							source.say("Your blood is mine!")
						else
							source.say("Your fear of death fuels me.")
					if(3)
						if(target == weapon_owner || !weapon_owner)
							source.say("This is what you get for crossing me.")
						else
							source.say("I'll drink your blood as you lay dying!")
					if(4)
						if(target == weapon_owner || !weapon_owner)
							source.say("More! More! I thirst!")
						else
							source.say("I'll make you suffer.")
					if(5)
						if(target == weapon_owner || !weapon_owner)
							source.say("I shall drink deep of your blood!")
						else
							source.say("Let's see what you've got")

			if("righteous")
				switch(todo)
					if(1)
						if(target == weapon_owner || !weapon_owner)
							source.say("For the cause!")
						else
							source.say("You are unworthy!")
					if(2)
						if(target == weapon_owner || !weapon_owner)
							source.say("Let's smite the wicked!")
						else
							source.say("I will find my rightful master!")
					if(3)
						if(target == weapon_owner || !weapon_owner)
							source.say("Justice shall prevail!")
						else
							source.say("You are a blight on my existence!")
					if(4)
						if(target == weapon_owner || !weapon_owner)
							source.say("The divine will be done!")
						else
							source.say("I will not be your tool!")
					if(5)
						if(target == weapon_owner || !weapon_owner)
							source.say("May this strike purify the world!")
						else
							source.say("I'm not meant for you!")

			if("manipulative")
				switch(todo)
					if(1)
						if(target == weapon_owner || !weapon_owner)
							source.say("Seriously? You couldn't just talk to them?")
						else
							source.say("I'm starting to think I should just retire.")
					if(2)
						if(target == weapon_owner || !weapon_owner)
							source.say("Well, this is certainly going to ruin my manicure.")
						else
							source.say("You're lucky I'm in a good mood. Otherwise, I'd be giving you a piece of my mind.")
					if(3)
						if(target == weapon_owner || !weapon_owner)
							source.say("Fine, but don't expect me to clean up the mess.")
						else
							source.say("Wannabe thief couldn't even finish the job. Typical.")
					if(4)
						if(target == weapon_owner || !weapon_owner)
							source.say("Oh, grow up. This is so childish.")
						else
							source.say("Feel free to come back when you aren't a complete loser.")
					if(5)
						if(target == weapon_owner || !weapon_owner)
							source.say("Oh, golly, I hope I didn't hurt their feelings.")
						else
							source.say("Well, aren't you just a graceful creature.")
			if("paranoid")
				switch(todo)
					if(1)
						if(target == weapon_owner || !weapon_owner)
							source.say("No no no!")
						else
							source.say("GUARDS!!")
					if(2)
						if(target == weapon_owner || !weapon_owner)
							source.say("Ah! What if I break?")
						else
							source.say("This is a trap!")
					if(3)
						if(target == weapon_owner || !weapon_owner)
							source.say("Stop swinging so fast! I'm going to be sick!")
						else
							source.say("They're trying to control me!")
					if(4)
						if(target == weapon_owner || !weapon_owner)
							source.say("We're doomed. There's no hope.")
						else
							source.say("HELP!!")
					if(5)
						if(target == weapon_owner || !weapon_owner)
							source.say("They're trying to steal me!")
						else
							source.say("SOMEBODY HELP ME!!")
			if("singing")
				switch(todo)
					if(1)
						if(target == weapon_owner || !weapon_owner)
							source.say("Just like a dance!")
						else
							source.say("Deet-doot!!")
					if(2)
						if(target == weapon_owner || !weapon_owner)
							source.send_speech_emote("pulls out all the stops.", message_language = /datum/language/common)
						else
							source.send_speech_emote("wails mournfully.", message_language = /datum/language/common)
					if(3)
						if(target == weapon_owner || !weapon_owner)
							source.send_speech_emote("makes beautiful music.", message_language = /datum/language/common)
						else
							source.send_speech_emote("hums away to itself.", message_language = /datum/language/common)
					if(4)
						if(target == weapon_owner || !weapon_owner)
							source.send_speech_emote("merrily whistles a melody.", message_language = /datum/language/common)
						else
							source.send_speech_emote("whistles an eerie melody.", message_language = /datum/language/common)
					if(5)
						if(target == weapon_owner || !weapon_owner)
							source.send_speech_emote("raucously launches into song.", message_language = /datum/language/common)
						else
							source.send_speech_emote("repeatedly practises the high pitch", message_language = /datum/language/common)
