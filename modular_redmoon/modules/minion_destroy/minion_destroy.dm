// Присвоение заклинания уничтожения преспешника при выдаче заклинания отдачи приказа
/obj/effect/proc_holder/spell/invoked/minion_order/on_gain(mob/living/user)
	. = ..()
	if(!user.mind.has_spell(/obj/effect/proc_holder/spell/invoked/minion_destroy))
		user.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/minion_destroy)

// Удаление заклинания уничтожения преспешника при удалении заклинания отдачи приказа
/obj/effect/proc_holder/spell/invoked/minion_order/on_lose(mob/living/user)
	. = ..()
	if(user.mind.has_spell(/obj/effect/proc_holder/spell/invoked/minion_destroy))
		user.mind.RemoveSpell(/obj/effect/proc_holder/spell/invoked/minion_destroy)

/obj/effect/proc_holder/spell/invoked/minion_destroy
	name = "Get rid of a minion"
	desc = "Kill one of my minions."
	overlay_state = "jump" // Другую иконку бы
	associated_skill = /datum/skill/misc/athletics
	chargedrain = 1
	chargetime = 0 SECONDS
	releasedrain = 0 
	charge_max = 3 SECONDS

/obj/effect/proc_holder/spell/invoked/minion_destroy/cast(list/targets, mob/user)
	if(!ishuman(user))
		to_chat(user, span_danger("Только люди могу использовать эту способность. Сообщите разработчикам!"))
		return

	var/mob/living/carbon/human/caster = user

	var/mob/target = input(usr, caster.client.prefs.be_russian ? "От какого подопечного я хочу избавиться?" : "What minion shall I get rid off?", caster.client.prefs.be_russian ? "Как твой Бог и Хозяин..." : "As your God and your Master...") as null|anything in caster.minions
	if(!target)
		to_chat(user, caster.client.prefs.be_russian ? span_notice("Я решаю подождать.") : span_notice("I decide to wait."))
		return
	to_chat(user, caster.client.prefs.be_russian ? span_notice("Магия, связывающая меня и [target] рассеивается... Ровно как и сущность моего слуги.") : span_notice("The magic, bounding [target] to me, shall be broken from now... And so, their shell."))
	target.death()
	target.update_stat()
	caster.minions -= target
	return
