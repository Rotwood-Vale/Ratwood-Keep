/obj/structure/roguemachine/lottery_roguetown
	name = "XYLIX'S FORTUNE"
	desc = "An infinite, yawning hole that makes or breaks men."
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "lottery"
	density = FALSE
	pixel_y = 32
	var/gamblingprice = 0
	var/gamblingprob = 2
	var/diceroll = 100
	var/maxtithing = 100
	var/stopgambling = 0


/obj/structure/roguemachine/lottery_roguetown/attack_hand(mob/living/user) //empty hand

	src.say("Your current tithe is [src.gamblingprice]. Care to spin?")
	playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
	return

/obj/structure/roguemachine/lottery_roguetown/attackby(obj/item/roguecoin/P, mob/living/user)

	. = ..()

	if(istype(P, /obj/item/roguecoin))
		if(src.gamblingprice + (P.sellprice * P.quantity) > src.maxtithing)
			say("This puts the starting tithe over [src.maxtithing] mammons.")
			playsound(src, 'sound/misc/machineno.ogg', 100, FALSE, -1)
			return

		else
			src.gamblingprice += (P.sellprice * P.quantity)
			qdel(P)
			src.say("Your current tithe is now [src.gamblingprice]. Care to spin?")
			playsound(src, 'sound/misc/machinequestion.ogg', 100, FALSE, -1)
			return


/obj/structure/roguemachine/lottery_roguetown/MiddleClick(mob/living/user, params) //LET'S GO GAMBLING
//checks - is it time to go gambling??
	if(src.stopgambling == 1)
		return
	if(src.gamblingprice == 0)
		src.say(pick("Eager fool; you need mammons to gamble your life away.", "You are missing your tithe.", "A lord without land is no lord at all."))
		return


	else
		src.diceroll = rand(1,100)
		src.say(pick("Around and around I go, where I stop, only I know.", "Xylix smiles upon your idiocy, child.", "The wheel of fate spins, and spins.", "Oh, you poor fool.", "This is going to hurt for one of us.", "I laugh, you cry; I weep, you cheer..", "I will be your fool; I'll perform for you...", "Let's go gambling!",))
		playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
		playsound(src, 'sound/misc/letsgogambling.ogg', 100, FALSE, -1)
		src.gamblingprob += (user.STALUC - 8)
		src.stopgambling = 1

//thug shaker
		var/oldx = pixel_x
		animate(src, pixel_x = oldx+1, time = 1)
		animate(pixel_x = oldx-1, time = 1)
		animate(pixel_x = oldx, time = .5)

		sleep(50)

		if(src.gamblingprob > src.diceroll)
			src.gamblingprice *= 2
			src.say("Well-maneuvered, aristocrat. Your peasant's tithe is now [src.gamblingprice]. Play again?")
			playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
			src.stopgambling = 0
			src.gamblingprob = 0
			return
		else
			src.gamblingprice = 0
			src.say(pick("TEN, WHEEL OF FORTUNE - inversed.", "The Castle. O, Omen!", "A harvest of locusts...!.", "Look into my eyes and whisper your woes.", "Aw, dangit.", "Fool. Poor fool.", "Your eyes leak out of your skull, drool falling from your lips.", "Divine idiocy."))
			playsound(src, 'sound/misc/bug.ogg', 100, FALSE, -1)
			sleep(20)
			src.stopgambling = 0
			src.say("King of fools, your land is barren. Play again?")
			playsound(src, 'sound/misc/bug.ogg', 100, FALSE, -1)
			src.gamblingprob = 0
			return



/obj/structure/roguemachine/lottery_roguetown/attack_right(mob/living/user) //how the fuck do i
	. = ..()
	if(!ishuman(user))
		return
	else
		if(gamblingprice <= 0)
			say("Poor thing, you are coinless.")
			return
		if(gamblingprice < 0)
			say("Your peasant's tithe is NEGATIVE.")
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
		var/coin_amt = input(user, "Sayyid, you have [src.gamblingprice] mammon in tithes. You may withdraw [floor(gamblingprice/mod)] [selection] COINS.", src) as null|num
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


