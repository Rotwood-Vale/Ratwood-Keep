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
				I.flags = RESET_TRANSFORM
				H << I
				rel_images += I


/datum/controller/subsystem/family/proc/SetupFamilies()
	if(!length(family_candidates))
		return
	var/total_families

	var/list/current_families = list()


	family_candidates = shuffle(family_candidates)
	total_families = max(1,round(length(family_candidates)/2)) //Since we're currently only matching spouses. Just assume we want enough families for groups of two.
	while(total_families && length(family_candidates)) //Construct families.
		var/mob/living/carbon/head = pick(family_candidates) //Could be weighted on age. But it doesn't really matter due to a lack of last names.

		if(head)
			var/datum/family/F = new()
			var/family_name
			var/i = 0
			while(!family_name || used_names.Find(family_name))
				family_name = pick(strings("family.json","prefix")) + "-" + pick(strings("family.json","title"))
				if(i == 100)
					family_name += " the [pick("ill","unfortunate")] lucked" //fallback on the impossible chance it CANNOT make a unique name.
			F.name = family_name
			used_names += family_name
			F.addMember(head)
			current_families += F

		total_families--

	for(var/mob/living/carbon/human/H in family_candidates) //Try and find a suitable family for all candidates. Note. this system is currently only built to match spouses. A more complex system would be needed for full families.
		families = shuffle(current_families)
		fam_loop:
			for(var/fam in current_families)
				var/datum/family/F = fam
				var/mob/living/carbon/human/connecting_member
				for(var/name in F.members) //Loop through all family members and try and connect H to them.
					connecting_member = F.members[name]:resolve()
					var/rel_type = F.tryConnect(H,connecting_member)
					if(F.checkFamilyCompat(H,connecting_member,rel_type)) //suitable. Add them to the family and connect them.
						F.addMember(H)
						F.addRel(H,connecting_member,getMatchingRel(rel_type),TRUE)
						F.addRel(connecting_member,H,rel_type,TRUE)

						current_families -= F
						break fam_loop

	for(var/fam in families) //Remove families with only one member.
		var/datum/family/F = fam
		if(length(F.members) <= 1)
			qdel(F)


/datum/controller/subsystem/family/proc/SetupLordFamily()
	var/datum/family/lord_family
	var/mob/living/carbon/human/lord
	var/mob/living/carbon/human/lady //stored separate as they have to be added before the children.
	var/list/children = list()


	for(var/mob/living/carbon/human/H in GLOB.mob_list)
		if(!H.client) //Needed because the preference menu makes dummy humans.
			continue
		var/datum/job/J = SSjob.GetJob(H.job)
		if(!J || !J.lord_family)
			continue
		if(istype(J,/datum/job/roguetown/lord))
			if(!lord)
				lord = H
				lord_family = new()
				lord_family.name = GLOB.lordsurname
				lord_family.addMember(H)
		else if(istype(J,/datum/job/roguetown/lady))
			lady = H
		else
			children |= H

	if(!lord_family)
		return

	var/list/family_list = list(lady)

	family_list += children

	for(var/m in family_list)
		if(!m)
			continue
		var/mob/living/carbon/human/H = m

		lord_family.addMember(H)

		var/datum/job/J = SSjob.GetJob(H.job)
		var/rel_type = J.lord_rel_type
		if(rel_type != REL_TYPE_SPOUSE) //Genitals are already checked when the job is assigned. Ane we ignore both the Lord's & Consort's attraction prefs.
			if(!lord_family.checkFamilyCompat(H,lord,J.lord_rel_type)) //They're not suitible for their assigned relation type.
				if(rel_type == REL_TYPE_OFFSPRING && lord_family.checkFamilyCompat(H,lord,REL_TYPE_SIBLING)) //Fallback, if they can't be children. Check if they can be siblings.
					rel_type = REL_TYPE_SIBLING
				else
					rel_type = REL_TYPE_RELATIVE

		lord_family.addRel(H,lord,rel_type,TRUE)
		lord_family.addRel(lord,H,getMatchingRel(rel_type),TRUE)


	for(var/ref in lord_family.members) //loop through all other members and connect them.
		if(ref == lord_family.members[1]) //skip the lord.
			continue
		var/mob/living/carbon/human/H = lord_family.members[ref]:resolve()
		var/datum/relation/H_rel = lord_family.getTrueRel(lord,H)

		world << "H: [H.real_name] [H_rel.rel_type]"
		for(var/ref2 in lord_family.members)
			if(ref2 == lord_family.members[1] || ref2 == ref) //skip the lord and first member.
				continue
			var/mob/living/carbon/human/HH = lord_family.members[ref2]:resolve()
			var/datum/relation/HH_rel = lord_family.getTrueRel(lord,HH)

			world << "HH: [HH.real_name] [HH_rel.rel_type]"
			var/new_rel = REL_TYPE_RELATIVE
			switch(H_rel.rel_type)
				if(REL_TYPE_SPOUSE)
					switch(HH_rel.rel_type)
						if(REL_TYPE_OFFSPRING)
							new_rel = REL_TYPE_PARENT
				if(REL_TYPE_OFFSPRING)
					switch(HH_rel)
						if(REL_TYPE_OFFSPRING)
							new_rel = REL_TYPE_SIBLING
						if(REL_TYPE_SPOUSE)
							new_rel = REL_TYPE_OFFSPRING

			world << "RESULT:[new_rel]<BR>"
			lord_family.addRel(H,HH,new_rel,TRUE)

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
		var/mob/living/carbon/human/H = members[N]:resolve()
		if(H)
			H.family = null

	for(var/rel in relations)
		var/datum/relation/R = rel
		R.holder = null
		R.target = null
		qdel(R)

/datum/family/proc/getRelations(var/mob/living/carbon/human/member,var/rel_type) //Returns all relations of the specified type.
	var/list/rels = list()
	for(var/datum/relation/R in relations)
		if(R.holder == member && (!rel_type || R.type == rel_type))
			rels += R

	return rels


/datum/family/proc/getRel(var/mob/living/carbon/human/holder,var/mob/living/carbon/human/target) //Returns relationship shared by holder & target.
	for(var/datum/relation/R in relations)
		if(WEAKREF(holder) == R.holder && members[target.name] == R.target)
			return R

/datum/family/proc/getTrueRel(var/mob/living/carbon/human/holder,var/mob/living/carbon/human/target) //Returns true relationship shared by holder & target.
	for(var/datum/relation/R in relations)
		if(WEAKREF(holder) == R.holder && WEAKREF(target) == R.target)
			return R

/datum/family/proc/addRel(var/mob/living/carbon/human/target, var/mob/living/carbon/human/holder,var/rel_type, var/announce = FALSE) //creates a relation for two members.
	var/datum/relation/R
	var/list/rel_types = typesof(/datum/relation)
	for(var/type in rel_types)
		var/datum/relation/T = type
		if(T::rel_type == rel_type)
			R = new T(holder,target)

	if(!R)
		R = new /datum/relation/relative(holder,target)
	relations += R
	if(announce)
		spawn(1)
			to_chat(holder,"<span class='notice'>My [R.name]. [target.real_name] ([target.age]) is here alongside me.</span>")

/datum/family/proc/tryConnect(var/mob/living/carbon/human/target, var/mob/living/carbon/human/member) //Gets the rel_type for the targets. For now, it only returns spouse.
	return REL_TYPE_SPOUSE


/datum/family/proc/checkFamilyCompat(var/mob/living/carbon/human/target, var/mob/living/carbon/human/member, var/rel_type) //Checks target's suitability for being in a family with the family member.
	switch(rel_type)
		if(REL_TYPE_SPOUSE)
			if(!member.client)
				return
			//Check gender.
			if(!member.client.prefs.family_gender.Find(target.gender))
				return FALSE

			//Check species.
			if(!member.client.prefs.family_species.Find(target.dna.species.id))
				return FALSE

			//Check sex.
			for(var/G in list(ORGAN_SLOT_VAGINA,ORGAN_SLOT_PENIS)) //Ensure that member & target don't share the same sex.
				if(member.getorganslot(G) && target.getorganslot(G))
					return FALSE

			var/list/age_values = AGE_VALUES
			var/target_value = age_values[target.age]
			var/member_value = age_values[member.age]
			if(max(member_value,target_value) - min(member_value,target_value) > 1) //Too high an age difference.
				return FALSE

			if(HAS_TRAIT(target, TRAIT_NOBLE) && !HAS_TRAIT(member, TRAIT_NOBLE))
				return

			if(HAS_TRAIT(member, TRAIT_NOBLE) && !HAS_TRAIT(target, TRAIT_NOBLE))
				return

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

/datum/family/proc/addMember(var/mob/living/carbon/human/H)
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

/datum/relation/New(var/mob/living/carbon/human/H,var/mob/living/carbon/human/T)
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
		if(T.getorganslot(ORGAN_SLOT_PENIS))
			return "Husband"
		if(T.getorganslot(ORGAN_SLOT_VAGINA))
			return "Wife"
	return "Spouse"

/datum/relation/sibling
	name = "Sibling"
	rel_type = REL_TYPE_SIBLING

/datum/relation/sibling/getName()
	var/mob/living/carbon/human/T = target:resolve()
	if(T)
		if(T.getorganslot(ORGAN_SLOT_PENIS))
			return "Brother"
		if(T.getorganslot(ORGAN_SLOT_VAGINA))
			return "Sister"
	return "Sibling"


/datum/relation/parent
	name = "Parent"
	rel_type = REL_TYPE_PARENT

/datum/relation/parent/getName()
	var/mob/living/carbon/human/T = target:resolve()
	if(T)
		if(T.getorganslot(ORGAN_SLOT_PENIS))
			return "Father"
		if(T.getorganslot(ORGAN_SLOT_VAGINA))
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

/mob/living/carbon/human/proc/getFamily(var/true_family = FALSE)//Returns the family src belongs to. By default. We use our names + DNA to support people pretending to be family members. Use true_family if you wish to get their ACTUAL family.
	if(true_family)
		return family
	for(var/f in SSfamily.families)
		var/datum/family/F = f
		if(F.members.Find(name) && dna.uni_identity == family.member_identity[target.name])
			return F


/mob/living/carbon/human/proc/isFamily(var/mob/living/carbon/human/target,var/true = FALSE) //Checks if target is in our family. By default. We use our names + DNA to support people pretending to be family members. Use true if you wish to check if they ACTUALLY belong to the family.
	if(!family)
		return FALSE

	if(true)
		return target.family == family

	if(family.members[target.name] != null) //Name has the advantage of supporting masked humans + future cases like stealing identities.
		if(target.dna.uni_identity == family.member_identity[target.name])
			return TRUE
	return FALSE

/mob/living/carbon/human/proc/getRelationship(var/mob/living/carbon/human/target)
	if(!family)
		return

	if(!family.members.Find(target.name) || target.dna.uni_identity != family.member_identity[target.name])  //Name has the advantage of supporting masked humans + future cases like stealing identities.
		return

	return family.getRel(src,target)


