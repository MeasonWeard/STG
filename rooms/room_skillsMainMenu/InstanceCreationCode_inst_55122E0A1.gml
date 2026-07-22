txt = "Back";
leftKey = vk_escape;

leftFunc = function() {

	if (instance_exists(global.player)) instance_destroy(global.player);
	room_goto(stage_hub1);
	
}