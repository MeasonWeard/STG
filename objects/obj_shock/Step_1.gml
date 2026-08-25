if (setup) {

	setup = false;

	var nearby = scr_hash_getNearbyRange(
		global.stageController.charHash,
		x,
		y,
		2
	);

	var candidates = [];
	var len = array_length(nearby);

	for (var i = 0; i < len; i++) {

		var char = nearby[i];

		if (!instance_exists(char)) continue;
		if (char == owner) continue;
		
		if (char.faction == faction) continue;
		
		var dist = point_distance(x, y, char.x, char.y);

		if (dist > range) continue;
		
		var los = scr_physics_hasLineOfSight(x, y, char.x, char.y);
		if (!los) continue;

		array_push(candidates, [char, dist]);

	}

	// Closest first
	array_sort(candidates, function(a, b) {
		return a[1] - b[1];
	});

	var targetCount = min(targets, array_length(candidates));

	for (var i = 0; i < targetCount; i++) {

		var char = candidates[i][0];

		array_push(targetList, char);

		var zapX = char.x;
		var zapY = (char.y + char.bbox_top) * 0.5;

		instance_create_layer(zapX, zapY, "Instances", obj_doubleZap);
	
		if (!is_undefined(damage)) {
			scr_char_damage(char, damage, damageTypes.ability, false);
		}

	}

}