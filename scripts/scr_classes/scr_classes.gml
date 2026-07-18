function classInst() constructor {
	
	name = "";
	
	id = -1;
	
	majorBonuses = undefined;
	minorBonuses = undefined;

	unlockedSkills = [];

}

function class_physics(): classInst() constructor {

	name = "Physics";
	id = classes.physics;
	
	majorBonuses = {
		radDamPerc: 10
	}
	
	minorBonuses = {
		kinDamPerc: 10
	}
	
}

function class_chemistry(): classInst() constructor {

	name = "Chemistry";
	id = classes.chemistry;
	
	majorBonuses = {
		chemDamPerc: 10
	}
	
	minorBonuses = {
		fireDamPerc: 10
	}
	
}

function class_biology(): classInst() constructor {

	name = "Biology";
	id = classes.biology;
	
	majorBonuses = {
		hpRegenPerc: 15
	}
	
	minorBonuses = {
		maxHpPerc: 10
	}
	
}

function class_engineering(): classInst() constructor {

	name = "Engineering";
	id = classes.engineering;
	
	majorBonuses = {
		energyRegenPerc: 15
	}
	
	minorBonuses = {
		elecDamPerc: 10
	}
	
}