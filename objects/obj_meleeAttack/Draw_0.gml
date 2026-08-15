image_blend = col;

//draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, col, image_alpha);
draw_self();

if (image_index == image_number - 1) instance_destroy();