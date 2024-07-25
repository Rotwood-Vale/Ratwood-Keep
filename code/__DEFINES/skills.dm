
// Skills
#define SKILL_LEVEL_NONE 0
#define SKILL_LEVEL_NOVICE 1 //basic
#define SKILL_LEVEL_APPRENTICE 2 //novice
#define SKILL_LEVEL_JOURNEYMAN 3 //skilled
#define SKILL_LEVEL_EXPERT 4 //expert
#define SKILL_LEVEL_MASTER 5 //master
#define SKILL_LEVEL_LEGENDARY 6 //legendary

#define SKILL_EXP_NOVICE 50
#define SKILL_EXP_APPRENTICE 150
#define SKILL_EXP_JOURNEYMAN 275
#define SKILL_EXP_EXPERT 625
#define SKILL_EXP_MASTER 1200
#define SKILL_EXP_LEGENDARY 2200

// Gets the reference for the skill type that was given
#define GetSkillRef(A) (SSskills.all_skills[A])

//Blacksmith resultant skills
#define BLACKSMITH_LEVEL_MIN -10
#define BLACKSMITH_LEVEL_SPOIL -2 // you can only get this by using spoilt bars and crude skill
#define BLACKSMITH_LEVEL_AWFUL -1 // you can only get this by using poor bars and crude skill (or spoilt bars and rough skill)
#define BLACKSMITH_LEVEL_CRUDE 0
#define BLACKSMITH_LEVEL_ROUGH 1
#define BLACKSMITH_LEVEL_COMPETENT 2
#define BLACKSMITH_LEVEL_FINE 3
#define BLACKSMITH_LEVEL_FLAWLESS 4
#define BLACKSMITH_LEVEL_LEGENDARY 5
#define BLACKSMITH_LEVEL_MAX 10

//Forging resultant skills
#define SMELTERY_LEVEL_SPOIL 0
#define SMELTERY_LEVEL_POOR 1
#define SMELTERY_LEVEL_NORMAL 2
#define SMELTERY_LEVEL_GOOD 3
#define SMELTERY_LEVEL_EXPERT 4
#define SMELTERY_LEVEL_MASTER 5
#define SMELTERY_LEVEL_LEGENDARY 6
