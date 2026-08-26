if (active and instance_exists(owner)) {
	
	owner.finalStats[$ statKey] = statAfter;

}

if (is_real(timer)) {

	if (timer <= 0) instance_destroy();
	
	timer --;
	
}