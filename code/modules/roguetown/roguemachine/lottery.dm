/obj/structure/roguemachine/lottery_roguetown
	name = "XYLIX'S FORTUNE"
	desc = "An infinite, yawning hole that makes or breaks men."
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "lottery"
	density = FALSE
	pixel_y = 32
	var/gamblingprice = 0
	var/gamblingprob = 0
	var/diceroll = 100
	var/maxtithing = 100


/obj/structure/roguemachine/lottery_roguetown/attack_hand(mob/living/user, obj/item/P)

	. = ..()

	if(istype(P, /obj/item/roguecoin))
		if(src.gamblingprice + P.sellprice > src.maxtithing)
			say("This puts the bounty over 100 mammons. I am meant for poorer fools, not kings. Start with a smaller amount.")
			return

		else
			src.gamblingprice += P.sellprice
			qdel(P)
			src.say("Your current tithe is now [src.gamblingprice]. Care to spin?")
			playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
			playsound(src, 'sound/misc/machineno.ogg', 100, FALSE, -1)
			return

	else //empty hand or other trash click
		src.say("Your current tithe is [src.gamblingprice]. Care to spin?")
		playsound(src, 'sound/misc/machineno.ogg', 100, FALSE, -1)
		playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
		return

/obj/structure/roguemachine/lottery_roguetown/MiddleClick(mob/living/user, params) //LET'S GO GAMBLING

	src.diceroll = rand(1,100)
	src.say(pick("Around and around I go, where I stop, only I know.", "Xylix smiles upon your idiocy, child.", "The wheel of fate spins, and spins.", "Oh, you poor fool.", "This is going to hurt for one of us.", "I laugh, you cry; I weep, you yell.", "I will be your fool; I'll perform for you...", "Let's go gambling!",))
	user.STALUC += src.gamblingprob
	sleep(50)
	if(src.gamblingprob < src.diceroll)
		src.gamblingprice = 0
		src.say(pick("TEN, WHEEL OF FORTUNE - inversed.", "The Castle. O, Omen!", "Your current tithe is zero. ...Oh, you've lost, by the way.", "Look into my eyes and whisper your woes.", "Aw, dangit.", "Fool. Poor fool. Your eyes leak out of your skull, drool falling from your lips."))
		return
	if(src.gamblingprob >= src.diceroll)
		src.gamblingprice *= 2
		src.say("Your peasant's tithe is now [src.gamblingprice]. Play again?")


/obj/structure/roguemachine/lottery_roguetown/attack_right(mob/living/user) //how the fuck do i
	. = ..()
	if(!ishuman(user))
		return
		if(gamblingprice <= 0)
			say("Poor thing, you are coinless.")
			return
		if(gamblingprice < 0)
			say("Your balance is NEGATIVE.")
			return
		var/list/choicez = list()
		if(gamblingprice > 10)
			choicez += "GOLD"
		if(gamblingprice > 5)
			choicez += "SILVER"
		choicez += "BRONZE"
		var/selection = input(user, "Make a Selection", src) as null|anything in choicez
		if(!selection)
			return
		var/mod = 1
		if(selection == "GOLD")
			mod = 10
		if(selection == "SILVER")
			mod = 5
		var/coin_amt = input(user, "Moloch, you have [src.gamblingprice] mammon in tithes. You may withdraw [floor(gamblingprice/mod)] [selection] COINS from your account.", src) as null|num
		coin_amt = round(coin_amt)
		if(coin_amt < 1)
			return
		if(!Adjacent(user))
			return
		if((coin_amt*mod) > gamblingprice)
			playsound(src, 'sound/misc/machineno.ogg', 100, FALSE, -1)
			return
		else
			budget2change(coin_amt*mod, user, selection)


