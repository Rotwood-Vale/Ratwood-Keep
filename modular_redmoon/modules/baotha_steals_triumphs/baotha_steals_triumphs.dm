// Искать связанный код по тэгу "baotha_steals_triumphs"

/datum/sex_controller
	/// Количество совершенных действий. Нужно, чтобы баотиты за секунду не воровали чужие триумфы.
	var/actions_made = 0

/datum/controller/subsystem/ticker
	var/list/violated_by_baotha = list()

/datum/sex_controller/proc/baotha_invitation(var/mob/living/baotha_cultist, var/mob/living/victim)
	if(victim.real_name in SSticker.violated_by_baotha)
		return FALSE
	SSticker.violated_by_baotha += victim.real_name
	baotha_cultist.adjust_triumphs(1)
	victim.adjust_triumphs(-1)
	to_chat(victim, victim.client.prefs.be_russian ? span_userdanger("Я чувствую, как мою душу оскверняют!") : span_userdanger("I feel how my soul is being corrupted by them!"))
	var/question = alert(victim, "Give up and praise Baotha?...", "Give up to the pleasure!", "No!", "Yes!")
	if(question != "Yes!")
		to_chat(baotha_cultist, baotha_cultist.client.prefs.be_russian ? span_userdanger("Моя игрушка решила держаться за своего недо-бога до конца... Какая жалость, что от меня это не спасает!") : span_danger("My toy decided to hold on their god to the end... How pitty that is will not save them from me!"))
		to_chat(victim, victim.client.prefs.be_russian ? span_userdanger("МОЯ ВЕРА - МОЙ ЩИТ! И ДУХ МОЙ СИЛЁН!") : span_userdanger("MY FAITH IS MY SHIELD! AND SPIRIT IS STRONG!"))
		return FALSE
	to_chat(victim, victim.client.prefs.be_russian ? span_userdanger("Я предаю своего Бога... Я ничтожество. В любом случае, прими меня, Баота!") : span_userdanger("I turned on my God... I am a weakling. Anyway, take me, Baotha!"))
	victim.set_patron(/datum/patron/inhumen/baotha)
	victim.whisper("Славься, Баота...!")

/datum/sex_controller/proc/baotha_process(var/mob/living/baotha_cultist, var/mob/living/victim)
	if(baotha_cultist == victim)
		return FALSE
	if(baotha_cultist.patron.type != /datum/patron/inhumen/baotha)
		return FALSE
	if(victim.patron.type == /datum/patron/inhumen/baotha)
		return FALSE
	if(actions_made < 12)
		to_chat(baotha_cultist, baotha_cultist.client.prefs.be_russian ? span_warning("Мне нужно получить больше удовольствия, чтобы осквернить!") : span_warning("I need to get more pleasure from them to corrupt!"))
		return FALSE
	var/amount_to_change_nutrition = min(100, NUTRITION_LEVEL_FULL - baotha_cultist.nutrition)
	var/amount_to_change_hydration = min(100, HYDRATION_LEVEL_FULL - baotha_cultist.nutrition)
	if(victim.real_name in SSticker.violated_by_baotha)
		target.adjust_nutrition(-amount_to_change_nutrition)
		target.adjust_hydration(-amount_to_change_hydration)
		baotha_cultist.adjust_nutrition(amount_to_change_nutrition)
		baotha_cultist.adjust_hydration(amount_to_change_hydration)
	else // В первый раз, это особенно больно
		amount_to_change_nutrition = min(400, NUTRITION_LEVEL_FULL - baotha_cultist.nutrition)
		amount_to_change_hydration = min(400, HYDRATION_LEVEL_FULL - baotha_cultist.nutrition)
		target.adjust_nutrition(-amount_to_change_nutrition)
		target.adjust_hydration(-amount_to_change_hydration)
		baotha_cultist.adjust_nutrition(amount_to_change_nutrition)
		baotha_cultist.adjust_hydration(amount_to_change_hydration)
	spawn(0)
		baotha_invitation(baotha_cultist, victim)
	var/list/baotha_taunts = list(
		"Weakling... Your body will be a pleasurable toy!",
		"I guess it will corrupt them enought... Praise, Baotha!",
		"[victim.gender == MALE ? "His" : "Her"] spirit shall fall... Just like their false-teachings!")
	var/list/baotha_taunts_ru = list(
		"Ничтожество... Твоё тело будет хорошей игрушкой!",
		"Надеюсь, это достаточно осквернит [victim.gender == MALE ? "его" : "её"] душу... Славься, Баота!",
		"Силы наполняют меня, пока моя жертва ослабевает... Славься, Баота!",
		"[victim.gender == MALE ? "Его" : "Её"] дух падёт... Как и [victim.gender == MALE ? "его" : "её"] лжеучения!")
	to_chat(baotha_cultist, baotha_cultist.client.prefs.be_russian ? span_lovebold(pick(baotha_taunts_ru)) : span_lovebold(pick((baotha_taunts))))
	to_chat(victim, victim.client.prefs.be_russian ? span_danger("ИЗ МЕНЯ ВЫСАСЫВАЮТ ЖИЗНЕННЫЕ СИЛЫ! НЕТ!!") : span_danger("MY LIFEFORCE IS BEING PULLED AWAY! PLEASE, NO!!"))
