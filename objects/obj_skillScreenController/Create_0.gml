global.skillScreenController = self;
playerData = global.gameData.playerData;

var spent = scr_skills_countSpentSkillPoints()
totalPoints = scr_skills_getTotalSkillPoints();
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

	room_goto(stage_hub1);
	
}