/proc/parse_zone(zone)
	switch(zone)
		if(BODY_ZONE_PRECISE_R_HAND)
			return "right hand"
		if(BODY_ZONE_PRECISE_L_HAND)
			return "left hand"
		if(BODY_ZONE_L_ARM)
			return "left arm"
		if(BODY_ZONE_R_ARM)
			return "right arm"
		if(BODY_ZONE_L_LEG)
			return "left leg"
		if(BODY_ZONE_R_LEG)
			return "right leg"
		if(BODY_ZONE_PRECISE_L_FOOT)
			return "left foot"
		if(BODY_ZONE_PRECISE_R_FOOT)
			return "right foot"
		if(BODY_ZONE_PRECISE_NECK)
			return "throat"
		if(BODY_ZONE_PRECISE_GROIN)
			return "groin"
		if(BODY_ZONE_PRECISE_EARS)	//we want the chatlog to say 'grabbed his ear' not 'grabbed his ears' etc
			return "ear"
		if(BODY_ZONE_PRECISE_R_EYE)
			return "right eye"
		if(BODY_ZONE_PRECISE_L_EYE)
			return "left eye"
		if(BODY_ZONE_PRECISE_NOSE)
			return "nose"
		if(BODY_ZONE_PRECISE_R_INHAND)
			return "right hand"
		if(BODY_ZONE_PRECISE_L_INHAND)
			return "left hand"
		if(BODY_ZONE_PRECISE_SKULL)
			return "skull"
		if(BODY_ZONE_PRECISE_MOUTH)
			return "mouth"
	return zone

/proc/parse_organ_slot(slot)
	switch(slot)
		if(ORGAN_SLOT_BRAIN)
			return "brain"
		if(ORGAN_SLOT_APPENDIX)
			return "appendix"
		if(ORGAN_SLOT_RIGHT_ARM_AUG)
			return "right arm implant"
		if(ORGAN_SLOT_LEFT_ARM_AUG)
			return "left arm implant"
		if(ORGAN_SLOT_STOMACH)
			return "stomach"
		if(ORGAN_SLOT_STOMACH_AID)
			return "stomach aid"
		if(ORGAN_SLOT_BREATHING_TUBE)
			return "breathing tube"
		if(ORGAN_SLOT_EARS)
			return "ears"
		if(ORGAN_SLOT_EYES)
			return "eyes"
		if(ORGAN_SLOT_LUNGS)
			return "lungs"
		if(ORGAN_SLOT_HEART)
			return "heart"
		if(ORGAN_SLOT_ZOMBIE)
			return "zombie gland"
		if(ORGAN_SLOT_THRUSTERS)
			return "thrusters"
		if(ORGAN_SLOT_HUD)
			return "eye implant"
		if(ORGAN_SLOT_LIVER)
			return "liver"
		if(ORGAN_SLOT_TONGUE)
			return "tongue"
		if(ORGAN_SLOT_VOICE)
			return "vocal cords"
		if(ORGAN_SLOT_ADAMANTINE_RESONATOR)
			return "adamantine resonator"
		if(ORGAN_SLOT_HEART_AID)
			return "heart aid"
		if(ORGAN_SLOT_BRAIN_ANTIDROP)
			return "brain antidrop implant"
		if(ORGAN_SLOT_BRAIN_ANTISTUN)
			return "brain antistun implant"
		if(ORGAN_SLOT_TAIL)
			return "tail"
		if(ORGAN_SLOT_PARASITE_EGG)
			return "parasite egg"
		if(ORGAN_SLOT_REGENERATIVE_CORE)
			return "regenerative core"
	return slot

/proc/parse_zone_fancy(zone, combat, combattarget, closeby, turnedaround, ontheground, grabbing, squinting, defiant, uncovered, dicked, pussied, strength, self = FALSE)
	switch(zone)
		if(BODY_ZONE_PRECISE_R_HAND)
			if(closeby && !combat)
				if(squinting)
					return "fingers"
				return "hands"
			else
				return "arms"
		if(BODY_ZONE_PRECISE_L_HAND)
			if(closeby && !combat)
				if(squinting)
					return "fingers"
				return "hands"
			else
				return "arms"
		if(BODY_ZONE_PRECISE_R_INHAND)
			if(closeby && !combat)
				if(squinting)
					return "fingers"
				return "hands"
			else
				return "arms"
		if(BODY_ZONE_PRECISE_L_INHAND)
			if(closeby && !combat)
				if(squinting)
					return "fingers"
				return "hands"
			else
				return "arms"
		if(BODY_ZONE_L_ARM)
			if(closeby && !combat)
				if(grabbing)
					return "armpits"
				return "shoulders"
			if(closeby && squinting && strength && combat && combattarget)
				return "biceps"
			else
				return "arms"
		if(BODY_ZONE_R_ARM)
			if(closeby && !combat)
				if(grabbing)
					return "armpits"
				return "shoulders"
			if(closeby && squinting && strength && combat && combattarget)
				return "biceps"
			else
				return "arms"
		if(BODY_ZONE_L_LEG)
			if(closeby && !combat)
				if(squinting)
					return "thighs"
				return "knees"
			if(closeby && squinting && strength && combat && combattarget)
				return "calves"
			else
				return "legs"
		if(BODY_ZONE_R_LEG)
			if(closeby && !combat)
				if(squinting)
					return "thighs"
				return "knees"
			if(closeby && squinting && strength && combat && combattarget)
				return "calves"
			else
				return "legs"
		if(BODY_ZONE_PRECISE_L_FOOT)
			if(ontheground && closeby && squinting && uncovered)
				if(combat)
					return "toes"
				return "soles"
			if(turnedaround && closeby && !combat && uncovered)
				return "ankles"
			if(closeby && !combat)
				if(!uncovered)
					return "shoes"
				return "feet"
			return "legs"
		if(BODY_ZONE_PRECISE_R_FOOT)
			if(ontheground && closeby && squinting && uncovered)
				if(combat)
					return "toes"
				return "soles"
			if(turnedaround && closeby && !combat && uncovered)
				return "ankles"
			if(closeby && !combat)
				if(!uncovered)
					return "shoes"
				return "feet"
			return "legs"
		if(BODY_ZONE_PRECISE_STOMACH)
			if(!turnedaround)
				if(closeby && squinting && strength && combat && combattarget && uncovered)
					return "abs"
				if(closeby && !combat)
					if(squinting)
						return "waist"
					if(grabbing)
						return "belly"
					return "stomach"
			if(closeby && !combat)
				return "lower back"
			else
				return "body"
		if(BODY_ZONE_CHEST)
			if(!turnedaround)
				if(closeby && squinting && strength && combat && combattarget && uncovered)
					return "pecs"
				if(closeby && !combat)
					if(squinting && uncovered)
						return "breasts"
					return "chest"
			if(closeby && squinting && strength && combat && combattarget && uncovered)
				return "lats"
			if(closeby && !combat && !self)
				return "back"
			else
				return "body"
		if(BODY_ZONE_PRECISE_GROIN)
			if((turnedaround && !self) || (self && !squinting && combat))
				if(closeby && grabbing && squinting && ontheground && !defiant && !combat && uncovered && !self)
					return "asshole"
				return "ass"
			if(closeby && !combat)
				if(squinting && !defiant)
					if(dicked)
						if(uncovered)
							return "cock"
						else
							return "bulge"
					if(pussied)
						if(uncovered)
							return "slit"
						else
							return "camel toe"
				return "crotch"
			if(squinting && combat)
				return "hips"
			else
				return "groin"
		if(BODY_ZONE_PRECISE_NECK)
			if(self)
				return FALSE
			if(closeby && !turnedaround && !combat)
				return "neck"
			return "head"
		if(BODY_ZONE_PRECISE_EARS)
			if(self)
				return FALSE
			if(closeby && !combat && uncovered)
				return "ears"
			else
				return "head"
		if(BODY_ZONE_PRECISE_R_EYE)
			if(self)
				return FALSE
			if(closeby && !turnedaround && !combat && uncovered)
				if(squinting)
					return "cheeks"
				return "eyes"
			else
				return "head"
		if(BODY_ZONE_PRECISE_L_EYE)
			if(self)
				return FALSE
			if(closeby && !turnedaround && !combat && uncovered)
				if(squinting)
					return "cheeks"
				return "eyes"
			else
				return "head"
		if(BODY_ZONE_PRECISE_NOSE)
			if(self)
				return FALSE
			if(closeby && !turnedaround && !combat && uncovered)
				return "nose"
			else
				return "head"
		if(BODY_ZONE_HEAD)
			if(self)
				return FALSE
			if(closeby && !turnedaround && !combat && uncovered)
				if(squinting)
					return "chin"
				return "face"
			else
				return "head"
		if(BODY_ZONE_PRECISE_SKULL)
			if(self)
				return FALSE
			if(closeby && !combat && uncovered)
				if(squinting && !turnedaround)
					return "forehead"
				return "hair"
			else
				return "head"
		if(BODY_ZONE_PRECISE_MOUTH)
			if(self)
				return FALSE
			if(closeby && !turnedaround && uncovered)
				if(!combat)
					if(squinting)
						if(!defiant && prob(1))
							return "seductive lips"
						return "lips"
					return "mouth"
				return "jaw"
			else
				return "head"
	return zone
