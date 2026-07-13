function scr_progression_addXp(amount) {

	var playerData = global.gameData.playerData;

	playerData.xp += amount;

	while (playerData.xp >= scr_progression_xpRequired(playerData.level)) {

	    playerData.xp -= scr_progression_xpRequired(playerData.level);
	    playerData.level++;

	}
		
}

function scr_progression_xpRequired(level) {

	var req = 5000;
	
	var inc = 0;
	
	repeat(level) {
		
		inc += 2500;
		req += inc;
		
	}
	
	return req;
	
}