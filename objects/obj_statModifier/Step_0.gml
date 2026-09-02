if (!instance_exists(owner)) {
	
	instance_destroy();
	exit;
	
}

if (is_real(timer)) {

	if (timer <= 0) instance_destroy();
	
	timer --;
	
}