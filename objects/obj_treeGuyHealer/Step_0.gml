event_inherited();

scr_char_animateLRMirror(false);

if (instance_exists(target)) {

	var dist = point_distance(x, y, target.x, target.y);
	
	if (weaponIndex == 0 and dist > 210) scr_weapons_equipWeapon(self, 1);
	if (weaponIndex == 1 and dist <= 210) scr_weapons_equipWeapon(self, 0);
	

}

if (scr_timeSlicing_isMyTurn("skillCheck", skillCheckIndex)) {
		
	if (skills.skill1.canCast(self)) {
		
		//var cx = hashCellX ?? 
		
		var chars = scr_hash_getNearbyCell(charHash, hashCellX, hashCellY);
		var charsLen = array_length(chars);
			
		for (var i = 0; i < charsLen; i ++) {
			
			var char = chars[i];
			
			if (!instance_exists(char)) continue;
			if (char.faction != faction) continue;
			if (!scr_char_hasTag(char, "bio")) continue;
			
			if (char.id == id) {
			
				if (hp < maxHp * 0.5) {
					scr_char_castSkill(self, skills.skill1);
				}
				
				continue;
			
			}
			
			if (char.hp < char.maxHp) {
				scr_char_castSkill(self, skills.skill1);
				break;
			}
				
		}
		
	}
		
}