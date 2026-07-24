event_inherited();

scr_hash_remove(global.stageController.charHash, id, hashCellX, hashCellY);

if (variable_instance_exists(self, "ghost")) {

	if (instance_exists(ghost)) instance_destroy(ghost);
	
}