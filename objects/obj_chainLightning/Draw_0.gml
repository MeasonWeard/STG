jitterTick--;

if (jitterTick <= 0) {

	jitterTick = jitter;

	lightningPoints = [];

	var sourceX = owner.x;
	var sourceY = owner.y - owner.sprite_height * 0.5;

	var len = array_length(chainList);

	for (var i = 0; i < len; i++) {

		var target = chainList[i];

		var targetX;
		var targetY;

		if (instance_exists(target)) {
			targetX = target.x;
			targetY = (target.y + target.bbox_top) * 0.5;
			chainPos[i] = [targetX, targetY];
		} else {
			targetX = chainPos[i][0];
			targetY = chainPos[i][1];
		}

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