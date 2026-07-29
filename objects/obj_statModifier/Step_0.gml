if (active and instance_exists(owner)) {
	
	owner.stats[$ statKey] = statAfter;

}

if (is_real(timer)) {

	if (timer <= 0) instance_destroy();
	
	timer --;
	
}