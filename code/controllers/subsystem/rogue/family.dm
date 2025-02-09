#define REL_TYPE_SPOUSE 1
#define REL_TYPE_SIBLING 2
#define REL_TYPE_PARENT 3
#define REL_TYPE_OFFSPRING 4
#define REL_TYPE_RELATIVE 5

SUBSYSTEM_DEF(family)
	name = "family"


	var/list/families = list()
	var/list/used_names = list()
	var/list/used_titles = list()

	var/list/relative_types = list()

	var/list/rel_images = list()

	var/family_candidates = list()

	var/list/special_role_blacklist = list(ROLE_LICH, ROLE_NBEAST) //Special roles that're prevented from having families.


/datum/controller/subsystem/family/fire() //update family icons.
	var/list/old_images = rel_images.Copy()
	for(var/i in old_images)
		var/image/I = i
		I.loc = null
		qdel(I)

	rel_images.Cut()
	for(var/mob/living/carbon/human/H in GLOB.mob_list)
		for(var/mob/living/carbon/human/HH in GLOB.mob_list)
			if(HH == H)
				continue
			if(H.isFamily(HH))
				var/datum/relation/R = H.getRelationship(HH)
				if(!R)
					continue
				var/image/I = image('icons/mob/rel.dmi',HH,icon_state=R.rel_state)
				I.appearance_flags = RESET_TRANSFORM
				H << I
				rel_images += I

/datum/controller/subsystem/family/proc/makeFamily(mob/living/carbon/human/head, name)
	var/i = 0
	while(!name || used_names.Find(name))
		i++
		name = pick(strings("family.json","prefix")) + "-" + pick(strings("family.json","title"))
		if(i == 100)
			name += " the [pick("ill","unfortunate")] lucked" //fallback on the impossible chance it CANNOT make a unique name.

	var/datum/family/F = new()
	// REDMOON ADD START - family_changes - имя семьи
	if(head.family_surname)
		F.name = head.family_surname
	else
	// REDMOON ADD END
		F.name = name
		used_names += name
	F.addMember(head)

	return F

/datum/controller/subsystem/family/proc/SetupFamilies()
	if(!length(family_candidates))
		return
	var/total_families
	var/reserved_family_candidates = family_candidates // REDMOON ADD - family_changes
	var/list/current_families = list()

	var/list/head_candidates = list()
	for(var/c in family_candidates)
		var/mob/living/carbon/human/H = c
		if(H.getorganslot(ORGAN_SLOT_PENIS) && H.family_surname) // REDMOON EDIT - family_changes - фута может образовывать семью WAS if(H.gender == MALE)
			head_candidates += H

	family_candidates = shuffle(family_candidates)
	total_families = max(1,round(length(family_candidates)/2)) //Since we're currently only matching spouses. Just assume we want enough families for groups of two.
	while(total_families && length(head_candidates)) //Construct families.
		var/mob/living/carbon/head = pick(head_candidates)

		if(head)
			var/datum/family/F = makeFamily(head)
			current_families += F
//			family_candidates -= head - REDMOON REMOVAL - family_changes - футы и мужчины учавствуют в выборке
			head_candidates -= head

		total_families--

	can_loop:
		for(var/mob/living/carbon/human/H in family_candidates) //Try and find a suitable family for all candidates. Note. this system is currently only built to match spouses. A more complex system would be needed for full families.
			families = shuffle(current_families)
			for(var/fam in current_families)
				var/datum/family/F = fam
				var/mob/living/carbon/human/connecting_member
				for(var/name in F.members) //Loop through all family members and try and connect H to them.
					connecting_member = F.members[name]:resolve()
					var/rel_type = F.tryConnect(H,connecting_member)
					if(F.checkFamilyCompat(H,connecting_member,rel_type) && F.checkFamilyCompat(connecting_member,H,rel_type)) //suitable. Add them to the family and connect them. (Note using checkFamilyCompat for both falls apart for anything other than spouses. The checks should be moved to a different proc at some point.)
						// BLUEMOON ADD START - family_changes - присвоение фамилий
						H.real_name = "[H.client.prefs.real_name] [connecting_member.family_surname]"
						if(H.family)
							qdel(H.family)
						family_candidates -= connecting_member
						// REDMOON ADD END
						F.addMember(H)
						F.addRel(H,connecting_member,getMatchingRel(rel_type),TRUE)
						F.addRel(connecting_member,H,rel_type,TRUE)

						current_families -= F
						family_candidates -= H // Remove the matched candidate
						reserved_family_candidates -= H // REDMOON ADD - family_changes
						reserved_family_candidates -= connecting_member // REDMOON ADD - family_changes
						continue can_loop // Continue to next candidate instead of breaking completely

	family_candidates = reserved_family_candidates // REDMOON ADD - family_changes - сюда входят и главы семей и женщины без мужей
	for(var/fam in families) //Remove families with only one member.
		var/datum/family/F = fam
		if(length(F.members) <= 1)
			qdel(F)


/datum/controller/subsystem/family/proc/SetupLordFamily()
	var/datum/family/ruler_family
	var/mob/living/carbon/human/ruler
	var/mob/living/carbon/human/consort //stored separate as they have to be added before the children.
	var/list/children = list()


	for(var/mob/living/carbon/human/H in GLOB.mob_list)
		if(!H.client) //Needed because the preference menu makes dummy humans.
			continue
		var/datum/job/J = SSjob.GetJob(H.job)
		if(!J || !J.ruler_family)
			continue
		if(istype(J,/datum/job/roguetown/ruler))
			if(!ruler)
				ruler = H
				ruler_family = makeFamily(ruler, GLOB.lordsurname)
		else if(istype(J,/datum/job/roguetown/consort))
			consort = H
		else
			children |= H

	if(!ruler_family)
		return

	var/list/family_list = list(consort)

	family_list += children

	for(var/m in family_list)
		if(!m)
			continue
		var/mob/living/carbon/human/H = m

		ruler_family.addMember(H)

		var/datum/job/J = SSjob.GetJob(H.job)
		var/rel_type = J.lord_rel_type
		if(rel_type != REL_TYPE_SPOUSE) //Genitals are already checked when the job is assigned. Ane we ignore both the Lord's & Consort's attraction prefs.
			if(!ruler_family.checkFamilyCompat(H,ruler,J.lord_rel_type)) //They're not suitible for their assigned relation type.
				if(rel_type == REL_TYPE_OFFSPRING && ruler_family.checkFamilyCompat(H,ruler,REL_TYPE_SIBLING)) //Fallback, if they can't be children. Check if they can be siblings.
					rel_type = REL_TYPE_SIBLING
				else
					rel_type = REL_TYPE_RELATIVE

		ruler_family.addRel(H,ruler,rel_type,TRUE)
		ruler_family.addRel(ruler,H,getMatchingRel(rel_type),TRUE)


	for(var/ref in ruler_family.members) //loop through all other members and connect them.
		if(ref == ruler_family.members[1]) //skip the lord.
			continue
		var/mob/living/carbon/human/H = ruler_family.members[ref]:resolve()
		var/datum/relation/H_rel = ruler_family.getTrueRel(ruler,H)

		for(var/ref2 in ruler_family.members)
			if(ref2 == ruler_family.members[1] || ref2 == ref) //skip the lord and first member.
				continue
			var/mob/living/carbon/human/HH = ruler_family.members[ref2]:resolve()
			var/datum/relation/HH_rel = ruler_family.getTrueRel(ruler,HH)

			var/new_rel = REL_TYPE_RELATIVE
			switch(H_rel.rel_type)
				if(REL_TYPE_SPOUSE)
					switch(HH_rel.rel_type)
						if(REL_TYPE_OFFSPRING)
							new_rel = REL_TYPE_PARENT
				if(REL_TYPE_OFFSPRING)
					switch(HH_rel.rel_type)
						if(REL_TYPE_OFFSPRING)
							new_rel = REL_TYPE_SIBLING
						if(REL_TYPE_SPOUSE)
							new_rel = REL_TYPE_OFFSPRING

			ruler_family.addRel(H,HH,new_rel,TRUE)

/datum/family
	var/name = "ERROR"
	var/list/members = list() //Assoc list storing weakrefs to the members. The keys are the members real names.
	var/list/relations = list()
	var/list/member_identity = list() //stores uni_identity of members to compare against.

/datum/family/New()
	SSfamily.families += src

/datum/family/Destroy()
	.=..()
	for(var/N in members)
		if(isnull(N))
			continue
		var/mob/living/carbon/human/H = members[N]:resolve()
		if(H)
			H.family = null

	for(var/rel in relations)
		if(isnull(rel))
			continue
		var/datum/relation/R = rel
		R.holder = null
		R.target = null
		qdel(R)
	SSfamily.families -= src // REDMOON ADD - удаляем пустой weakref

/datum/family/proc/getRelations(mob/living/carbon/human/member, rel_type) //Returns all relations of the specified type.
	var/list/rels = list()
	for(var/datum/relation/R in relations)
		if(R.holder == WEAKREF(member) && (!rel_type || R.rel_type == rel_type))
			rels += R

	return rels


/datum/family/proc/getRel(mob/living/carbon/human/holder, mob/living/carbon/human/target) //Returns relationship shared by holder & target.
	for(var/datum/relation/R in relations)
		if(WEAKREF(holder) == R.holder && members[target.name] == R.target)
			return R

/datum/family/proc/getTrueRel(mob/living/carbon/human/holder, mob/living/carbon/human/target) //Returns true relationship shared by holder & target.
	for(var/datum/relation/R in relations)
		if(WEAKREF(holder) == R.holder && WEAKREF(target) == R.target)
			return R

/datum/family/proc/addRel(mob/living/carbon/human/target, mob/living/carbon/human/holder,rel_type, announce = FALSE) //creates a relation for two members.
	var/datum/relation/R
	var/list/rel_types = typesof(/datum/relation)
	for(var/type in rel_types)
		var/datum/relation/T = type
		if(T::rel_type == rel_type)
			R = new T(holder,target)

	if(!R)
		R = new /datum/relation/relative(holder,target)
	relations += R
	// REDMOON ADD START - family_changes
	// информация в memories. Модулярнее сделать не получилось.
	if(holder.mind)
		holder.mind.store_memory("<b>[target.real_name] ([target.job])</b> is my <b>[R.name]</b>. [target.p_they(TRUE)] is [target.age] [target.dna.species.name].")
	// REDMOON ADD END
	if(announce)
		spawn(1)
			to_chat(holder,"<span class='notice'><b>[target.real_name] ([target.job])</b> is my <b>[R.name]</b>. [target.p_they(TRUE)] is [target.age] [target.dna.species.name]. I remember that.</span>") // REDMOON EDIT - was to_chat(holder,"<span class='notice'>My [R.name], [target.real_name] ([target.dna.species.name], [target.job], [target.age]) is here alongside me.</span>")
			// REDMOON ADD START - family_changes - оповещение об альтернативных гениталиях 
			var/altered_genitals = FALSE
			switch(target.gender)
				if(MALE)
					if(target.getorganslot(ORGAN_SLOT_VAGINA))
						altered_genitals = TRUE
				if(FEMALE)
					if(target.getorganslot(ORGAN_SLOT_PENIS))
						altered_genitals = TRUE
			if(altered_genitals)
				to_chat(holder, "[target.p_their(TRUE)] genitals are... Uncommon.")
			// REDMOON ADD END

		R.onConnect(holder,target) //Bit of hack to have this here. But it stops church marriages from being given rings.

/datum/family/proc/tryConnect(mob/living/carbon/human/target, mob/living/carbon/human/member) //Gets the rel_type for the targets. For now, it only returns spouse.
	return REL_TYPE_SPOUSE


/datum/family/proc/checkFamilyCompat(mob/living/carbon/human/target, mob/living/carbon/human/member, rel_type) //Checks target's suitability for being in a family with the family member.
	switch(rel_type)
		if(REL_TYPE_SPOUSE)
			if(member == target) // REDMOON ADD START - family_changes - из-за того, что глава семьи тоже ролится в списках на семейство, необходимое дополнение
				return FALSE // REDMOON ADD END
			if(!member.client)
				return
			/* REDMOON REMOVAL START - family_changes - мешает проверкам на гениталии ниже
			//Check gender.
			if(!member.client.prefs.family_gender.Find(target.gender))
				return FALSE 
			/ REDMOON REMOVAL END*/

			//Check species.
			if(!member.client.prefs.family_species.Find(target.dna.species.id))
				return FALSE
			/* REDMOON REMOVAL START - family_changes 
			- Перенесено в проверку согласия на гениталии
			//Check sex.
			if(member.gender == target.gender) //Ensure that member & target don't share the same sex.
				return FALSE
			- перенесено ниже, чтобы обходить проверку, если выставлен Ckey
			var/list/age_values = AGE_VALUES
			var/target_value = age_values[target.age]
			var/member_value = age_values[member.age]
			if(max(member_value,target_value) - min(member_value,target_value) > 1) //Too high an age difference.
				return FALSE
			REDMOON REMOVAL END */

			if(HAS_TRAIT(target, TRAIT_NOBLE) && !HAS_TRAIT(member, TRAIT_NOBLE))
				return

			if(HAS_TRAIT(member, TRAIT_NOBLE) && !HAS_TRAIT(target, TRAIT_NOBLE))
				return

			// REDMOON ADD START - family_changes
			// Свадьба без возможности деторождения не поддерживается Эорой
			if((target.getorganslot(ORGAN_SLOT_PENIS) && !target.getorganslot(ORGAN_SLOT_VAGINA)) && (member.getorganslot(ORGAN_SLOT_PENIS) && !member.getorganslot(ORGAN_SLOT_VAGINA)))
				return FALSE
			if((target.getorganslot(ORGAN_SLOT_VAGINA) && !target.getorganslot(ORGAN_SLOT_PENIS)) && (member.getorganslot(ORGAN_SLOT_VAGINA) && !member.getorganslot(ORGAN_SLOT_PENIS)))
				return FALSE

			// только персонажами с нужным CKEY могут быть партнёрами, если он выставлен
			if(member.client.prefs.spouse_ckey)
				if(target.client.ckey == lowertext(member.client.prefs.spouse_ckey))
					return TRUE // Обходится проверка на возраст и допустимые гениталии
				else
					return FALSE

			// Проверка на допустимые гениталии у партнёра
			var/target_genitals = "Male"
			if(target.gender == MALE)
				if(target.getorganslot(ORGAN_SLOT_VAGINA))
					target_genitals = "Cuntboy"
			else if(target.gender == FEMALE)
				if(target.getorganslot(ORGAN_SLOT_PENIS))
					target_genitals = "Futa"
				else
					target_genitals = "Female"

			if(!member.client.prefs.family_genitals.Find(target_genitals))
				return FALSE

			var/list/age_values = AGE_VALUES
			var/target_value = age_values[target.age]
			var/member_value = age_values[member.age]
			if(max(member_value,target_value) - min(member_value,target_value) > 1) //Too high an age difference.
				return FALSE
			// REDMOON ADD END
			return TRUE //suitable.

		if(REL_TYPE_SIBLING)
			var/list/age_values = AGE_VALUES
			var/target_value = age_values[target.age]
			var/member_value = age_values[member.age]
			if(max(member_value,target_value) - min(member_value,target_value) > 1) //Too high an age difference.
				return FALSE

			if(target.dna.species.type != member.dna.species.type)
				return FALSE

			return TRUE

		if(REL_TYPE_RELATIVE)
			return TRUE


		if(REL_TYPE_OFFSPRING)
			var/list/age_values = AGE_VALUES
			var/target_value = age_values[target.age]
			var/member_value = age_values[member.age]
			if(member_value - target_value > 1) //Too high an age difference.
				return FALSE
			var/list/allowed_species = list(member.dna.species.type)

			var/datum/relation/R
			var/mob/living/carbon/human/spouse
			var/list/rel_list = getRelations(member,REL_TYPE_SPOUSE)

			if(length(rel_list))
				R = rel_list[1]

			if(R)
				spouse = members[R.target]:resolve()
			if(spouse)
				if(spouse.dna.species.type != member.dna.species.type) //Parents have different species. Allow half children.
					allowed_species |= member.dna.species.halfchild_types[spouse.dna.species.id]

			if(!target.dna.species.type in allowed_species)
				return FALSE
			return TRUE

		else
			if(istype(target.dna.species,member.dna.species.type)) //Same species? Can always be in a family.
				return TRUE

	return FALSE


proc/getMatchingRel(var/rel_type)
	switch(rel_type)
		if(REL_TYPE_PARENT)
			return REL_TYPE_OFFSPRING
		if(REL_TYPE_OFFSPRING)
			return REL_TYPE_PARENT
		else
			return rel_type

/datum/family/proc/addMember(mob/living/carbon/human/H)
	members[H.real_name] = WEAKREF(H)
	member_identity[H.real_name] = H.dna.uni_identity
	H.family = src
	to_chat(H,"<span class='notice'><big>I'm apart of the [name] family!</big>")

/mob/living/carbon/human
	var/datum/family/family

/datum/family/proc/getHeadMember()
	var/H = getHeadRef():resolve()
	if(!H)
		return
	return H

/datum/family/proc/getHeadRef()
	var/head_name = members[1]
	return members[head_name]


/datum/relation
	var/name
	var/holder //The holder of the relationship.
	var/target //Who the relationship applies to. Example: Holder is husband, target is Wife.
	var/rel_type
	var/rel_state = "rel"

/datum/relation/proc/getName()
	return name


/datum/relation/proc/onConnect(mob/living/carbon/human/holder, mob/living/carbon/human/target)
	return

/datum/relation/New(mob/living/carbon/human/H, mob/living/carbon/human/T)
	holder = WEAKREF(H)
	target = WEAKREF(T)
	name = getName() //Done once to prevent any organ changes from changing the name.

/datum/relation/spouse
	name = "Spouse"
	rel_type = REL_TYPE_SPOUSE
	rel_state = "love"

/datum/relation/spouse/getName()
	var/mob/living/carbon/human/T = target:resolve()
	if(T)
		if(T.gender == MALE)
			if(!T.getorganslot(ORGAN_SLOT_PENIS)) // REDMOON ADD START - family_changes
				return "Spouse" // // REDMOON ADD END - Для кантбоев всё-таки не выставляем "мужа" в роли...
			return "Husband"
		if(T.gender == FEMALE)
			if(T.getorganslot(ORGAN_SLOT_PENIS)) // // REDMOON ADD START - family_changes
				return "Spouse" // REDMOON ADD END - Фута считается парой
			return "Wife"
	return "Spouse"

/datum/relation/spouse/onConnect(mob/living/carbon/human/holder, mob/living/carbon/human/target)
	var/datum/job/holder_job = SSjob.GetJob(holder.job)

	// Only give rings to non-baron/consort spouses.
	if(istype(holder_job, /datum/job/roguetown/ruler) || istype(holder_job, /datum/job/roguetown/consort))
		return

	// Handle existing rings before equipping new one
	if(holder.wear_ring)
		// Try to store in belt first
		var/obj/item/storage/belt = holder.get_item_by_slot(SLOT_BELT)
		if(istype(belt) && SEND_SIGNAL(belt, COMSIG_TRY_STORAGE_INSERT, holder.wear_ring, holder))
			to_chat(holder, span_notice("I store my old ring in my belt."))
		else
			// Try backpack slots if belt storage fails
			var/obj/item/storage/backpack/backr = holder.get_item_by_slot(SLOT_BACK_R)
			if(istype(backr) && SEND_SIGNAL(backr, COMSIG_TRY_STORAGE_INSERT, holder.wear_ring, holder))
				to_chat(holder, span_notice("I store my old ring in my right backpack."))
			else
				var/obj/item/storage/backpack/backl = holder.get_item_by_slot(SLOT_BACK_L)
				if(istype(backl) && SEND_SIGNAL(backl, COMSIG_TRY_STORAGE_INSERT, holder.wear_ring, holder))
					to_chat(holder, span_notice("I store my old ring in my left backpack."))
				else
					holder.dropItemToGround(holder.wear_ring)
					to_chat(holder, span_warning("I had to drop my old ring."))


/datum/relation/sibling
	name = "Sibling"
	rel_type = REL_TYPE_SIBLING

/datum/relation/sibling/getName()
	var/mob/living/carbon/human/T = target:resolve()
	if(T)
		if(T.gender == MALE)
			return "Brother"
		if(T.gender == FEMALE)
			return "Sister"
	return "Sibling"


/datum/relation/parent
	name = "Parent"
	rel_type = REL_TYPE_PARENT

/datum/relation/parent/getName()
	var/mob/living/carbon/human/T = target:resolve()
	if(T)
		if(T.gender == MALE)
			return "Father"
		if(T.gender == FEMALE)
			return "Mother"
	return "Parent"


/datum/relation/offspring
	name = "Child"
	rel_type = REL_TYPE_OFFSPRING

/datum/relation/offspring/getName()
	var/mob/living/carbon/human/T = target:resolve()
	if(T)
		if(T.getorganslot(ORGAN_SLOT_PENIS))
			return "Son"
		if(T.getorganslot(ORGAN_SLOT_VAGINA))
			return "Daughter"
	return "Child"

/datum/relation/relative
	name = "Relative"
	rel_type = REL_TYPE_RELATIVE
	rel_state = "rel2"

/mob/living/carbon/human/proc/getFamily(true_family = FALSE)//Returns the family src belongs to. By default. We use our names + DNA to support people pretending to be family members. Use true_family if you wish to get their ACTUAL family.
	if(true_family)
		return family
	for(var/f in SSfamily.families)
		if(isnull(f))
			continue
		var/datum/family/F = f
		if(F.members.Find(name) && dna.uni_identity == family.member_identity[target.name])
			return F


/mob/living/carbon/human/proc/isFamily(var/mob/living/carbon/human/target, true_family = FALSE) //Checks if target is in our family. By default. We use our names + DNA to support people pretending to be family members. Use true_family if you wish to check if they ACTUALLY belong to the family.
	if(!family)
		return FALSE

	if(true_family)
		return target.family == family

	if(family.members[target.name] != null) //Name has the advantage of supporting masked humans + future cases like stealing identities.
		if(target.dna.uni_identity == family.member_identity[target.name])
			return TRUE
	return FALSE

/mob/living/carbon/human/proc/getRelationship(mob/living/carbon/human/target)
	if(!family)
		return

	if(!family.members.Find(target.name) || target.dna.uni_identity != family.member_identity[target.name])  //Name has the advantage of supporting masked humans + future cases like stealing identities.
		return

	return family.getRel(src,target)


