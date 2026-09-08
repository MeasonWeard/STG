// Inherit the parent event
event_inherited();

if (spawning) exit;
	
scr_ai_petSuicideIntoTarget();	

//scr_ai_standardPetBehaviour();

if (instance_exists(target)) {
	
	var xx = (target.colLeft + target.colRight) * 0.5;
	var yy = (target.colTop + target.colBottom) * 0.5;
		
	var dist = point_distance(x, y, xx, yy);
	if (dist <= explodeDist) hp = 0;
	
}