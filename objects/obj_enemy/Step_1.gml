// Inherit the parent event
event_inherited();

if (enemySetup) {

	enemySetup = false;

	xstart = x;
	ystart = y;

	var lvl = level == 0 ? scr_char_rollLevel() : level;
	var evolve = false;
	
	if (is_real(evolveLevel) and lvl >= evolveLevel and array_length(evolutions) > 0) {
	
		var effLvl = clamp(lvl - evolveLevel, 0, 10);
	
		var dec = effLvl / 10;
		var chance = lerp(evolveChanceMin, evolveChanceMax, dec);
		
		evolve = scr_random_chance(chance);
		
	}
	
	if(evolve) {
		
		var obj = scr_randomElement(evolutions);
		
		if (object_exists(obj)) {
		
			var newChar = instance_create_layer(x, y, "Instances", obj);
			newChar.levelUp = false;
			scr_char_levelUp(newChar, lvl);
			
			newChar.hashCellX = hashCellX;
			newChar.hashCellY = hashCellY;
			array_copy(newChar.nearbyEnv, 0, nearbyEnv, 0, array_length(nearbyEnv));
		
		}
		
		dropOnDestroy = false;
		instance_destroy();
		exit;
		
	} else {
	
		scr_char_levelUp(self, lvl);
	
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

if (alert or runBack) sc.alertEnemiesNext++;