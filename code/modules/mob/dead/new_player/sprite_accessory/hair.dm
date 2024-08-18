/datum/sprite_accessory/hair
	abstract_type = /datum/sprite_accessory/hair
	color_key_name = "Hair"
	layer = HAIR_LAYER

/datum/sprite_accessory/hair/adjust_appearance_list(list/appearance_list, obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	generic_gender_feature_adjust(appearance_list, organ, bodypart, owner, OFFSET_FACE, OFFSET_FACE_F)

/datum/sprite_accessory/hair/head
	abstract_type = /datum/sprite_accessory/hair/head
	icon = 'icons/mob/sprite_accessory/hair/human_hair.dmi'

/datum/sprite_accessory/hair/head/is_visible(obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	return is_human_part_visible(owner, HIDEHAIR)

/datum/sprite_accessory/hair/head/bald
	name = "Bald"
	icon_state = null

/datum/sprite_accessory/hair/head/shorthaireighties
	name = "80s-style Hair"
	icon_state = "80s"

/datum/sprite_accessory/hair/head/afro
	name = "Afro"
	icon_state = "afro"

/datum/sprite_accessory/hair/head/afro2
	name = "Afro 2"
	icon_state = "afro2"

/datum/sprite_accessory/hair/head/afro_large
	name = "Afro (Large)"
	icon_state = "afro-big"

/datum/sprite_accessory/hair/head/antenna
	name = "Ahoge"
	icon_state = "antenna"

/datum/sprite_accessory/hair/head/balding
	name = "Balding Hair"
	icon_state = "balding"

/datum/sprite_accessory/hair/head/bedhead
	name = "Bedhead"
	icon_state = "bedhead"

/datum/sprite_accessory/hair/head/bedhead2
	name = "Bedhead 2"
	icon_state = "bedhead2"

/datum/sprite_accessory/hair/head/bedhead3
	name = "Bedhead 3"
	icon_state = "bedhead3"

/datum/sprite_accessory/hair/head/bedheadlong
	name = "Bedhead (Long)"
	icon_state = "bedhead-long"

/datum/sprite_accessory/hair/head/beehive
	name = "Beehive"
	icon_state = "beehive"

/datum/sprite_accessory/hair/head/beehive2
	name = "Beehive 2"
	icon_state = "beehive2"

/datum/sprite_accessory/hair/head/bob
	name = "Bobcut"
	icon_state = "bob"

/datum/sprite_accessory/hair/head/bob2
	name = "Bobcut 2"
	icon_state = "bob2"

/datum/sprite_accessory/hair/head/bob3
	name = "Bobcut 3"
	icon_state = "bob3"

/datum/sprite_accessory/hair/head/bob4
	name = "Bobcut 4"
	icon_state = "bob4"

/datum/sprite_accessory/hair/head/bobcurl
	name = "Bobcurl"
	icon_state = "bobcurl"

/datum/sprite_accessory/hair/head/boddicker
	name = "Boddicker"
	icon_state = "boddicker"

/datum/sprite_accessory/hair/head/bowlcut
	name = "Bowlcut"
	icon_state = "bowlcut"

/datum/sprite_accessory/hair/head/bowlcut2
	name = "Bowlcut 2"
	icon_state = "bowlcut2"

/datum/sprite_accessory/hair/head/braid
	name = "Braid (Floorlength)"
	icon_state = "braid"

/datum/sprite_accessory/hair/head/front_braid
	name = "Braided Front"
	icon_state = "braid-front"

/datum/sprite_accessory/hair/head/not_floorlength_braid
	name = "Braid (High)"
	icon_state = "braid-high"

/datum/sprite_accessory/hair/head/lowbraid
	name = "Braid (Low)"
	icon_state = "braid-low"

/datum/sprite_accessory/hair/head/shortbraid
	name = "Braid (Short)"
	icon_state = "braid-short"

/datum/sprite_accessory/hair/head/braided
	name = "Braided"
	icon_state = "braided"

/datum/sprite_accessory/hair/head/braidtail
	name = "Braided Tail"
	icon_state = "braided-tail"

/datum/sprite_accessory/hair/head/bun
	name = "Bun Head"
	icon_state = "bun"

/datum/sprite_accessory/hair/head/bun2
	name = "Bun Head 2"
	icon_state = "bun2"

/datum/sprite_accessory/hair/head/bun3
	name = "Bun Head 3"
	icon_state = "bun3"

/datum/sprite_accessory/hair/head/largebun
	name = "Bun (Large)"
	icon_state = "bun-large"

/datum/sprite_accessory/hair/head/manbun
	name = "Bun (Manbun)"
	icon_state = "bun-manbun"

/datum/sprite_accessory/hair/head/tightbun
	name = "Bun (Tight)"
	icon_state = "bun-tight"

/datum/sprite_accessory/hair/head/business
	name = "Business Hair"
	icon_state = "business"

/datum/sprite_accessory/hair/head/business2
	name = "Business Hair 2"
	icon_state = "business2"

/datum/sprite_accessory/hair/head/business3
	name = "Business Hair 3"
	icon_state = "business3"

/datum/sprite_accessory/hair/head/business4
	name = "Business Hair 4"
	icon_state = "business4"

/datum/sprite_accessory/hair/head/buzz
	name = "Buzzcut"
	icon_state = "buzzcut"

/datum/sprite_accessory/hair/head/cia
	name = "CIA"
	icon_state = "cia"

/datum/sprite_accessory/hair/head/coffeehouse
	name = "Coffee House"
	icon_state = "coffeehouse"

/datum/sprite_accessory/hair/head/combover
	name = "Combover"
	icon_state = "combover"

/datum/sprite_accessory/hair/head/comet
	name = "Comet"
	icon_state = "comet"

/datum/sprite_accessory/hair/head/cornrows1
	name = "Cornrows"
	icon_state = "cornrows"

/datum/sprite_accessory/hair/head/cornrows2
	name = "Cornrows 2"
	icon_state = "cornrows2"

/datum/sprite_accessory/hair/head/cornrowbraid
	name = "Cornrow Braid"
	icon_state = "cornrow-braid"

/datum/sprite_accessory/hair/head/cornrowbun
	name = "Cornrow Bun"
	icon_state = "cornrow-bun"

/datum/sprite_accessory/hair/head/cornrowdualtail
	name = "Cornrow Tail"
	icon_state = "cornrow-tail"

/datum/sprite_accessory/hair/head/crew
	name = "Crewcut"
	icon_state = "crewcut"

/datum/sprite_accessory/hair/head/curls
	name = "Curls"
	icon_state = "curls"

/datum/sprite_accessory/hair/head/cut
	name = "Cut Hair"
	icon_state = "cut"

/datum/sprite_accessory/hair/head/dandpompadour
	name = "Dandy Pompadour"
	icon_state = "dandypompadour"

/datum/sprite_accessory/hair/head/devillock
	name = "Devil Lock"
	icon_state = "devillock"

/datum/sprite_accessory/hair/head/doublebun
	name = "Double Bun"
	icon_state = "doublebun"

/datum/sprite_accessory/hair/head/dreadlocks
	name = "Dreadlocks"
	icon_state = "dreads"

/datum/sprite_accessory/hair/head/drillhair
	name = "Drillruru"
	icon_state = "drillruru"

/datum/sprite_accessory/hair/head/drillhairextended
	name = "Drill Hair (Extended)"
	icon_state = "drillhairextended"

/datum/sprite_accessory/hair/head/emo
	name = "Emo"
	icon_state = "emo"

/datum/sprite_accessory/hair/head/emo2
	name = "Emo 2"
	icon_state = "emo2"

/datum/sprite_accessory/hair/head/emofringe
	name = "Emo Fringe"
	icon_state = "emofringe"

/datum/sprite_accessory/hair/head/longemo
	name = "Emo Long"
	icon_state = "emolong"

/datum/sprite_accessory/hair/head/nofade
	name = "Fade (None)"
	icon_state = "fade-none"

/datum/sprite_accessory/hair/head/lowfade
	name = "Fade (Low)"
	icon_state = "fade-low"

/datum/sprite_accessory/hair/head/medfade
	name = "Fade (Medium)"
	icon_state = "fade-medium"

/datum/sprite_accessory/hair/head/highfade
	name = "Fade (High)"
	icon_state = "fade-high"

/datum/sprite_accessory/hair/head/baldfade
	name = "Fade (Bald)"
	icon_state = "fade-bald"

/datum/sprite_accessory/hair/head/father
	name = "Father"
	icon_state = "father"

/datum/sprite_accessory/hair/head/feather
	name = "Feather"
	icon_state = "feather"

/datum/sprite_accessory/hair/head/flair
	name = "Flair"
	icon_state = "flair"

/datum/sprite_accessory/hair/head/flattop
	name = "Flat Top / Sergeant"
	icon_state = "flattop"

/datum/sprite_accessory/hair/head/flattop_big
	name = "Flat Top (Big)"
	icon_state = "flattop-big"

/datum/sprite_accessory/hair/head/flow_hair
	name = "Flow Hair"
	icon_state = "flow"

/datum/sprite_accessory/hair/head/gelled
	name = "Gelled Back"
	icon_state = "gelled"

/datum/sprite_accessory/hair/head/gentle
	name = "Gentle"
	icon_state = "gentle"

/datum/sprite_accessory/hair/head/halfbang
	name = "Half-banged Hair"
	icon_state = "halfbang"

/datum/sprite_accessory/hair/head/halfbang2
	name = "Half-banged Hair 2"
	icon_state = "halfbang2"

/datum/sprite_accessory/hair/head/halfshaved
	name = "Half-shaved"
	icon_state = "halfshaved"

/datum/sprite_accessory/hair/head/hedgehog
	name = "Hedgehog Hair"
	icon_state = "hedgehog"

/datum/sprite_accessory/hair/head/himecut
	name = "Hime Cut"
	icon_state = "himecut"

/datum/sprite_accessory/hair/head/himecut2
	name = "Hime Cut 2"
	icon_state = "himecut2"

/datum/sprite_accessory/hair/head/shorthime
	name = "Hime Cut (Short)"
	icon_state = "shorthime"

/datum/sprite_accessory/hair/head/himeup
	name = "Hime Updo"
	icon_state = "himeup"

/datum/sprite_accessory/hair/head/hitop
	name = "Hitop"
	icon_state = "hitop"

/datum/sprite_accessory/hair/head/jade
	name = "Jade"
	icon_state = "jade"

/datum/sprite_accessory/hair/head/jensen
	name = "Jensen Hair"
	icon_state = "jensen"

/datum/sprite_accessory/hair/head/joestar
	name = "Joestar"
	icon_state = "joestar"

/datum/sprite_accessory/hair/head/keanu
	name = "Keanu Hair"
	icon_state = "keanu"

/datum/sprite_accessory/hair/head/kusangi
	name = "Kusanagi Hair"
	icon_state = "kusanagi"

/datum/sprite_accessory/hair/head/long
	name = "Long Hair 1"
	icon_state = "long"

/datum/sprite_accessory/hair/head/long2
	name = "Long Hair 2"
	icon_state = "long2"

/datum/sprite_accessory/hair/head/long3
	name = "Long Hair 3"
	icon_state = "long3"

/datum/sprite_accessory/hair/head/long_over_eye
	name = "Long Over Eye"
	icon_state = "longovereye"

/datum/sprite_accessory/hair/head/longbangs
	name = "Long Bangs"
	icon_state = "lbangs"

/datum/sprite_accessory/hair/head/longfringe
	name = "Long Fringe"
	icon_state = "longfringe"

/datum/sprite_accessory/hair/head/sidepartlongalt
	name = "Long Side Part"
	icon_state = "longsidepart"

/datum/sprite_accessory/hair/head/megaeyebrows
	name = "Mega Eyebrows"
	icon_state = "megaeyebrows"

/datum/sprite_accessory/hair/head/messy
	name = "Messy"
	icon_state = "messy"

/datum/sprite_accessory/hair/head/modern
	name = "Modern"
	icon_state = "modern"

/datum/sprite_accessory/hair/head/modern2
	name = "Modern (New)"
	icon_state = "modern2"


/datum/sprite_accessory/hair/head/mohawk
	name = "Mohawk"
	icon_state = "mohawk"

/datum/sprite_accessory/hair/head/reversemohawk
	name = "Mohawk (Reverse)"
	icon_state = "mohawk-reverse"

/datum/sprite_accessory/hair/head/shavedmohawk
	name = "Mohawk (Shaved)"
	icon_state = "mohawk-shaved"

/datum/sprite_accessory/hair/head/unshavenmohawk
	name = "Mohawk (Big)"
	icon_state = "mohawk-unshaven"

/datum/sprite_accessory/hair/head/mulder
	name = "Mulder"
	icon_state = "mulder"

/datum/sprite_accessory/hair/head/nitori
	name = "Nitori"
	icon_state = "nitori"

/datum/sprite_accessory/hair/head/odango
	name = "Odango"
	icon_state = "odango"

/datum/sprite_accessory/hair/head/ombre
	name = "Ombre"
	icon_state = "ombre"

/datum/sprite_accessory/hair/head/oneshoulder
	name = "One Shoulder"
	icon_state = "oneshoulder"

/datum/sprite_accessory/hair/head/over_eye
	name = "Over Eye"
	icon_state = "shortovereye"

/datum/sprite_accessory/hair/head/oxton
	name = "Oxton"
	icon_state = "oxton"

/datum/sprite_accessory/hair/head/parted
	name = "Parted"
	icon_state = "parted"

/datum/sprite_accessory/hair/head/partedside
	name = "Parted (Side)"
	icon_state = "part"

/datum/sprite_accessory/hair/head/pigtails
	name = "Pigtails"
	icon_state = "pigtails"

/datum/sprite_accessory/hair/head/pigtails2
	name = "Pigtails 2"
	icon_state = "pigtails2"

/datum/sprite_accessory/hair/head/pigtails3
	name = "Pigtails 3"
	icon_state = "pigtails3"

/datum/sprite_accessory/hair/head/kagami
	name = "Pigtails (Kagami)"
	icon_state = "pigtails-kagami"

/datum/sprite_accessory/hair/head/pixie
	name = "Pixie Cut"
	icon_state = "pixie"

/datum/sprite_accessory/hair/head/pompadour
	name = "Pompadour"
	icon_state = "pompadour"

/datum/sprite_accessory/hair/head/bigpompadour
	name = "Pompadour (Big)"
	icon_state = "pompadour-big"

/datum/sprite_accessory/hair/head/ponytail1
	name = "Ponytail"
	icon_state = "ponytail"

/datum/sprite_accessory/hair/head/ponytail2
	name = "Ponytail 2"
	icon_state = "ponytail2"

/datum/sprite_accessory/hair/head/ponytail3
	name = "Ponytail 3"
	icon_state = "ponytail3"

/datum/sprite_accessory/hair/head/ponytail4
	name = "Ponytail 4"
	icon_state = "ponytail4"

/datum/sprite_accessory/hair/head/ponytail5
	name = "Ponytail 5"
	icon_state = "ponytail5"

/datum/sprite_accessory/hair/head/ponytail6
	name = "Ponytail 6"
	icon_state = "ponytail6"

/datum/sprite_accessory/hair/head/ponytail7
	name = "Ponytail 7"
	icon_state = "ponytail7"

/datum/sprite_accessory/hair/head/highponytail
	name = "Ponytail (High)"
	icon_state = "ponytail-high"

/datum/sprite_accessory/hair/head/longponytail
	name = "Ponytail (Long)"
	icon_state = "ponytail-longstraight"

/datum/sprite_accessory/hair/head/stail
	name = "Ponytail (Short)"
	icon_state = "ponytail-short"

/datum/sprite_accessory/hair/head/countryponytail
	name = "Ponytail (Country)"
	icon_state = "ponytail-country"

/datum/sprite_accessory/hair/head/fringetail
	name = "Ponytail (Fringe)"
	icon_state = "fringetail"

/datum/sprite_accessory/hair/head/sidetail
	name = "Ponytail (Side)"
	icon_state = "sidetail"

/datum/sprite_accessory/hair/head/sidetail2
	name = "Ponytail (Side) 2"
	icon_state = "sidetail2"

/datum/sprite_accessory/hair/head/sidetail3
	name = "Ponytail (Side) 3"
	icon_state = "sidetail3"

/datum/sprite_accessory/hair/head/sidetail4
	name = "Ponytail (Side) 4"
	icon_state = "sidetail4"

/datum/sprite_accessory/hair/head/spikyponytail
	name = "Ponytail (Spiky)"
	icon_state = "spikyponytail"

/datum/sprite_accessory/hair/head/poofy
	name = "Poofy"
	icon_state = "poofy"

/datum/sprite_accessory/hair/head/quiff
	name = "Quiff"
	icon_state = "quiff"

/datum/sprite_accessory/hair/head/ronin
	name = "Ronin"
	icon_state = "ronin"

/datum/sprite_accessory/hair/head/shaved
	name = "Shaved"
	icon_state = "shaved"

/datum/sprite_accessory/hair/head/shavedpart
	name = "Shaved Part"
	icon_state = "shavedpart"

/datum/sprite_accessory/hair/head/shortbangs
	name = "Short Bangs"
	icon_state = "shortbangs"

/datum/sprite_accessory/hair/head/short
	name = "Short Hair"
	icon_state = "short"

/datum/sprite_accessory/hair/head/shorthair2
	name = "Short Hair 2"
	icon_state = "shorthair2"

/datum/sprite_accessory/hair/head/shorthair3
	name = "Short Hair 3"
	icon_state = "shorthair3"

/datum/sprite_accessory/hair/head/shorthair7
	name = "Short Hair 7"
	icon_state = "shorthairg"

/datum/sprite_accessory/hair/head/rosa
	name = "Short Hair Rosa"
	icon_state = "rosa"

/datum/sprite_accessory/hair/head/shoulderlength
	name = "Shoulder-length Hair"
	icon_state = "shoulder"

/datum/sprite_accessory/hair/head/sidecut
	name = "Sidecut"
	icon_state = "sidecut"

/datum/sprite_accessory/hair/head/skinhead
	name = "Skinhead"
	icon_state = "skinhead"

/datum/sprite_accessory/hair/head/protagonist
	name = "Slightly Long Hair"
	icon_state = "protagonist"

/datum/sprite_accessory/hair/head/spiky
	name = "Spiky"
	icon_state = "spikey"

/datum/sprite_accessory/hair/head/spiky2
	name = "Spiky 2"
	icon_state = "spiky"

/datum/sprite_accessory/hair/head/spiky3
	name = "Spiky 3"
	icon_state = "spiky2"

/datum/sprite_accessory/hair/head/swept
	name = "Swept Back Hair"
	icon_state = "swept"

/datum/sprite_accessory/hair/head/swept2
	name = "Swept Back Hair 2"
	icon_state = "swept2"

/datum/sprite_accessory/hair/head/thinning
	name = "Thinning"
	icon_state = "thinning"

/datum/sprite_accessory/hair/head/thinningfront
	name = "Thinning (Front)"
	icon_state = "thinningfront"

/datum/sprite_accessory/hair/head/thinningrear
	name = "Thinning (Rear)"
	icon_state = "thinningrear"

/datum/sprite_accessory/hair/head/topknot
	name = "Topknot"
	icon_state = "topknot"

/datum/sprite_accessory/hair/head/tressshoulder
	name = "Tress Shoulder"
	icon_state = "tressshoulder"

/datum/sprite_accessory/hair/head/trimmed
	name = "Trimmed"
	icon_state = "trimmed"

/datum/sprite_accessory/hair/head/trimflat
	name = "Trim Flat"
	icon_state = "trimflat"

/datum/sprite_accessory/hair/head/twintails
	name = "Twintails"
	icon_state = "twintail"

/datum/sprite_accessory/hair/head/undercut
	name = "Undercut"
	icon_state = "undercut"

/datum/sprite_accessory/hair/head/undercutleft
	name = "Undercut Left"
	icon_state = "undercutleft"

/datum/sprite_accessory/hair/head/undercutright
	name = "Undercut Right"
	icon_state = "undercutright"

/datum/sprite_accessory/hair/head/unkept
	name = "Unkept"
	icon_state = "unkept"

/datum/sprite_accessory/hair/head/updo
	name = "Updo"
	icon_state = "updo"

/datum/sprite_accessory/hair/head/longer
	name = "Very Long Hair"
	icon_state = "vlong"

/datum/sprite_accessory/hair/head/longest
	name = "Very Long Hair 2"
	icon_state = "longest"

/datum/sprite_accessory/hair/head/longest2
	name = "Very Long Over Eye"
	icon_state = "longest2"

/datum/sprite_accessory/hair/head/veryshortovereye
	name = "Very Short Over Eye"
	icon_state = "veryshortovereyealternate"

/datum/sprite_accessory/hair/head/longestalt
	name = "Very Long with Fringe"
	icon_state = "vlongfringe"

/datum/sprite_accessory/hair/head/volaju
	name = "Volaju"
	icon_state = "volaju"

/datum/sprite_accessory/hair/head/wisp
	name = "Wisp"
	icon_state = "wisp"

/datum/sprite_accessory/hair/head/hyenamane
	name = "Hyena Mane"
	icon_state = "hyenamane"

/datum/sprite_accessory/hair/head/forelock
	name = "Forelock"
	icon_state = "forelock"

/datum/sprite_accessory/hair/head/pirate
	name = "Pirate"
	icon_state = "pirate"

/datum/sprite_accessory/hair/head/shavedmohawk
	name = "Shaved Mohawk"
	icon_state = "shavedmohawk"

/datum/sprite_accessory/hair/head/baldfade
	name = "Bald Fade"
	icon_state = "baldfade"

/datum/sprite_accessory/hair/head/rogue
	name = "Rogue"
	icon_state = "rogue"

/datum/sprite_accessory/hair/head/romantic
	name = "Romantic"
	icon_state = "romantic"

/datum/sprite_accessory/hair/head/runt
	name = "Runt"
	icon_state = "runt"

/datum/sprite_accessory/hair/head/son
	name = "Son"
	icon_state = "son"

/datum/sprite_accessory/hair/head/bog
	name = "Bog"
	icon_state = "bog"

/datum/sprite_accessory/hair/head/scout
	name = "Scout"
	icon_state = "scout"

/datum/sprite_accessory/hair/head/son2
	name = "Son (Alt)"
	icon_state = "son2"

/datum/sprite_accessory/hair/head/long4
	name = "Long (Fourth)"
	icon_state = "long4"

/datum/sprite_accessory/hair/head/amazon
	name = "Amazon"
	icon_state = "amazon"

/datum/sprite_accessory/hair/head/longstraightponytail
	name = "Long Ponytail"
	icon_state = "longstraightponytail"

/datum/sprite_accessory/hair/head/barmaid
	name = "Barmaid"
	icon_state = "barmaid"

/datum/sprite_accessory/hair/head/bob_rt
	name = "Bob (Rogue)"
	icon_state = "bob_rt"

/datum/sprite_accessory/hair/head/messy_rt
	name = "Messy (Rogue)"
	icon_state = "messy_rt"

/datum/sprite_accessory/hair/head/homely
	name = "Homely"
	icon_state = "homely"

/datum/sprite_accessory/hair/head/longtails
	name = "Longtails"
	icon_state = "longtails"

/datum/sprite_accessory/hair/head/hime
	name = "Hime"
	icon_state = "hime"

/datum/sprite_accessory/hair/head/manbun
	name = "Manbun"
	icon_state = "manbun"

/datum/sprite_accessory/hair/head/tied
	name = "Tied"
	icon_state = "tied"

/datum/sprite_accessory/hair/head/tied2
	name = "Tied (Alt)"
	icon_state = "tied2"

/datum/sprite_accessory/hair/head/fatherless
	name = "Fatherless"
	icon_state = "fatherless"

/datum/sprite_accessory/hair/head/fatherless2
	name = "Fatherless (Alt)"
	icon_state = "fatherless2"

/datum/sprite_accessory/hair/head/kepthair
	name = "Kepthair"
	icon_state = "kepthair"

/datum/sprite_accessory/hair/head/singlebraid
	name = "Single Braid"
	icon_state = "singlebraid"

/datum/sprite_accessory/hair/head/vulpkian
	abstract_type = /datum/sprite_accessory/hair/head/vulpkian
	icon = 'icons/mob/sprite_accessory/hair/vulpkian_hair.dmi'

/datum/sprite_accessory/hair/head/vulpkian/anita
	name = "Vulpkian Anita"
	icon_state = "anita"

/datum/sprite_accessory/hair/head/vulpkian/jagged
	name = "Vulpkian Jagged"
	icon_state = "jagged"

/datum/sprite_accessory/hair/head/vulpkian/kajam1
	name = "Vulpkian Kajam 1"
	icon_state = "kajam1"

/datum/sprite_accessory/hair/head/vulpkian/kajam2
	name = "Vulpkian Kajam 2"
	icon_state = "kajam2"

/datum/sprite_accessory/hair/head/vulpkian/keid
	name = "Vulpkian Keid"
	icon_state = "keid"

/datum/sprite_accessory/hair/head/vulpkian/mizar
	name = "Vulpkian Mizar"
	icon_state = "mizar"

/datum/sprite_accessory/hair/head/vulpkian/raine
	name = "Vulpkian Raine"
	icon_state = "raine"

/datum/sprite_accessory/hair/facial
	abstract_type = /datum/sprite_accessory/hair/facial
	icon = 'icons/mob/sprite_accessory/hair/human_facial_hair.dmi'

/datum/sprite_accessory/hair/facial/is_visible(obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	return is_human_part_visible(owner, HIDEFACIALHAIR)

/datum/sprite_accessory/hair/facial/shaved
	name = "Shaved"
	icon_state = null

/datum/sprite_accessory/hair/facial/abe
	name = "Beard (Abraham Lincoln)"
	icon_state = "abe"

/datum/sprite_accessory/hair/facial/brokenman
	name = "Beard (Broken Man)"
	icon_state = "brokenman"

/datum/sprite_accessory/hair/facial/chinstrap
	name = "Beard (Chinstrap)"
	icon_state = "chin"

/datum/sprite_accessory/hair/facial/dwarf
	name = "Beard (Dwarf)"
	icon_state = "dwarf"

/datum/sprite_accessory/hair/facial/fullbeard
	name = "Beard (Full)"
	icon_state = "fullbeard"

/datum/sprite_accessory/hair/facial/croppedfullbeard
	name = "Beard (Cropped Fullbeard)"
	icon_state = "croppedfullbeard"

/datum/sprite_accessory/hair/facial/gt
	name = "Beard (Goatee)"
	icon_state = "gt"

/datum/sprite_accessory/hair/facial/hip
	name = "Beard (Hipster)"
	icon_state = "hip"

/datum/sprite_accessory/hair/facial/jensen
	name = "Beard (Jensen)"
	icon_state = "jensen"

/datum/sprite_accessory/hair/facial/neckbeard
	name = "Beard (Neckbeard)"
	icon_state = "neckbeard"

/datum/sprite_accessory/hair/facial/vlongbeard
	name = "Beard (Very Long)"
	icon_state = "wise"

/datum/sprite_accessory/hair/facial/muttonmus
	name = "Beard (Muttonmus)"
	icon_state = "muttonmus"

/datum/sprite_accessory/hair/facial/martialartist
	name = "Beard (Martial Artist)"
	icon_state = "martialartist"

/datum/sprite_accessory/hair/facial/chinlessbeard
	name = "Beard (Chinless Beard)"
	icon_state = "chinlessbeard"

/datum/sprite_accessory/hair/facial/moonshiner
	name = "Beard (Moonshiner)"
	icon_state = "moonshiner"

/datum/sprite_accessory/hair/facial/longbeard
	name = "Beard (Long)"
	icon_state = "longbeard"

/datum/sprite_accessory/hair/facial/volaju
	name = "Beard (Volaju)"
	icon_state = "volaju"

/datum/sprite_accessory/hair/facial/threeoclock
	name = "Beard (Three o Clock Shadow)"
	icon_state = "3oclock"

/datum/sprite_accessory/hair/facial/fiveoclock
	name = "Beard (Five o Clock Shadow)"
	icon_state = "5oclock"

/datum/sprite_accessory/hair/facial/fiveoclockm
	name = "Beard (Five o Clock Moustache)"
	icon_state = "5oclock_moustache"

/datum/sprite_accessory/hair/facial/sevenoclock
	name = "Beard (Seven o Clock Shadow)"
	icon_state = "7oclock"

/datum/sprite_accessory/hair/facial/sevenoclockm
	name = "Beard (Seven o Clock Moustache)"
	icon_state = "7oclock_moustache"

/datum/sprite_accessory/hair/facial/stubble
	name = "Beard (Stubble)"
	icon_state = "stubble"

/datum/sprite_accessory/hair/facial/pipe
	name = "Beard (Pipe)"
	icon_state = "pipe"

/datum/sprite_accessory/hair/facial/knightly
	name = "Beard (Knightly)"
	icon_state = "knightly"

/datum/sprite_accessory/hair/facial/manly
	name = "Beard (Manly)"
	icon_state = "manly"

/datum/sprite_accessory/hair/facial/viking
	name = "Beard (Viking)"
	icon_state = "viking"

/datum/sprite_accessory/hair/facial/moustache
	name = "Moustache"
	icon_state = "moustache"

/datum/sprite_accessory/hair/facial/fiveoclockmoustache
	name = "Moustache (Five o Clock)"
	icon_state = "5oclockmoustache"

/datum/sprite_accessory/hair/facial/pencilstache
	name = "Moustache (Pencilstache)"
	icon_state = "pencilstache"

/datum/sprite_accessory/hair/facial/smallstache
	name = "Moustache (Smallstache)"
	icon_state = "smallstache"

/datum/sprite_accessory/hair/facial/walrus
	name = "Moustache (Walrus)"
	icon_state = "walrus"

/datum/sprite_accessory/hair/facial/fu
	name = "Moustache (Fu Manchu)"
	icon_state = "fumanchu"

/datum/sprite_accessory/hair/facial/hogan
	name = "Moustache (Hulk Hogan)"
	icon_state = "hogan"

/datum/sprite_accessory/hair/facial/selleck
	name = "Moustache (Selleck)"
	icon_state = "selleck"

/datum/sprite_accessory/hair/facial/chaplin
	name = "Moustache (Square)"
	icon_state = "chaplin"

/datum/sprite_accessory/hair/facial/vandyke
	name = "Moustache (Van Dyke)"
	icon_state = "vandyke"

/datum/sprite_accessory/hair/facial/watson
	name = "Moustache (Watson)"
	icon_state = "watson"

/datum/sprite_accessory/hair/facial/sideburn
	name = "Sideburns"
	icon_state = "sideburns"

/datum/sprite_accessory/hair/facial/burns
	name = "Sideburns (Burns)"
	icon_state = "burns"

/datum/sprite_accessory/hair/facial/elvis
	name = "Sideburns (Elvis)"
	icon_state = "elvis"

/datum/sprite_accessory/hair/facial/mutton
	name = "Sideburns (Mutton Chops)"
	icon_state = "mutton"

/datum/sprite_accessory/hair/head/vox
	abstract_type = /datum/sprite_accessory/hair/head/vox
	icon = 'icons/mob/sprite_accessory/hair/vox_hair.dmi'

/datum/sprite_accessory/hair/head/vox/afro
	name = "Afro"
	icon_state = "afro"

/datum/sprite_accessory/hair/head/vox/crestedquills
	name = "Crested Quills"
	icon_state = "crestedquills"

/datum/sprite_accessory/hair/head/vox/emperorquills
	name = "Emperor Quills"
	icon_state = "emperorquills"

/datum/sprite_accessory/hair/head/vox/horns
	name = "Horns"
	icon_state = "horns"

/datum/sprite_accessory/hair/head/vox/keelquills
	name = "Keel Quills"
	icon_state = "keelquills"

/datum/sprite_accessory/hair/head/vox/keetquills
	name = "Keet Quills"
	icon_state = "keetquills"

/datum/sprite_accessory/hair/head/vox/kingly
	name = "Kingly"
	icon_state = "kingly"

/datum/sprite_accessory/hair/head/vox/mohawk
	name = "Mohawk"
	icon_state = "mohawk"

/datum/sprite_accessory/hair/head/vox/nights
	name = "Nights"
	icon_state = "nights"

/datum/sprite_accessory/hair/head/vox/razorclipped
	name = "Razor Clipped"
	icon_state = "razorclipped"

/datum/sprite_accessory/hair/head/vox/razor
	name = "Razor"
	icon_state = "razor"

/datum/sprite_accessory/hair/head/vox/shortquills
	name = "Short Quills"
	icon_state = "shortquills"

/datum/sprite_accessory/hair/head/vox/tielquills
	name = "Tiel Quills"
	icon_state = "tielquills"

/datum/sprite_accessory/hair/head/vox/yasu
	name = "Yasu"
	icon_state = "yasu"

/datum/sprite_accessory/hair/facial/vox
	abstract_type = /datum/sprite_accessory/hair/facial/vox
	icon = 'icons/mob/sprite_accessory/hair/vox_facial_hair.dmi'

/datum/sprite_accessory/hair/facial/vox/beard
	name = "Beard"
	icon_state = "beard"

/datum/sprite_accessory/hair/facial/vox/colonel
	name = "Beard (Colonel)"
	icon_state = "colonel"

/datum/sprite_accessory/hair/facial/vox/fu
	name = "Beard (Fu)"
	icon_state = "fu"

/datum/sprite_accessory/hair/facial/vox/neck
	name = "Neck Quills"
	icon_state = "neck"
