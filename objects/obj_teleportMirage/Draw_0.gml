depth = layers.physical -y;

draw_sprite_ext(sprite_index, image_index, x, y, scale, scale, 0, col, alpha);

alpha -= 0.02;
scale -= 0.005;

if (alpha <= 0) instance_destroy();