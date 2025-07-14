/datum/job/roguetown/bandit //pysdon above there's like THREE bandit.dms now I'm so sorry. This one is latejoin bandits, the one in villain is the antag datum, and the one in the 'antag' folder is an old refugee class we don't use. Good luck!
	title = "Bandit"
	flag = BANDIT
	department_flag = FOREIGNERS
	faction = "Station"
	total_positions = 4
	spawn_positions = 4
	antag_job = TRUE
	allowed_races = RACES_VERY_SHUNNED_UP	//Begone foul seelies. Your age of banditry is gone
	tutorial = "Long ago you did a crime worthy of your bounty being hung on the wall outside of the local inn. You now live with your fellow freemen in the bog, and generally get up to no good."
	obfuscated_job = TRUE

	outfit = null
	outfit_female = null

	display_order = JDO_BANDIT
	show_in_credits = FALSE
	announce_latejoin = FALSE
	min_pq = 5
	max_pq = null

	subclass_cat_rolls = list(CTAG_BANDIT = 20)
	PQ_boost_divider = 10

	wanderer_examine = TRUE
	foreign_examine = TRUE
	advjob_examine = TRUE
	always_show_on_latechoices = TRUE
	job_reopens_slots_on_death = FALSE //no endless stream of bandits, unless the migration waves deem it so
	same_job_respawn_delay = 30 MINUTES


	cmode_music = 'sound/music/combat_bandit2.ogg'

/datum/job/roguetown/bandit/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(L)
		var/mob/living/carbon/human/H = L
		if(!H.mind)
			return
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")
		H.ambushable = FALSE

/datum/outfit/job/roguetown/bandit/post_equip(mob/living/carbon/human/H)
	..()
	var/datum/antagonist/new_antag = new /datum/antagonist/bandit()
	H.mind.add_antag_datum(new_antag)
	if(!SSrole_class_handler.bandits_in_round)
		SSrole_class_handler.bandits_in_round = TRUE
	addtimer(CALLBACK(H, TYPE_PROC_REF(/mob/living/carbon/human, choose_name_popup), "BANDIT"), 5 SECONDS)


/*BANDIT DESIGN GOALS:

Minor antagonist meant to abduct, ransom, pillage and steal from the people. Fill in periods of calm with trouble, giving work to guards.
Main points: 5 stat total, Journeyman skill for main weapons (Bow/crossbows get expert until bow draw time is rebalanced properly.)
Meant to be better statted then vanguard but same skill level. Vanguard has better starting gear, but bandits can earn much better gear more reliably, and get even more stats.

Brigand:3 str, 2 end, 2 con 1 per, -3 INT
Foresworn: 2 str, 2 end 2 con, 2 spd -3 INT
Hedgeknight: 4 str, 2 end 2 con -1 spd
Knave: 1 str, 1 con 2 per 2 spd, -3 INT (+2 spd if dagger) (+1 str +1 per if sword/bow)
Sawbones: 1 str 2 int 1 spd 1 fortune
Bandit Mage: 1 str, 2 int, 1 end, 1 spd
*/
