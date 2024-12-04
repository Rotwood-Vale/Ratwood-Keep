// Overhauled vore system
#define DM_HOLD "Hold"
#define DM_DIGEST "Digest"
#define DM_NOISY "Noisy"
#define DM_DRAGON "Dragon"

#define DIGESTABLE 		(1<<0)
#define SHOW_VORE_PREFS (1<<1)
#define DEVOURABLE		(1<<2)
#define FEEDING			(1<<3)
#define NO_VORE			(1<<4)
#define OPEN_PANEL		(1<<5)
#define ABSORBED		(1<<6)
#define VORE_INIT		(1<<7)
#define VOREPREF_INIT	(1<<8)
#define LICKABLE		(1<<9)

#define MAX_VORE_FLAG	(1<<10)-1 // change this whenever you add a vore flag, must be largest vore flag*2-1

#define isbelly(A) istype(A, /obj/belly)
#define QDEL_NULL_LIST(x) if(x) { for(var/y in x) { qdel(y) } ; x = null }
#define VORE_STRUGGLE_EMOTE_CHANCE 40

// Stance for hostile mobs to be in while devouring someone.
#define HOSTILE_STANCE_EATING	99

/* // removing sizeplay again
GLOBAL_LIST_INIT(player_sizes_list, list("Macro" = SIZESCALE_HUGE, "Big" = SIZESCALE_BIG, "Normal" = SIZESCALE_NORMAL, "Small" = SIZESCALE_SMALL, "Tiny" = SIZESCALE_TINY))
// Edited to make the new travis check go away
*/

GLOBAL_LIST_INIT(pred_vore_sounds, list(
		"Gulp" = 'modular_causticcove/sound/vore/pred/swallow_01.ogg',
		"Swallow" = 'modular_causticcove/sound/vore/pred/swallow_02.ogg',
		"Insertion1" = 'modular_causticcove/sound/vore/pred/insertion_01.ogg',
		"Insertion2" = 'modular_causticcove/sound/vore/pred/insertion_02.ogg',
		"Tauric Swallow" = 'modular_causticcove/sound/vore/pred/taurswallow.ogg',
		"Stomach Move"		= 'modular_causticcove/sound/vore/pred/stomachmove.ogg',
		"Schlorp" = 'modular_causticcove/sound/vore/pred/schlorp.ogg',
		"Squish1" = 'modular_causticcove/sound/vore/pred/squish_01.ogg',
		"Squish2" = 'modular_causticcove/sound/vore/pred/squish_02.ogg',
		"Squish3" = 'modular_causticcove/sound/vore/pred/squish_03.ogg',
		"Squish4" = 'modular_causticcove/sound/vore/pred/squish_04.ogg',
		"Rustle (cloth)" = 'modular_causticcove/sound/effects/rustle5.ogg',
		"Rustle 2 (cloth)"	= 'modular_causticcove/sound/effects/rustle2.ogg',
		"Rustle 3 (cloth)"	= 'modular_causticcove/sound/effects/rustle3.ogg',
		"Rustle 4 (cloth)"	= 'modular_causticcove/sound/effects/rustle4.ogg',
		"Rustle 5 (cloth)"	= 'modular_causticcove/sound/effects/rustle5.ogg',
		"None" = null
		))

GLOBAL_LIST_INIT(prey_vore_sounds, list(
		"Gulp" = 'modular_causticcove/sound/vore/prey/swallow_01.ogg',
		"Swallow" = 'modular_causticcove/sound/vore/prey/swallow_02.ogg',
		"Insertion1" = 'modular_causticcove/sound/vore/prey/insertion_01.ogg',
		"Insertion2" = 'modular_causticcove/sound/vore/prey/insertion_02.ogg',
		"Tauric Swallow" = 'modular_causticcove/sound/vore/prey/taurswallow.ogg',
		"Stomach Move"		= 'modular_causticcove/sound/vore/prey/stomachmove.ogg',
		"Schlorp" = 'modular_causticcove/sound/vore/prey/schlorp.ogg',
		"Squish1" = 'modular_causticcove/sound/vore/prey/squish_01.ogg',
		"Squish2" = 'modular_causticcove/sound/vore/prey/squish_02.ogg',
		"Squish3" = 'modular_causticcove/sound/vore/prey/squish_03.ogg',
		"Squish4" = 'modular_causticcove/sound/vore/prey/squish_04.ogg',
		"Rustle (cloth)" = 'modular_causticcove/sound/effects/rustle5.ogg',
		"Rustle 2 (cloth)"	= 'modular_causticcove/sound/effects/rustle2.ogg',
		"Rustle 3 (cloth)"	= 'modular_causticcove/sound/effects/rustle3.ogg',
		"Rustle 4 (cloth)"	= 'modular_causticcove/sound/effects/rustle4.ogg',
		"Rustle 5 (cloth)"	= 'modular_causticcove/sound/effects/rustle5.ogg',
		"None" = null
		))

GLOBAL_LIST_INIT(pred_release_sounds, list(
		"Rustle (cloth)" = 'modular_causticcove/sound/effects/rustle1.ogg',
		"Rustle 2 (cloth)" = 'modular_causticcove/sound/effects/rustle2.ogg',
		"Rustle 3 (cloth)" = 'modular_causticcove/sound/effects/rustle3.ogg',
		"Rustle 4 (cloth)" = 'modular_causticcove/sound/effects/rustle4.ogg',
		"Rustle 5 (cloth)" = 'modular_causticcove/sound/effects/rustle5.ogg',
		"Stomach Move" = 'modular_causticcove/sound/vore/pred/stomachmove.ogg',
		"Pred Escape" = 'modular_causticcove/sound/vore/pred/escape.ogg',
		"Splatter" = 'modular_causticcove/sound/effects/splat.ogg',
		"None" = null
		))

GLOBAL_LIST_INIT(prey_release_sounds, list(
		"Rustle (cloth)" = 'modular_causticcove/sound/effects/rustle1.ogg',
		"Rustle 2 (cloth)" = 'modular_causticcove/sound/effects/rustle2.ogg',
		"Rustle 3 (cloth)" = 'modular_causticcove/sound/effects/rustle3.ogg',
		"Rustle 4 (cloth)" = 'modular_causticcove/sound/effects/rustle4.ogg',
		"Rustle 5 (cloth)" = 'modular_causticcove/sound/effects/rustle5.ogg',
		"Stomach Move" = 'modular_causticcove/sound/vore/prey/stomachmove.ogg',
		"Pred Escape" = 'modular_causticcove/sound/vore/prey/escape.ogg',
		"Splatter" = 'modular_causticcove/sound/effects/splat.ogg',
		"None" = null
		))

#define FIRE_PRIORITY_VORE			5

// Flags
#define EATING_NOISES		(1<<0)
#define DIGESTION_NOISES	(1<<1)
#define CIT_TOGGLES_DEFAULT (EATING_NOISES | DIGESTION_NOISES)

//belly sound pref things
#define NORMIE_HEARCHECK 4

#define MAX_TASTE_LEN			40 //lick... vore... ew...

#define COPY_SPECIFIC_BITFIELDS(a,b,flags)\
	do{\
		var/_old = a & ~(flags);\
		var/_cleaned = b & (flags);\
		a = _old | _cleaned;\
	} while(0);
