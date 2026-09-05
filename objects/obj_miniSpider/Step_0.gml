// Inherit the parent event
event_inherited();

if (spawning) exit;
	
scr_ai_standardPetBehaviour();

if (instance_exists(target)) {
	
	var dist = point_distance(x, y, target.x, target.y);
	if (dist <= explodeDist) hp = 0;
	
}