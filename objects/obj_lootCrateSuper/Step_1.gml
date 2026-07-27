event_inherited();

if (global.stageController.stageInProgress) {

	hp = 10000;
	
} else {
	
	if (createArrow) {
	
		createArrow = false;
		hp = 250;
		
		var arrow = instance_create_layer(x, y, "Instances", obj_arrow);
		arrow.target = self;
		arrow.source = global.player;
		arrow.text = "LOOT";
		arrow.col = c_purple;
		
	}
	
}
