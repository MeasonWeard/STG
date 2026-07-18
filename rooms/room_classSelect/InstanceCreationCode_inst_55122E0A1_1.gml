txt = "Back";
leftKey = vk_escape;

leftFunc = function() {

	room_goto(stage_hub1);
	
}

constantFunc = function() {
	
	active = true;
	if (!global.classSelectController.showBackButton) active = false;
	
}