// Inherit the parent event
event_inherited();

if (boss) showHealthBar = true;

if (levelUp and is_callable(levelUpFunc)) {

	levelUp = false;

	var maxLevel = instance_exists(rc) ? rc.runLevel : 10;
	
	var chance = maxLevel * 10;
	
	while(level < maxLevel and scr_random_chance(chance)) {
	
		chance -= 10;
		
		level ++;
		levelUpFunc();
	
		setupStats = true;
		setAmmo = true;
	
	}
	
}