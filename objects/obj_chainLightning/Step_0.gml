life--;

if (life <= 0) {
	instance_destroy();
	exit;
}

chainTick--;

if (firstZap) {

	firstZap = false;

	var firstChar = chainList[0];

	if (instance_exists(firstChar)) {
		
		var xx = firstChar.x;
		var yy = firstChar.y;
		
		scr_audio_playSoundAt(snd_zap, xx, yy);
		
		scr_char_damage(firstChar, damage, damageTypes.ability, false);
		instance_create_layer(chainList[0].x, chainList[0].y, "Instances", obj_doubleZap);
		
		
	}
	
}

if (chainTick <= 0 and chainsDone < chains) {

	chainTick = interval;

	var source = owner;

	for (var i = array_length(chainList) - 1; i >= 0; i--) {

		if (instance_exists(chainList[i])) {
			source = chainList[i];
			break;
		}

	}

	if (instance_exists(source)) {

		var nearby = scr_hash_getNearby(global.stageController.charHash, source.x, source.y);
		var len = array_length(nearby);

		var found = noone;
		var closest = 999999999999;

		for (var i = 0; i < len; i++) {

			var char = nearby[i];

			if (!instance_exists(char)) continue;
			if (char == owner) continue;
			if (char.faction == owner.faction) continue;

			var alreadyChained = false;

			for (var j = 0; j < array_length(chainList); j++) {
				if (chainList[j] == char) {
					alreadyChained = true;
					break;
				}
			}

			if (alreadyChained) continue;

			var dist = point_distance(source.x, source.y, char.x, char.y);

			if (dist < closest) {
				closest = dist;
				found = char;
			}
		}

		if (found != noone) {

			array_push(chainList, found);
			chainsDone++;
			
			instance_create_layer(found.x, found.y, "Instances", obj_doubleZap);
			scr_audio_playSoundAt(snd_zap, found.x, found.y);
			
			if (!is_undefined(damage)) {
				scr_char_damage(found, damage, damageTypes.ability, false);
			}
			
		}
	}
}