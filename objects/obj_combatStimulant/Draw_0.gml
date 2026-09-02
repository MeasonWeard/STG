if (!instance_exists(owner)) exit;

var len = array_length(posHistory);

for (var i = 0; i < len; i++) {

	var pos = posHistory[i];

	//don't draw stored image at owner's current position
	if (pos.x == owner.x and pos.y == owner.y + 4) continue;

	var alpha = maxAlpha * ((i + 1) / (len + 1));

	draw_sprite_ext(
		pos.sprite,
		pos.image,
		pos.x,
		pos.y,
		pos.xscale * 1.1,
		pos.yscale * 1.1,
		0,
		c_red,
		alpha
	);

}

//draw current owner image at maximum alpha
draw_sprite_ext(
	owner.sprite_index,
	owner.image_index,
	owner.x,
	owner.y + 4,
	owner.image_xscale * 1.1,
	owner.image_yscale * 1.1,
	owner.image_angle,
	c_red,
	maxAlpha
);