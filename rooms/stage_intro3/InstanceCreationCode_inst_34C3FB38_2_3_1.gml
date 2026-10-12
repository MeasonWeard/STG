scripted = true;

alertLighting = noone;
createdArrows = false;
stageOver = false;

scriptFunc = function() {

	if (alertLighting == noone) alertLighting = instance_create_layer(x, y, "Instances", obj_alarmLighting);
	
	var count = instance_number(obj_enemy);
	
	if (!createdArrows and count < 16) {

		createdArrows = true;
	
		scr_obj_createEnemyArrows();
	
	}
	
	if (count == 0 and !stageOver) {
		
		stageOver = true;
		
		scr_stages_completeStage();
		
	}
	
}