// THIS FILE IS AUTOGENERATED, DO NOT MODIFY
main()
{
	self setModel("char_usa_pbycrew_pel2_body1_1");
	self.headModel = "char_usa_pbycrew_pel2_fullmask";
	self attach(self.headModel, "", true);
	self.voice = "american";
}

precache()
{
	precacheModel("char_usa_pbycrew_pel2_body1_1");
	precacheModel("char_usa_pbycrew_pel2_fullmask");
}
