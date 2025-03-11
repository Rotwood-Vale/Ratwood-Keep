//funny movement signals

#define COMSIG_FUNNY_MOVEMENT_AVADJ "funny_movement_angular_velocity_adjustment"
	#define COMPONENT_FUNNY_MOVEMENT_BLOCK_AVADJ (1<<0)

#define COMSIG_FUNNY_MOVEMENT_DRAG "funny_movement_drag"
	#define COMPONENT_FUNNY_MOVEMENT_BLOCK_DRAG (1<<0)

#define COMSIG_FUNNY_MOVEMENT_THRUST "funny_movement_thrust"
	#define COMPONENT_FUNNY_MOVEMENT_BLOCK_THRUST (1<<0)

	#define COMSIG_FUNNY_MOVEMENT_ACCELERATION "funny_movement_acceleration"
		#define COMPONENT_FUNNY_MOVEMENT_BLOCK_ACCELERATION (1<<0)

#define COMSIG_FUNNY_MOVEMENT_PROCESSING_START "funny_movement_processing_start"
#define COMSIG_FUNNY_MOVEMENT_PROCESSING_FINISH "funny_movement_processing_finish"

/obj/vehicle/sealed/tank
	name = "\improper Baneblade"
	icon = 'modular_redmoon/icons/car.dmi'
	icon_state = "tank"
	bound_width = 32 * 3
	bound_height = 32 * 3
	pixel_x = -16
	pixel_y = -16
	max_integrity = 2000
	armor = list(MELEE = 50, BULLET = 30, LASER = 30, ENERGY = 30, BOMB = 50, BIO = 0, RAD = 0, FIRE = 100, ACID = 100)
	move_force = MOVE_FORCE_VERY_STRONG
	move_resist = MOVE_FORCE_EXTREMELY_STRONG
	// generic_canpass = FALSE
	var/datum/component/funny_movement/movement
	var/ram_velocity = 1
	var/phase_velocity = 10
	var/driver_rotation = 15

/obj/vehicle/sealed/tank/ComponentInitialize()
	movement = AddComponent(/datum/component/funny_movement)
	movement.icon_dir_num = 4
	movement.maxthrust_forward = 5
	movement.maxthrust_backward = 4
	RegisterSignal(movement, COMSIG_FUNNY_MOVEMENT_PROCESSING_FINISH, PROC_REF(funny_movement_moved))

/obj/vehicle/sealed/tank/proc/funny_movement_moved()
	SIGNAL_HANDLER
	movement.desired_thrust_dir = 0

/obj/vehicle/sealed/tank/vehicle_move(direction)
	if(direction & NORTH)
		movement.desired_thrust_dir |= NORTH
	if(direction & SOUTH)
		movement.desired_thrust_dir |= SOUTH
	if(direction & WEST)
		movement.desired_angle = movement.angle - driver_rotation
	if(direction & EAST)
		movement.desired_angle = movement.angle + driver_rotation

/obj/vehicle/sealed/tank/Move(atom/newloc, direct, glide_size_override)
	ram(newloc)
	. = ..()

/obj/vehicle/sealed/tank/proc/funni(amount = 20)
	movement.apply_impulse_at_angle(movement.angle, amount)

/obj/vehicle/sealed/tank/proc/ram(atom/newloc)
	var/velocity_mag = sqrt(movement.velocity_x**2 + movement.velocity_y**2)
	if(velocity_mag > phase_velocity)
		movement_type |= UNSTOPPABLE
	else
		movement_type &= ~UNSTOPPABLE

	if(velocity_mag > ram_velocity)
		var/list/newlocs = isturf(newloc) ? block(locate(newloc.x+(-bound_x) / world.icon_size, newloc.y+(-bound_y) / world.icon_size, newloc.z), locate(newloc.x+(-bound_x+bound_width) / world.icon_size-1, newloc.y+(-bound_y+bound_height) / world.icon_size-1, newloc.z)) : list(newloc)
		if(newlocs)
			for(var/turf/T in newlocs & locs)
				if(!isopenturf(T))
					continue
				for(var/atom/A in T.contents)
					if(A == src || (A in occupants))
						continue
					if(isliving(A))
						var/mob/living/rammed = A
						visible_message(span_danger("<b>[capitalize(src)]</b> давит <b>[A]</b>!"))
						playsound(src, 'sound/misc/bang.ogg', 50, 1)
						rammed.energy_add(-400)
						rammed.stamina_add(50)
						rammed.apply_damage(rand(200,400), BRUTE)
						continue
					if(isobj(A) && A.density)
						var/obj/dead_obj = A
						dead_obj.take_damage(INFINITY, BRUTE, NONE, TRUE, dir, INFINITY)
						continue
