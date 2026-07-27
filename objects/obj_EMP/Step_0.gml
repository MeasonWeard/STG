if (life < 1 or (flashAlpha <= 0 and jitterAlpha <= 0)) instance_destroy();

life--;

if (doDamage) {

	doDamage = false;
	
	var dec = 1 + mechBonus * 0.01;
	
	var nearby = scr_hash_getNearby(global.stageController.charHash, x, y);
	var nearbyLen = array_length(nearby);
	
	for (var i = 0; i < nearbyLen; i++) {

		var char = nearby[i];
	
		if (!instance_exists(char)) continue;
		if (char.faction == owner.faction) continue;
		
		var col = false;
				
		var nearestX = clamp(x, char.colLeft, char.colRight);
		var nearestY = clamp(y, char.colTop, char.colBottom);

		var dist = point_distance(x, y, nearestX, nearestY);

		if (dist <= radius) col = true;
				
		if (col) {
		
			var isMech = scr_char_hasTag(char, "mech");
			
			var dam = isMech? scr_stats_multiplyDamageProfile(damage, dec) : damage;
			
			scr_char_damage(char, dam, undefined, false);
		
		}
				
	}
	
}