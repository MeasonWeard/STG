event_inherited();

image_speed = 0;

if (open and image_index < image_number - 1) image_speed = 1;
if (!open and image_index > 0) image_speed = -1;
