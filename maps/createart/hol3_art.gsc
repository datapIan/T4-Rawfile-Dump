//_createart generated.  modify at your own risk. Changing values should be fine.
main()
{

	level.tweakfile = true;
 
	// *Fog section* 

	setdvar("scr_fog_exp_halfplane", "6000");
	setdvar("scr_fog_exp_halfheight", "0");
	setdvar("scr_fog_nearplane", "100");
	setdvar("scr_fog_red", "0.5921");
	setdvar("scr_fog_green", "0.6274");
	setdvar("scr_fog_blue", "0.6039");
	setdvar("scr_fog_baseheight", "0");

	// *depth of field section* 

	level.dofDefault["nearStart"] = 0;
	level.dofDefault["nearEnd"] = 1;
	level.dofDefault["farStart"] = 8000;
	level.dofDefault["farEnd"] = 10000;
	level.dofDefault["nearBlur"] = 5;
	level.dofDefault["farBlur"] = 0;

	players = maps\_utility::get_players();
	for( i = 0; i < players.size; i++ )
	{
		players[i] maps\_art::setdefaultdepthoffield();
	}

	setdvar("visionstore_glowTweakEnable", "0");
	setdvar("visionstore_glowTweakRadius0", "5");
	setdvar("visionstore_glowTweakRadius1", "");
	setdvar("visionstore_glowTweakBloomCutoff", "0.5");
	setdvar("visionstore_glowTweakBloomDesaturation", "0");
	setdvar("visionstore_glowTweakBloomIntensity0", "1");
	setdvar("visionstore_glowTweakBloomIntensity1", "");
	setdvar("visionstore_glowTweakSkyBleedIntensity0", "");
	setdvar("visionstore_glowTweakSkyBleedIntensity1", "");
	setdvar("visionstore_filmTweakEnable", "0");
	setdvar("visionstore_filmTweakContrast", "1.4");
	setdvar("visionstore_filmTweakBrightness", "0");
	setdvar("visionstore_filmTweakDesaturation", "0.2");
	setdvar("visionstore_filmTweakInvert", "0");
	setdvar("visionstore_filmTweakLightTint", "1.1 1.05 0.85");
	setdvar("visionstore_filmTweakDarkTint", "0.7 0.85 1");

	VisionSetNaked( "hol3", 1 );

}
