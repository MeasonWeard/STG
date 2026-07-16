if (closeDelay > 0) {

	closeDelay --;

} else {
	
	if (playSound) {

		playSound = false;
		scr_audio_playSoundAt(snd_portalClose, x, y);
	
	}
	
	if (image_xscale > 0) {

		image_xscale -= 0.04;
		image_yscale -= 0.04;
	
	}
	
	if (image_xscale <= 0) instance_destroy();

}

image_alpha += alphaDir * 0.01;

if (image_alpha >= 0.7) alphaDir = -1;
if (image_alpha <= 0.5) alphaDir = 1;