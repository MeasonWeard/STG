if (!instance_exists(source) or !instance_exists(target)) {
	instance_destroy();
	exit;
}

var cam = view_camera[0];

var camX = camera_get_view_x(cam);
var camY = camera_get_view_y(cam);
var camW = camera_get_view_width(cam);
var camH = camera_get_view_height(cam);

//visibility
visible = !(target.x >= camX and target.x <= camX + camW and target.y >= camY and target.y <= camY + camH);

if(!visible) exit;

//
var left = camX + screenPad;
var right = camX + camW - screenPad;
var top = camY + screenPad;
var bottom = camY + camH - screenPad;

// direction from player to enemy
dir = point_direction(source.x, source.y, target.x, target.y);
image_angle = dir;

// default position: near the enemy, but not on top of it
var distToTarget = point_distance(source.x, source.y, target.x, target.y);

var arrowDist = max(0, distToTarget - minDist);

var px = source.x + lengthdir_x(arrowDist, dir);
var py = source.y + lengthdir_y(arrowDist, dir);

// clamp to camera rectangle
x = clamp(px, left, right);
y = clamp(py, top, bottom);

