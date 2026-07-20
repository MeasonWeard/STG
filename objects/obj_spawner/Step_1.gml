if (setup) {

	setup = false;

	if (scr_stages_inStartingCell()) {

		if (instance_exists(global.player)) {
	
			var dist = point_distance(x, y, global.player.x, global.player.y);
		
			if (dist < 600) instance_destroy();
	
		}
	
	}
	
	if (array_length(commonList) == 0) {
	
		var group = scr_randomElement(groups);
		
		commonList = group;
	
	}

}