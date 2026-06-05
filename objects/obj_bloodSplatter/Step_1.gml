event_inherited();

if (setup) {

	setup = false;
	
	var spread = clamp(force * 12, 10, 120);

	for (var i = 0; i < particles; i++) {

		var dir = -270 + random_range(-spread, spread); // centred on UP
		var spd = random_range(force, force * 1.5);
	
		array_push(parts, {
			x: x,
			y: y,
			xspd: lengthdir_x(spd, dir),
			yspd: lengthdir_y(spd, dir),
			rad: rad,
			splits: splits,
			life: irandom_range(life * 0.5, life * 1.5)
		});
	}
	
}

