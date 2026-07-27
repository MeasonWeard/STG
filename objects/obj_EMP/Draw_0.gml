//flash
if (flashAlpha > 0) {

	draw_set_alpha(flashAlpha);
	draw_circle_colour(x, y, radius, c_white, c_aqua, false);

} 

//electricity
jitterTick--;

if (jitterTick <= 0) {

	jitterTick = jitter;

	lightningPoints = [];

	var centreX = x;
	var centreY = y;

	//if (instance_exists(owner)) {
	//	centreX = owner.x;
	//	centreY = owner.y - owner.sprite_height * 0.5;
	//}

	var circumference = 2 * pi * radius;
	var segs = max(8, ceil(circumference / 16));

	var firstX;
	var firstY;

	var prevX;
	var prevY;

	for (var i = 0; i < segs; i++) {

		var angle = (i / segs) * 360;

		// Move each point randomly inward or outward
		var off = random_range(-8, 8);
		var pointRadius = radius + off;

		var px = centreX + lengthdir_x(pointRadius, angle);
		var py = centreY + lengthdir_y(pointRadius, angle);

		if (i == 0) {

			firstX = px;
			firstY = py;

		} else {

			array_push(lightningPoints, [
				prevX,
				prevY,
				px,
				py
			]);

		}

		prevX = px;
		prevY = py;

	}

	// Join the final point back to the first
	array_push(lightningPoints, [
		prevX,
		prevY,
		firstX,
		firstY
	]);

}

draw_set_colour(c_aqua);

var len = array_length(lightningPoints);

draw_set_alpha(jitterAlpha);

for (var i = 0; i < len; i++) {

	var p = lightningPoints[i];

	draw_line(
		p[0],
		p[1],
		p[2],
		p[3]
	);

}

flashAlpha -= 0.045;
jitterAlpha -= 0.045;

draw_set_alpha(1);
draw_set_colour(c_white);