// Backgrounds focusing on Ranger/Rogue archetypes.
/datum/background/agile/swift
	name = "Swift"
	ru_name = "Быстрый"
	desc = "With the wind in your hair and trouble at your back, your speed has oft been your salvation."
	ru_desc = "Быстрые ноги драки не боятся."
	stat_array = list(STAT_STRENGTH = -2, STAT_PERCEPTION = -2, STAT_CONSTITUTION = -2, STAT_ENDURANCE = 2, STAT_SPEED = 4)

/datum/background/agile/hardy
	name = "Hardy"
	ru_name = "Стойкий"
	desc = "Uniquely Pestran fortitude affords you the means to shrug off illnesses and poisons that others might not."
	ru_desc = "Стойкий против большинства болезней и ядов."
	stat_array = list(STAT_STRENGTH = -3, STAT_CONSTITUTION = 2,  STAT_INTELLIGENCE = 1, STAT_ENDURANCE = 1, STAT_SPEED = -3)

/datum/background/agile/tricky
	name = "Tricky"
	ru_name = "Хитрый"
	desc = "Swift feet with a mind to match and a tiny sliver of the Ten's own luck... or not."
	ru_desc = "Хитрый и удачливый. Или нет?"
	stat_array = list(STAT_STRENGTH = -2, STAT_PERCEPTION = 1, STAT_ENDURANCE = -2, STAT_SPEED = 1, STAT_FORTUNE = list(-1, 1))

/datum/background/agile/thug
	name = "Thuggish"
	ru_name = "Тупица"
	desc = "Your robust physique and keen eye have oft been your most valuable friends in such trying times."
	ru_desc = "Ваше крепкое телосложение и зоркий глаз всегда были вашими самыми ценными друзьями в такие трудные времена."
	stat_array = list(STAT_STRENGTH = 2, STAT_PERCEPTION = 1, STAT_INTELLIGENCE = -2, STAT_SPEED = -4)

/datum/background/agile/wary
	name = "Wary"
	ru_name = "Осторожный"
	desc = "Eyes forward, ever and always. A careful course has always seen you through... so far."
	ru_desc = "Вы всегда смотрели вперед, и это всегда помогало вам. Хотя, возможно... не всегда."
	stat_array = list(STAT_STRENGTH = -4, STAT_PERCEPTION = 2, STAT_INTELLIGENCE = 1, STAT_CONSTITUTION = 1, STAT_SPEED = -4)

// Backgrounds focusing on mental-stats - perfect for wizard and religious archetypes.
/datum/background/mental/scholarly
	name = "Studious"
	ru_name = "Ученик"
	desc = "Your understanding of the world avails you, more often than not."
	ru_desc = "Ваше понимание мира часто помогает вам."
	stat_array =  list(STAT_STRENGTH = -3, STAT_PERCEPTION = 1, STAT_INTELLIGENCE = 2, STAT_ENDURANCE = -3)

/datum/background/mental/faithdriven
	name = "Resolute"
	ru_name = "Набожный"
	desc = "Look ever to the Gods for guidance in these trying times - and so you have, to the exclusion of the world around you."
	ru_desc = "Вы всегда ищете совета у Богов в эти трудные времена - и так вы и делаете, игнорируя мир вокруг вас."
	stat_array = list(STAT_PERCEPTION = -6, STAT_INTELLIGENCE = 1, STAT_CONSTITUTION = 1, STAT_ENDURANCE = 1)

/datum/background/mental/zealous
	name = "Zealous"
	ru_name = "Верующий"
	desc = "Faith in something drives your body and mind to match what neither can see."
	ru_desc = "Вера во что-то заставляет ваше тело и разум соответствовать тому, чего никто не видит."
	stat_array = list(STAT_STRENGTH = 1, STAT_PERCEPTION = -3, STAT_INTELLIGENCE = 1, STAT_ENDURANCE = 1, STAT_SPEED = -3)

/datum/background/mental/augury
	name = "Foresighted"
	ru_name = "Провидец"
	desc = "You see what is and what will sometimes be."
	ru_desc = "Вы видите то, что есть и то, что будет."
	stat_array = list(STAT_STRENGTH = -3, STAT_PERCEPTION = 2, STAT_INTELLIGENCE = 1, STAT_ENDURANCE = -3)

/datum/background/mental/adept
	name = "Adept"
	ru_name = "Умелый"
	desc = "Your will leads the way."
	ru_desc = "Ваше воля ведет вас."
	stat_array = list(STAT_STRENGTH = -2, STAT_PERCEPTION = 1, STAT_INTELLIGENCE = 1, STAT_CONSTITUTION = -4, STAT_SPEED = 1)

// Backgrounds focusing warrior, farmer, and melee-fighters.
/datum/background/physical/trained
	name = "Trained"
	ru_name = "Тренированный"
	desc = "Years honing your physique has left you with a physical edge, but your faculties have been neglected somewhat."
	ru_desc = "Годы тренировки вашего тела оставили вас с физическим преимуществом, но ваши интеллектуальные способности были несколько затронуты."
	stat_array = list(STAT_STRENGTH = 1, STAT_PERCEPTION = -2, STAT_INTELLIGENCE = -4, STAT_CONSTITUTION = 1, STAT_ENDURANCE = 1)

/datum/background/physical/muscular
	name = "Muscular"
	ru_name = "Мускулистый"
	desc = "Hard labor has honed you into a mass of sinew - a valuable trait in a world where might makes right."
	ru_desc = "Тяжёлый труд сделал вас мускулистым - ценный навык в мире, где сила решает все."
	stat_array = list(STAT_STRENGTH = 2, STAT_PERCEPTION = -2, STAT_INTELLIGENCE = -2, STAT_CONSTITUTION = 1, STAT_SPEED = -2)

/datum/background/physical/tactician
	name = "Alert"
	ru_name = "Внимательный"
	desc = "You sharpened both your body and your mind as best you were able, and vigilance has been your reward."
	ru_desc = "Вы оттачивали свое тело и ум, как только могли, и бдительность стала вашей наградой."
	stat_array = list(STAT_STRENGTH = 1, STAT_PERCEPTION = 1, STAT_CONSTITUTION = -2, STAT_ENDURANCE = -2)

/datum/background/physical/taut
	name = "Taut"
	ru_name = "Худой"
	desc = "Wound tight like the limbs of a time-teller, your physicality is poised to strike - or flee - at a moment's notice."
	ru_desc = "Ваша физическая форма, затянутая, как конечности сказителя времени. Вы готовы нанести быстрый удар или устроить быстрый побег в любой момент."
	stat_array = list(STAT_STRENGTH = 1, STAT_PERCEPTION = -1, STAT_INTELLIGENCE = -1, STAT_CONSTITUTION = -2, STAT_SPEED = 1)

/datum/background/physical/toil
	name = "Toil-hardened"
	ru_name = "Трудолюбивый"
	desc = "Your life, hard-lived, has imparted one solitary adage: carry on above all else. And so you endure."
	ru_desc = "Ваша тяжёлая жизнь дала вам одно единственное мудрое изречение: живи и выживай. Так и живём."
	stat_array = list(STAT_PERCEPTION = -2, STAT_INTELLIGENCE = -4, STAT_CONSTITUTION = 1, STAT_ENDURANCE = 2)

// Backgrounds for those wildcards out there who like a challenge; basically PUNISHING or random archetypes.
/datum/background/wildcard/wretched
	name = "Wretched"
	ru_name = "Убогий"
	desc = "The cruelty of Enigma leaves many in its wake - you among them. But with her terrible eye turned elsewhere, perhaps it is time for your fortune to be made..."
	ru_desc = "Жестокость Острова Энигмы оставляет после себя множество шрамов, и вы в их числе. Но теперь, когда ее ужасный взор обращен в другую сторону, возможно, настало время и для вашей судьбы..."
	stat_array = list(STAT_STRENGTH = -2, STAT_PERCEPTION = -2, STAT_INTELLIGENCE = -2, STAT_CONSTITUTION = -2, STAT_ENDURANCE = -2, STAT_SPEED = -2, STAT_FORTUNE = 12)

/datum/background/wildcard/fated
	name = "Fated"
	ru_name = "Неопределённый"
	desc = "The first or the last - let destiny's fickle loom decree what your fate shall be."
	ru_desc = "Первый или последний - пусть Ксайликс определит вашу судьбу."
	stat_array = list(STAT_STRENGTH = list(-1, 1), STAT_PERCEPTION = list(-1, 1), STAT_INTELLIGENCE = list(-1, 1), STAT_CONSTITUTION = list(-1, 1), STAT_ENDURANCE = list(-1, 1), STAT_SPEED = list(-1, 1), STAT_FORTUNE = list(-1, 1))

/datum/background/wildcard/frail
	name = "Frail"
	ru_name = "Хрупкий"
	desc = "The growing dark limns your vision more with every passing day: your flesh and mind are failing you, and destiny has turned her gaze from you. How will your tale endure such hardship?"
	ru_desc = "Вы стареете и ваше зрение становится хуже с каждым днем. Ваше тело и разум слабеют, и судьба отвернулась от вас. Как же вы переживёте такое испытание в мире, где сила решает все?"
	stat_array = list(STAT_STRENGTH = -4, STAT_PERCEPTION = -4, STAT_INTELLIGENCE = -4, STAT_CONSTITUTION = -4, STAT_ENDURANCE = -4, STAT_SPEED = -4, STAT_FORTUNE = -4)
