/datum/voicepack/female/moth/get_sound(soundin)
	var/used
	if(!used)
		switch(soundin)
			if("deathgurgle")
				used = pick('sound/vo/moth_death.ogg')
			if("fatigue")
				used = 'sound/vo/female/elf/fatigue.ogg'
			if("chuckle")
				used = 'sound/vo/mothsqueak.ogg'
			if("giggle")
				used = list('sound/vo/female/gen/giggle (1).ogg','sound/vo/female/gen/giggle (2).ogg')
			if("cry")
				used = list('sound/vo/female/gen/cry (1).ogg','sound/vo/female/gen/cry (2).ogg','sound/vo/female/gen/cry (3).ogg','sound/vo/female/gen/cry (4).ogg','sound/vo/female/gen/cry (5).ogg','sound/vo/female/gen/cry (6).ogg','sound/vo/female/gen/cry (7).ogg')
			if("embed")
				used = list('sound/vo/female/elf/pain (1).ogg','sound/vo/female/elf/pain (2).ogg','sound/vo/female/elf/pain (3).ogg','sound/vo/female/elf/pain (4).ogg')
			if("firescream")
				used = list('sound/vo/female/gen/firescream (1).ogg','sound/vo/female/gen/firescream (2).ogg')
			if("gasp")
				used = list('sound/vo/female/elf/gasp (1).ogg','sound/vo/female/elf/gasp (2).ogg','sound/vo/female/elf/gasp (3).ogg')
			if("grumble")
				used = 'sound/vo/female/gen/grumble.ogg'
			if("hmm")
				used = list('sound/vo/female/elf/hmm (1).ogg','sound/vo/female/elf/hmm (2).ogg')
			if("huh")
				used = 'sound/vo/moth_a.ogg'
			if("laugh")
				used = 'sound/vo/mothlaugh.ogg'
			if("pain")
				used = list('sound/vo/female/elf/pain (1).ogg','sound/vo/female/elf/pain (2).ogg','sound/vo/female/elf/pain (3).ogg','sound/vo/female/elf/pain (4).ogg')
			if("paincrit")
				used = list('sound/vo/female/elf/paincrit.ogg')
			if("painmoan")
				used = list('sound/vo/female/gen/painmoan (1).ogg','sound/vo/female/gen/painmoan (2).ogg','sound/vo/female/gen/painmoan (3).ogg','sound/vo/female/gen/painmoan (4).ogg','sound/vo/female/gen/painmoan (5).ogg','sound/vo/female/gen/painmoan (6).ogg','sound/vo/female/gen/painmoan (7).ogg','sound/vo/female/gen/painmoan (8).ogg')
			if("painscream")
				used = list('sound/vo/female/elf/painscream (1).ogg','sound/vo/female/elf/painscream (2).ogg')
			if("rage")
				used = list('sound/vo/female/gen/rage (1).ogg','sound/vo/female/gen/rage (2).ogg','sound/vo/female/gen/rage (3).ogg')
			if("scream")
				used = 'sound/vo/moth_scream.ogg'
			if("flutter")
				used = 'sound/vo/moth_flutter.ogg'
			if("chitter")
				used = 'sound/vo/mothchitter.ogg'
	if(!used)
		used = ..(soundin)
	return used
