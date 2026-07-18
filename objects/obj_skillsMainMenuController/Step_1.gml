if (setup) {

	setup = false;
	
	//Button1
	if (instance_exists(class1Button) and instance_exists(label1)) {
		
		if (!is_undefined(class1)) {
			class1Button.txt = class1.name;
			class1Button.active = true;		
			label1.txt = "";
		}
	
	}
	
	
	//Button 2
	if (instance_exists(class2Button) and instance_exists(label2)) {
	
		class2Button.txt = "-----";
	
		if (level < 10) {
		
			label2.txt = "Available at level 10";
		
		} else if (class1 == undefined) {
		
			label2.txt = "Select Specialization";
			class2Button.txt = "Select";
		
		} else {
		
			class2Button.txt = class2.name;
		
		}
	
	}
	
}
