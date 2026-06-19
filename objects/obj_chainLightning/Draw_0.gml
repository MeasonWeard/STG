//draw_set_alpha(1);
//draw_set_colour(c_aqua);

//var len = array_length(chainList);

//if (len > 0) {

//	var sourceX = x;
//	var sourceY = y;

//	if (instance_exists(owner)) {
//		sourceX = owner.x;
//		sourceY = owner.y;
//	}

//	for (var i = 0; i < len; i++) {

//		var target = chainList[i];

//		if (!instance_exists(target)) continue;

//		draw_line(sourceX, sourceY, target.x, target.y);

//		sourceX = target.x;
//		sourceY = target.y;
//	}
//}

//draw_set_colour(c_white);
//draw_set_alpha(1);

jitterTick--;

if (jitterTick <= 0) {

	jitterTick = jitter;

	lightningPoints = [];

	var sourceX = owner.x;
	var sourceY = owner.y;

	var len = array_length(chainList);

	for (var i = 0; i < len; i++) {

		var target = chainList[i];

		if (!instance_exists(target)) continue;

		var targetX = target.x;
		var targetY = target.y;

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

			array_push(lightningPoints, [prevX, prevY, px, py]);

			prevX = px;
			prevY = py;

		}

		array_push(lightningPoints, [prevX, prevY, targetX, targetY]);

		sourceX = targetX;
		sourceY = targetY;

	}

}

draw_set_colour(c_aqua);

var len = array_length(lightningPoints);

for (var i = 0; i < len; i++) {

	var p = lightningPoints[i];

	draw_line(p[0], p[1], p[2], p[3]);

}

draw_set_colour(c_white);