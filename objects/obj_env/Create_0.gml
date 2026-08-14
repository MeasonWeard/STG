event_inherited();

setup = true;

canMove = false;

hashCellX = undefined;
hashCellY = undefined;

bulletHitSounds = global.data.soundProfiles.bulletHitMetal;
bulletHitFunc = undefined;

blockLos = false;

onGround = false;
projCollision = true;

height = 200;

solid = true;

smashable = false;
smashed = false;
prevSmashed = false;
smashSound = snd_glassSmash;