function scr_obj_createExclusive(obj, xx, yy){

	if (!object_exists(obj)) return noone;
	
	with (obj) {
		instance_destroy();	
	}
	
	var newObj = instance_create_layer(xx, yy, "Instances", obj);
	
	return newObj;

}