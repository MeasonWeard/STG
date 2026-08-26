font = fnt_large;
col = c_lime;

textGetter = function() {

	var name = global.gameData.playerData.name;
	var lvl = global.gameData.playerData.level;
	
	return name + "    |    Level: " + string(lvl);
	
}