// Inherit the parent event
event_inherited();

if (alert and instance_exists(target)) {

	var dist = point_distance(x, y, target.x, target.y);
	
	if (weaponIndex == 1 and dist > 290) scr_weapons_equipWeapon(self, 0);
	if (weaponIndex == 0 and dist <= 290) scr_weapons_equipWeapon(self, 1);
	
	if (scr_timeSlicing_isMyTurn("skillCheck", skillCheckIndex)) {
		
		if (skills.skill1.canCast(self)) {
		
			var dir = point_direction(x, y, target.x, target.y);
			var overshoot = irandom_range(200, 300);

			var xx = target.x + lengthdir_x(overshoot, dir);
			var yy = target.y + lengthdir_y(overshoot, dir);
			
			var pt = scr_randomPointInCircle(xx, yy, 250);
			
			aimX = pt.xx;
			aimY = pt.yy;
			
		}
		
		scr_char_castSkillAtDist(self, skills.skill1, 500, true);
		
	}
	
}