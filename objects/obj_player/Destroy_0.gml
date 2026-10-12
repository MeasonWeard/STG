event_inherited();

with(obj_char) {

	if (!pet) continue;
	if (faction != other.faction) continue;

	persistent = false;
	
}

if (!global.stageController.hub) scr_obj_createPortal(x, y);