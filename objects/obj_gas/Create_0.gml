charHash = global.stageController.charHash;
envHash = global.stageController.envHash;

faction = undefined;

image_speed = 0;
image_index = irandom_range(0, image_number - 1);
image_alpha = 0.5 + random_range(-0.1, 0.1);

dir = 0;
spd = 2;
damage = undefined;

wiggleDir = 0;
wiggleStep = choose(-2, 2) * 0.08;
wiggleStrength = 1.5;

life = 180;

damTick = 0;
damTime = 30;
envTick = irandom_range(0, 3);
envTime = 4;
lastSafeX = x;
lastSafeY = y;

depth = layers.projectiles;

colLeft = bbox_left;
colRight = bbox_right;
colTop = bbox_top;
colBottom = bbox_bottom;

damSounds = [snd_gasHurt];

charges = 4;

height = irandom_range(25, 99);
//rot = random_range(-2, 2);