function scr_random_generateSeed(){

	randomise();
	
	return irandom(99999999);

}

function scr_randomElement(array) {

	var len = array_length(array);
	
	if (len == 0) return undefined;
	
	var rand = irandom_range(0, len - 1);
	var el = array[rand];
	
	return el;
	
}

function scr_randomPointInCircle(xx, yy, radius) {

	var dir = random(360);
	var dist = sqrt(random(radius * radius));

	var px = xx + lengthdir_x(dist, dir);
	var py = yy + lengthdir_y(dist, dir);
	
	return {
		xx: px,
		yy: py
	}
	
}
