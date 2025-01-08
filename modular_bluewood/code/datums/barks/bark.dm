/datum/preferences/random_character()
	. = ..()
	bark_id = pick(GLOB.bark_random_list)
	bark_pitch = BARK_PITCH_RAND(gender)
	bark_variance = BARK_VARIANCE_RAND

//Datums for barks and bark accessories

/datum/bark
	var/name = "Default"
	var/id = "Default"
	var/soundpath //Path for the actual sound file used for the bark

	// Pitch vars. The actual range for a bark is [(pitch - (maxvariance*0.5)) to (pitch + (maxvariance*0.5))]
	// Make absolutely sure to take variance into account when curating a sound for bark purposes.
	var/minpitch = BARK_DEFAULT_MINPITCH
	var/maxpitch = BARK_DEFAULT_MAXPITCH
	var/minvariance = BARK_DEFAULT_MINVARY
	var/maxvariance = BARK_DEFAULT_MAXVARY

	// Speed vars. Speed determines the number of characters required for each bark, with lower speeds being faster with higher bark density
	var/minspeed = BARK_DEFAULT_MINSPEED
	var/maxspeed = BARK_DEFAULT_MAXSPEED

	// Visibility vars. Regardless of what's set below, these can still be obtained via adminbus and genetics. Rule of fun.
	var/list/ckeys_allowed
	var/ignore = FALSE //Controls whether or not this can be chosen in chargen
	var/allow_random = FALSE //Allows chargen randomization to use this. This is mainly to restrict the pool to sounds that fit well for most characters


// So the basic jist of the sound design here: We make use primarily of shorter instrument samples for barks. We would've went with animalese instead, but doing so would've involved quite a bit of overhead to saycode.
// Short instrument samples tend to sound surprisingly nice for barks, being able to be played in rapid succession without being outright obnoxious.
// It isn't just instruments that work well here, however. Anything that works well as a stab? Short attack, no sustain, a decent amount of release? Also works extremely well for barks.

/datum/bark/mutedc2
	name = "Muted String (Low)"
	id = "mutedc2"
	soundpath = 'sound/barks/C2.ogg'
	allow_random = TRUE

/datum/bark/mutedc3
	name = "Muted String (Medium)"
	id = "mutedc3"
	soundpath = 'sound/barks/C3.ogg'
	allow_random = TRUE

/datum/bark/mutedc4
	name = "Muted String (High)"
	id = "mutedc4"
	soundpath = 'sound/barks/C4.ogg'
	allow_random = TRUE

/datum/bark/banjoc3
	name = "Banjo (Medium)"
	id = "banjoc3"
	soundpath = 'sound/barks/Cn3.ogg'
	allow_random = TRUE

/datum/bark/banjoc4
	name = "Banjo (High)"
	id = "banjoc4"
	soundpath = 'sound/barks/Cn4.ogg'
	allow_random = TRUE

/datum/bark/chitter
	name = "Chittery"
	id = "chitter"
	minspeed = 4 //Even with the sound being replaced with a unique, shorter sound, this is still a little too long for higher speeds
	soundpath = 'sound/barks/chitter.ogg'

/datum/bark/chitter/alt
	name = "Chittery Alt"
	id = "chitter2"
	soundpath = 'sound/barks/mothchitter2.ogg'

/datum/bark/moff
	name = "Moff"
	id = "moff"
	soundpath = 'sound/barks/mothsqueak.ogg'

//Undertale
/datum/bark/alphys
	name = "Alphys"
	id = "alphys"
	soundpath = 'sound/barks/voice_alphys.ogg'
	minvariance = 0

/datum/bark/asgore
	name = "Asgore"
	id = "asgore"
	soundpath = 'sound/barks/voice_asgore.ogg'
	minvariance = 0

/datum/bark/flowey
	name = "Flowey (normal)"
	id = "flowey1"
	soundpath = 'sound/barks/voice_flowey_1.ogg'
	minvariance = 0

/datum/bark/flowey/evil
	name = "Flowey (evil)"
	id = "flowey2"
	soundpath = 'sound/barks/voice_flowey_2.ogg'
	minvariance = 0

/datum/bark/papyrus
	name = "Papyrus"
	id = "papyrus"
	soundpath = 'sound/barks/voice_papyrus.ogg'
	minvariance = 0

/datum/bark/ralsei
	name = "Ralsei"
	id = "ralsei"
	soundpath = 'sound/barks/voice_ralsei.ogg'
	minvariance = 0

/datum/bark/toriel
	name = "Toriel"
	id = "toriel"
	soundpath = 'sound/barks/voice_toriel.ogg'
	minvariance = 0
	maxpitch = BARK_DEFAULT_MAXPITCH*2 //Just because if it's high enough you get Asriel's voice

/datum/bark/undyne
	name = "Undyne"
	id = "undyne"
	soundpath = 'sound/barks/voice_undyne.ogg'
	minvariance = 0

/datum/bark/temmie
	name = "Temmie"
	id = "temmie"
	soundpath = 'sound/barks/voice_temmie.ogg'
	minvariance = 0

/datum/bark/susie
	name = "Susie"
	id = "susie"
	soundpath = 'sound/barks/voice_susie.ogg'
	minvariance = 0

/datum/bark/gaster
	name = "Gaster"
	id = "gaster"
	soundpath = 'sound/barks/voice_gaster_1.ogg'
	minvariance = 0

/datum/bark/mettaton
	name = "Mettaton"
	id = "mettaton"
	soundpath = 'sound/barks/voice_metta_1.ogg'
	minvariance = 0

/datum/bark/gen_monster
	name = "Generic Monster 1"
	id = "gen_monster_1"
	soundpath = 'sound/barks/voice_monster1.ogg'
	minvariance = 0

/datum/bark/gen_monster/alt
	name = "Generic Monster 2"
	id = "gen_monster_2"
	soundpath = 'sound/barks/voice_monster2.ogg'
	minvariance = 0

/datum/bark/wilson
	name = "Wilson"
	id = "wilson"
	soundpath = 'sound/barks/wilson_bark.ogg'

/datum/bark/wolfgang
	name = "Wolfgang"
	id = "wolfgang"
	soundpath = 'sound/barks/wolfgang_bark.ogg'
	minspeed = 4
	maxspeed = 10

/datum/bark/woodie
	name = "Woodie"
	id = "woodie"
	soundpath = 'sound/barks/woodie_bark.ogg'
	minspeed = 4
	maxspeed = 10

/datum/bark/wurt
	name = "Wurt"
	id = "wurt"
	soundpath = 'sound/barks/wurt_bark.ogg'

/datum/bark/wx78
	name = "wx78"
	id = "wx78"
	soundpath = 'sound/barks/wx78_bark.ogg'
	minspeed = 3
	maxspeed = 9

/datum/bark/blub
	name = "Blub"
	id = "blub"
	soundpath = 'sound/barks/blub.ogg'

/datum/bark/buwoo
	name = "Buwoo"
	id = "buwoo"
	soundpath = 'sound/barks/buwoo.ogg'

/datum/bark/lizard
	name = "Lizard"
	id = "lizard"
	soundpath = 'sound/barks/lizard.ogg'

/datum/bark/pugg
	name = "Pugg"
	id = "pugg"
	soundpath = 'sound/barks/pugg.ogg'

/datum/bark/radio
	name = "Radio 1"
	id = "radio1"
	soundpath = 'sound/barks/radio.ogg'

/datum/bark/radio/short
	name = "Radio 2"
	id = "radio2"
	soundpath = 'sound/barks/radio2.ogg'

/datum/bark/radio/ai
	name = "Radio (AI)"
	id = "radio_ai"
	soundpath = 'sound/barks/radio_ai.ogg'

/datum/bark/roach //Turkish characters be like
	name = "Roach"
	id = "roach"
	soundpath = 'sound/barks/roach.ogg'

/datum/bark/skelly
	name = "Skelly"
	id = "skelly"
	soundpath = 'sound/barks/skelly.ogg'

/datum/bark/speak
	name = "Speak 1"
	id = "speak1"
	soundpath = 'sound/barks/speak_1.ogg'

/datum/bark/speak/alt1
	name = "Speak 2"
	id = "speak2"
	soundpath = 'sound/barks/speak_2.ogg'

/datum/bark/speak/alt2
	name = "Speak 3"
	id = "speak3"
	soundpath = 'sound/barks/speak_3.ogg'

/datum/bark/speak/alt3
	name = "Speak 4"
	id = "speak4"
	soundpath = 'sound/barks/speak_4.ogg'

/datum/bark/caw
	name = "Caw"
	id = "caw"
	allow_random = TRUE
	soundpath = 'sound/barks/caw.ogg'

/datum/bark/caw/alt1
	name = "Caw 2"
	id = "caw2"
	soundpath = 'sound/barks/caw1.ogg'
	minspeed = 4
	maxspeed = 9

/datum/bark/caw/alt2
	name = "Caw 3"
	id = "caw3"
	soundpath = 'sound/barks/caw2.ogg'
	minspeed = 3
	maxspeed = 9

/datum/bark/caw/alt3
	name = "Caw 4"
	id = "caw4"
	soundpath = 'sound/barks/caw3.ogg'
	minspeed = 3
	maxspeed = 9

/datum/bark/ehh
	name = "Ehh 1"
	id = "ehh1"
	soundpath = 'sound/barks/ehh.ogg'
	minspeed = 3
	maxspeed = 9

/datum/bark/ehh/alt1
	name = "Ehh 2"
	id = "ehh2"
	soundpath = 'sound/barks/ehh2.ogg'

/datum/bark/ehh/alt2
	name = "Ehh 3"
	id = "ehh3"
	soundpath = 'sound/barks/ehh3.ogg'

/datum/bark/ehh/alt3
	name = "Ehh 4"
	id = "ehh4"
	soundpath = 'sound/barks/ehh4.ogg'
	minspeed = 3
	maxspeed = 9

/datum/bark/ehh/alt5
	name = "Ehh 5"
	id = "ehh5"
	soundpath = 'sound/barks/ehh5.ogg'

/datum/bark/eugh
	name = "Eugh"
	id = "eugh"
	soundpath = 'sound/barks/eugh.ogg'
	minspeed = 6
	maxspeed = 11

/datum/bark/faucet
	name = "Faucet 1"
	id = "faucet1"
	soundpath = 'sound/barks/faucet.ogg'

/datum/bark/faucet/alt1
	name = "Faucet 2"
	id = "faucet2"
	soundpath = 'sound/barks/faucet2.ogg'

/datum/bark/growl
	name = "Growl 1"
	id = "growl1"
	soundpath = 'sound/barks/growl.ogg'
	minspeed = 3
	maxspeed = 9

/datum/bark/growl/alt1
	name = "Growl 2"
	id = "growl2"
	soundpath = 'sound/barks/growl2.ogg'

/datum/bark/hoot
	name = "Hoot"
	id = "hoot"
	soundpath = 'sound/barks/hoot.ogg'
	minspeed = 4
	maxspeed = 9

/datum/bark/moan
	name = "Moan 1"
	id = "moan1"
	soundpath = 'sound/barks/moan1.ogg'
	minspeed = 5
	maxspeed = 9

/datum/bark/moan/alt1
	name = "Moan 2"
	id = "moan2"
	soundpath = 'sound/barks/moan2.ogg'
	minspeed = 4
	maxspeed = 9

/datum/bark/moan/alt2
	name = "Moan 3"
	id = "moan3"
	soundpath = 'sound/barks/moan3.ogg'
	minspeed = 5
	maxspeed = 9

/datum/bark/raah
	name = "Raah 1"
	id = "raah1"
	soundpath = 'sound/barks/raah1.ogg'
	minspeed = 6
	maxspeed = 10

/datum/bark/raah/alt1
	name = "Raah 2"
	id = "raah2"
	soundpath = 'sound/barks/raah2.ogg'
	minspeed = 5
	maxspeed = 9

/datum/bark/slurp
	name = "Slurp"
	id = "slurp"
	soundpath = 'sound/barks/slurp.ogg'

/datum/bark/tweet
	name = "Tweet"
	id = "tweet"
	soundpath = 'sound/barks/tweet.ogg'

/datum/bark/uhm
	name = "Uhm"
	id = "uhm"
	soundpath = 'sound/barks/uhm.ogg'

/datum/bark/ace_blip
	name = "Ace Talk 1"
	id = "acetalk1"
	soundpath = 'sound/barks/aa_blip.ogg'
	allow_random = TRUE
	minspeed = 4
	minvariance = 0

/datum/bark/ace_blip/alt1
	name = "Ace Talk 2"
	id = "acetalk2"
	soundpath = 'sound/barks/aa_dd_blip.ogg'

/datum/bark/ace_blip/alt2
	name = "Ace Talk 3"
	id = "acetalk3"
	soundpath = 'sound/barks/aa_tgaa_blip.ogg'

/datum/bark/ace_typewriter
	name = "Ace Typewriter"
	id = "acewrite"
	soundpath = 'sound/barks/aa_blip_typewriter.ogg'
	minspeed = 4
	minvariance = 0

/datum/bark/nomi
	name = "Nomi"
	id = "nomi"
	soundpath = 'sound/barks/nomi.ogg'
