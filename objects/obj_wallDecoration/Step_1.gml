if (setup) {

	setup = false;

	var closest = 9999999999;
	var xx = x;
	var yy = y;
	
	with (obj_wall) {
	
		var dist = point_distance(xx, yy, x, y - 64);
		
		if (dist > 150) continue;
		
		if (dist < closest) {
		
			closest = dist;
			other.owner = self;
		
		}
	
	}
	
	if (instance_exists(owner)) {
		
		if (instance_exists(owner.decoration) and owner.decoration.natural) {
		
			instance_destroy(owner.decoration);
		
		}
		
		owner.decoration = self;
		
		depth = owner.depth - 1;
		
	}
	
		//smashable
	if (!global.stageController.hub and smashable) {
	
		var smashables = global.runController.currentCell.smashables;
		var len = array_length(smashables);
		
		for (var i = 0; i < len; i++) {
		
			var entry = smashables[i];
			
			if (!is_struct(entry)) continue;
			
			var obj = entry.obj;
			
			if (!obj == object_index) continue;
			
			var px = entry.xx;
			var py = entry.yy;
			
			if (px == x and py = y) {
				smashed = entry.smashed;
				prevSmashed = true;
			}
		
		}
	
	}
	
}