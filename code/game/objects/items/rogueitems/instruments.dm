
/datum/looping_sound/instrument
	mid_sounds = list('sound/blank.ogg')
	mid_length = 2400 // 4 minutes for some reason. better would be each song having a specific length
	volume = 100
	extra_range = 5
	persistent_loop = TRUE
	var/stress2give = /datum/stressevent/music
	sound_group = /datum/sound_group/instruments //reserves sound channels for up to 10 instruments at a time

/obj/item/rogue/instrument
	name = ""
	desc = ""
	icon = 'icons/roguetown/items/music.dmi'
	icon_state = ""
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_BACK_R|ITEM_SLOT_BACK_L
	can_parry = TRUE
	force = 23
	throwforce = 7
	throw_range = 4
	var/lastfilechange = 0
	var/curvol = 100
	var/datum/looping_sound/instrument/soundloop
	var/list/song_list = list()
	var/note_color = "#7f7f7f"
	var/groupplaying = FALSE
	var/curfile = ""
	var/playing = FALSE

	// -- the below is for tetris inventory
	// grid_height = 64
	// grid_width = 32

/obj/item/rogue/instrument/equipped(mob/living/user, slot, initial, silent)
	. = ..()
	if(playing && user.get_active_held_item() != src)
		playing = FALSE
		groupplaying = FALSE
		soundloop.stop()
		user.remove_status_effect(/datum/status_effect/buff/playing_music)

/obj/item/rogue/instrument/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.4,"sx" = 0,"sy" = 2,"nx" = 1,"ny" = -4,"wx" = -1,"wy" = 2,"ex" = 7,"ey" = 1,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = -2,"eturn" = -2,"nflip" = 8,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/rogue/instrument/Initialize()
	soundloop = new(src, FALSE)
	. = ..()

/obj/item/rogue/instrument/Destroy()
	qdel(soundloop)
	. = ..()

/obj/item/rogue/instrument/dropped(mob/living/user, silent)
	..()
	groupplaying = FALSE
	playing = FALSE
	if(soundloop)
		soundloop.stop()
		user.remove_status_effect(/datum/status_effect/buff/playing_music)

/obj/item/rogue/instrument/attack_self(mob/living/user)
	var/stressevent = /datum/stressevent/music
	. = ..()
	if(.)
		return
	user.changeNext_move(CLICK_CD_MELEE)
	if(playing)
		playing = FALSE
		groupplaying = FALSE
		soundloop.stop()
		user.remove_status_effect(/datum/status_effect/buff/playing_music)
		return
	else
		if(user.get_inactive_held_item())
			to_chat(user, span_warning("You need your other hand free to play."))

		var/playdecision = alert(user, "Would you like to start a band?", "Band Play", "Yes", "No")
		switch(playdecision)
			if("Yes")
				groupplaying = TRUE
			if("No")
				groupplaying = FALSE
				
		if(!groupplaying)
			var/list/options = song_list.Copy()
			if(user.mind && user.mind.get_skill_level(/datum/skill/misc/music) >= 4)
				options["Upload New Song"] = "upload"
			
			var/choice = input(user, "Which song?", "Music", name) as null|anything in options
			if(!choice || !user)
				return
				
			if(playing || !(src in user.held_items))
				return
				
			if(choice == "Upload New Song")
				if(lastfilechange && world.time < lastfilechange + 3 MINUTES)
					say("NOT YET!")
					return
				playsound(loc, 'sound/misc/beep.ogg', 100, FALSE, -1)
				var/infile = input(user, "CHOOSE A NEW SONG", src) as null|file

				if(!infile)
					return
				if(playing || !(src in user.held_items) || user.get_inactive_held_item())
					return

				var/filename = "[infile]"
				var/file_ext = lowertext(copytext(filename, -4))
				var/file_size = length(infile)
				message_admins("[ADMIN_LOOKUPFLW(user)] uploaded a song [filename] of size [file_size / 1000000] (~MB).")
				if(file_ext != ".ogg")
					to_chat(user, span_warning("SONG MUST BE AN OGG."))
					return
				if(file_size > 6485760)
					to_chat(user, span_warning("TOO BIG. 6 MEGS OR LESS."))
					return
				lastfilechange = world.time
				fcopy(infile,"data/jukeboxuploads/[user.ckey]/[filename]")
				curfile = file("data/jukeboxuploads/[user.ckey]/[filename]")
				var/songname = input(user, "Name your song:", "Song Name") as text|null
				if(songname)
					song_list[songname] = curfile
				return
			curfile = song_list[choice]
			if(!user || playing || !(src in user.held_items))
				return
			if(user.mind)
				switch(user.mind.get_skill_level(/datum/skill/misc/music))
					if(1)
						stressevent = /datum/stressevent/music
						soundloop.stress2give = stressevent
					if(2)
						note_color = "#ffffff"
						stressevent = /datum/stressevent/music/two
						soundloop.stress2give = stressevent
					if(3)
						note_color = "#1eff00"
						stressevent = /datum/stressevent/music/three
						soundloop.stress2give = stressevent
					if(4)
						note_color = "#0070dd"
						stressevent = /datum/stressevent/music/four
						soundloop.stress2give = stressevent
					if(5)
						note_color = "#a335ee"
						stressevent = /datum/stressevent/music/five
						soundloop.stress2give = stressevent
					if(6)
						note_color = "#ff8000"
						stressevent = /datum/stressevent/music/six
						soundloop.stress2give = stressevent
					else
						soundloop.stress2give = stressevent
			if(!(src in user.held_items))
				return
			if(user.get_inactive_held_item())
				playing = FALSE
				soundloop.stop()
				user.remove_status_effect(/datum/status_effect/buff/playing_music)
				return
			if(curfile)
				playing = TRUE
				soundloop.mid_sounds = list(curfile)
				soundloop.cursound = null
				soundloop.start()
				user.apply_status_effect(/datum/status_effect/buff/playing_music, stressevent, note_color)
			else
				playing = FALSE
				groupplaying = FALSE
				soundloop.stop()
				user.remove_status_effect(/datum/status_effect/buff/playing_music)
		if(groupplaying)
			var/pplnearby =view(7,loc)
			var/list/instrumentsintheband = list()
			var/list/bandmates = list()
			for(var/mob/living/carbon/human/potentialbandmates in pplnearby)
				var/list/thisguyinstrument = list()
				var/obj/item/iteminhand = potentialbandmates.get_active_held_item()
				if(istype(iteminhand, /obj/item/rogue/instrument))
					var/decision = alert(potentialbandmates, "Would you like to perform in a band?", "Band Play", "Yes", "No")
					switch(decision)
						if("No")
							return
						else
							bandmates += potentialbandmates
							instrumentsintheband += iteminhand
							thisguyinstrument += iteminhand
							for(var/obj/item/rogue/instrument/bandinstrumentspersonal in thisguyinstrument)
								if(bandinstrumentspersonal.playing)
									return
								bandinstrumentspersonal.curfile = input(potentialbandmates, "Which song shall [potentialbandmates] perform?", "Music", name) as null|anything in bandinstrumentspersonal.song_list
								bandinstrumentspersonal.curfile = bandinstrumentspersonal.song_list[bandinstrumentspersonal.curfile]
			if(do_after(user, 1))
				for(var/obj/item/rogue/instrument/bandinstrumentsband in instrumentsintheband)
					if(!curfile)
						return
					bandinstrumentsband.playing = TRUE
					bandinstrumentsband.groupplaying = TRUE
					bandinstrumentsband.soundloop.mid_sounds = bandinstrumentsband.curfile
					bandinstrumentsband.soundloop.cursound = null
					bandinstrumentsband.soundloop.start()
					for(var/mob/living/carbon/human/A in bandmates)
						A.apply_status_effect(/datum/status_effect/buff/playing_music, stressevent, note_color)

/obj/item/rogue/instrument/lute
	name = "lute"
	desc = "Its graceful curves were designed to weave joyful melodies."
	icon_state = "lute"
	song_list = list("A Knight's Return" = 'modular/sound/music/instruments/lute (1).ogg',
	"Amongst Fare Friends" = 'modular/sound/music/instruments/lute (2).ogg',
	"The Road Traveled by Few" = 'modular/sound/music/instruments/lute (3).ogg',
	"Tip Thine Tankard" = 'modular/sound/music/instruments/lute (4).ogg',
	"A Reed On the Wind" = 'modular/sound/music/instruments/lute (5).ogg',
	"Jests On Steel Ears" = 'modular/sound/music/instruments/lute (6).ogg',
	"Merchant in the Mire" = 'modular/sound/music/instruments/lute (7).ogg',
	"The Power" = 'modular/sound/music/instruments/lute (8).ogg', //Baldur's Gate 3 Song
	"Bard Dance" = 'modular/sound/music/instruments/lute (9).ogg', //Baldur's Gate 3 Song
	"Old Time Battles" = 'modular/sound/music/instruments/lute (10).ogg') //Baldur's Gate 3 Song

/obj/item/rogue/instrument/accord
	name = "accordion"
	desc = "A harmonious vessel of nostalgia and celebration."
	icon_state = "accordion"
	song_list = list("Her Healing Tears" = 'modular/sound/music/instruments/accord (1).ogg',
	"Peddler's Tale" = 'modular/sound/music/instruments/accord (2).ogg',
	"We Toil Together" = 'modular/sound/music/instruments/accord (3).ogg',
	"Just One More, Tavern Wench" = 'modular/sound/music/instruments/accord (4).ogg',
	"Moonlight Carnival" = 'modular/sound/music/instruments/accord (5).ogg',
	"'Ye Best Be Goin'" = 'modular/sound/music/instruments/accord (6).ogg',
	"Beloved Blue" = 'modular/sound/music/instruments/accord (7).ogg')

/obj/item/rogue/instrument/guitar
	name = "guitar"
	desc = "This is a guitar, chosen instrument of wanderers and the heartbroken." // YIPPEE I LOVE GUITAR
	icon_state = "guitar"
	song_list = list("Fire-Cast Shadows" = 'modular/sound/music/instruments/guitar (1).ogg',
	"The Forced Hand" = 'modular/sound/music/instruments/guitar (2).ogg',
	"Regrets Unpaid" = 'modular/sound/music/instruments/guitar (3).ogg',
	"'Took the Mammon and Ran'" = 'modular/sound/music/instruments/guitar (4).ogg',
	"Poor Man's Tithe" = 'modular/sound/music/instruments/guitar (5).ogg',
	"In His Arms Ye'll Find Me" = 'modular/sound/music/instruments/guitar (6).ogg',
	"El Odio" = 'modular/sound/music/instruments/guitar (7).ogg',
	"Danza De Las Lanzas" = 'modular/sound/music/instruments/guitar (8).ogg',
	"The Feline, Forever Returning" = 'modular/sound/music/instruments/guitar (9).ogg',
	"El Beso Carmesí" = 'modular/sound/music/instruments/guitar (10).ogg',
	"The Queen's High Seas" = 'modular/sound/music/instruments/guitar (11).ogg',
	"Harsh Testimony" = 'modular/sound/music/instruments/guitar (12).ogg',
	"Someone Fair" = 'modular/sound/music/instruments/guitar (13).ogg',
	"Daisies in Bloom" = 'modular/sound/music/instruments/guitar (14).ogg')

/obj/item/rogue/instrument/harp
	name = "harp"
	desc = "A harp of elven craftsmanship."
	icon_state = "harp"
	song_list = list("Through Thine Window, He Glanced" = 'modular/sound/music/instruments/harb (1).ogg',
	"The Lady of Red Silks" = 'modular/sound/music/instruments/harb (2).ogg',
	"Eora Doth Watches" = 'modular/sound/music/instruments/harb (3).ogg',
	"On the Breeze" = 'modular/sound/music/instruments/harb (4).ogg',
	"Never Enough" = 'modular/sound/music/instruments/harb (5).ogg',
	"Sundered Heart" = 'modular/sound/music/instruments/harb (6).ogg',
	"Corridors of Time" = 'modular/sound/music/instruments/harb (7).ogg',
	"Determination" = 'modular/sound/music/instruments/harb (8).ogg')

/obj/item/rogue/instrument/flute
	name = "flute"
	desc = "A row of slender hollow tubes of varying lengths that produce a light airy sound when blown across."
	icon_state = "flute"
	song_list = list("Half-Dragon's Ten Mammon" = 'modular/sound/music/instruments/flute (1).ogg',
	"'The Local Favorite'" = 'modular/sound/music/instruments/flute (2).ogg',
	"Rous in the Cellar" = 'modular/sound/music/instruments/flute (3).ogg',
	"Her Boots, So Incandescent" = 'modular/sound/music/instruments/flute (4).ogg',
	"Moondust Minx" = 'modular/sound/music/instruments/flute (5).ogg',
	"Quest to the Ends" = 'modular/sound/music/instruments/flute (6).ogg',
	"Spit Shine" = 'modular/sound/music/instruments/flute (7).ogg',
	"The Power" = 'modular/sound/music/instruments/flute (8).ogg', //Baldur's Gate 3 Song
	"Bard Dance" = 'modular/sound/music/instruments/flute (9).ogg', //Baldur's Gate 3 Song
	"Old Time Battles" = 'modular/sound/music/instruments/flute (10).ogg') //Baldur's Gate 3 Song

/obj/item/rogue/instrument/drum
	name = "drum"
	desc = "Fashioned from taut skins across a sturdy frame, pulses like a giant heartbeat."
	icon_state = "drum"
	song_list = list("Barbarian's Moot" = 'modular/sound/music/instruments/drum (1).ogg',
	"Muster the Wardens" = 'modular/sound/music/instruments/drum (2).ogg',
	"The Earth That Quakes" = 'modular/sound/music/instruments/drum (3).ogg',
	"The Power" = 'modular/sound/music/instruments/drum (4).ogg', //BG3 Song
	"Bard Dance" = 'modular/sound/music/instruments/drum (5).ogg', // BG3 Song
	"Old Time Battles" = 'modular/sound/music/instruments/drum (6).ogg') // BG3 Song

/obj/item/rogue/instrument/hurdygurdy
	name = "hurdy-gurdy"
	desc = "A knob-driven, wooden string instrument that reminds you of the oceans far."
	icon_state = "hurdygurdy"
	song_list = list("Ruler's One Ring" = 'modular/sound/music/instruments/hurdy (1).ogg',
	"Tangled Trod" = 'modular/sound/music/instruments/hurdy (2).ogg',
	"Motus" = 'modular/sound/music/instruments/hurdy (3).ogg',
	"Becalmed" = 'modular/sound/music/instruments/hurdy (4).ogg',
	"The Bloody Throne" = 'modular/sound/music/instruments/hurdy (5).ogg',
	"We Shall Sail Together" = 'modular/sound/music/instruments/hurdy (6).ogg')

/obj/item/rogue/instrument/viola
	name = "viola"
	desc = "The prim and proper Viola, every prince's first instrument taught."
	icon_state = "viola"
	song_list = list("Far Flung Tale" = 'modular/sound/music/instruments/viola (1).ogg',
	"G Major Cello Suite No. 1" = 'modular/sound/music/instruments/viola (2).ogg',
	"Ursine's Home" = 'modular/sound/music/instruments/viola (3).ogg',
	"Mead, Gold and Blood" = 'modular/sound/music/instruments/viola (4).ogg',
	"Gasgow's Reel" = 'modular/sound/music/instruments/viola (5).ogg',
	"The Power" = 'modular/sound/music/instruments/viola (6).ogg', //BG3 Song, I KNOW THIS ISNT A VIOLIN, LEAVE ME ALONE
	"Bard Dance" = 'modular/sound/music/instruments/viola (7).ogg', // BG3 Song
	"Old Time Battles" = 'modular/sound/music/instruments/viola (8).ogg') // BG3 Song


/obj/item/rogue/instrument/vocals
	name = "vocalist's talisman"
	desc = "This talisman emanates a soft shimmer of light. When held, it can amplify and even change a bard's voice."
	icon_state = "vtalisman"
	song_list = list("Harpy's Call (Feminine)" = 'modular/sound/music/instruments/vocalsf (1).ogg',
	"Necra's Lullaby (Feminine)" = 'modular/sound/music/instruments/vocalsf (2).ogg',
	"Death Touched Aasimar (Feminine)" = 'modular/sound/music/instruments/vocalsf (3).ogg',
	"Our Mother, Our Divine (Feminine)" = 'modular/sound/music/instruments/vocalsf (4).ogg',
	"Wed, Forever More (Feminine)" = 'modular/sound/music/instruments/vocalsf (5).ogg',
	"Paper Boats (Feminine + Vocals)" = 'modular/sound/music/instruments/vocalsf (6).ogg',
	"The Dragon's Blood Surges (Masculine)" = 'modular/sound/music/instruments/vocalsm (1).ogg',
	"Timeless Temple (Masculine)" = 'modular/sound/music/instruments/vocalsm (2).ogg',
	"Angel's Earnt Halo (Masculine)" = 'modular/sound/music/instruments/vocalsm (3).ogg',
	"A Fabled Choir (Masculine)" = 'modular/sound/music/instruments/vocalsm (4).ogg',
	"A Pained Farewell (Masculine + Feminine)" = 'modular/sound/music/instruments/vocalsx (1).ogg',
	"The Power (Whistling)" = 'modular/sound/music/instruments/vocalsx (2).ogg',
	"Bard Dance (Whistling)" = 'modular/sound/music/instruments/vocalsx (3).ogg',
	"Old Time Battles (Whistling)" = 'modular/sound/music/instruments/vocalsx (4).ogg')
