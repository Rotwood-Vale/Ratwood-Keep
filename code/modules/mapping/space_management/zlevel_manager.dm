// Populate the space level list and prepare space transitions
/datum/controller/subsystem/mapping/proc/InitializeDefaultZLevels()
    if (z_list)  // subsystem/Recover or badminnery, no need
        return

    z_list = list()
    var/list/default_map_traits = DEFAULT_MAP_TRAITS

    // Ensure the number of traits matches the number of Z-levels
    if (default_map_traits.len != world.maxz)
        WARNING("Mismatch between the number of map traits ([default_map_traits.len]) and the number of Z-levels ([world.maxz]). Adjusting.")
        if (default_map_traits.len > world.maxz)
            default_map_traits.Cut(world.maxz + 1)  // Remove excess traits
        else
            for (var/i in (default_map_traits.len + 1) to world.maxz)
                default_map_traits += list(list(ZTRAIT_STATION = TRUE))  // Add default traits for missing Z-levels

    // Initialize Z-levels
    for (var/I in 1 to world.maxz)
        var/list/features = default_map_traits[I]
        var/datum/space_level/S = new(I, features[DL_NAME], features[DL_TRAITS])
        z_list += S

/datum/controller/subsystem/mapping/proc/add_new_zlevel(name, traits = list(), z_type = /datum/space_level)
    SEND_GLOBAL_SIGNAL(COMSIG_GLOB_NEW_Z, args)
    var/new_z = z_list.len + 1
    if (world.maxz < new_z)
        world.incrementMaxZ()
    CHECK_TICK
    // Create the new Z-level
    var/datum/space_level/S = new z_type(new_z, name, traits)
    z_list += S
    return S

/datum/controller/subsystem/mapping/proc/get_level(z)
    if (z_list && z >= 1 && z <= z_list.len)
        return z_list[z]
    var/list_len = z_list ? z_list.len : "no Z-levels available"
    CRASH("Unmanaged Z-level [z]! maxz = [world.maxz], z_list.len = [list_len]")
