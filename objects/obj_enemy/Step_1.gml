// Inherit the parent event
event_inherited();

if (boss) showHealthBar = true;

if (levelUp and is_callable(levelUpFunc)) {

	levelUp = false;

	var maxLevel = rc.runLevel;
	
	var chance = maxLevel * 10;
	
	while(level < maxLevel and scr_random_chance(chance)) {
	
		chance -= 10;
		
		level ++;
		levelUpFunc();
	
		setupStats = true;
		setAmmo = true;
	
	}
	
}