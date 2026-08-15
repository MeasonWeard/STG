junkTick = irandom_range(0, 240);

constFunc = function() {

	if (junkTick > 0) {
		
		junkTick --;
		
	} else {
	
		junkTick = irandom_range(180, 300);
		
		var junk = instance_create_layer(xMid, yMid, "Instances", obj_junk);
		junk.dir = -1;
		junk.vert = false;
		junk.y += irandom_range(-4, 4);
		
	}
	
}