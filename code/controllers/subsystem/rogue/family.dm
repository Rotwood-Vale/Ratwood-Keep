#define REL_TYPE_SPOUSE 1
#define REL_TYPE_SIBLING 2
#define REL_TYPE_PARENT 3
#define REL_TYPE_OFFSPRING 4

SUBSYSTEM_DEF(family)
	name = "family"


	var/list/families = list()
	var/list/prefix_titles = list("prefix")
	var/list/titles = list("title")
	var/list/used_titles = list()

	var/list/relative_types = list()

	var/list/want_family = list()

/datum/controller/subsystem/family/Initialize()
/*
	prefix_titles = string("strings/family.json","prefix")
	titles = string("strings/family.txt","title")
*/

/datum/family
	var/name
	var/list/members = list() //Assoc list storing weakrefs to the members. The keys are the members real names.
	var/list/relations = list()

/datum/family/proc/getRelations(var/mob/living/carbon/human/member,var/rel_type) //Returns all relations of the specified type.
	var/list/rels = list()
	for(var/datum/relation/R in relations)
		if(R.holder == member && R.type == rel_type)
			rels += R

	return rels


/datum/family/proc/checkFamilyCompat(var/mob/living/carbon/human/target, var/mob/living/carbon/human/member, var/rel_type) //Checks target's suitability for being in a family with the family member.
	switch(rel_type)
		if(REL_TYPE_SPOUSE)
			if(!member.client)
				return
			//Check gender.
			if(!member.client.prefs.family_gender.Find(target.gender))
				return FALSE

			//Check species.
			if(!member.client.prefs.family_speices.Find(target.species.id))
				return FALSE

			//Check sex.
			var/has_vag = target.getorganslot(ORGAN_SLOT_VAGINA)
			var/has_penis = target.getorganslot(ORGAN_SLOT_PENIS)
			if(has_penis && has_vag)
				if(!member.client.prefs.family_sex.Find("herm"))
					return FALSE
			if(has_penis)
				if(!member.client.prefs.family_sex.Find("penis"))
					return FALSE
			if(has_vag)
				if(!member.client.prefs.family_sex.Find("vagina"))
					return FALSE

			return TRUE //suitible.


		if(REL_TYPE_OFFSPRING)
			var/list/allowed_species = list(member.species.type)
			var/relation/R = getRelations(member,REL_TYPE_SPOUSE)[1]
			var/mob/living/carbon/human/spouse = resolve(members[R.target])
			if(spouse.species.type != member.species.type) //Parents have different species. Allow half children.
				allowed_species |= member.species.halfchild_type[spouse.species.id]

			if(!target.species.type in allowed_species)
				return FALSE
			return TRUE

		else
			if(istype(target.species,member.species.type)) //Same species? Can always be in a family. (Note: This needs to be changed if mixed race partners shouldn't be allowed to have full race children.)
				return TRUE
			return FALSE

/mob/living/carbon/human
	var/datum/family/family

/datum/family/proc/getHeadMember()
	var/H = resolve(getHeadRef())
	if(!H)
		return
	return H

/datum/family/proc/getHeadRef()
	var/head_name = members[1]
	return members[head_name]

/datum/family/New(var/mob/living/carbon/human/H)



/datum/relation
	var/name
	var/holder //The holder of the relationship.
	var/target //Who the relationship applies to. Example: Holder is husband, target is Wife.
	var/type

/datum/relation/New()


/datum/relation/spouse