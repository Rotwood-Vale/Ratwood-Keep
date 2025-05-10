//CANATMOSPASS
#define ATMOS_PASS_YES 1
#define ATMOS_PASS_NO 0
/// ask CanAtmosPass()
#define ATMOS_PASS_PROC -1
/// just check density
#define ATMOS_PASS_DENSITY -2

#define CANATMOSPASS(A, O) ( A.CanAtmosPass == ATMOS_PASS_PROC ? A.CanAtmosPass(O) : ( A.CanAtmosPass == ATMOS_PASS_DENSITY ? !A.density : A.CanAtmosPass ) )
#define CANVERTICALATMOSPASS(A, O) ( A.CanAtmosPassVertical == ATMOS_PASS_PROC ? A.CanAtmosPass(O, TRUE) : ( A.CanAtmosPassVertical == ATMOS_PASS_DENSITY ? !A.density : A.CanAtmosPassVertical ) )
#define CALCULATE_ADJACENT_TURFS(T) SSadjacent_air.queue[T] = 1

/// 0degC
#define T0C						273.15
/// 20degC
#define T20C					293.15
/// 100degC
#define T100C                   373.15