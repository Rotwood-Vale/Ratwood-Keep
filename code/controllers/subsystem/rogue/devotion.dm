/// DEFINITIONS ///
#define CLERIC_T0 0
#define CLERIC_T1 1
#define CLERIC_T2 2
#define CLERIC_T3 3

#define CLERIC_REQ_0 0
#define CLERIC_REQ_1 100
#define CLERIC_REQ_2 250
#define CLERIC_REQ_3 500

// Cleric Holder Datums

/datum/devotion/cleric_holder
	var/holder_mob = null
	var/patron = null
	var/devotion = 0
	var/max_devotion = 1000
	var/progression = 0
	var/max_progression = CLERIC_REQ_3
	var/level = CLERIC_T0

/datum/devotion/cleric_holder/New(mob/living/carbon/human/holder, god)
	holder_mob = holder
	holder.cleric = src
	patron = god

/datum/devotion/cleric_holder/proc/check_devotion(req)
	if(abs(req) <= devotion)
		return TRUE
	return FALSE

/datum/devotion/cleric_holder/proc/update_devotion(dev_amt, prog_amt)
	var/datum/patron/P = patron
	devotion += dev_amt
	//Max devotion limit
	if(devotion > max_devotion)
		devotion = max_devotion
		to_chat(holder_mob, "<span class='warning'>I have reached the limit of my devotion...</span>")
	if(!prog_amt) // no point in the rest if it's just an expenditure
		return
	progression = min(progression + prog_amt, max_progression)
	var/obj/effect/spell_unlocked
	switch(level)
		if(CLERIC_T0)
			if(progression >= CLERIC_REQ_1)
				level = CLERIC_T1
				spell_unlocked = P.t1
		if(CLERIC_T1)
			if(progression >= CLERIC_REQ_2)
				level = CLERIC_T2
				spell_unlocked = P.t2
		if(CLERIC_T2)
			if(progression >= CLERIC_REQ_3)
				level = CLERIC_T3
				spell_unlocked = P.t3
	if(spell_unlocked && !usr.mind.has_spell(spell_unlocked))
		spell_unlocked = new spell_unlocked
		to_chat(holder_mob, "<span class='boldnotice'>I have unlocked a new spell: [spell_unlocked]</font>")
		usr.mind.AddSpell(spell_unlocked)

// Devotion Debugs

/mob/living/carbon/human/proc/devotionreport()
	set name = "Check Devotion"
	set category = "Cleric"

	var/datum/devotion/cleric_holder/C = src.cleric
	to_chat(src,"My devotion is [C.devotion].")

/mob/living/carbon/human/proc/devotionchange()
	set name = "(DEBUG)Change Devotion"
	set category = "Special Verbs"

	var/datum/devotion/cleric_holder/C = src.cleric
	var/changeamt = input(src, "My devotion is [C.devotion]. How much to change?", "How much to change?") as null|num
	if(!changeamt)
		return
	C.devotion += changeamt

// Generation Procs

/mob/living/carbon/human/proc/clericpray()
	set name = "Give Prayer"
	set category = "Cleric"
	
	var/datum/devotion/cleric_holder/C = src.cleric
	var/prayersesh = 0

	visible_message("[src] kneels their head in prayer to the Gods.", "I kneel my head in prayer to [patron.name]")
	for(var/i in 1 to 20)
		if(do_after(src, 30))
			if(C.devotion >= C.max_devotion)
				to_chat(src, "<font color='red'>I have reached the limit of my devotion...</font>")
				break
			C.update_devotion(2, 2)
			prayersesh += 2
		else
			visible_message("[src] concludes their prayer.", "I conclude my prayer.")
			to_chat(src, "<font color='purple'>I gained [prayersesh] devotion!</font>")
			return
	to_chat(src, "<font color='purple'>I gained [prayersesh] devotion!</font>")
