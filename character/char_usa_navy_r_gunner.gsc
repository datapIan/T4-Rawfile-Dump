// THIS FILE IS AUTOGENERATED, DO NOT MODIFY
main()
{
	self setModel("char_usa_navy_wetsailor_body");
	self.headModel = "char_usa_marine_head1_2";
	self attach(self.headModel, "", true);
	self.hatModel = "char_usa_navy_wetsailor_cap2";
	self attach(self.hatModel);
	self.voice = "american";
}

precache()
{
	precacheModel("char_usa_navy_wetsailor_body");
	precacheModel("char_usa_marine_head1_2");
	precacheModel("char_usa_navy_wetsailor_cap2");
}
