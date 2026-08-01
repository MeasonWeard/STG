global.skillScreenController = self;
playerData = global.gameData.playerData;

var spent = scr_progression_countSpentSkillPoints()
totalPoints = scr_progression_getTotalSkillPoints();
points = max(0, totalPoints - spent);

back = function() {

	var unlockedSkills = [];

	with (obj_skillNode) {
	
		if (!is_struct(thisSkill)) continue;
		if (thisSkill.level < 1) continue;
	
		var skillStruct = {};
		
		scr_data_structCopyInto(skillStruct, thisSkill);
	
		array_push(unlockedSkills, skillStruct);
	
	}
	
	global.selectedClass.unlockedSkills = unlockedSkills;
	scr_file_saveGame(global.saveFile, global.gameData);

	if (global.gameData.playerData.class2 == undefined) {
		if (instance_exists(global.player)) instance_destroy(global.player);
		room_goto(stage_hub1);
	} else {
		room_goto(room_skillsMainMenu);
	}
	
	
}