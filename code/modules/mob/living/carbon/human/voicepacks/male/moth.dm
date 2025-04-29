/datum/voicepack/male/moth/get_sound(soundin)
	var/used
	if(!used)
		switch(soundin)
			if("deathgurgle")
				used = pick('sound/vo/moth_death.ogg')
			if("agony")
				used = 'sound/vo/male/elf/agony.ogg'
			if("chuckle")
				used = 'sound/vo/mothsqueak.ogg'
			if("cry")
				used = list('sound/vo/male/elf/cry (1).ogg','sound/vo/male/elf/cry (2).ogg','sound/vo/male/elf/cry (3).ogg')
			if("embed")
				used = list('sound/vo/male/elf/embed (1).ogg','sound/vo/male/elf/embed (2).ogg')
			if("firescream")
				used = list('sound/vo/male/elf/firescream (1).ogg','sound/vo/male/elf/firescream (2).ogg','sound/vo/male/elf/firescream (3).ogg')
			if("gasp")
				used = list('sound/vo/male/elf/gasp (1).ogg','sound/vo/male/elf/gasp (2).ogg','sound/vo/male/elf/gasp (3).ogg')
			if("grumble")
				used = 'sound/vo/male/elf/grumble.ogg'
			if("haltyell")
				used = 'sound/vo/male/elf/haltyell.ogg'
			if("huh")
				used = 'sound/vo/moth_a.ogg'
			if("laugh")
				used = 'sound/vo/mothlaugh.ogg'
			if("pain")
				used = list('sound/vo/male/elf/pain (1).ogg','sound/vo/male/elf/pain (2).ogg','sound/vo/male/elf/pain (3).ogg')
			if("paincrit")
				used = list('sound/vo/male/elf/paincrit (1).ogg','sound/vo/male/elf/paincrit (2).ogg','sound/vo/male/elf/paincrit (3).ogg')
			if("painmoan")
				used = list('sound/vo/male/elf/painmoan (1).ogg','sound/vo/male/elf/painmoan (2).ogg','sound/vo/male/elf/painmoan (3).ogg')
			if("painscream")
				used = list('sound/vo/male/elf/painscream (1).ogg','sound/vo/male/elf/painscream (2).ogg')
			if("rage")
				used = list('sound/vo/male/elf/rage (1).ogg','sound/vo/male/elf/rage (2).ogg')
			if("scream")
				used = 'sound/vo/moth_scream.ogg'
			if("flutter")
				used = 'sound/vo/moth_flutter.ogg'
			if("chitter")
				used = 'sound/vo/mothchitter.ogg'
	if(!used)
		used = ..(soundin)
	return used
