main()
{

	maps\mp\mp_roundhouse_fx::main();	
	maps\mp\createart\mp_roundhouse_art::main();

	precachemodel("collision_geo_ramp");
	precachemodel("collision_geo_32x32x128");

	maps\mp\_load::main();
	
	// If the team nationalites change in this file,
	// you must update the team nationality in the level's csc file as well!
	
	
	maps\mp\mp_roundhouse_amb::main();

	// uncomment this when you have your own mini-map for this map
	maps\mp\_compass::setupMiniMap("compass_map_mp_roundhouse");

	game["allies"] = "russian";
	game["axis"] = "german";
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	game["allies_soldiertype"] = "german";
	game["axis_soldiertype"] = "german";

	game["strings"]["war_callsign_a"] = &"MPUI_CALLSIGN_ROUNDHOUSE_A";
	game["strings"]["war_callsign_b"] = &"MPUI_CALLSIGN_ROUNDHOUSE_B";
	game["strings"]["war_callsign_c"] = &"MPUI_CALLSIGN_ROUNDHOUSE_C";
	game["strings"]["war_callsign_d"] = &"MPUI_CALLSIGN_ROUNDHOUSE_D";
	game["strings"]["war_callsign_e"] = &"MPUI_CALLSIGN_ROUNDHOUSE_E";

	game["strings_menu"]["war_callsign_a"] = "@MPUI_CALLSIGN_ROUNDHOUSE_A";
	game["strings_menu"]["war_callsign_b"] = "@MPUI_CALLSIGN_ROUNDHOUSE_B";
	game["strings_menu"]["war_callsign_c"] = "@MPUI_CALLSIGN_ROUNDHOUSE_C";
	game["strings_menu"]["war_callsign_d"] = "@MPUI_CALLSIGN_ROUNDHOUSE_D";
	game["strings_menu"]["war_callsign_e"] = "@MPUI_CALLSIGN_ROUNDHOUSE_E";

	setdvar( "r_specularcolorscale", "1" );

	setdvar("compassmaxrange","2100");

	// enable new spawning system
	maps\mp\gametypes\_spawning::level_use_unified_spawning(true);
	
	thread trigger_killer( (1646,-3590, -518), 500, 10 );  // large and thin
	
	// original map hole
	spawncollision("collision_geo_ramp","collider",(1616,-3592,-416), (0,0,0));
	//lamp jump
	spawncollision("collision_geo_32x32x128","collider",(-463, -874, -277), (0,0,0));
	 
	return;
}

trigger_killer( position, width, height )
{
	kill_trig = spawn("trigger_radius", position, 0, width, height);

	while(1)
	{
		kill_trig waittill("trigger",player);
		if ( isplayer( player ) )
		{
			player suicide();
		}
	}
}

