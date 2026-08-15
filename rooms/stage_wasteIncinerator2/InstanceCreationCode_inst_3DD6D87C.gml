junkTick = irandom_range(0, 4);

constFunc = function() {

	if (junkTick > 0) {
		
		junkTick --;
		
	} else {

		junkTick = 4;
	
		with (obj_junk) {
	
			if (point_in_rectangle(x, y, other.left, other.top, other.right, other.bottom)) {
		
				instance_destroy();
		
			}
	
		}
	
	}
	
}