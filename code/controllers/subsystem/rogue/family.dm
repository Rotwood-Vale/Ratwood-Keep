#define REL_TYPE_SPOUSE 1
#define REL_TYPE_SIBLING 2
#define REL_TYPE_PARENT 3
#define REL_TYPE_OFFSPRING 4

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
						F.addRel(H,connecting_member,rel_type,TRUE)
						F.addRel(connecting_member,H,rel_type,TRUE)

						current_families -= F
						break fam_loop

	for(var/fam in families) //Remove families with only one member.
		var/datum/family/F = fam
		if(length(F.members) <= 1)
			qdel(F)




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

/datum/family/proc/addRel(var/mob/living/carbon/human/target, var/mob/living/carbon/human/holder,var/rel_type, var/announce = FALSE) //creates a relation for two members.
	var/datum/relation/R
	switch(rel_type)
		if(REL_TYPE_SPOUSE)
			R = new /datum/relation/spouse(holder,target)

	relations += R
	if(announce)
		to_chat(holder,"<span class='notice'>My [R.getName()]. [target.real_name] ([target.age]) is here alongside me.</span>")

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

			return TRUE //suitable.


		if(REL_TYPE_OFFSPRING)
			var/list/allowed_species = list(member.dna.species.type)
			var/datum/relation/R = getRelations(member,REL_TYPE_SPOUSE)[1]
			var/mob/living/carbon/human/spouse = members[R.target]:resolve()
			if(spouse.dna.species.type != member.dna.species.type) //Parents have different species. Allow half children.
				allowed_species |= member.dna.species.halfchild_types[spouse.dna.species.id]

			if(!target.dna.species.type in allowed_species)
				return FALSE
			return TRUE

		else
			if(istype(target.dna.species,member.dna.species.type)) //Same species? Can always be in a family. (Note: This needs to be changed if mixed race partners shouldn't be allowed to have full race children.)
				return TRUE

	return FALSE

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
	var/rel_state = "blood"

/datum/relation/proc/getName()
	return "Name"

/datum/relation/New(var/mob/living/carbon/human/H,var/mob/living/carbon/human/T)
	holder = WEAKREF(H)
	target = WEAKREF(T)


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

/mob/living/carbon/human/proc/getFamily(var/true = FALSE)//Returns the family src belongs to. By default. We use our names + DNA to support people pretending to be family members. Use true if you wish to get their ACTUAL family.
	if(true)
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