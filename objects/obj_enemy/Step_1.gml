// Inherit the parent event
event_inherited();

if (boss) showHealthBar = true;

if (levelUp and is_callable(levelUpFunc)) {

	levelUp = false;

	var targetLevel = 0;
	var rc = global.runController;
	
	if (instance_exists(rc) and is_array(rc.levelWeights) and array_length(rc.levelWeights) > 0) {
		
		targetLevel = scr_random_weightedPick(rc.levelWeights);
		
	} else {
	
		targetLevel = 15;
	
	}
	
	if (targetLevel > level) {
	
		setupStats = true;
		setAmmo = true;
		setupBasics = true;
		
	}

	while (level < targetLevel) {

		level++;
		levelUpFunc();
	
	}


	
}

if (calculateData) {

	calculateData = false;

	var playerLevel = instance_exists(global.player) ? global.player.level : 0;
	
	var lvlMod = 1 + level * 0.1;
	var diffMod = 1 + clamp(level - playerLevel, -5, 5) * 0.1;

	minData = max(2, round(minData * lvlMod * diffMod));
	maxData = max(4, round(maxData * lvlMod * diffMod));
	
}