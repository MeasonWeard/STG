scripted = true;

alertLighting = noone;

scriptFunc = function() {

	if (alertLighting == noone) alertLighting = instance_create_layer(x, y, "Instances", obj_alarmLighting);

}