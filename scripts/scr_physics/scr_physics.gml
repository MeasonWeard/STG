function scr_physics_hasLineOfSight(x1, y1, x2, y2) {

	var nearby = scr_hash_getAlongLine(global.stageController.envHash, x1, y1, x2, y2, 1);
	var len = array_length(nearby);

	for (var i = 0; i < len; i++) {

		var env = nearby[i];

		if (!instance_exists(env)) continue;
		
		if (!env.blockLos) continue;

		if (scr_physics_lineIntersectsRectangle(
			x1,
			y1,
			x2,
			y2,
			env.colLeft,
			env.colTop,
			env.colRight,
			env.colBottom
		)) {
			return false;
		}
	}

	return true;
	
}

function scr_physics_lineIntersectsRectangle(
	x1,
	y1,
	x2,
	y2,
	left,
	top,
	right,
	bottom
) {

	// One of the points is inside the rectangle.
	if (point_in_rectangle(x1, y1, left, top, right, bottom)) return true;
	if (point_in_rectangle(x2, y2, left, top, right, bottom)) return true;

	// Check the line against each side.
	if (scr_physics_linesIntersect(
		x1, y1, x2, y2,
		left, top, right, top
	)) return true;

	if (scr_physics_linesIntersect(
		x1, y1, x2, y2,
		right, top, right, bottom
	)) return true;

	if (scr_physics_linesIntersect(
		x1, y1, x2, y2,
		right, bottom, left, bottom
	)) return true;

	if (scr_physics_linesIntersect(
		x1, y1, x2, y2,
		left, bottom, left, top
	)) return true;

	return false;
}

function scr_physics_linesIntersect(
	x1,
	y1,
	x2,
	y2,
	x3,
	y3,
	x4,
	y4
) {

	var denominator =
		(x1 - x2) * (y3 - y4)
		- (y1 - y2) * (x3 - x4);

	// Parallel lines.
	if (denominator == 0) return false;

	var t =
		((x1 - x3) * (y3 - y4)
		- (y1 - y3) * (x3 - x4))
		/ denominator;

	var u =
		-((x1 - x2) * (y1 - y3)
		- (y1 - y2) * (x1 - x3))
		/ denominator;

	return (
		t >= 0 and t <= 1
		and
		u >= 0 and u <= 1
	);
}

function scr_physics_collisionLineRectangle(x1, y1, x2, y2, left, top, right, bottom) {

	// Either endpoint is already inside the rectangle
	if (
		x1 >= left and x1 <= right and
		y1 >= top and y1 <= bottom
	) {
		return true;
	}

	if (
		x2 >= left and x2 <= right and
		y2 >= top and y2 <= bottom
	) {
		return true;
	}

	// Check against each edge
	if (scr_physics_collisionLine(x1, y1, x2, y2, left, top, right, top)) return true;
	if (scr_physics_collisionLine(x1, y1, x2, y2, right, top, right, bottom)) return true;
	if (scr_physics_collisionLine(x1, y1, x2, y2, right, bottom, left, bottom)) return true;
	if (scr_physics_collisionLine(x1, y1, x2, y2, left, bottom, left, top)) return true;

	return false;

}

function scr_physics_collisionLine(x1, y1, x2, y2, x3, y3, x4, y4) {

	var denominator =
		(x1 - x2) * (y3 - y4) -
		(y1 - y2) * (x3 - x4);

	if (denominator == 0) return false;

	var t =
		((x1 - x3) * (y3 - y4) -
		(y1 - y3) * (x3 - x4))
		/ denominator;

	var u =
		-((x1 - x2) * (y1 - y3) -
		(y1 - y2) * (x1 - x3))
		/ denominator;

	return t >= 0 and t <= 1 and u >= 0 and u <= 1;

}