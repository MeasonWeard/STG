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
	
	if(!object_exists(obj)) exit;
	
	var inst = instance_create_layer(xx, yy, "Instances", obj);
	inst.val = val;
	
	if (burst) scr_items_burst(inst);
	
}

