GLOBAL_LIST_EMPTY(loadout_items)

/datum/loadout_item
	var/name = "Parent loadout datum"
	var/desc
	var/path


//HATS
/datum/loadout_item/shalal
	name = "Keffiyeh"
	desc = "Шапка."
	path = /obj/item/clothing/head/roguetown/roguehood/shalal

/datum/loadout_item/strawhat
	name = "Straw Hat"
	desc = "Шапка."
	path = /obj/item/clothing/head/roguetown/strawhat

/datum/loadout_item/witchhat
	name = "Witch Hat"
	desc = "Шапка."
	path = /obj/item/clothing/head/roguetown/puritan

/datum/loadout_item/bardhat
	name = "Bard Hat"
	desc = "Шапка."
	path = /obj/item/clothing/head/roguetown/bardhat

/datum/loadout_item/fancyhat
	name = "Fancy Hat"
	desc = "Шапка."
	path = /obj/item/clothing/head/roguetown/fancyhat

/datum/loadout_item/headband
	name = "Headband"
	desc = "Шапка."
	path = /obj/item/clothing/head/roguetown/headband

//CLOAKS
/datum/loadout_item/hood
	name = "Hood"
	desc = "Капюшон."
	path = /obj/item/clothing/head/roguetown/roguehood

/datum/loadout_item/tabard
	name = "Tabard"
	desc = "Плащ."
	path = /obj/item/clothing/cloak/tabard

/datum/loadout_item/surcoat
	name = "Surcoat"
	desc = "Плащ."
	path = /obj/item/clothing/cloak/stabard

/datum/loadout_item/jupon
	name = "Jupon"
	desc = "Плащ."
	path = /obj/item/clothing/cloak/stabard/surcoat

/datum/loadout_item/cape
	name = "Cape"
	desc = "Плащ."
	path = /obj/item/clothing/cloak/cape

/datum/loadout_item/halfcloak
	name = "Halfcloak"
	desc = "Плащ."
	path = /obj/item/clothing/cloak/half

/datum/loadout_item/raincloak
	name = "Rain Cloak"
	desc = "Плащ."
	path = /obj/item/clothing/cloak/raincloak

/datum/loadout_item/raincloak/apron/blacksmith
	name = "Leather Apron"
	desc = "Фартук."
	path = /obj/item/clothing/cloak/apron/blacksmith

//SHOES
/datum/loadout_item/darkboots
	name = "Dark Boots"
	desc = "Сапоги."
	path = /obj/item/clothing/shoes/roguetown/boots

/datum/loadout_item/nobleboots
	name = "Noble Boots"
	desc = "Сапоги."
	path = /obj/item/clothing/shoes/roguetown/armor/nobleboot

/datum/loadout_item/shortboots
	name = "Short Boots"
	desc = "Сапоги."
	path = /obj/item/clothing/shoes/roguetown/shortboots

/datum/loadout_item/ridingboots
	name = "Riding Boots"
	desc = "Сапоги."
	path = /obj/item/clothing/shoes/roguetown/ridingboots

//SHIRTS
/datum/loadout_item/robe
	name = "Robe"
	desc = "Одежда."
	path = /obj/item/clothing/suit/roguetown/shirt/robe

/datum/loadout_item/formalsilks
	name = "Formal Silks"
	desc = "Одежда."
	path = /obj/item/clothing/suit/roguetown/shirt/undershirt/puritan

/datum/loadout_item/tunic
	name = "Tunic"
	desc = "Одежда."
	path = /obj/item/clothing/suit/roguetown/shirt/tunic

/datum/loadout_item/dress
	name = "Dress"
	desc = "Одежда."
	path = /obj/item/clothing/suit/roguetown/shirt/dress/gen

/datum/loadout_item/bardress
	name = "Bar Dress"
	desc = "Одежда."
	path = /obj/item/clothing/suit/roguetown/shirt/dress

/datum/loadout_item/chemise
	name = "Chemise"
	desc = "Одежда."
	path = /obj/item/clothing/suit/roguetown/shirt/dress/silkdress

/datum/loadout_item/straplessdress
	name = "Strapless Dress"
	desc = "Одежда."
	path = /obj/item/clothing/suit/roguetown/shirt/dress/gen/strapless

/datum/loadout_item/straplessdress
	name = "Black Strapless Dresses"
	desc = "Одежда."
	path = /obj/item/clothing/suit/roguetown/shirt/dress/gen/strapless/black

/datum/loadout_item/belldresblue
	name = "Blue Strapless Dresses"
	desc = "Одежда."
	path = /obj/item/clothing/suit/roguetown/shirt/dress/gen/strapless/blue

/datum/loadout_item/belldressred
	name = "Red Strapless Dresses"
	desc = "Одежда."
	path = /obj/item/clothing/suit/roguetown/shirt/dress/gen/strapless/red

/datum/loadout_item/belldresspurple
	name = "Purple Strapless Dresses"
	desc = "Одежда."
	path = /obj/item/clothing/suit/roguetown/shirt/dress/gen/strapless/purple


//ACCESSORIES
/datum/loadout_item/juststockings
	name = "Stockings"
	desc = "Чулочки."
	path = /obj/item/clothing/under/roguetown/tights/stockings

/datum/loadout_item/silkstockings
	name = "Silk Stockings"
	desc = "Чулочки."
	path = /obj/item/clothing/under/roguetown/tights/stockings/silk

/datum/loadout_item/stockings
	name = "Fishnet Stockings"
	desc = "Чулочки."
	path = /obj/item/clothing/under/roguetown/tights/stockings/fishnet

/datum/loadout_item/stockingswhite
	name = "White Fishnet Stockings"
	desc = "Чулочки."
	path = /obj/item/clothing/under/roguetown/tights/stockings/fishnet/white

/datum/loadout_item/stockingsblack
	name = "Black Fishnet Stockings"
	desc = "Чулочки."
	path = /obj/item/clothing/under/roguetown/tights/stockings/fishnet/black

/datum/loadout_item/stockingsred
	name = "Red Fishnet Stockings"
	desc = "Чулочки."
	path = /obj/item/clothing/under/roguetown/tights/stockings/fishnet/red

/datum/loadout_item/stockingspurple
	name = "Purple Fishnet Stockings"
	desc = "Чулочки."
	path = /obj/item/clothing/under/roguetown/tights/stockings/fishnet/purple

//below are not clothes and may be valuable and well, clearly superior to having clothes but you only get one choice, and it's a 'loadout' so maybe its fine.
// Above clothing are usually hard to get on their own, some.

//ACCESSORIES
/datum/loadout_item/sring
	name = "Silver Ring"
	desc = "Кольцо."
	path = /obj/item/clothing/ring/silver

/datum/loadout_item/gring
	name = "Gold Ring"
	desc = "Кольцо."
	path = /obj/item/clothing/ring/gold

/datum/loadout_item/divine
	name = "Divine symbol"
	desc = "Ксайликса. Или нет?"
	path = /obj/item/clothing/neck/roguetown/psicross

//ARMOR
/datum/loadout_item/ironmask
	name = "Iron Mask"
	desc = "Маска."
	path = /obj/item/clothing/mask/rogue/facemask

/datum/loadout_item/ironmask
	name = "Iron coif"
	desc = "Койф."
	path = /obj/item/clothing/neck/roguetown/chaincoif/iron

/datum/loadout_item/lbracers
	name = "Leather Bracers"
	desc = "Наручи."
	path = /obj/item/clothing/wrists/roguetown/bracers/leather

// Musical Instruments

/datum/loadout_item/instrumentguitar
	name = "Guitar"
	desc = "Гитара."
	path = /obj/item/rogue/instrument/guitar

/datum/loadout_item/instrumentdrum
	name = "Drum"
	desc = "Барабан."
	path = /obj/item/rogue/instrument/drum

/datum/loadout_item/instrumentaccord
	name = "Accord"
	desc = "Аккордеон."
	path = /obj/item/rogue/instrument/accord

/datum/loadout_item/instrumentlute
	name = "Lute"
	desc = "Лютня."
	path = /obj/item/rogue/instrument/lute

/datum/loadout_item/instrumentharp
	name = "Harp"
	desc = "Арфа."
	path = /obj/item/rogue/instrument/harp

/datum/loadout_item/instrumentflute
	name = "Flute"
	desc = "Трубка. Жаль не из кожи."
	path = /obj/item/rogue/instrument/flute

/datum/loadout_item/hurdygurdy
	name = "Hurdygurdy"
	desc = "Музыкальная штука!"
	path = /obj/item/rogue/instrument/hurdygurdy

/datum/loadout_item/viola
	name = "Viola"
	desc = "Музыкальная штука!"
	path = /obj/item/rogue/instrument/viola

/datum/loadout_item/vocals
	name = "Vocalist's Talisman"
	desc = "Как же хочется спеть!"
	path = /obj/item/rogue/instrument/vocals

// Weapon
/datum/loadout_item/hungingknife
	name = "Hunting Knife"
	desc = "НОЖЫК."
	path = /obj/item/rogueweapon/huntingknife
