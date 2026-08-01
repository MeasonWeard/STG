//formatting
meleeBarLeft = x - meleeBarWidth * 0.5;
meleeBarRight = x + meleeBarWidth * 0.5;
meleeBarTop = y - meleeBarHeight * 0.5 + 25;
meleeBarBottom = y + meleeBarHeight * 0.5 + 25;
meleeNumX = meleeBarRight + 8;
meleeNumY = meleeBarTop;

ammoNumX = meleeBarLeft - 8;
ammoNumY = meleeNumY;

reloadBarLeft = x - reloadBarWidth * 0.5;
reloadBarRight = x + reloadBarWidth * 0.5;
reloadBarTop = meleeBarBottom + 8;
reloadBarBottom = reloadBarTop + reloadBarHeight;

gunNameX = x;
gunNameY = y - 50;

if (instance_exists(sc)) {
	
	if (enemyCheckTick > 0) {

		enemyCheckTick --;
	
	} else {

		enemyCheckTick = 8;
		enemy = instance_exists(enemy) ? enemy : noone;
	
		var charHash = global.stageController.charHash;
		var nearby = scr_hash_getNearby(charHash, x, y);
		var len = array_length(nearby);
	
		for (var i = 0; i < len; i++) {
	
			var char = nearby[i];
			if (!instance_exists(char)) continue;
			if (char.faction != "enemy") continue;
		
			var left = char.bbox_left - enemyPad;
			var right = char.bbox_right + enemyPad;
			var top = char.bbox_top - enemyPad;
			var bottom = char.bbox_bottom + enemyPad;
		
			if (!point_in_rectangle(x, y, left, top, right, bottom)) continue;
	
			enemy = char;
	
		}
	
	}

}