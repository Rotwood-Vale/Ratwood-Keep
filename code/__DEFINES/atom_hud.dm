//for antag huds. these are used at the /mob level
#define ANTAG_HUD		"23"

//by default everything in the hud_list of an atom is an image
//a value in hud_list with one of these will change that behavior
#define HUD_LIST_LIST 1

//data HUD (medhud, sechud) defines
//Don't forget to update human/New() if you change these!

#define ANTAG_HUD_REV		1 //peasant reb
#define ANTAG_HUD_TRAITOR 	2 //zizocult
#define ANTAG_HUD_VAMPIRE	3
#define ROGUE_HUD_MARRIED	4

// Notification action types
#define NOTIFY_JUMP "jump"
#define NOTIFY_ATTACK "attack"
#define NOTIFY_ORBIT "orbit"

/// cooldown for being shown the images for any particular data hud
#define ADD_HUD_TO_COOLDOWN 20
