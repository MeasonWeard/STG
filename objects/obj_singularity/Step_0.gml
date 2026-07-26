var nearby = scr_hash_getNearbyRange(charHash, x, y, 2);
var nearbyLen = array_length(nearby);

for (var i = 0; i < nearbyLen; i++) {

	var char = nearby[i];
	
	if (!instance_exists(char)) continue;
	if (char.faction == faction) continue;
	
	var dist = point_distance(x, y, char.x, char.y);

	if (dist > pullRange or dist < minPullRange) continue;
	
	var t = 1 - (dist / pullRange);
	var pullStrength = maxPullStrength * t;
	
	var dir = point_direction(char.x, char.y, x, y);

	char.xspd += lengthdir_x(pullStrength, dir);
	char.yspd += lengthdir_y(pullStrength, dir);
	
}

if (tick <= 0) {

	var ex = scr_effects_explosion(x, y, 12);
	ex.damage = damage;
	ex.faction = faction;
	instance_destroy();
	
}

tick --;