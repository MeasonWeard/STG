function scr_random_generateSeed(){

	randomise();
	
	return irandom(99999999);

}

function scr_randomElement(array) {

	if (!is_array(array)) return undefined;

	var len = array_length(array);
	
	if (len == 0) return undefined;
	
	var rand = irandom_range(0, len - 1);
	var el = array[rand];
	
	return el;
	
}

function scr_randomElementRemove(array) {

	if (!is_array(array)) return undefined;

	var len = array_length(array);
	
	if (len == 0) return undefined;
	
	var rand = irandom_range(0, len - 1);
	var el = array[rand];
	
	array_delete(array, rand, 1);
	
	return el;
	
}

function scr_randomPointInCircle(xx, yy, radius) {

	var dir = random(360);
	var dist = sqrt(random(radius * radius));

	var px = xx + lengthdir_x(dist, dir);
	var py = yy + lengthdir_y(dist, dir);
	
	return {
		xx: px,
		yy: py
	}
	
}

function scr_randomPointInCircleMinDist(xx, yy, radius, minDist) {

	var dir = random(360);

	var minSq = minDist * minDist;
	var maxSq = radius * radius;

	var dist = sqrt(random_range(minSq, maxSq));

	var px = xx + lengthdir_x(dist, dir);
	var py = yy + lengthdir_y(dist, dir);
	
	return {
		xx: px,
		yy: py
	};
	
}

function scr_randomPointInCircleBiased(xx, yy, radius, bias) {

	var dir = random(360);

	var t = random(1);

	if (bias != 1) {
		t = power(t, bias);
	}

	var dist = sqrt(t * radius * radius);

	var px = xx + lengthdir_x(dist, dir);
	var py = yy + lengthdir_y(dist, dir);
	
	return {
		xx: px,
		yy: py
	};
	
}

function scr_randomIntermittent(frequency, chance) {

	if (current_time mod frequency != 0) return false;

	return random(100) < chance;

}

function scr_random_weightedPick(arr) {

	var totalWeight = 0;
	var len = array_length(arr);

	for (var i = 0; i < len; i++) {
		totalWeight += arr[i][1];
	}

	var roll = random(totalWeight);

	for (var i = 0; i < len; i++) {
	
		roll -= arr[i][1];
	
		if (roll <= 0) {
			return arr[i][0];
		}
	
	}

	return arr[len - 1][0]; // fallback
	
}

function irandom_range_biased(minVal, maxVal, bias, biasTowardsLow = true) {

    var r = random(1);

    if (biasTowardsLow) {
        r = power(r, bias);
    } else {
        r = 1 - power(1 - r, bias);
    }

    return round(lerp(minVal, maxVal, r));

}

function random_range_biased(minVal, maxVal, bias, biasTowardsLow, decimalPlaces) {

    var r = random(1);

    if (biasTowardsLow) {
        r = power(r, bias);
    } else {
        r = 1 - power(1 - r, bias);
    }

    var result = lerp(minVal, maxVal, r);

    var mult = power(10, decimalPlaces);
    result = round(result * mult) / mult;

    return result;

}

function scr_random_chance(chance) {

    if (chance <= 0) return false;
    if (chance >= 100) return true;

    return random(100) < chance;

}