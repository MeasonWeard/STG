function scr_items_inRange(item, char, range){

}

function scr_items_burst(item) {

	if (!instance_exists(item)) exit;

	item.burstDir = irandom_range(0, 359);
	item.burstVel = irandom_range(15, 20);

}

function scr_items_spawn(obj, xx, yy, val, burst) {
	
	if(!object_exists(obj)) exit;
	
	var inst = instance_create_layer(xx, yy, "Instances", obj);
	inst.val = val;
	
	if (burst) scr_items_burst(inst);
	
}