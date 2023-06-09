// Destructible initialization script
#include maps\_destructible;
#using_animtree( "vehicles" );

init()
{
	set_function_pointer( "explosion_anim", "dest_beetle", ::get_explosion_animation );
	set_function_pointer( "flattire_anim", "dest_beetle", ::get_flattire_animation );

	build_destructible_radiusdamage( "dest_beetle", undefined, 225, 250, 40, true );
	build_destructible_deathquake( "dest_beetle", 0.4, 1.0, 500 );

	set_pre_explosion( "dest_beetle", "destructibles/fx_dest_fire_car_fade_40" );
}

get_explosion_animation( broken_notify )
{
	return %v_beetle_explode;
}

get_flattire_animation( broken_notify )
{
	if( broken_notify == "flat_tire_left_rear" )
	{
		return %v_beetle_flattire_lb;
	}
	else if( broken_notify == "flat_tire_right_rear" )
	{
		return %v_beetle_flattire_rb;
	}
	else if( broken_notify == "flat_tire_left_front" )
	{
		return %v_beetle_flattire_lf;		
	}
	else if( broken_notify == "flat_tire_right_front" )
	{
		return %v_beetle_flattire_rf;
	}
}

empty()
{
}