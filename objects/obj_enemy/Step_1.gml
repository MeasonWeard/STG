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

	while (level < targetLevel) {

		level++;
		levelUpFunc();

		setupStats = true;
		setAmmo = true;

	}
	
}