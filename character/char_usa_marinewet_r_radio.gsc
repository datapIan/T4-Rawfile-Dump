// THIS FILE IS AUTOGENERATED, DO NOT MODIFY
main()
{
	self setModel("char_usa_marine_wet_body1_1");
	self.headModel = codescripts\character::randomElement(xmodelalias\char_usa_marine_headalias::main());
	self attach(self.headModel, "", true);
	self.hatModel = "char_usa_raider_wet_helm2";
	self attach(self.hatModel);
	self.gearModel = "char_usa_marine_wet_radio";
	self attach(self.gearModel);
	self.voice = "american";
}

precache()
{
	precacheModel("char_usa_marine_wet_body1_1");
	codescripts\character::precacheModelArray(xmodelalias\char_usa_marine_headalias::main());
	precacheModel("char_usa_raider_wet_helm2");
	precacheModel("char_usa_marine_wet_radio");
}
