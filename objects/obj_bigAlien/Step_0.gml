// Inherit the parent event
event_inherited();

if (alert and instance_exists(target)) {

	var dist = point_distance(x, y, target.x, target.y);
	
	if (weaponIndex == 1 and dist > 290) scr_weapons_equipWeapon(self, 0);
	if (weaponIndex == 0 and dist <= 290) scr_weapons_equipWeapon(self, 1);
	
}