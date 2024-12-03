#define GET_AI_BEHAVIOR(behavior_type) SSai_behaviors.ai_behaviors[behavior_type]
#define HAS_AI_CONTROLLER_TYPE(thing, type) istype(thing?.ai_controller, type)
#define AI_STATUS_ON		1
#define AI_STATUS_OFF		2
///Carbon checks
#define SHOULD_RESIST(source) (source.on_fire || source.buckled || HAS_TRAIT(source, TRAIT_RESTRAINED) || (source.pulledby && source.pulledby.grab_state > GRAB_PASSIVE))
#define IS_DEAD_OR_INCAP(source) (source.incapacitated() || IS_IN_STASIS(source) || source.stat)
///Max pathing attempts before auto-fail
#define MAX_PATHING_ATTEMPTS 30
///Flags for ai_behavior new()
#define AI_CONTROLLER_INCOMPATIBLE (1<<0)
///Does this task require movement from the AI before it can be performed?
#define AI_BEHAVIOR_REQUIRE_MOVEMENT (1<<0)
///Does this task let you perform the action while you move closer? (Things like moving and shooting)
#define AI_BEHAVIOR_MOVE_AND_PERFORM (1<<1)
///Cooldown on planning if planning failed last time
#define AI_FAILED_PLANNING_COOLDOWN 1.5 SECONDS
///Subtree defines
///This subtree should cancel any further planning, (Including from other subtrees)
#define SUBTREE_RETURN_FINISH_PLANNING 1
///AI flags
#define STOP_MOVING_WHEN_PULLED (1<<0)
//Generic BB keys
#define BB_CURRENT_MIN_MOVE_DISTANCE "min_move_distance"
