if (setup) {

	setup = false;

	//destroy if too close to player starting location
	if (scr_stages_inStartingCell()) {

		if (instance_exists(global.player)) {

			var dist = point_distance(x, y, global.player.x, global.player.y);
		
			if (dist < 800) instance_destroy();
	
		}
	
	}
	
	//create list
	if (array_length(enemyList) == 0) {
	
		var group = scr_randomElement(groups);
		
		enemyList = group;
	
	}

	//amount of enemies
	var runLevel = rc.runLevel;
	
	minEnemies = clamp(runLevel * 2, 1, 8);
	maxEnemies = clamp(runLevel * 4, 4, 12);

}