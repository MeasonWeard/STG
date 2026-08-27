if (setup) {

	setup = false;

	var ps = 1 / freq;
	time = round(ps * 60);
	tick = irandom_range(0, time);
	
	if (instance_exists(owner)) faction = owner.faction;
	
}