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

		var zapX = firstChar.x;
		var zapY = (firstChar.y + firstChar.bbox_top) * 0.5;

		array_push(chainPos, [zapX, zapY]);
		array_push(chainOriginPos, [firstChar.x, firstChar.y]);

		scr_audio_playSoundAt(snd_zap, zapX, zapY);

		scr_char_damage(firstChar, damage, damageTypes.ability, false);
		instance_create_layer(zapX, zapY, "Instances", obj_doubleZap);
	}
}

if (chainTick <= 0 and chainsDone < chains) {

	chainTick = interval;

	var sourceX = owner.x;
	var sourceY = owner.y;

	var chainLen = array_length(chainList);

	if (chainLen > 0) {

		var lastIndex = chainLen - 1;

		if (instance_exists(chainList[lastIndex])) {
			sourceX = chainList[lastIndex].x;
			sourceY = chainList[lastIndex].y;
		}
		else if (array_length(chainOriginPos) > lastIndex) {
			sourceX = chainOriginPos[lastIndex][0];
			sourceY = chainOriginPos[lastIndex][1];
		}
	}

	var nearby = scr_hash_getNearbyRange(global.stageController.charHash, sourceX, sourceY, 2);

	var len = array_length(nearby);

	var found = noone;
	var closest = 999999999999;

	for (var i = 0; i < len; i++) {

		var char = nearby[i];

		if (!instance_exists(char)) continue;
		if (char == owner) continue;
		if (char.faction == faction) continue;

		var dist = point_distance(sourceX, sourceY, char.x, char.y);
		if (dist > range) continue;
	
		var alreadyChained = false;
		
		var los = scr_physics_hasLineOfSight(sourceX, sourceY, char.x, char.y);
		if (!los) continue;

		for (var j = 0; j < array_length(chainList); j++) {
			if (chainList[j] == char) {
				alreadyChained = true;
				break;
			}
		}

		if (alreadyChained) continue;

		if (dist < closest) {
			closest = dist;
			found = char;
		}
		
	}

	if (found != noone) {

		var zapX = found.x;
		var zapY = (found.y + found.bbox_top) * 0.5;

		array_push(chainList, found);
		array_push(chainPos, [zapX, zapY]);
		array_push(chainOriginPos, [found.x, found.y]);

		chainsDone++;

		instance_create_layer(zapX, zapY, "Instances", obj_doubleZap);
		scr_audio_playSoundAt(snd_zap, zapX, zapY);

		if (!is_undefined(damage)) {
			scr_char_damage(found, damage, damageTypes.ability, false);
		}
		
		damage = scr_stats_multiplyDamageProfile(damage, 0.75);
		
	}
}

// update remembered positions
var len = array_length(chainList);

for (var i = 0; i < len; i++) {

	var target = chainList[i];

	if (instance_exists(target)) {

		var zapX = target.x;
		var zapY = (target.y + target.bbox_top) * 0.5;

		chainPos[i] = [zapX, zapY];
		chainOriginPos[i] = [target.x, target.y];
	}
}