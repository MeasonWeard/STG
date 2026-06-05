event_inherited();

if (delay == 0) {

	for (var i = array_length(parts) - 1; i >= 0; i--) {
	
		var p = parts[i];
	
		p.x += p.xspd;
		p.y += p.yspd;
	
		p.yspd += grav; // gravity curve
	
		p.xspd *= 0.98;
		p.yspd *= 0.98;
	
		p.life--;
	
		if (p.life <= 0) {
		
	if (p.splits > 0) {
	
			parts[i] = {
					x: p.x,
					y: p.y,
					xspd: p.xspd * random_range(0.6, 0.9),
					yspd: p.yspd * random_range(0.6, 0.9),
					rad: max(1, p.rad * 0.6),
					splits: p.splits - 1,
					life: irandom_range(10, 20)
				};
	
			} else {
	
				array_delete(parts, i, 1);
	
			}
		
		} else {
		
			parts[i] = p;
		
		}
	}

	if (array_length(parts) <= 0) {
		instance_destroy();
	}

} else {

	delay --;
	
}