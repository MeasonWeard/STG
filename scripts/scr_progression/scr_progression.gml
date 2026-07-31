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