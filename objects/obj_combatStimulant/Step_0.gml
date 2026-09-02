if (!instance_exists(owner)) {
	instance_destroy();
	exit;
}

x = owner.x;
y = owner.y + 4;

if (audio_emitter_exists(emitter)) {
	audio_emitter_position(emitter, x, y, 0);
}

depth = owner.depth - 12;

if (storeTick > 0) {

	storeTick --;

} else {

	storeTick = storeTime;

	array_push(posHistory, {
		x: owner.x,
		y: owner.y + 4,
		sprite: owner.sprite_index,
		image: owner.image_index,
		xscale: owner.image_xscale,
		yscale: owner.image_yscale
	});

	if (array_length(posHistory) > maxHistory) {
		array_delete(posHistory, 0, 1);
	}

}

timer --;

if (timer <= 0) {
	instance_destroy();
}