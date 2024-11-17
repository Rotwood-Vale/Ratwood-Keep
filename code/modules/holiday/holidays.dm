/datum/holiday
	var/name = "Bugsgiving"

	var/begin_day = 1
	var/begin_month = 0
	var/end_day = 0 // Default of 0 means the holiday lasts a single day
	var/end_month = 0
	var/begin_week = FALSE //If set to a number, then this holiday will begin on certain week
	var/begin_weekday = FALSE //If set to a weekday, then this will trigger the holiday on the above week
	var/always_celebrate = FALSE // for christmas neverending, or testing.
	var/current_year = 0
	var/year_offset = 0
	var/obj/item/drone_hat //If this is defined, drones without a default hat will spawn with this one during the holiday; check drones_as_items.dm to see this used

// This proc gets run before the game starts when the holiday is activated. Do festive shit here.
/datum/holiday/proc/celebrate()
	return

// When the round starts, this proc is ran to get a text message to display to everyone to wish them a happy holiday
/datum/holiday/proc/greet()
	return "Have a happy [name]!"

// Returns special prefixes for the station name on certain days. You wind up with names like "Christmas Object Epsilon". See new_station_name()
/datum/holiday/proc/getStationPrefix()
	//get the first word of the Holiday and use that
	var/i = findtext(name," ",1,0)
	return copytext(name,1,i)

// Return 1 if this holidy should be celebrated today
/datum/holiday/proc/shouldCelebrate(dd, mm, yy, ww, ddd)
	if(always_celebrate)
		return TRUE

	if(!end_day)
		end_day = begin_day
	if(!end_month)
		end_month = begin_month
	if(begin_week && begin_weekday)
		if(begin_week == ww && begin_weekday == ddd && begin_month == mm)
			return TRUE
	if(end_month > begin_month) //holiday spans multiple months in one year
		if(mm == end_month) //in final month
			if(dd <= end_day)
				return TRUE

		else if(mm == begin_month)//in first month
			if(dd >= begin_day)
				return TRUE

		else if(mm in begin_month to end_month) //holiday spans 3+ months and we're in the middle, day doesn't matter at all
			return TRUE

	else if(end_month == begin_month) // starts and stops in same month, simplest case
		if(mm == begin_month && (dd in begin_day to end_day))
			return TRUE

	else // starts in one year, ends in the next
		if(mm >= begin_month && dd >= begin_day) // Holiday ends next year
			return TRUE
		if(mm <= end_month && dd <= end_day) // Holiday started last year
			return TRUE

	return FALSE
