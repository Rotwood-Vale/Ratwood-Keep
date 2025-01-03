/datum/slapcraft_recipe/sewing
	abstract_type = /datum/slapcraft_recipe/sewing
	skillcraft = /datum/skill/misc/sewing
	category = SLAP_CAT_SEWING
	subcategory = SLAP_SUBCAT_CLOTHING

/datum/slapcraft_recipe/carpentry
	abstract_type = /datum/slapcraft_recipe/carpentry
	skillcraft = /datum/skill/craft/carpentry
	category = SLAP_CAT_CARPTENTRY

/datum/slapcraft_recipe/carpentry/structure
	abstract_type = /datum/slapcraft_recipe/carpentry/structure
	in_place_craft = TRUE
	subcategory = SLAP_SUBCAT_STRUCTURE
	craftsound = 'sound/foley/Building-01.ogg'

/datum/slapcraft_recipe/carpentry/structure/check_craft_requirements(mob/user, turf/T)
	if(istype(T,/turf/open/transparent/openspace))
		return FALSE
	return ..()

/datum/slapcraft_recipe/carpentry/item
	abstract_type = /datum/slapcraft_recipe/carpentry/item
	subcategory = SLAP_SUBCAT_ITEM


/datum/slapcraft_recipe/masonry
	abstract_type = /datum/slapcraft_recipe/masonry
	skillcraft = /datum/skill/craft/masonry
	category = SLAP_CAT_MASONRY

/datum/slapcraft_recipe/masonry/structure
	abstract_type = /datum/slapcraft_recipe/masonry/structure
	in_place_craft = TRUE
	subcategory = SLAP_SUBCAT_STRUCTURE
	craftsound = 'sound/foley/Building-01.ogg'

/datum/slapcraft_recipe/masonry/structure/check_craft_requirements(mob/user, turf/T)
	if(istype(T,/turf/open/transparent/openspace))
		return FALSE
	return ..()

/datum/slapcraft_recipe/engineering
	abstract_type = /datum/slapcraft_recipe/engineering
	skillcraft =/datum/skill/craft/engineering
	category = SLAP_CAT_ENGINEERING

/datum/slapcraft_recipe/engineering/structure
	abstract_type = /datum/slapcraft_recipe/engineering/structure
	in_place_craft = TRUE
	subcategory = SLAP_SUBCAT_STRUCTURE
	craftsound = 'sound/foley/Building-01.ogg'

/datum/slapcraft_recipe/engineering/structure/check_craft_requirements(mob/user, turf/T)
	if(istype(T,/turf/open/transparent/openspace))
		return FALSE
	return ..()
