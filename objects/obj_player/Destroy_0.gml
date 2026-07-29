event_inherited();

if (instance_exists(global.runController)) global.runController.gameState = "fail";

with(obj_char) {

	if (!pet) continue;
	if (faction != other.faction) continue;
	
	persistent = false;
	
}

if (!global.stageController.hub) scr_obj_createPortal(x, y);