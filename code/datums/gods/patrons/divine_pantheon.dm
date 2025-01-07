/datum/patron/divine
	name = null
	associated_faith = /datum/faith/divine
	t0 = /obj/effect/proc_holder/spell/invoked/lesser_heal

/datum/patron/divine/astrata
	name = "Астрата"
	domain = "Богиня Солнца, Дня и Порядка"
	desc = "Первенец Псайдона, близнец Нока, одарила разумным существам Солнцем как своим божественным даром."
	worshippers = "Последователи: благородные, фанатичные крестоносцы и люд, и фермеры."
	t1 = /obj/effect/proc_holder/spell/invoked/sacred_flame_rogue
	t2 = /obj/effect/proc_holder/spell/invoked/heal
	t3 = /obj/effect/proc_holder/spell/invoked/revive
	confess_lines = list(
		"АСТРАТА МОЙ СВЕТ!",
		"АСТРАТА ПРИНОСИТ ПОРЯДОК!",
		"Я СЛУЖУ ВО СЛАВУ СОЛНЦА!",
	)

/datum/patron/divine/noc
	name = "Нок"
	domain = "Богиня Луны, Ночи и Знаний"
	desc = "Первенец Псайдона, близнец Астраты, одаренная божественными знаниями."
	worshippers = "Волшебники и ученые"
	mob_traits = list(TRAIT_NOCTURNAL) //lighting alpha 245. DV spell is 220, DV spell w/noc or DV special is 200
	t1 = /obj/effect/proc_holder/spell/invoked/blindness
	t2 = /obj/effect/proc_holder/spell/invoked/invisibility
	confess_lines = list(
		"НОК - ЭТО НОЧЬ!",
		"НОК ВСЕ ВИДИТ!",
		"Я ИЩУ ТАЙНЫ ЛУНЫ!",
	)

/datum/patron/divine/dendor
	name = "Дендор"
	domain = "Бог Земли и Природы"
	desc = "Первородный сын Псайдона, покровитель зверей и леса. Со временем сошел с ума и уснул."
	worshippers = "Друиды, звери, безумцы"
	mob_traits = list(TRAIT_VINE_WALKER)
	t1 = /obj/effect/proc_holder/spell/targeted/blesscrop
	t2 = /obj/effect/proc_holder/spell/targeted/beasttame
	t3 = /obj/effect/proc_holder/spell/targeted/conjure_vines
	confess_lines = list(
		"ДЕНДОР ОБЕСПЕЧИВАЕТ ЕДОЙ!",
		"ОТЕЦ ДЕРЕВЬЕВ ПРИНОСИТ ЩЕДРОСТЬ!",
		"Я ОТВЕЧАЮ НА ЗОВ ДИКОЙ ПРИРОДЫ!",
	)

/datum/patron/divine/abyssor
	name = "Абиссор"
	domain = "Бог Океана, Штормов и Приливов"
	desc = "Возлюбленный Сын, одаривший первобытных разумных существ пищей и водой."
	worshippers = "Люди моря, моряки и рыболовы"
	confess_lines = list(
		"АБИССОР ПОВЕЛЕВАЕТ ВОЛНАМИ!",
		"ЯРОСТЬ ОКЕАНА - ВОЛЯ АБИССОРА!",
		"МЕНЯ ВЛЕЧЁТ ПРИЛИВ!",
	)

/datum/patron/divine/ravox
	name = "Равокс"
	domain = "Бог Войны, Справедливости и Силы"
	desc = "Самый сильный из детей Псайдона, он наблюдает за людьми издалека."
	worshippers = "Войны, Наёмники и те, кто ищет справедливости"
	t1 = /obj/effect/proc_holder/spell/invoked/burden
	confess_lines = list(
		"РАВОКС - ЭТО СПРАВЕДЛИВОСТЬ!",
		"ЧЕРЕЗ РАЗДОРЫ - К БЛАГОДАТИ!",
		"БАРАБАНЫ ВОЙНЫ БЬЮТ В МОЕЙ ГРУДИ!",
	)

/datum/patron/divine/necra
	name = "Некра"
	domain = "Богиня Смерти и Загробного мира"
	desc = "Леди в вуали - боязливая, но уважаемая богиня, который ведет мертвых."
	worshippers = "Мертвые, скорбящие, могильщики"
	mob_traits = list(TRAIT_SOUL_EXAMINE)
	t1 = /obj/effect/proc_holder/spell/targeted/burialrite
	t2 = /obj/effect/proc_holder/spell/targeted/churn
	t3 = /obj/effect/proc_holder/spell/targeted/soulspeak
	confess_lines = list(
		"ВСЕ ДУШИ ПОПАДАЮТ К НЕКРЕ!",
		"ЛЕДИ В ВУАЛИ - НАШ ПОСЛЕДНИЙ ПОКОЙ!",
		"Я НЕ БОЮСЬ СМЕРТИ, МОЯ ГОСПОЖА ЖДЕТ МЕНЯ!",
	)

/datum/patron/divine/xylix
	name = "Ксайликс"
	domain = "Бог Хитрости, Свободы и Вдохновения"
	desc = "Безумный бог, одаривший разумное существо жаждой странствий и тысячей хитростей."
	worshippers = "Обманщики, мошенники, дьяволы с серебряным языком и жуликоватые типы"
	confess_lines = list(
		"АСТРАТА - МОЙ СВЕТ!",
		"НОК - НОЧЬ!",
		"ДЕНДОР ОБЕСПЕЧИВАЕТ ЕДОЙ!",
		"АБИССОР ПОВЕЛЕВАЕТ ВОЛНАМИ!",
		"РАВОКС - ЭТО СПРАВЕДЛИВОСТЬ!",
		"ВСЕ ДУШИ НАХОДЯТ СВОЙ ПУТЬ У НЕКРЫ!",
		"ХАХАХАХА! АХАХАХА! ХАХАХАХА!",
		"ПЕСТРА УСПОКАИВАЕТ ВСЕ НЕДУГИ!",
		"МАЛУМ - МОЯ МУЗА!",
		"ЭОРА ОБЪЕДИНЯЕТ НАС!",
	)

/datum/patron/divine/pestra
	name = "Пестра"
	domain = "Богиня разложения, болезней и медицины"
	desc = "Любящая дочь Псайдона, одаренный доктор."
	worshippers = "Больные, лекари, аптекари"
	mob_traits = list(TRAIT_EMPATH, TRAIT_ROT_EATER)
	t0 = list(/obj/effect/proc_holder/spell/invoked/diagnose, /obj/effect/proc_holder/spell/invoked/lesser_heal) // Combine both spells on t0
	t1 = /obj/effect/proc_holder/spell/invoked/heal
	t2 = /obj/effect/proc_holder/spell/invoked/attach_bodypart
	t3 = /obj/effect/proc_holder/spell/invoked/cure_rot
	confess_lines = list(
		"ПЕСТРА УСПОКАИВАЕТ ВСЕ НЕДУГИ!",
		"РАЗЛОЖЕНИЕ - ЭТО ПРОДОЛЖЕНИЕ ЖИЗНИ!",
		"МОЙ НЕДУГ - МОЕ ЗАВЕЩАНИЕ!",
	)

/datum/patron/divine/malum
	name = "Малум"
	domain = "Бог огня, Разрушения и Возрождения"
	desc = "Бесстрастный Бог, его дети не таят зла в своих поступках."
	worshippers = "Кузнецы, шахтеры, художники, ремесленники"
	mob_traits = list(TRAIT_FORGEBLESSED)
	t1 = /obj/effect/proc_holder/spell/invoked/vigorousexchange
	t2 = /obj/effect/proc_holder/spell/invoked/heatmetal
	t3 = /obj/effect/proc_holder/spell/invoked/hammerfall
	t4 = /obj/effect/proc_holder/spell/invoked/craftercovenant
	confess_lines = list(
		"МАЛУМ - МОЯ МУЗА!",
		"ИСТИННАЯ ЦЕННОСТЬ - В ТРУДЕ!",
		"Я - ИНСТРУМЕНТ ТВОРЕНИЯ!",
	)

/datum/patron/divine/eora
	name = "Эора"
	domain = "Богиня любви, жизни и красоты"
	desc = "Божественным даром Эоры была семья, и она научила разумное существо создавать искусство и вино, чтобы он мог наслаждаться полной жизнью. \
	Она учит любви к семье и красоте и ненавидит всё, что им угрожает."
	worshippers = "Любовники, заботливые бабушки и дедушки, молодожены, миротворцы"
	t0 = /obj/effect/proc_holder/spell/invoked/lesser_heal
	t1 = /obj/effect/proc_holder/spell/invoked/eoracurse
	t2 = /obj/effect/proc_holder/spell/invoked/bud
	t3 = /obj/effect/proc_holder/spell/invoked/eoracharm
	confess_lines = list(
		"ЭОРА ОБЪЕДИНЯЕТ НАС!",
		"ЕЕ КРАСОТА ДАЖЕ В ЭТИХ МУЧЕНИЯХ!",
		"Я ЛЮБЛЮ ТЕБЯ, ДАЖЕ КОГДА ТЫ ПОСЯГАЕШЬ НА МЕНЯ!",
	)
