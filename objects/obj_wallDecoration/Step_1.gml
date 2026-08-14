if (findWall) {

	findWall = false;

	var closest = 9999999999;
	var xx = x;
	var yy = y;
	
	with (obj_wall) {
	
		var dist = point_distance(xx, yy, x, y - 64);
		
		if (dist < closest) {
		
			closest = dist;
			other.owner = self;
		
		}
	
	}
	
	if (instance_exists(owner)) {
		
		if (instance_exists(owner.decoration)) {
		
			instance_destroy(owner.decoration);
		
		}
		
		owner.decoration = self;
		
		depth = owner.depth - 1;
		
	}
	
}