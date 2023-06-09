// _flak88.gsc
// Sets up the behavior for the German Flak 88.

// TODO: Set up vehicle animations so they dont warp to center of flak88 after sequence is over
// TODO: get proper shell model for flak 88
#include maps\_utility;
#include common_scripts\utility;
#include maps\_vehicle;
#include maps\_vehicle_aianim; 
#include maps\_anim;

main( model, type )
{
	// Shell model 
	//precachemodel("com_trashbag"); 
	  
	level.tanks = [];
	// Sets up the basics for the vehicle. Pass in the vehicletype here.
	build_template( "flak88", model, type );
	
	// Anything specific to this vehicle.
	build_localinit( ::init_local );
	
	// Sets up the regular model and the death model.
	build_deathmodel( "german_artillery_flak88_nm", "german_artillery_flak88_nm_destroy" );
	build_deathmodel( "artillery_ger_flak88_winter", "artillery_ger_flak88_winter_d" );
	build_deathmodel( "artillery_ger_flak88", "artillery_ger_flak88_d" );
	
	
	// Build in the shock for when the vehicle fires is main turret
	build_shoot_shock( "tankblast" );
	
	// Animations to use when the vehicle is moving forward and backwards.
	//build_drive( %abrams_movement, %abrams_movement_backwards, 10 );
	
	// Exhaust FX to use
	//build_exhaust( "distortion/abrams_exhaust" );
	
	// Dust to play off of "tag_engine_exhaust"
	//build_deckdust( "dust/abrams_desk_dust" );
	
	// FX to play when vehicle dies
	build_deathfx( "explosions/large_vehicle_explosion", undefined, "explo_metal_rand" );
	
	// Health, min, max for the vehicle
	build_life( 999, 500, 1500 );
	
	// Default team
	build_team( "axis" );

	// Use if vehicle has a main turret
	build_mainturret();

	// Use if the vehicle needs a compass icon.
	//build_compassicon();

	// Everything else
	
	level.flak88_shell_model = "grenade_bag";
	level.flak88_bomb_model = "grenade_bag";
	level.flak88_bomb_model_obj = "grenade_bag";

	level.timersused = 0;
	level.safetyRange = 350;
	//load_flak_fx();
	//load_flak_anims();
	load_crew_anims();
	array_levelthread(getentarray("flakbarrel","targetname"),::flakbarrel);
}

// Anthing specific to this vehicle, used globally.
init_local()
{
	self flak88_init();
}

// SCRIPER_MOD: JesseS (5/1/07) Took out for now
// TODO: Make this work again
// Animation set up for vehicle anims
//#using_animtree( "tank" ); 
//set_vehicle_anims( positions )
//{
//	return positions; 
//}

////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////

//main(model)
//{
//
//	if (getcvar("debug_flak88") == "")
//		setcvar("debug_flak88", "off");
//		
//	precachemodel("xmodel/military_flak88_shell");
//	precachestring(&"SCRIPT_EXPLOSIVESPLANTED");
//
//
//	return true;
//}

// SCRITPER_MOD: jesseS (5/1/07): removed for now
// TODO: re-add fx
//load_flak_fx()
//{
//	level._effect["flak_burst"] = loadfx ("fx/muzzleflashes/flak_flash.efx");
//	level._effect["flak88_explode"] = loadfx ("fx/explosions/flak88_explosion.efx");
//	level._effect["damaged_vehicle_smoke"] = loadfx ("fx/smoke/damaged_vehicle_smoke.efx");
//	level._effect["flak_dust_blowback"] = loadfx ("fx/dust/flak_dust_blowback.efx");
//}

// SCRIPTER_MOD: 
// JesseS (5/1/07): Took this out for now until we figure out what to do with vehicle anims
//#using_animtree("flak88");
//load_flak_anims()
//{
//	level.scr_animtree["flak88"] = #animtree;
//	level.scr_anim["flak88"]["fire"] = %flak88_gun_fire_antitank;
//}

#using_animtree("generic_human");
load_crew_anims()
{	
	//Leader - Officer
	level.scr_anim["leader"]["fire"]			= %ai_88antitank_leader_loadandfire;
	level.scr_anim["leader"]["idle0"]			= %ai_88antitank_leader_twitch;
	level.scr_anim["leader"]["idle1"]			= %ai_88antitank_leader_idle;
	level.scr_anim["leader"]["idle2"]			= %ai_88antitank_leader_idle;
	level.scr_anim["leader"]["idle3"]			= %ai_88antitank_leader_idle;
	level.scr_anim["leader"]["idle4"]			= %ai_88antitank_leader_idle;
	level.scr_anim["leader"]["turnleft"]		= %ai_88antitank_leader_turnleft;
	level.scr_anim["leader"]["turnright"]		= %ai_88antitank_leader_turnright;
	level.scr_anim["leader"]["commandleft"]		= %ai_88antitank_leader_commandright;
	level.scr_anim["leader"]["commandright"]	= %ai_88antitank_leader_commandleft;
	
	//Passer - gets ammo from the box and hands it to the loader
	level.scr_anim["passer"]["fire"]			= 	%ai_88antitank_passer_loadandfire;
	level.scr_anim["passer"]["idle0"]			= 	%ai_88antitank_passer_twitch;
	level.scr_anim["passer"]["idle1"]			= 	%ai_88antitank_passer_idle;
	level.scr_anim["passer"]["idle2"]			= 	%ai_88antitank_passer_idle;
	level.scr_anim["passer"]["idle3"]			= 	%ai_88antitank_passer_idle;
	level.scr_anim["passer"]["idle4"]			= 	%ai_88antitank_passer_idle;
	level.scr_anim["passer"]["turnleft"]		= %ai_88antitank_passer_turnright;
	level.scr_anim["passer"]["turnright"]		= %ai_88antitank_passer_turnleft;
	
	//Loader - gets the shell from the passer and puts it into the gun
	level.scr_anim["loader"]["fire"]			= 	%ai_88antitank_loader_loadandfire;
	level.scr_anim["loader"]["idle0"]			= 	%ai_88antitank_loader_twitch;
	level.scr_anim["loader"]["idle1"]			= 	%ai_88antitank_loader_idle;
	level.scr_anim["loader"]["idle2"]			= 	%ai_88antitank_loader_idle;
	level.scr_anim["loader"]["idle3"]			= 	%ai_88antitank_loader_idle;
	level.scr_anim["loader"]["idle4"]			= 	%ai_88antitank_loader_idle;
	level.scr_anim["loader"]["turnleft"]		= %ai_88antitank_loader_turnleft;
	level.scr_anim["loader"]["turnright"]		= %ai_88antitank_loader_turnright;
	
	//Ejecter - makes the flak88 fire
	level.scr_anim["ejecter"]["fire"]			= 		%ai_88antitank_ejecter_loadandfire;
	level.scr_anim["ejecter"]["idle0"]			= 	%ai_88antitank_ejecter_twitch;
	level.scr_anim["ejecter"]["idle1"]			= 	%ai_88antitank_ejecter_idle;
	level.scr_anim["ejecter"]["idle2"]			= 	%ai_88antitank_ejecter_idle;
	level.scr_anim["ejecter"]["idle3"]			= 	%ai_88antitank_ejecter_idle;
	level.scr_anim["ejecter"]["idle4"]			= 	%ai_88antitank_ejecter_idle;
	level.scr_anim["ejecter"]["turnleft"]		= 	%ai_88antitank_ejecter_turnright;
	level.scr_anim["ejecter"]["turnright"]		= %ai_88antitank_ejecter_turnleft;
	
	//Aimer - turns wheel
	level.scr_anim["aimer"]["fire"]				= 	%ai_88antitank_aimer_loadandfire;
	level.scr_anim["aimer"]["idle0"]			= 	%ai_88antitank_aimer_twitch;
	level.scr_anim["aimer"]["idle1"]			= 	%ai_88antitank_aimer_idle;
	level.scr_anim["aimer"]["idle2"]			= 	%ai_88antitank_aimer_idle;
	level.scr_anim["aimer"]["idle3"]			= 	%ai_88antitank_aimer_idle;
	level.scr_anim["aimer"]["idle4"]			= 	%ai_88antitank_aimer_idle;
	level.scr_anim["aimer"]["turnleft"]			= %ai_88antitank_aimer_turnright;
	level.scr_anim["aimer"]["turnright"]		= %ai_88antitank_aimer_turnleft;
}

flakcrew_animation_think(flak)
{
	self endon ("death");
	self endon ("crew dismounted");
	flak endon ("crew dismounted");
	flak endon ("newcrew");
	for (;;)
	{
		if (flak.turning != "none")
			self thread flakcrew_playAnim(flak, flak.turning);
		else
			self thread flakcrew_playAnim(flak, "idle" + randomint(5));
		
		self waittill ("flakcrew animation done");
	}
}

flakcrew_playAnim(flak, animName)
{
	self notify ("stop anim");
	self endon ("stop anim");
	self endon ("death");
	flak endon ("death");
	flak endon ("crew dismounted");
	
	tagOrigin = flak getTagOrigin ("tag_turret");
	tagAngles = flak getTagAngles ("tag_turret");
	if (isalive (self))
	{
		self animscripted("scriptedanimdone", tagOrigin, tagAngles, level.scr_anim[self.crewposition][animName]);
		self thread donotetracks_flak88("scriptedanimdone",flak);
		self.allowDeath = 1;
		self waittillmatch ("scriptedanimdone","end");
		self notify ("flakcrew animation done");
	}
}

donotetracks_flak88(anime,flak)
{
	self endon ("stop anim");
	self endon ("death");
	flak endon ("death");
	flak endon ("crew dead");
	flak endon ("crew dismounted");	
	while(1)
	{
		self waittill(anime,note);
		switch(note)
		{
			case "attach":
			self attach_shell();
			break;
			case "detach":
			self detach_shell();
			break;
			case "end":
			break;
			default:
			self detach_shell();
			break;
		}	
	}
	
}

detach_shell()
{
	if(self.has_shell)
	{
		self.has_shell = false;
		self detach(level.flak88_shell_model,"tag_weapon_right");
	}	
}

attach_shell()
{
	if(!self.has_shell)
	{
		self.has_shell = true;
		self attach(level.flak88_shell_model,"tag_weapon_right");
	}	
}

flakcrew_gunbackinhand(flak)
{
	self endon ("death");
	flak endon ("newcrew");
	flak waittill_any("crew dismounted", "crew dead", "death");
	self detach_shell();
	//self.hasWeapon = true;
//	self.weapon = self.oldweapon;
	flak notify ("crew dismounted");
	
	if( !flak isCheap() )
	{
		self animscripts\shared::placeWeaponOn( self.primaryweapon, "right");
	}
	
	// SCRIPTER_MOD: JesseS(5/1/07): took out this call, since placeweaponOn is the new way to do it
	//self animscripts\shared::PutGunInHand("right");
	self.health = self.oldhealth;
	self.oldhealth = undefined;
	wait randomfloatrange(0,1);
	self stopanimscripted();
	
}

badplace_when_near()
{
	if(level.script == "elalamein")
		return;  //testing
	self endon ("death");
	self endon ("bomb planted");
	
	//spawn trigger radius
	trig = spawn( "trigger_radius", self.origin, 0, 200, 200 );
	
	for (;;)
	{
		trig waittill ("trigger");
		
		badplacename = ("flak_badplace_player_near" + randomint(1000));
		badplace_cylinder(badplacename, 2, self.origin, 250, 300);
		wait 1.8;
	}
}

flak_use_dismount()
{
	self waittill ("trigger");
	level flak88_dismount_crew(self,true);
}

flak88_init()
{
	if(!isdefined(self.script_team))
		self.script_team = "axis";
	
	// SCRIPTER_MOD: JesseS (5/1/07) removed for now
	// todo: setup vehicle anims again
	//self useAnimTree(level.scr_animtree["flak88"]);
	//self life_flak88();
	self thread kill_flak88();
	self thread shoot();
	self.enemyque = [];  // a kind of integration with _vehicle attack stuff
	//get the explosives if it has any and setup that stuff
	if (isdefined (self.target))
	{
		targeted = getentarray(self.target,"targetname");
		triggerUse = [];
		for (i=0;i<targeted.size;i++)
		{
			if (targeted[i].classname == "trigger_use")
				triggerUse[triggerUse.size] = targeted[i];
			else if (targeted[i].classname == "script_origin")
				self.customTarget = targeted[i];
		}
		if (triggerUse.size > 0)
		{	
			self.bombTriggers = [];
			self.bombs = [];
			for (i=0;i<triggerUse.size;i++)
			{
				if (isdefined (triggerUse[i].target))
				{
					tempBomb = getent(triggerUse[i].target,"targetname");
					if (isdefined (tempBomb))
					{
						self.bombTriggers[self.bombTriggers.size] = triggerUse[i];
						self.bombs[self.bombs.size] = tempBomb;
					}
				}
			}
			
			if ( (self.bombTriggers.size > 0) && (self.bombs.size > 0) )
			{
				// SCRIPTER_MOD: JesseS 5/1/07: took these out for now
				//precacheModel("xmodel/military_tntbomb_obj");
				//precacheModel("xmodel/military_tntbomb");
				//precacheShader("hudStopwatch");
				//precacheShader("hudStopwatchNeedle");
				self thread flak88_explosives();
				self thread badplace_when_near();
			}
		}
	}
	
	self.turning = "none";
	self thread flak_monitorTurretAngles();
	self thread flak_use_dismount();
	if (isdefined (self.script_flak88))
		self spawner_trigger();
}

flak_monitorTurretAngles()
{
	self endon ("death");
	self endon ("crew dismounted");
	
	prevAngles = (0,0,0);
	newAngles = (0,0,0);
	for (;;)
	{
		prevAngles = newAngles;
		newAngles = self getTagAngles ("tag_turret");
		
		if (newAngles[1] < prevAngles[1])
			self.turning = "turnright";
		else if (newAngles[1] > prevAngles[1])
			self.turning = "turnleft";
		else
			self.turning = "none";
		
		wait 0.1;
	}
}

flak88_explosives()
{
	self endon ("death");
	for (i=0;i<self.bombs.size;i++)
	{
		self.bombs[i] linkto(self, "tag_turret");
		self.bombs[i] setmodel (level.flak88_bomb_model_obj);
	}
	for (i=0;i<self.bombTriggers.size;i++)
	{
		self.bombTriggers[i] enablelinkto();
		self.bombTriggers[i] linkto(self, "tag_barrel");
		self thread flak88_explosives_wait(self.bombTriggers[i]);
	}
	
	self waittill ("explosives planted");
	
//	badplacename = ("flak_badplace_" + randomfloat(1000));
//	badplace_cylinder(badplacename, -1, self.origin, 250, 300);
	badplace_cylinder("", level.explosiveplanttime, self.origin, 250, 300);
	
	iprintlnbold (&"SCRIPT_EXPLOSIVESPLANTED");
	
	for (i=0;i<self.bombTriggers.size;i++)
		self.bombTriggers[i] delete();
	
	//get closest bomb to player
	// SCRIPTER_MOD: JesseS (7/21/2007): TODO: Fix get_players reference here
	bomb = getClosest(get_players()[0] getOrigin(), self.bombs);
	bomb setmodel (level.flak88_bomb_model);
	bomb playsound ("explo_plant_rand");
	bomb thread loopsound_for_time_or_death ("bomb_tick",level.explosiveplanttime);
	
	for (i=0;i<self.bombs.size;i++)
	{
		if (self.bombs[i] == bomb)
			continue;
		self.bombs[i] delete();
	}
	
	if (isdefined (self.bombstopwatch))
		self.bombstopwatch destroy();

	// SCRIPTER_MOD: JesseS (5/1/07): Took this out for
	// TODO: Add back in stop watch functionality
	//self.bombstopwatch = maps\_utility::getstopwatch(60);
	level.timersused++;
	wait level.explosiveplanttime;
	bomb stoploopsound ("bomb_tick");
	level.timersused--;
	if (level.timersused < 1)
	{
		if (isdefined (self.bombstopwatch))
			self.bombstopwatch destroy();
	}
//	badplace_delete(badplacename);
// SCRIPTER_MOD: JesseS (7/21/2007): TODO: fix get_players reference here
	self notify ("death", get_players()[0]);
}

loopsound_for_time_or_death(sound,time)
{
//	self thread loopsound_end_ondeath(sound);
	self endon ("death");
	self playloopsound (sound);
	wait time;
	self stoploopsound (sound);
}

loopsound_end_ondeath(sound)
{
//	self waittill ("death");
//	self stoploopsound (sound);
}

flak88_explosives_wait(trigger)
{
	self endon ("death");
	self endon ("explosives planted");
	
	trigger setHintString (&"SCRIPT_PLATFORM_HINTSTR_PLANTEXPLOSIVES");
	trigger waittill ("trigger");
	
	if (isdefined (trigger.script_noteworthy))
		level notify (trigger.script_noteworthy);
	self notify ("explosives planted", trigger);
}

stop_flak88_objective(flak)
{
	self waittill ("trigger");
	flak.remaining_ai_afterstop = 0;
	ai = getaiarray("axis");
	for (i=0;i<ai.size;i++)
	{
		if(distance(flat_origin(ai[i].origin),flat_origin(flak.origin)) < 600)
			ai[i] thread stop_flak88_remainingai(flak);
	}
	if(!flak.remaining_ai_afterstop)
		flak notify ("flakai_cleared");	
}

stop_flak88(flak)
{
	flak endon ("death");
	flak endon ("crew dead");
	flak endon ("crew dismounted");
	self waittill ("trigger");
	//notify the flak and all AI to stop working
	flak88_dismount_crew(flak);
}

stop_flak88_remainingai(flak)
{
	flak.remaining_ai_afterstop++;
	self waittill ("death");
	flak.remaining_ai_afterstop--;
	if(!flak.remaining_ai_afterstop)
		flak notify ("flakai_cleared");
}

spawn_trigger_wait(trigger)
{
	trigger waittill ("trigger");
	if (isdefined (trigger.script_noteworthy))
		level waittill (trigger.script_noteworthy);
	if(isdefined(trigger.script_flakaicount))
	{
		count = trigger.script_flakaicount;
		if(isdefined(level.flakaicountmod) && count)
			count--;
	}
	else
		count = undefined;	

	self notify ("spawntriggered",count);
}

spawner_trigger()
{
	self endon ("death");
	if (!isdefined (self.script_flak88))
		return;
	spawn_trigger = false;
	AllTrigs = [];
	AllTrigs = getentarray ("trigger_multiple","classname");
	trigs2 = [];
	trigs2 = getentarray ("trigger_radius","classname");
	if (isdefined (trigs2[0]))
	{
		for (i=0;i<trigs2.size;i++)
			AllTrigs[AllTrigs.size] = trigs2[i];
	}
	if (isdefined (AllTrigs[0]))
	{
		for (i=0;i<AllTrigs.size;i++)
		{
			if ( (isdefined (AllTrigs[i].script_flak88)) && (AllTrigs[i].script_flak88 == self.script_flak88) )
			{
				if ( (isdefined (AllTrigs[i].targetname)) && (AllTrigs[i].targetname == "stop flak88") )
				{
					alltrigs[i] thread stop_flak88_objective(self);
					continue;
				}
				spawn_trigger = true;
				thread spawn_trigger_wait(AllTrigs[i]);
			}
		}
	}
	ents = getspawnerarray();
	spawners = [];
	for (i=0;i<ents.size;i++)
	{
		if (!isdefined (ents[i].script_flak88))
			continue;
		if (ents[i].script_flak88 == self.script_flak88)
			spawners[spawners.size] = ents[i];
	}
	
	if (spawners.size == 0)
		return;
	
	crewspawned = false;
	
	count = 0;
	while(1)
	{
		numberofguys = undefined;
		if (spawn_trigger)
			self waittill ("spawntriggered",numberofguys);
		
		self.crewsize = 0;
		self.crewMembers = [];
		
		if(!isdefined(numberofguys))
			numberofguys = spawners.size;
		
		println("attempting to set up new flakcrew: ",count);
		count++;
		self notify ("newcrew");
		
		
		//spawn the flak88 crew
		leader = undefined;
		loader = undefined;
		passer = undefined;
		ejecter = undefined;
		aimer = undefined;
		
		for (i=0;i<numberofguys;i++)
		{
			if (!isdefined(spawners[i]))
				continue;
			spawners[i].count = 1;
			spawned = undefined;
			if( !self isCheap() )
			{
				spawned = spawners[i] spawn_ai();
			}
			else
			{
				maps\_spawner::dronespawn_setstruct( spawners[i] );
				spawned = dronespawn( spawners[i] );
				if( isDefined( spawned ) )
				{
					spawned thread maps\_drones::drone_fakeDeath();
					spawned.no_death_sink = true;
					spawned.team = "axis";
				}
			}
			if (!spawn_failed(spawned) || self isCheap() )
			{
				self.crewposition = undefined;
				self.crewsize++;
				//self.associatedAI++;
				self.crewMembers[self.crewMembers.size] = spawned;
				if( !self isCheap() )
				{
					spawned.goalradius = 768;
					spawned setgoalpos (self.origin);
				}
				spawned.has_shell = false;
				
				//set the guys crew position for the flak88
				if (!isdefined (loader))
				{
					spawned.crewposition = "loader";
					loader = 1;
				}
				else if (!isdefined (passer))
				{
					spawned.crewposition = "passer";
					passer = 1;
				}
				else if (!isdefined (leader))
				{
					spawned.crewposition = "leader";
					leader = 1;
				}
				else if (!isdefined (ejecter))
				{
					spawned.crewposition = "ejecter";
					ejecter = 1;
				}
				else if (!isdefined (aimer))
				{
					spawned.crewposition = "aimer";
					aimer = 1;
				}
				else
				{
					if( !self isCheap() )
					{
						//all positions are filled so just make this guy go to his node
						self.crewsize--;
						if (!isdefined (spawned.target))
						{
							// he doesn't have a node so make him stay near the flak88
							spawned.goalradius = 800;
							spawned setGoalPos (self.origin);
						}
						else
						{
							node = getnode (spawned.target,"targetname");
							if (isdefined (node))
								spawned setgoalNode (node);
						}
					}
				}
				
				//make him play the animations
				if (isdefined (spawned.crewposition))
				{
					spawned.oldhealth = spawned.health;
					if( spawned.oldhealth <= 0 )
					{
						spawned.oldhealth = 1;
					}
					spawned.health = 1;
//					spawned.oldweapon = spawned.weapon;
					spawned linkto (self, "tag_turret");
					//spawned.hasWeapon = false;
//				spawned.weapon = "xmodel/military_flak88_shell";
					spawned.anim_disablelongdeath = true; // never to be enabled again.
				
				
					// SCRIPTER_MOD: jesses (4/5/07):: This doesnt exist anymore
					// TODO: Turn off battle chatter here
					//spawned thread maps\_utility::setbattlechatter(false);
				
				//	spawned animscripts\shared::putGunInHand ("none");
					
					if( !self isCheap() )
					{
						spawned animscripts\shared::placeWeaponOn( spawned.primaryweapon, "none");
					}
	
					spawned thread flakcrew_animation_think(self);
					spawned thread flakcrew_gunbackinhand(self);
					thread delete_on_newcrew(spawned);
				}
				level thread flak88_crew_waittill_death(self, spawned);
			}
		}
		/*
		for( i = 0 ; i < self.crewmembers.size ; i++ )
		{
			assert(isdefined(self.crewmembers[i]));
			assert(isalive(self.crewmembers[i]));
		}
		*/
		self.crewmembers = array_removeDead(self.crewmembers);
		
		self thread flak88_waittill_crewdead(self.crewmembers);
		self thread think();
		trigs = getentarray ("stop flak88","targetname");
		for (i=0;i<trigs.size;i++)
		{
			if ( (isdefined (trigs[i].script_flak88)) && (trigs[i].script_flak88 == self.script_flak88) )
			{
				trigs[i] thread stop_flak88(self);
				break;
			}
		}

		if(!spawn_trigger)
			break;
	}
}

mount_world_flakcrew( entArray )
{
	self endon ("death");
	
	crew_array = [];
	if( !isDefined( self.crewmembers ) )
	{
		self.crewmembers = [];
		self.crewsize = 5;
	}
	
	// Sanity check, is there no crew for the gun?
	for( i = 0; i < self.crewsize; i++ )
	{
		// SCRIPTER_MOD: BJoyal (6/18/08): see if they are alive as well as dead
		if( isDefined( self.crewmembers[i] ) && isalive( self.crewmembers[i] ) )
		{
			ASSERTMSG( "Trying to set a new crew on a flak 88 with a designated crew!" );
			return;
		}
	}
	
	self notify( "newcrew" );
	
	leader = undefined;
	loader = undefined;
	passer = undefined;
	ejecter = undefined;
	aimer = undefined;
	
	for (i=0;i<entArray.size;i++)
	{
		// SCRIPTER_MOD: BJoyal (6/18/08): Check to see if he is dead as well as defined
		if (!isdefined(entArray[i]) && !isalive(entArray[i]) )
			continue;
			
		self.crewposition = undefined;
		self.crewsize++;
		//self.associatedAI++;
		self.crewMembers[self.crewMembers.size] = entArray[i];
		entArray[i].goalradius = 768;
		entArray[i] setgoalpos (self.origin);
		entArray[i].has_shell = false;
		
		//set the guys crew position for the flak88
		if (!isdefined (loader))
		{
			entArray[i].crewposition = "loader";
			entArray[i].animname = "loader";
			crew_array = array_add( crew_array, entArray[i] );
			loader = 1;
		}
		else if (!isdefined (passer))
		{
			entArray[i].crewposition = "passer";
			entArray[i].animname = "passer";
			crew_array = array_add( crew_array, entArray[i] );
			passer = 1;
		}
		else if (!isdefined (leader))
		{
			entArray[i].crewposition = "leader";
			entArray[i].animname = "leader";
			crew_array = array_add( crew_array, entArray[i] );
			leader = 1;
		}
		else if (!isdefined (ejecter))
		{
			entArray[i].crewposition = "ejecter";
			entArray[i].animname = "ejecter";
			crew_array = array_add( crew_array, entArray[i] );
			ejecter = 1;
		}
		else if (!isdefined (aimer))
		{
			entArray[i].crewposition = "aimer";
			entArray[i].animname = "aimer";
			crew_array = array_add( crew_array, entArray[i] );
			aimer = 1;
		}
		else
		{
			//all positions are filled so just make this guy go to his node
			self.crewsize--;
			if (!isdefined (entArray[i].target))
			{
				// he doesn't have a node so make him stay near the flak88
				entArray[i].goalradius = 800;
				entArray[i] setGoalPos (self.origin);
			}
			else
			{
				node = getnode (entArray[i].target,"targetname");
				if (isdefined (node))
					entArray[i] setgoalNode (node);
			}
		}
		//make him play the animations
		
		level thread flak88_crew_waittill_death(self, entArray[i]);
	}
	/*
	for( i = 0 ; i < self.crewmembers.size ; i++ )
	{
		assert(isdefined(self.crewmembers[i]));
		assert(isalive(self.crewmembers[i]));
	}
	*/
	
	// SCRIPTER_MOD: BJoyal (6/18/08): remove dead from the array (in case some died during this setup)
	crew_array = array_removeDead(crew_array);
	
	level anim_reach( crew_array, "idle1", "tag_turret",  self );
	for( i = 0; i < crew_array.size; i++ )
	{
		if(isdefined( crew_array[i]) && isalive(crew_array[i]) )
		{
			crew_array[i].oldhealth = crew_array[i].health;
			crew_array[i].health = 1;
//					entArray[i].oldweapon = spawned.weapon;
			crew_array[i] linkto (self, "tag_turret");
			//entArray[i].hasWeapon = false;
//				entArray[i].weapon = "xmodel/military_flak88_shell";
			crew_array[i].anim_disablelongdeath = true; // never to be enabled again.
		
		
			// SCRIPTER_MOD: jesses (4/5/07):: This doesnt exist anymore
			// TODO: Turn off battle chatter here
			//entArray[i] thread maps\_utility::setbattlechatter(false);
		
		//	entArray[i] animscripts\shared::putGunInHand ("none");
			
			crew_array[i] animscripts\shared::placeWeaponOn( entArray[i].primaryweapon, "none");

			crew_array[i] thread flakcrew_animation_think(self);
			crew_array[i] thread flakcrew_gunbackinhand(self);
		}
	}
	
	self.crewmembers = array_removeDead(self.crewmembers);
	
	self thread flak88_waittill_crewdead(self.crewmembers);
	self thread think();
	trigs = getentarray ("stop flak88","targetname");
	for (i=0;i<trigs.size;i++)
	{
		if ( (isdefined (trigs[i].script_flak88)) && (trigs[i].script_flak88 == self.script_flak88) )
		{
			trigs[i] thread stop_flak88(self);
			break;
		}
	}
}

delete_on_newcrew(spawned)
{
	spawned endon ("death");
	self waittill ("newcrew");
	spawned delete();
}

flak88_dismount_crew(flak,used)
{
	if(!isdefined(used))
		used = false;
    if (isdefined (flak.crewMembers))
	{
		for (i=0;i<flak.crewMembers.size;i++)
		{
			if (!isdefined (flak.crewMembers[i]))
				continue;
			flak.crewMembers[i] detach_shell();
			flak.crewMembers[i] unlink();
		}
	}
	if(!used)
		flak clearTurretTarget();
	flak notify ("crew dismounted");
}

flak88_waittill_crewdead(guys)
{
	self endon ("newcrew");
	level waittill_dead(guys);
	self notify ("crew dead");
}



flak88_crew_waittill_death(flak, crew_member)
{
	flak endon ("newcrew");
	flak endon ("death");
	flak endon ("crew dismounted");
	crew_member endon ("crew dismounted");
	//crew_member endon ("death");
	
	isLeader = false;
	if ( (isdefined (crew_member.crewposition)) && (crew_member.crewposition == "leader") )
		isLeader = true;
	crew_member waittill ("death");
	if (isdefined (crew_member))
	{
		crew_member detach_shell();
		crew_member unlink();
	}
	flak.crewsize--;
	if (flak.crewsize <= 0)
	{
		flak clearTurretTarget();
		flak notify ("crew dead");
	}
	else if (!isLeader)
	{
		//someone in the crew was killed so notify the other crew members to dismount the gun
		flak clearTurretTarget();
		
		flak88_dismount_crew(flak);
	}
}

//life_flak88()
//{
//	self.health = 999;
//	self.deathsound = "flak88_explode";
//	self.deathfx = "flak88_explode";
//	self.deathmodel = level.deathmodel[self.model];
//}

kill_flak88()
{
	notifyString = undefined;
	
	self waittill("death");
	if(isdefined(level.hitbyplayervehiclethread))
		thread [[level.hitbyplayervehiclethread]]();
	
	//kill the crew
	ai = getaiarray();
	for (i=0;i<ai.size;i++)
	{
		if (!isdefined(ai[i]))
			continue;
		if (!isalive(ai[i]))
			continue;
		if (!isdefined(ai[i].script_flak88))
			continue;
		if (!isdefined(self.script_flak88))
			continue;
		if ( (isdefined (ai[i].script_flak88)) && (ai[i].script_flak88 == self.script_flak88) )
		{
			ai[i] unlink();
			if (distance(self.origin,ai[i].origin) <= 350)
				ai[i] doDamage(	ai[i].health, ai[i].origin );
		}
	}
	//flak88_dismount_crew(self);
	
	if (isdefined (notifyString))
		level notify (notifyString);
	
	if (!isdefined(self))
		return;
	
	if (isdefined (self.bombstopwatch))
		self.bombstopwatch destroy();
	
	if(level.playervehicle != self)
		self clearTurretTarget();
	
	if (isdefined (self.deathsound))
		self playsound(self.deathsound);
	if (isdefined (self.deathfx))
		level thread maps\_fx::OneShotfx(self.deathfx, self.origin, 0);
	
	players = get_players();
	for (i = 0; i < players.size; i++)
	{
		players[i] enableHealthShield( false );
		radiusDamage (self.origin + (0,0,300), 400, 700, 100);
		players[i] enableHealthShield( true );
	}
	
	level thread maps\_fx::loopfx("damaged_vehicle_smoke", self.origin, .8);
	earthquake( 0.25, 3, self.origin, 1050 );
	
	if (isdefined (self.deathmodel))
		self setmodel(self.deathmodel);
	if (isdefined (self.bombs))
	{
		for (i=0;i<self.bombs.size;i++)
		{
			if (isdefined(self.bombs[i]))
				self.bombs[i] delete();
		}
	}
	
	if (isdefined (self.bombTriggers))
	{
		for (i=0;i<self.bombTriggers.size;i++)
		{
			if (isdefined (self.bombTriggers[i]))
				self.bombTriggers[i] delete();
		}
	}
}

shoot_flak(org)
{
	if (!isdefined (org))
		return false;
	if (!isdefined (self))
		return false;
	if (self.health <= 0)
		return false;
	
	//dont allow crew or flak to be killed when actually fireing (some sort of splash damage protection)
	//self flak_and_crew_splashSheild();
	
	wait 0.2;
	
	//crew needs to play fire animation...
	if (isdefined (self.crewMembers))
	{
		for (i=0;i<self.crewMembers.size;i++)
		{
			if ( (isdefined (self.crewMembers[i])) && (isdefined (self.crewMembers[i].crewposition)) )
				self.crewMembers[i] thread flakcrew_playAnim(self, "fire");
		}
	}
	
	//SCRIPTER_MOD: JesseS (5/9/2007) - took out blowback, doesnt exist yet
	//playfxOnTag ( level._effect["flak_dust_blowback"], self, "tag_turret" );
	
	self notify ("turret_fire");
	
	wait 0.2;
	
	//set the crew members and flaks health values back to normal now that they fired
	//self flak_and_crew_removeSplashSheild();
	
	return true;
}
/*
flak_and_crew_splashSheild()
{
	self.health_before_fire = self.health;
	if (isdefined (self.crewMembers))
	{
		for (i=0;i<self.crewMembers.size;i++)
		{
			self.crewMembers[i].health_before_fire = self.crewMembers[i].health;
			self.crewMembers[i].health = 1000000;
		}
	}
}
*/
/*
flak_and_crew_removeSplashSheild()
{
	if ( (isdefined (self)) && (self.health > 0) )
	//self.health = self.health_before_fire;
	//self.health_before_fire = undefined;
	if (isdefined (self.crewMembers))
	{
		for (i=0;i<self.crewMembers.size;i++)
		{
			if ( (isdefined (self.crewMembers[i])) && (isalive (self.crewMembers[i])) && (self.crewMembers[i].health > 0) )
			{
				self.crewMembers[i].health = self.crewMembers[i].health_before_fire;
				self.crewMembers[i].health_before_fire = undefined;
			}
		}
	}
}
*/
//INTEGRATES WITH THE TANK SCRIPTS
//-------------------------------------------
//LOOKS FOR TANKS IN THE LEVEL.TANKS VARIABLE
//ARRAY AND SHOOTS AT CLOSEST TANKS FIRST
//-------------------------------------------
think()
{
	self endon ("death");
	self endon ("newcrew");
	if (!isdefined (self.script_accuracy))
		self.script_accuracy = .4;
	else if (self.script_accuracy >= 1.000)
		self.script_accuracy = .99;
	
	if ( (!isdefined (self.script_delay_min)) || (!isdefined (self.script_delay_max)) )
	{
		self.script_delay_min = 4;
		self.script_delay_max = 8;
	}
	
	if ( (isdefined (self.script_leftarc)) && (isdefined (self.script_rightarc)) && ( (self.script_leftarc + self.script_rightarc) >= 360 ) )
	{
		self.script_leftarc = undefined;
		self.script_rightarc = undefined;
	}
	delay_difference = (self.script_delay_max - self.script_delay_min);
	
	if ( (!isdefined (self.script_shoottanks)) && (!isdefined (self.script_shootAI)) )
	{
		//set defaults (auto flak88s only shoot tanks by default)
		self.script_shoottanks = 0;	// SCRIPTER_MOD: JesseS (05/09/07): Set to 0 by default for now
		self.script_shootai = 0;
	}
	
	if (!isdefined (self.script_shoottanks))
		self.script_shoottanks = 1;
	if (!isdefined (self.script_shootAI))
		self.script_shootAI = 0;
	
	if ( (self.script_shoottanks == 0) && (self.script_shootai == 0) )
		self.autoTarget = false;
	
	if (!isdefined (self.autoTarget))
		self.autoTarget = true;
	
	//*************
	// FLAK88 THINK
	//*************
	self endon ("crew dismounted");
	self endon ("crew dead");
	
	// SCRIPTER_MOD: JesseS (7/21/2007): TODO: fixup get_players reference here
	get_players()[0] endon ("death");
	
	for (;;)
	{
		//flak88s could be controlled in another script at this point so check to see if this is the case
		if ( (isdefined (self.autoTarget)) && (self.autoTarget == false) )
		{
			if (isdefined (self.customTarget))
				level Target_Kill_Using_Accuracy(self, self.customTarget, delay_difference);
			else
				wait 1;
			continue;
		}
		
		//Check to see what the flak88 is allowed to shoot and aquire targets based on it's allowed targets
		//Tanks have higher priority than AI
		AI_Target = undefined;
		Tank_Target = undefined;
		if (self.script_shootAI == 1)
			AI_Target = self Target_Aquire_AI();
		if (self.script_shoottanks == 1)
			Tank_Target = self Target_Aquire_Tank();
		
		if ( (!isdefined (AI_Target)) && (!isdefined (Tank_Target)) )
		{
			//no targets for the flak88 to shoot at
			//if (!isdefined (self))
			//	return;
			self clearTurretTarget();
			wait 0.5;
		}
		else
		{
			target = undefined;
			//The flak88 has a target...
			if (isdefined (Tank_Target))
				target = Tank_Target;
			else if (isdefined (AI_Target))
				target = AI_Target;
			
			//Flak88 will kill the target that has been aquired
			if (isdefined (target))
				level Target_Kill_Using_Accuracy(self, target, delay_difference);
		}
	}
}

Target_Aquire_Tank()
{
	self endon ("death");
	if(level.tanks.size == 0)
		return undefined;

	//find the closest tank to the flak88 (but not too close = level.safetyRange)
	target = undefined;
	closest = 100000000;
	
	
	if(self.enemyque.size) //integrate with vehicle focus fire triggers.	
	{
		array = [];
		for(i=0;i<self.enemyque.size;i++)
		{
			if(isdefined(self.enemyque[i]) && self.enemyque[i].health > 0)
				array[array.size] = self.enemyque[i];
		}
		self.enemyque = array;
	}
	else
		array = level.tanks;
	
	if(isdefined(level._flakignoretanks))
	{
		for(i=0;i<level._flakignoretanks.size;i++)
			array = array_remove(array,level._flakignoretanks[i]);
	}
	
	for (i=0;i<array.size;i++)
	{
		//check to see if this tank is within the allowed fire arc
		if ( (cone_check(self, array[i].origin) == true) && (array[i].script_team != self.script_team) )
		{
			dist = distance (self.origin, array[i].origin);
			if ( (dist < closest) && (dist >= level.safetyRange) )
			{
				//this is closest but if it doesn't pass safety range tests then throw it out
				if (!SafetyRangeCheck(array[i].origin))
					continue;
				
				//if you can't hit the tank then dont try to shoot it
				tank_org = (array[i].origin + (0,0,40));
				flak_org = (self.origin + (0,0,68));
				trace = bulletTrace(flak_org, tank_org, false, undefined);
				end_loc = trace["position"];
				
				OffsetX = abs(tank_org[0] - end_loc[0]);
				OffsetY = abs(tank_org[1] - end_loc[1]);
				OffsetZ = abs(tank_org[2] - end_loc[2]);
				
				OffsetX_Pass = (OffsetX <= 160);
				OffsetY_Pass = (OffsetY <= 160);
				OffsetZ_Pass = (OffsetZ <= 160);
				
				if (!(OffsetX_Pass && OffsetY_Pass && OffsetZ_Pass))
					continue;
				
				closest = dist;
				target = array[i];
			}
		}
		
		return target;
	}
}

Target_Aquire_AI()
{
	//for now just try to shoot the player
	//self endon ("death");
	// SCRIPTER_MOD: JesseS (7/21/2007): TODO: fix get_players reference here
	get_players()[0] endon ("death");
	
	flak = self;
	//flak_pos_tag_barrel = flak getTagOrigin ("tag_barrel");
	flak_pos_tag_barrel = flak getTagOrigin ("tag_turret");
	flak_pos_tag_barrel = (flak_pos_tag_barrel + (0,0,45));
	
	flak_pos_tag_flash = flak getTagOrigin ("tag_flash");
	
	enemyTeam = undefined;
	if (flak.script_team == "allies")
		enemyTeam = "axis";
	else if (flak.script_team == "axis")
		enemyTeam = "allies";
	else
		return;
	
	ent = getaiarray(enemyTeam);
	if(enemyteam == "allies")
	{
		ent[ent.size] = ent[0];
		// SCRIPTER_MOD: JesseS (7/21/2007): TODO: fix get_players reference here
		ent[0] = get_players()[0];
	}
	for (i=0;i<ent.size;i++)
	{
		ent_pos = ent[i] getOrigin();
		ent_pos_eyes = ent[i] getEye();
		
		//-----------------------------------------------------------
		//Check if the ent[i] can be seen by the flak88 crew
		//	bit tricky here - since you can't ignore multiple ents in the trace we have to see
		//	if the ent[i] can see the flak or any of it's crew members (reverse order)
		//-----------------------------------------------------------
		trace = bulletTrace(ent_pos_eyes, flak_pos_tag_barrel, true, ent[i]);
		thread debug_flak88_drawLines(ent_pos_eyes);
		trace_hit_ent = trace["entity"];
		if (!isdefined (trace_hit_ent))
		{
			//check if it was close to the ent
			trace_pos = trace["position"];
			diffX = abs(flak_pos_tag_barrel[0] - trace_pos[0]);
			diffY = abs(flak_pos_tag_barrel[1] - trace_pos[1]);
			if (!( (diffX <= 100) && (diffY <= 100) ))
				continue;
		}
		//else
		//{
			//check if the hit entity is the flak or any of it's crew memebers
		//	validEntities = flak.crewMembers;
		//	validEntities[validEntities.size] = flak;
		//	tracePassed = false;
		//	for (j=0;i<validEntities.size;j++)
		//	{
		//		if ( (isdefined (validEntities[j])) && (trace_hit_ent == validEntities[j]) )
		//		{
		//			tracePassed = true;
		//			break;
		//		}
		//	}
		//	if (!tracePassed)
		//		continue;
		//}
		//-----------------------------------------------------------
		//-----------------------------------------------------------
		//-----------------------------------------------------------
		//
		//
		//
		//
		//
		//
		//-----------------------------------------------------------
		//Make sure the ent isn't too close (within the safety range)
		//-----------------------------------------------------------
		safetyCheck = SafetyRangeCheck(ent_pos_eyes, flak_pos_tag_barrel);
		if (!safetyCheck)
			continue;
		//-----------------------------------------------------------
		//-----------------------------------------------------------
		//
		//
		//
		//
		//
		//-----------------------------------------------------------
		//Make sure the ent isn't too close (within the safety range)
		//-----------------------------------------------------------
		coneCheck = cone_check(flak, ent_pos);
		if (!coneCheck)
			continue;
		//-----------------------------------------------------------
		//-----------------------------------------------------------
		//
		//
		//
		//
		//
		//
		//
		//-----------------------------------------------------------
		//This is a valid target
		return ent[i];
	}
}

SafetyRangeCheck(org, flakorg)
{
	//return true if it's ok to shoot
	//self = the flak88
	//org = location it wants to fire
	
	//if the target they are shooting is closer than level.safetyRange don't shoot
	if (!isdefined (flakorg))
		flakorg = (self.origin + (0,0,68));
	if (distance(org, flakorg) < level.safetyRange)
		return false;
	/*
	//if what it will actually hit is closer than level.safetyRange don't shoot
	trace = bulletTrace(flakorg, org, false, undefined);
	end_loc = trace["position"];
	if (distance (flakorg, end_loc) < level.safetyRange)
		return false;
	*/
	return true;
}

Target_Kill_Using_Accuracy(flak, target, delay_difference)
{
	flak endon ("crew dead");
	flak endon ("crew dismounted");
	
//	target endon ("death");
	
	if (!isdefined (target))
		return;
	if ( (target.classname != "script_origin") && (target.health <= 0) )
		return;
	
	if (target.classname != "script_origin")
	{
		if ( (isdefined (self.autoTarget)) && (self.autoTarget == false) )
			return;
	}
	
	if (isSentient (target))
	{
		aim_org = target getEye();
		aim_org = aim_org - (0,0,20);
	}
	else if (target.classname == "script_origin")
		aim_org = target.origin;
	else
		aim_org = (target.origin + (0,0,40));
	
	
	offset_x = randomfloat(100 - flak.script_accuracy*100);
	offset_y = randomfloat(100 - flak.script_accuracy*100);
	offset_z = randomfloat(100 - flak.script_accuracy*100);
	
	if (isSentient(target))
	{
		offset_x = (offset_x * .3);
		offset_y = (offset_y * .3);
		offset_z = (offset_z * .3);
	}
	else
		offset_z = (offset_z * .5);
	
	if (randomint(2) == 0)
		offset_x = (offset_x * -1);	
	if (randomint(2) == 0)
		offset_y = (offset_y * -1);
	if (randomint(2) == 0)
		offset_z = (offset_z * -1);
	
	aim_org = (aim_org + (offset_x, offset_y, offset_z));
	
	flak thread debug_flak88_drawLines(aim_org);
	
	flak setTurretTargetVec(aim_org);
	flak waittill("turret_on_target");
	flak clearTurretTarget();
	
	if(issentient(target) && (target.health <= 0 || !sighttracepassed(flak gettagorigin("tag_flash"),aim_org,0,flak)))
		return;
	
	if (isdefined (flak.script_startnotify))
	{
		flak waittill (flak.script_startnotify);
		flak.script_startnotify = undefined;
	}
	
	wait 2;
	
	flak shoot_flak(aim_org);
	
	if (isdefined (delay_difference))
	{
		if (delay_difference <= 0)
			wait flak.script_delay_min;
		else
			wait (flak.script_delay_min + randomfloat(delay_difference));
	}
	
	return;
}

//Checks to see if the 'target' is inside the fire arc of 'flak88'
//returns true: when 'target' is inside the cone of 'flak88'
//returns false: when 'target' is outside the cone of 'flak88'
cone_check(flak88, target_org)
{
	//If the arcs aren't defined then the flak88 can shoot 360
	//degrees so just return true (is inside the flak88s range)
	if ( (!isdefined (flak88.script_leftarc)) || (!isdefined (flak88.script_leftarc)) )
		return true;
	
	//------------
	//  cone check
	//------------
	forwardvec = anglestoforward(flak88.angles);
	orgA = flak88.origin;
	orgB = target_org;
	normalvec = vectorNormalize(orgB-orgA);
	vecdot = vectordot(forwardvec,normalvec);
	
	//if both the leftarc and rightarc are the same this check is enough...
	if (flak88.script_leftarc == flak88.script_rightarc)
	{
		if (vecdot > cos(flak88.script_leftarc))
			return true;
		return false;
	}
	else //other wise we have to consider both angles...
	{
		rightvec = anglestoright(flak88.angles);
		rightvecdot = vectordot(rightvec,normalvec);
		if (rightvecdot >= 0)
		    return (vecdot > cos(flak88.script_rightarc)); // right
		else
		    return (vecdot > cos(flak88.script_leftarc)); // left
	}
}

debug_flak88_drawLines(targetOrg)
{
	self notify ("stop drawing debug lines");
	self endon ("death");
	self endon ("stop drawing debug lines");
	
	// SCRIPTER_MOD: JesseS (5/1/07): Took out for now
	// TODO: Re-add debug cvar
	//if (getcvar("debug_flak88") == "off")
		return;
		
	for (;;)
	{
		line (self.origin + (0,0,68), targetOrg, (0.2, 0.5, 0.8), 0.5);
		wait 0.05;
	}
}

shoot()
{
	while(self.health > 0)
	{
		self waittill( "turret_fire" );
		self fire_flak88();
	}
}

fire_flak88()
{
	if(self.health <= 0)
		return;

	// fire the turret
	//SCRIPTER_MOD: JesseS (5/9/2007) - took this out until we get a fire anim for the flak88
	//self setanimrestart (level.scr_anim["flak88"]["fire"]);
	//SCRIPTER_MOD: JesseS (5/9/2007) - changed to fireweapon
	//self fireweapon();
}


flakbarrel(flakbarrel)
{
	flakbarrel solid();
	flak = getent(flakbarrel.target,"targetname");
	flakbarrel linkto(flak,"tag_barrel");
	flak waittill ("death");
	flakbarrel unlink();
}
