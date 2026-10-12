if (hub and instance_exists(global.player)) {
	
	global.hubPosX = global.player.x;
	global.hubPosY = global.player.y;
	
}

if (!paused and !instance_exists(global.player)) {

	deathCountdown--;
	
	if (restart) {
		scr_stages_goToStage(rc.currentCell);
		scr_audio_stopMusic();
		scr_audio_stopAmbience(1);
		scr_audio_stopAmbience(2);
	}
	
	if (deathCountdown < 1) {
		
		if (restartOnDeath) {
			
			if (!restart) {
			
				scr_stages_restartStage();
				restart = true;
			
			}
			
		
		} else {
			
			scr_stages_endRun();
			
		}
		
	}
	
}