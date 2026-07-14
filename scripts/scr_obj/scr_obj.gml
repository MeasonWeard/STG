function scr_obj_createExclusive(obj, xx, yy){

	if (!object_exists(obj)) return noone;
	
	with (obj) {
		instance_destroy();	
	}
	
	var newObj = instance_create_layer(xx, yy, "Instances", obj);
	
	return newObj;

}

function scr_obj_collision(objA, objB, overlap) {

	if (!instance_exists(objA)) return false;
	if (!instance_exists(objB)) return false;
	
	if (overlap) {
	
		return (
			objA.colLeft   < objB.colRight and
			objA.colRight  > objB.colLeft and
			objA.colTop    < objB.colBottom and
			objA.colBottom > objB.colTop
		);
	
	}
		
	return (
		objA.colLeft   <= objB.colRight and
		objA.colRight  >= objB.colLeft and
		objA.colTop    <= objB.colBottom and
		objA.colBottom >= objB.colTop
	);
	
}

function scr_obj_movementCollision(objA, objB, overlap) {

	if (!instance_exists(objA)) return false;
	if (!instance_exists(objB)) return false;

	if (overlap) {

		return (
			objA.movRight > objB.colLeft and
			objA.movLeft < objB.colRight and
			objA.movBottom > objB.colTop and
			objA.movTop < objB.colBottom
		);

	} else {

		return (
			objA.movRight >= objB.colLeft and
			objA.movLeft <= objB.colRight and
			objA.movBottom >= objB.colTop and
			objA.movTop <= objB.colBottom
		);

	}

}

function scr_obj_mouseHover() {
	
	var cursor = global.cursor;
	
	mouseHover = false;
	
	if (!instance_exists(cursor)) exit;
	
	if (cursor.x < bbox_left) exit;
	if (cursor.x > bbox_right) exit;
	if (cursor.y < bbox_top) exit;
	if (cursor.y > bbox_bottom) exit;
	
	mouseHover = true;
	
}

function scr_obj_clicked(button, hold) {

	if (!mouseHover) return false;

	var mb = mb_any;
	var clicked = false;
	
	if (button == 0) mb = mb_left;
	if (button == 1) mb = mb_right;

	if (hold) {
	
		if (mouse_check_button(mb)) clicked = true;
	
	} else {
		
		if (mouse_check_button_pressed(mb)) clicked = true;
	
	}
	
	return clicked;
	
}

function scr_obj_circleOverlaps(circleX, circleY, radius, obj) {

	if (!instance_exists(obj)) return false;

	var closestX = clamp(circleX, obj.colLeft, obj.colRight);
	var closestY = clamp(circleY, obj.colTop, obj.colBottom);

	var dx = circleX - closestX;
	var dy = circleY - closestY;

	return (dx * dx + dy * dy) <= (radius * radius);
	
}

function scr_obj_circleDistSq(circleX, circleY, radius, obj) {

	if (!instance_exists(obj)) return -1;

	var closestX = clamp(circleX, obj.colLeft, obj.colRight);
	var closestY = clamp(circleY, obj.colTop, obj.colBottom);

	var dx = circleX - closestX;
	var dy = circleY - closestY;

	var distSq = dx * dx + dy * dy;
	var radiusSq = radius * radius;

	if (distSq > radiusSq) return -1;

	return distSq;
	
}

function scr_obj_outlineCollisionMask(margin, col) {
	
	var left = bbox_left - margin;
	var right = bbox_right + margin;
	var top = bbox_top - margin;
	var bottom = bbox_bottom + margin;
	
	draw_set_colour(col);
	
	draw_rectangle(left, top, right, bottom, true);
	
}

function scr_obj_createPortal(xx, yy) {

	var portal = scr_obj_createExclusive(obj_portal, xx, yy);
		
	var arrow = instance_create_layer(xx, yy, "Instances", obj_arrow);
	arrow.target = portal;
	arrow.source = global.player;
	arrow.text = "END RUN";
	arrow.col = c_fuchsia;
	
}