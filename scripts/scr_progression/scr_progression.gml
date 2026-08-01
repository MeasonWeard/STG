function scr_progression_addXp(amount) {

	var playerData = global.gameData.playerData;

	playerData.xp += amount;

	while (playerData.xp >= scr_progression_xpRequired(playerData.level)) {

	    playerData.xp -= scr_progression_xpRequired(playerData.level);
	    playerData.level++;

	}
		
}

function scr_progression_xpRequired(level) {

	var req = 800;
	var inc = 0;

	repeat(level) {

		inc += 250;
		req += inc;

	}

	return req;
	
}

function scr_progression_calculateLevel(level, xp) {

	var newLevel = level;
	var newXp = xp;

	while (newXp >= scr_progression_xpRequired(newLevel)) {

		newXp -= scr_progression_xpRequired(newLevel);
		newLevel++;

	}

	return {
		newLevel : newLevel,
		newXp : newXp
	};

}

function scr_progression_getTotalSkillPoints() {

	var points = global.gameData.playerData.level;
	return points;
	
}

function scr_progression_countSpentSkillPoints() {
	
	var playerData = global.gameData.playerData;
	var points = 0;
	
	var class1 = playerData.class1;
	var class2 = playerData.class2;
	
	if (is_struct(class1)) {
	
		var unlockedSkills = class1.unlockedSkills;
		var len = array_length(unlockedSkills);
		
		for (var i = 0; i < len; i++) {
		
			var sk = unlockedSkills[i];
			if (!is_struct(sk)) continue;
			
			var level = sk.level;
			points += max(0, level);
		
		}
	
	}
	
	if (is_struct(class2)) {
	
		var unlockedSkills = class2.unlockedSkills;
		var len = array_length(unlockedSkills);
		
		for (var i = 0; i < len; i++) {
		
			var sk = unlockedSkills[i];
			if (!is_struct(sk)) continue;
			
			var level = sk.level;
			points += max(0, level);
		
		}
	
	}
	
	return points;
	
}