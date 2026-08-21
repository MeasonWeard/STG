event_inherited();

setup = true;

canMove = false;

hashCellX = undefined;
hashCellY = undefined;

bulletHitSounds = global.data.soundProfiles.bulletHitMetal;
bulletHitFunc = undefined;



onGround = false;
onCeiling = false;
projCollision = true;
movementCollision = true;
blockLos = false;

height = 200;

solid = true;

smashable = false;
smashed = false;
prevSmashed = false;
smashSound = snd_glassSmash;