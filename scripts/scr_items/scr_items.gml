function scr_items_inRange(item, char, range){

}

function scr_items_burst(item) {

	if (!instance_exists(item)) exit;

	item.burstDir = irandom_range(0, 359);
	item.burstVel = irandom_range(15, 20);

}

function scr_items_collect(char, item) {
	
	if (!is_callable(item.collectRequirements) or item.collectRequirements(char)) {
		
		if (is_callable(item.collectFunc)) item.collectFunc(char, item);
	
		var snd = scr_audio_randomSoundFromProfile(item.collectSounds);
		if (snd != undefined) audio_play_sound(snd, 0, false);
	
		instance_destroy(item);
		
	}
	
}

function scr_items_collectAll() {

	with(obj_item) {
	
		collectSounds = undefined;
		if (type == "resource" or type == "loot") scr_items_collect(global.player, self);
	
	}
	
}

function scr_items_collectResource(char, item) {
	
	var key = item.key;
	var val = item.val;
	
	scr_data_addResource(key, val);
	
}

function scr_items_spawn(obj, xx, yy, val, burst) {
	
	if(!object_exists(obj)) return noone;
	
	var inst = instance_create_layer(xx, yy, "Instances", obj);
	
	if (is_real(val)) inst.val = val;
	
	if (burst) scr_items_burst(inst);
	
	return inst;
	
}

function scr_items_drop(obj, xx, yy, chance, val, burst) {

	if (!scr_random_chance(chance)) return noone;

	var inst = scr_items_spawn(obj, xx, yy, val, burst);
	
	return inst;
	
}

function scr_items_dropData(xx, yy, dataMin, dataMax) {

    var dataNum = irandom_range(dataMin, dataMax);

    // round down to nearest 8
    dataNum = floor(dataNum / 8) * 8;

    if (dataNum <= 0) return 0;

    var baseVal = 8;

    // increase tier while even the max drop count is not enough
    while (dataNum > MAX_DATA_DROPS * baseVal) {
        baseVal *= 2;
    }

    // step back one tier so we get a mix instead of instantly all higher tier
    if (baseVal > 8) {
        baseVal = baseVal div 2;
    }

    var highVal = baseVal * 2;

    var highDrops = (dataNum - MAX_DATA_DROPS * baseVal) div baseVal;
    highDrops = clamp(highDrops, 0, MAX_DATA_DROPS);

    var lowDrops = MAX_DATA_DROPS - highDrops;

    // if total is below MAX_DATA_DROPS * baseVal, just drop fewer baseVal items
    if (dataNum < MAX_DATA_DROPS * baseVal) {
        lowDrops = dataNum div baseVal;
        highDrops = 0;
    }

    repeat (lowDrops) {
        scr_items_spawn(obj_res_data, xx, yy, baseVal, true);
    }

    repeat (highDrops) {
        scr_items_spawn(obj_res_data, xx, yy, highVal, true);
    }

    return dataNum;
	
}