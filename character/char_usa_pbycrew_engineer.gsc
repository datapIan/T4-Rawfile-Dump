// THIS FILE IS AUTOGENERATED, DO NOT MODIFY
main()
{
	self setModel("char_usa_pbycrew_body1_1");
	self.headModel = "char_usa_marine_head3_3";
	self attach(self.headModel, "", true);
	self.hatModel = "char_usa_pbycrew_ballcap1";
	self attach(self.hatModel);
	self.voice = "american";
}

precache()
{
	precacheModel("char_usa_pbycrew_body1_1");
	precacheModel("char_usa_marine_head3_3");
	precacheModel("char_usa_pbycrew_ballcap1");
}