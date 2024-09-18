/obj/structure/lottery_roguetown
	name = "XYLIX'S FORTUNE"
	desc = "An infinite, yawning hole that makes or breaks men."
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "feedinghole"
	density = FALSE
	pixel_y = 32
	var/gamblingprice = 0
	var/gamblingprob = 0
	var/diceroll = 100
	var/maxtithing = 100


/obj/structure/lottery_roguetown/attack_hand(mob/living/user, obj/item/P)

	. = ..()

	if(istype(P, /obj/item/roguecoin))
		if(src.gamblingprice + P.gamblingprice > src.maxtithing)
			say("This puts the bounty over 100 mammons. I am meant for poorer fools, not kings.")
			return
	else
		src.gamblingprice += P.gamblingprice
		qdel(P)
		src.say("Your current tithe is now [src.gamblingprice]. Care to spin?")
		playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
		playsound(src, 'sound/misc/machineno.ogg', 100, FALSE, -1)
		return
	else
		src.say("Your current tithe is [src.gamblingprice]. Care to spin?")
		playsound(src, 'sound/misc/machineno.ogg', 100, FALSE, -1)
		playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
		return

/obj/structure/lottery_roguetown/MiddleClick(mob/living/user, params) //LET'S GO GAMBLING

	src.diceroll = rand(1,100)
	src.say(pick("Around and around I go, where I stop, only I know.", "Xylix smiles upon your idiocy, child.", "The wheel of fate spins, and spins.", "Oh, you poor fool.", "This is going to hurt for one of us.", "I laugh, you cry; I weep, you yell.", "I will be your fool; I'll perform for you...", "Let's go gambling!")
	user.STAINT += src.gamblingprob
	sleep(50)
	if(src.gamblingprob < src.diceroll)
		src.gamblingprice = 0
		src.say(pick("TEN, WHEEL OF FORTUNE - inversed.", "The Castle, O, Omen!", "Your current tithe is zero. ...Oh, you've lost, by the way.", "Look into my eyes and whisper your woes.")
		return
	if(src.gamblingprob >= src.diceroll)
		src.gamblingprice *= 2
		src.say("Your peasant's tithe is now [src.gamblingprice]. Play again?"