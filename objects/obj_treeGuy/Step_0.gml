event_inherited();

scr_char_animateLRMirror(false);

if (instance_exists(target)) {

	var dist = point_distance(x, y, target.x, target.y);
	
	if (weaponIndex == 0 and dist > 210) scr_weapons_equipWeapon(self, 1);
	if (weaponIndex == 1 and dist <= 210) scr_weapons_equipWeapon(self, 0);
	
}