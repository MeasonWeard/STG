draw_self();

jitterTick--;

if (jitterTick <= 0) {

	image_angle = irandom_range(0, 355);

	jitterTick = jitter;

	lightningPoints = [];

	var len = array_length(targetList);

	for (var i = 0; i < len; i++) {

		var target = targetList[i];

		if (!instance_exists(target)) continue;

		var sourceX = x;
		var sourceY = y;

		var targetX = target.x;
		var targetY = (target.y + target.bbox_top) * 0.5;

		var dir = point_direction(sourceX, sourceY, targetX, targetY);
		var perpDir = dir + 90;

		var dist = point_distance(sourceX, sourceY, targetX, targetY);

		var segs = ceil(dist / 16);

		var prevX = sourceX;
		var prevY = sourceY;

		for (var j = 1; j < segs; j++) {

			var t = j / segs;

			var px = lerp(sourceX, targetX, t);
			var py = lerp(sourceY, targetY, t);

			var off = random_range(-8, 8);

			px += lengthdir_x(off, perpDir);
			py += lengthdir_y(off, perpDir);

			array_push(lightningPoints, [
				prevX,
				prevY,
				px,
				py
			]);

			prevX = px;
			prevY = py;

		}

		array_push(lightningPoints, [
			prevX,
			prevY,
			targetX,
			targetY
		]);

	}

}

draw_set_colour(c_aqua);


draw_set_colour(c_aqua);

//draw_circle(x, y, 18 + pulse, true);
//draw_circle(x, y, 24 - pulse * 0.65, true);
if (image_xscale == 0.75) {

	image_xscale = 1.5;
	image_yscale = 1.5;
	
} else {
	
	image_xscale = 0.75;
	image_xscale = 0.75;
	
}

var len = array_length(lightningPoints);

for (var i = 0; i < len; i++) {

	var p = lightningPoints[i];

	draw_line(
		p[0],
		p[1],
		p[2],
		p[3]
	);

}

draw_set_colour(c_white);