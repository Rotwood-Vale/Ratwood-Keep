/datum/component/funny_movement //отрезано от спейсподов
	var/velocity_x = 0 // tiles per second.
	var/velocity_y = 0
	var/offset_x = 0 // like pixel_x/y but in tiles
	var/offset_y = 0

	var/angle = 0 // degrees, clockwise
	var/angular_velocity = 0 // degrees per second
	var/max_angular_acceleration = 360 // in degrees per second per second

	var/brakes = FALSE//TRUE
	var/desired_thrust_dir = 0
	var/desired_angle = null

	var/maxthrust_forward = 1
	var/maxthrust_backward = 1
	var/maxthrust_sides = 1

	var/bump_impulse = 0.6
	var/bounce_factor = 0.2 // how much of our velocity to keep on collision
	var/lateral_bounce_factor = 0.95 // mostly there to slow you down when you drive (pilot?) down a 2x2 corridor

	var/ground_drag = 0.5

	var/default_dir = SOUTH
	var/icon_dir_num = 0 //отвечает за смену дира на спрайте и вращение трансформом. 0 - отсутствие смены дира
	var/original_animate_movement
	var/list/client/affected_viewers = list()

/datum/component/funny_movement/Initialize(mapload)
	if(!ismovable(parent))
		return COMPONENT_INCOMPATIBLE

/datum/component/funny_movement/RegisterWithParent()
	var/atom/movable/AM = parent
	original_animate_movement = AM.animate_movement
	AM.animate_movement = NO_STEPS // we do our own gliding here
	START_PROCESSING(SSfastprocess, src)
	RegisterSignal(parent, COMSIG_ATOM_BUMPED, PROC_REF(on_bumped))

/datum/component/funny_movement/UnregisterFromParent()
	var/atom/movable/AM = parent
	AM.animate_movement = original_animate_movement
	STOP_PROCESSING(SSfastprocess, src)
	UnregisterSignal(parent, COMSIG_ATOM_BUMPED)
	for(var/client/C in affected_viewers)
		animate(C, pixel_x = 0, pixel_y = 0, time = 0, flags=ANIMATION_END_NOW)

/datum/component/funny_movement/proc/on_bump(atom/movable/source, atom/A)
	var/bump_velocity = 0
	if(source.dir & (NORTH|SOUTH))
		bump_velocity = abs(velocity_y) + (abs(velocity_x) / 15)
	else
		bump_velocity = abs(velocity_x) + (abs(velocity_y) / 15)
	var/atom/movable/bumped = A
	if(istype(bumped) && !bumped.anchored && bump_velocity > 1)
		step(bumped, source.dir)

/datum/component/funny_movement/proc/on_bumped(atom/movable/source, atom/movable/A)
	SIGNAL_HANDLER
	if(A.dir & NORTH)
		velocity_y += bump_impulse
	if(A.dir & SOUTH)
		velocity_y -= bump_impulse
	if(A.dir & EAST)
		velocity_x += bump_impulse
	if(A.dir & WEST)
		velocity_x -= bump_impulse

/datum/component/funny_movement/proc/apply_impulse_at_angle(angle, amount)
	velocity_x += round(amount*cos(90 - angle), 0.01)
	velocity_y += round(amount*sin(90 - angle), 0.01)

/datum/component/funny_movement/process(delta_time)
	SEND_SIGNAL(src, COMSIG_FUNNY_MOVEMENT_PROCESSING_START)
	var/atom/movable/AM = parent
	var/last_offset_x = offset_x
	var/last_offset_y = offset_y
	var/last_angle = angle
	var/desired_angular_velocity = 0

	if(isnum(desired_angle))
		// do some finagling to make sure that our angles end up rotating the short way
		while(angle > desired_angle + 180)
			angle -= 360
			last_angle -= 360
		while(angle < desired_angle - 180)
			angle += 360
			last_angle += 360
		if(abs(desired_angle - angle) < (max_angular_acceleration * delta_time))
			desired_angular_velocity = (desired_angle - angle) / delta_time
		else if(desired_angle > angle)
			desired_angular_velocity = 2 * sqrt((desired_angle - angle) * max_angular_acceleration * 0.25)
		else
			desired_angular_velocity = -2 * sqrt((angle - desired_angle) * max_angular_acceleration * 0.25)

	var/angular_velocity_adjustment = clamp(desired_angular_velocity - angular_velocity, -max_angular_acceleration*delta_time, max_angular_acceleration*delta_time)
	if(angular_velocity_adjustment && !(SEND_SIGNAL(src, COMSIG_FUNNY_MOVEMENT_AVADJ, angular_velocity_adjustment, delta_time) & COMPONENT_FUNNY_MOVEMENT_BLOCK_AVADJ))
		angular_velocity += angular_velocity_adjustment

	angle += angular_velocity * delta_time

	// calculate drag and shit
	if(!(SEND_SIGNAL(src, COMSIG_FUNNY_MOVEMENT_DRAG, delta_time) & COMPONENT_FUNNY_MOVEMENT_BLOCK_DRAG))
		var/velocity_mag = sqrt(velocity_x*velocity_x+velocity_y*velocity_y) // magnitude
		if(velocity_mag || angular_velocity)
			var/drag = 0
			for(var/turf/T in AM.locs)
				//ground drag
				if(AM.movement_type & GROUND)
					drag += 0.001
					if((T.has_gravity()) || brakes) // brakes are a kind of magboots okay?
						drag += ground_drag

			if(velocity_mag > 20)
				drag = max(drag, (velocity_mag - 20) / delta_time)
			if(drag)
				if(velocity_mag)
					var/drag_factor = 1 - clamp(drag * delta_time / velocity_mag, 0, 1)
					velocity_x *= drag_factor
					velocity_y *= drag_factor
				if(angular_velocity != 0)
					var/drag_factor_spin = 1 - clamp(drag * 30 * delta_time / abs(angular_velocity), 0, 1)
					angular_velocity *= drag_factor_spin

	if(!(SEND_SIGNAL(src, COMSIG_FUNNY_MOVEMENT_THRUST) & COMPONENT_FUNNY_MOVEMENT_BLOCK_THRUST))
		var/thrust_x
		var/thrust_y
		var/fx = cos(90 - angle)
		var/fy = sin(90 - angle)
		var/sx = fy
		var/sy = -fx
		if(brakes)
			// basically calculates how much we can brake using the thrust
			var/forward_thrust = -((fx * velocity_x) + (fy * velocity_y)) / delta_time
			var/right_thrust = -((sx * velocity_x) + (sy * velocity_y)) / delta_time
			forward_thrust = clamp(forward_thrust, -maxthrust_backward, maxthrust_forward)
			right_thrust = clamp(right_thrust, -maxthrust_sides, maxthrust_sides)
			thrust_x += forward_thrust * fx + right_thrust * sx;
			thrust_y += forward_thrust * fy + right_thrust * sy;
		else // want some sort of help piloting the ship? Haha no fuck you do it yourself
			if(desired_thrust_dir & NORTH)
				thrust_x += fx * maxthrust_forward
				thrust_y += fy * maxthrust_forward
			if(desired_thrust_dir & SOUTH)
				thrust_x -= fx * maxthrust_backward
				thrust_y -= fy * maxthrust_backward
			if(desired_thrust_dir & EAST)
				thrust_x += sx * maxthrust_sides
				thrust_y += sy * maxthrust_sides
			if(desired_thrust_dir & WEST)
				thrust_x -= sx * maxthrust_sides
				thrust_y -= sy * maxthrust_sides

		if(!(SEND_SIGNAL(src, COMSIG_FUNNY_MOVEMENT_ACCELERATION, thrust_x, thrust_y, delta_time) & COMPONENT_FUNNY_MOVEMENT_BLOCK_ACCELERATION))
			velocity_x += thrust_x * delta_time
			velocity_y += thrust_y * delta_time

	offset_x += velocity_x * delta_time
	offset_y += velocity_y * delta_time
	// alright so now we reconcile the offsets with the in-world position.
	while((offset_x > 0 && velocity_x > 0) || (offset_y > 0 && velocity_y > 0) || (offset_x < 0 && velocity_x < 0) || (offset_y < 0 && velocity_y < 0))
		var/failed_x = FALSE
		var/failed_y = FALSE
		if(offset_x > 0 && velocity_x > 0)
			AM.dir = EAST
			if(!AM.Move(get_step(AM, EAST)))
				offset_x = 0
				failed_x = TRUE
				velocity_x *= -bounce_factor
				velocity_y *= lateral_bounce_factor
			else
				offset_x--
				last_offset_x--
		else if(offset_x < 0 && velocity_x < 0)
			AM.dir = WEST
			if(!AM.Move(get_step(AM, WEST)))
				offset_x = 0
				failed_x = TRUE
				velocity_x *= -bounce_factor
				velocity_y *= lateral_bounce_factor
			else
				offset_x++
				last_offset_x++
		else
			failed_x = TRUE
		if(offset_y > 0 && velocity_y > 0)
			AM.dir = NORTH
			if(!AM.Move(get_step(AM, NORTH)))
				offset_y = 0
				failed_y = TRUE
				velocity_y *= -bounce_factor
				velocity_x *= lateral_bounce_factor
			else
				offset_y--
				last_offset_y--
		else if(offset_y < 0 && velocity_y < 0)
			AM.dir = SOUTH
			if(!AM.Move(get_step(AM, SOUTH)))
				offset_y = 0
				failed_y = TRUE
				velocity_y *= -bounce_factor
				velocity_x *= lateral_bounce_factor
			else
				offset_y++
				last_offset_y++
		else
			failed_y = TRUE
		if(failed_x && failed_y)
			break
	// prevents situations where you go "wtf I'm clearly right next to it" as you enter a stationary spacepod
	if(velocity_x == 0)
		if(offset_x > 0.5)
			if(AM.Move(get_step(AM, EAST)))
				offset_x--
				last_offset_x--
			else
				offset_x = 0
		if(offset_x < -0.5)
			if(AM.Move(get_step(AM, WEST)))
				offset_x++
				last_offset_x++
			else
				offset_x = 0
	if(velocity_y == 0)
		if(offset_y > 0.5)
			if(AM.Move(get_step(AM, NORTH)))
				offset_y--
				last_offset_y--
			else
				offset_y = 0
		if(offset_y < -0.5)
			if(AM.Move(get_step(AM, SOUTH)))
				offset_y++
				last_offset_y++
			else
				offset_y = 0

	var/matrix/mat_from = new()
	var/matrix/mat_to = new()
	if(icon_dir_num < 4)
		if(icon_dir_num != 0)
			AM.dir = default_dir
		mat_from.Turn(last_angle)
		mat_to.Turn(angle)
	else
		AM.dir = angle2dir(angle)

	AM.transform = mat_from
	AM.pixel_x = AM.pixel_x + last_offset_x*32
	AM.pixel_y = AM.pixel_y + last_offset_y*32
	animate(AM, transform=mat_to, pixel_x = AM.pixel_x + offset_x*32, pixel_y = AM.pixel_y + offset_y*32, time = delta_time*10, flags=ANIMATION_END_NOW)

	var/list/possible_smooth_viewers = AM.contents | AM
	for(var/client/C in affected_viewers)
		if(!(C.mob in possible_smooth_viewers))
			animate(C, pixel_x = 0, pixel_y = 0, time = 0, flags=ANIMATION_END_NOW)
	affected_viewers = list()
	for(var/mob/M in possible_smooth_viewers) // reset_perspective(AM)?
		var/client/C = M.client
		if(!C)
			continue
		affected_viewers.Add(C)
		C.pixel_x = AM.pixel_x + last_offset_x*32
		C.pixel_y = AM.pixel_y + last_offset_y*32
		animate(C, pixel_x = AM.pixel_x + offset_x*32, pixel_y = AM.pixel_y + offset_y*32, time = delta_time*10, flags=ANIMATION_END_NOW)


	SEND_SIGNAL(src, COMSIG_FUNNY_MOVEMENT_PROCESSING_FINISH)
