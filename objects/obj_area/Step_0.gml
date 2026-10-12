if (is_callable(constFunc)) constFunc();

if (is_callable(triggerFunc)) {

	if (instance_exists(player)) {

		if (player.x > left and player.x < right and player.y > top and player.y < bottom) {
	
			playerInArea = true;
	
		} else {
		
			playerInArea = false;
		
		}
	
	}

	if (!prevPlayerInArea and playerInArea) {

		triggerFunc();
		
		if (!repeatTrigger) triggerFunc = undefined;
	
	}
	
	prevPlayerInArea = playerInArea;

}