/atom
	var/name_gen = "" // Родительный падеж
	var/name_accu = "" // Винительный падеж
	var/name_dat = "" // Дательный падеж
	var/name_inst = "" // Творительный падеж
	var/name_prep = "" // Предложный падеж

/atom/New(loc, ...) // Не инициализация, да
	if(!name_gen)
		name_gen = name
	if(!name_accu)
		name_accu = name
	if(!name_dat)
		name_dat = name
	if(!name_inst)
		name_inst = name
	if(!name_prep)
		name_prep = name
	..()
