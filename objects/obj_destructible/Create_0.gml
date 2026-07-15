event_inherited();

setup = true;

hp = 50;

hashCellX = undefined;
hashCellY = undefined;

bulletHitSounds = global.data.soundProfiles.bulletHitMetal;
bulletHitFunc = undefined;

destroyFunc = undefined;
destroySound = snd_break1;

contents = [];
maxContents = 100;

lootMaxRarity = 3;
lootImproveChance = 25;

resStackSize = 4;
resMinFactor = 0.25;

meleeHitList = [];