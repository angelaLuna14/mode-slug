const string soundx_3 = "misc/tc/x-3.mp3";
const string soundx_2 = "misc/tc/x-2.mp3";
const string sound_boos = "misc/tc/boos.mp3";
const string sound3_5 = "misc/tc/3-5.mp3";
const string sound3_4 = "misc/tc/3-4.mp3";
const string sound3_3 = "misc/tc/3-3.mp3";
const string sound3_2 = "misc/tc/3-2.mp3";
const string sound3_1a = "misc/tc/3-1.mp3";
const string sound3_1 = "misc/tc/mus/slug21.mp3";




void PluginInit(){
	g_Module.ScriptInfo.SetAuthor( "Angela Luna" );
	g_Module.ScriptInfo.SetContactInfo( "https://discord.gg/vZDG886" );
	//ES:
	//Idea orirginal de Nakano
	//agreadecimientos a outbeast guia 
	//EN:
	//Idea orirginal de Nakano
	//agreadecimientos a outbeast guia 

	g_Hooks.RegisterHook(Hooks::Player::PlayerSpawn, @proteccion);
    g_Hooks.RegisterHook(Hooks::Game::MapChange, @ResetOrChangeMap);
	g_Hooks.RegisterHook( Hooks::Player::ClientSay, @voterealist);
}

const array<string> g_RemoveEnts = {'func_healthcharger', 'func_recharge', 'item_healthkit', 'item_armorvest', 'item_battery' };
CClientCommand g_realistOn("realiston", "Turn on Hard Mode (admin only)", @RealistMode, ConCommandFlag::AdminOnly);
CClientCommand g_realistOff("realistOff", "disamble (admin only)", @RealistModeoff, ConCommandFlag::AdminOnly);
CClientCommand g_musicR("musicR", "Select to music (admin only)", @musicArf, ConCommandFlag::AdminOnly);

CBaseEntity@ PlayGenericSound(string strSound, Vector vecOrigin)
{
	dictionary snd =
	{
		{ "origin", "" + vecOrigin.ToString() },
		{ "message", "" + strSound },
		{ "health", "10" },
		{ "playmode", "2" },
		{ "spawnflags", "80" }
	};

	return g_EntityFuncs.CreateEntity( "ambient_generic", snd, true );
}

void RealistMode(const CCommand@ pArgs)
{
	CBasePlayer@ pCaller = g_ConCommandSystem.GetCurrentPlayer();
	const uint music = pArgs.ArgC() >= 1 ? atoi( pArgs.Arg( 1 ) ) : 0;
	//CBaseEntity@ info_ent = g_EntityFuncs.Create("ambient_generic", pCaller.GetOrigin() + Vector(0, 60, 0), Vector(0, 0, 0), false);

	if (g_PlayerFuncs.AdminLevel(pCaller) < ADMIN_YES)
	   g_PlayerFuncs.ClientPrint(pCaller, HUD_PRINTCONSOLE, "You have no access to this command.\n");
	else
		
		if( music == 1 )
		{
			PlayGenericSound( sound3_1, pCaller.GetOrigin() ).Use( pCaller, pCaller, USE_TOGGLE, 0.0f );
			realiston();
			fog();
			
		}
		else if( music == 2 )
		{
			PlayGenericSound( sound3_1, pCaller.GetOrigin() ).Use( pCaller, pCaller, USE_TOGGLE, 0.0f );
			realiston();
			fog();
		}
		else if( music == 3 )
		{
			PlayGenericSound( sound3_1, pCaller.GetOrigin() ).Use( pCaller, pCaller, USE_TOGGLE, 0.0f );
			realiston();
			fog();
		}
		else if( music == 4 )
		{
			PlayGenericSound( sound3_1, pCaller.GetOrigin() ).Use( pCaller, pCaller, USE_TOGGLE, 0.0f );
			realiston();
			fog();
		}
		else if( music == 5 )
		{
			PlayGenericSound( sound3_1, pCaller.GetOrigin() ).Use( pCaller, pCaller, USE_TOGGLE, 0.0f );
			realiston();
			fog();
		}
		else if( music == 6 )
		{
			PlayGenericSound( sound3_1, pCaller.GetOrigin() ).Use( pCaller, pCaller, USE_TOGGLE, 0.0f );
			realiston();
			fog();
		}
		else if( music == 7 )
		{
			PlayGenericSound( sound3_1, pCaller.GetOrigin() ).Use( pCaller, pCaller, USE_TOGGLE, 0.0f );
			realiston();
			fog();
		}
		else if( music == 8 )
		{
			PlayGenericSound( sound3_1, pCaller.GetOrigin() ).Use( pCaller, pCaller, USE_TOGGLE, 0.0f );
			realiston();
			fog();
		}
		else if( music == 0 )
		{
			PlayGenericSound( sound3_1, pCaller.GetOrigin() ).Use( pCaller, pCaller, USE_TOGGLE, 0.0f );
			realiston();
			fog();
			
		}
		else
			g_PlayerFuncs.ClientPrint(pCaller, HUD_PRINTTALK, "Las musicas son de 1 al 8\n");

}

HookReturnCode ent_efects(){
	for( int i = 0; i < g_Engine.maxEntities; ++i ) {
		CBaseEntity@ pEntity = g_EntityFuncs.Instance( i );
		if( pEntity is null ) continue;
		while((@pEntity = g_EntityFuncs.FindEntityByClassname(pEntity, "monster_*")) !is null){
			ent_efect();
			npcsheal();
		}
	}

    return HOOK_CONTINUE;
}

void ent_efect(){

	CBaseEntity@ pEnt = null;

	for (uint i = 0; i < g_RemoveEnts.length(); ++i) {
		while( ( @pEnt = g_EntityFuncs.FindEntityByClassname( pEnt, g_RemoveEnts[i] ) ) !is null ) {
		   g_EntityFuncs.Remove(pEnt);
		}
	}


}


void realiston(){
	
	CBasePlayer@ pCaller = g_ConCommandSystem.GetCurrentPlayer();
	CBaseEntity@ info_ent = g_EntityFuncs.Create("ambient_generic", pCaller.GetOrigin() + Vector(0, 60, 0), Vector(0, 0, 0), false);
	g_EntityFuncs.Create("ambient_generic", pCaller.GetOrigin() + Vector(0, 60, 0), Vector(0, 0, 0), false);
	g_Hooks.RegisterHook(Hooks::Player::PlayerSpawn, @weapons);
	player_weapon();
	ent_efect();
	CfgServerOn();
	pCaller.RemoveAllItems(false);
	p_weapons( EHandle( pCaller ), 0 );	
	npcsheal();
	for( int i = 0; i < g_Engine.maxEntities; ++i ) {
		CBaseEntity@ pEntity = g_EntityFuncs.Instance( i );
		if( pEntity is null ) continue;
		while((@pEntity = g_EntityFuncs.FindEntityByClassname(pEntity, "monster_*")) !is null){
			multiplySpeed(pEntity);
			multiplyMaxSpeed(pEntity);
		}
	}
	g_Hooks.RegisterHook( Hooks::Game::EntityCreated, @ent_efects );
	
}


void MapInit() {

	g_SoundSystem.PrecacheSound(sound3_1);
}


void RealistModeoff(const CCommand@ pArgs) {
	CBasePlayer@ pCaller = g_ConCommandSystem.GetCurrentPlayer();
	CBaseEntity@ pSound = PlayGenericSound( sound3_1, pCaller.GetOrigin() );
	if (g_PlayerFuncs.AdminLevel(pCaller) < ADMIN_YES)
	   g_PlayerFuncs.ClientPrint(pCaller, HUD_PRINTCONSOLE, "You have no access to this command.\n");
	else
		
	    g_Hooks.RemoveHook(Hooks::Player::PlayerSpawn, @weapons);	
		npcshealoff();
		player_weapon_disable();
		pSound.Use( pCaller, pCaller, USE_OFF, 0.0f ); // turns off sound
		
		g_EngineFuncs.ServerCommand("mp_respawndelay 5 \n");
		g_EngineFuncs.ServerCommand("weaponmode_shotgun 0 \n"); 
		g_EngineFuncs.ServerCommand("weaponmode_9mmhandgun 0 \n"); 
		g_EngineFuncs.ServerCommand("weaponmode_displacer 0 \n"); 
		g_Hooks.RemoveHook( Hooks::Game::EntityCreated, @ent_efects );
		fogoff();

}

HookReturnCode ResetOrChangeMap(){
	CBasePlayer@ pCaller = g_ConCommandSystem.GetCurrentPlayer();
	CBaseEntity@ info_ent = g_EntityFuncs.Create("ambient_generic", pCaller.GetOrigin() + Vector(0, 60, 0), Vector(0, 0, 0), false);

	g_Hooks.RemoveHook(Hooks::Player::PlayerSpawn, @weapons);	
	npcshealoff();
	player_weapon_disable();

	g_EngineFuncs.ServerCommand("mp_respawndelay 5 \n");
	g_EngineFuncs.ServerCommand("weaponmode_shotgun 0 \n"); 
	g_EngineFuncs.ServerCommand("weaponmode_9mmhandgun 0 \n"); 
	g_EngineFuncs.ServerCommand("weaponmode_displacer 0 \n"); 
	g_EntityFuncs.Remove(info_ent);
	g_Hooks.RemoveHook( Hooks::Game::EntityCreated, @ent_efects );
	fogoff();
    return HOOK_HANDLED;
}





void CfgServerOn(){
	g_EngineFuncs.ServerCommand("mp_respawndelay 1\n");
	g_EngineFuncs.ServerCommand("mp_weapon_droprules 0 \n");
	g_EngineFuncs.ServerCommand("weaponmode_shotgun 1 \n"); 
	g_EngineFuncs.ServerCommand("weaponmode_9mmhandgun 1 \n"); 
	g_EngineFuncs.ServerCommand("weaponmode_displacer 1 \n"); 
	 
}


void CfgServerOff(){
	g_EngineFuncs.ServerCommand("mp_respawndelay 5 \n");
	g_EngineFuncs.ServerCommand("weaponmode_shotgun 0 \n"); 
	g_EngineFuncs.ServerCommand("weaponmode_9mmhandgun 0 \n"); 
	g_EngineFuncs.ServerCommand("weaponmode_displacer 0 \n"); 
}








	


void multiplySpeed(CBaseEntity@ pEntity){
	CustomKeyvalues@ cKeyValues = pEntity.GetCustomKeyvalues();
	
	if(!cKeyValues.HasKeyvalue("$f_originalSpeed")){
		cKeyValues.SetKeyvalue("$f_originalSpeed", pEntity.pev.speed);
		pEntity.pev.speed = 4;
	}

	else{
		pEntity.pev.speed = cKeyValues.GetKeyvalue("$f_originalSpeed").GetFloat() * 4;
	}

}

void multiplyMaxSpeed(CBaseEntity@ pEntity){
	CustomKeyvalues@ cKeyValues = pEntity.GetCustomKeyvalues();
	
	if(!cKeyValues.HasKeyvalue("$f_originalMaxSpeed")){
		cKeyValues.SetKeyvalue("$f_originalMaxSpeed", pEntity.pev.maxspeed);
		pEntity.pev.maxspeed = 4;

	}

	else{
		pEntity.pev.maxspeed = cKeyValues.GetKeyvalue("$f_originalSpeed").GetFloat() * 4;
	}
}


CCVar cvarProtectDuration( "r_proteccion", 4.5f, "Duration of spawn invulnerability", ConCommandFlag::AdminOnly );

void SpawnProtection(EHandle hPlayer, const int iTakeDamageIn)
{
    if( !hPlayer )
        return;
    
    CBasePlayer@ pPlayer = cast<CBasePlayer@>( hPlayer.GetEntity() );
    pPlayer.pev.takedamage = float( iTakeDamageIn );

    if( iTakeDamageIn == 0 )
        g_Scheduler.SetTimeout( "SpawnProtection",cvarProtectDuration.GetFloat() , hPlayer, 1 );	
}

HookReturnCode proteccion(CBasePlayer@ pPlayer)
{   
	SpawnProtection( EHandle( pPlayer ), 0 );	
    return HOOK_CONTINUE;
}

HookReturnCode weapons(CBasePlayer@ pPlayer)
{   
	pPlayer.RemoveAllItems(false);
	p_weapons( EHandle( pPlayer ), 0 );

	
    return HOOK_CONTINUE;
}

void p_weapons(EHandle hPlayer, const int weapon)
{
    if( !hPlayer )
        return;
      
    CBasePlayer@ pPlayer = cast<CBasePlayer@>( hPlayer.GetEntity() );
    float( weapon );

    if( weapon == 0 ){
        g_Scheduler.SetTimeout( "p_weapons", 0.1 , hPlayer, 1 );
		g_Scheduler.SetTimeout( "p_weapons", 0.2 , hPlayer, 2 );
		g_Scheduler.SetTimeout( "p_weapons", 0.3 , hPlayer, 3 );
		g_Scheduler.SetTimeout( "p_weapons", 0.4 , hPlayer, 4 );
		g_Scheduler.SetTimeout( "p_weapons", 0.5 , hPlayer, 5 );
		g_Scheduler.SetTimeout( "p_weapons", 0.6 , hPlayer, 6 );
		g_Scheduler.SetTimeout( "p_weapons", 0.7 , hPlayer, 7 );
		g_Scheduler.SetTimeout( "p_weapons", 0.8 , hPlayer, 8 );
        
    }
    if( weapon == 1 ){
		g_EntityFuncs.Create("weapon_9mmhandgun", pPlayer.GetOrigin() + Vector(0, 0, 0), Vector(0, 0, 0),  false).KeyValue("m_flCustomRespawnTime", "-1");
		

    }
	if( weapon == 2 ){
		pPlayer.GiveNamedItem("ammo_9mmAR", 0, 0);
		
    }
	if( weapon == 3 ){

		pPlayer.GiveNamedItem("ammo_9mmAR", 0, 0);
		
    }
	if( weapon == 4 ){
		pPlayer.GiveNamedItem("item_longjump", 0, 0);
		

    }
	if( weapon == 5 ){
		
		pPlayer.GiveNamedItem("weapon_handgrenade", 0, 0);

    }
	if( weapon == 6 ){
		pPlayer.GiveNamedItem("ammo_9mmAR", 0, 0);

    }
	if( weapon == 7 ){
		pPlayer.GiveNamedItem("ammo_9mmAR", 0, 0);
    }
	if( weapon == 8 ){
		pPlayer.GiveNamedItem("ammo_9mmAR", 0, 0);

    }
        
}





void player_weapon(){

	g_EngineFuncs.CVarSetFloat("sk_plr_9mm_bullet", 100);
	g_EngineFuncs.CVarSetFloat("sk_plr_357_bullet", 120);
	g_EngineFuncs.CVarSetFloat("sk_plr_9mmAR_bullet", 150);
	g_EngineFuncs.CVarSetFloat("sk_plr_9mmAR_grenade", 150);
	g_EngineFuncs.CVarSetFloat("sk_plr_buckshot", 225);
	g_EngineFuncs.CVarSetFloat("sk_plr_xbow_bolt_monster", 100);
	g_EngineFuncs.CVarSetFloat("sk_plr_rpg", 200);
	g_EngineFuncs.CVarSetFloat("sk_plr_gauss", 50);
	g_EngineFuncs.CVarSetFloat("sk_plr_egon_narrow", 25);
	g_EngineFuncs.CVarSetFloat("sk_plr_egon_wide", 25);
	g_EngineFuncs.CVarSetFloat("sk_plr_hand_grenade", 150);
	g_EngineFuncs.CVarSetFloat("sk_plr_satchel", 350);
	g_EngineFuncs.CVarSetFloat("sk_plr_tripmine", 250);
	g_EngineFuncs.CVarSetFloat("sk_plr_wrench", 150);
	g_EngineFuncs.CVarSetFloat("sk_plr_grapple", 150);
	g_EngineFuncs.CVarSetFloat("sk_plr_uzi", 50);
	g_EngineFuncs.CVarSetFloat("sk_plr_secondarygauss", 500);
	g_EngineFuncs.CVarSetFloat("sk_plr_762_bullet", 150);
	g_EngineFuncs.CVarSetFloat("sk_plr_spore",250);
	g_EngineFuncs.CVarSetFloat("sk_plr_shockrifle", 50);
	g_EngineFuncs.CVarSetFloat("sk_plr_shockrifle_beam", 50);
	g_EngineFuncs.CVarSetFloat("sk_plr_displacer_other", 1000);
	g_EngineFuncs.CVarSetFloat("sk_plr_displacer_radius", 800);
}
void player_weapon_disable(){

	g_EngineFuncs.CVarSetFloat("sk_plr_9mm_bullet",8 );
	g_EngineFuncs.CVarSetFloat("sk_plr_357_bullet",40);
	g_EngineFuncs.CVarSetFloat("sk_plr_9mmAR_bullet", 8);
	g_EngineFuncs.CVarSetFloat("sk_plr_9mmAR_grenade", 100);
	g_EngineFuncs.CVarSetFloat("sk_plr_buckshot", 7);
	g_EngineFuncs.CVarSetFloat("sk_plr_xbow_bolt_monster", 60);
	g_EngineFuncs.CVarSetFloat("sk_plr_rpg", 150);
	g_EngineFuncs.CVarSetFloat("sk_plr_gauss", 15);
	g_EngineFuncs.CVarSetFloat("sk_plr_egon_narrow", 10);
	g_EngineFuncs.CVarSetFloat("sk_plr_egon_wide", 12);
	g_EngineFuncs.CVarSetFloat("sk_plr_hand_grenade", 100);
	g_EngineFuncs.CVarSetFloat("sk_plr_satchel", 160);
	g_EngineFuncs.CVarSetFloat("sk_plr_tripmine", 150);
	g_EngineFuncs.CVarSetFloat("sk_plr_wrench", 22);
	g_EngineFuncs.CVarSetFloat("sk_plr_grapple", 40);
	g_EngineFuncs.CVarSetFloat("sk_plr_uzi", 8);
	g_EngineFuncs.CVarSetFloat("sk_plr_secondarygauss", 190);
	g_EngineFuncs.CVarSetFloat("sk_plr_762_bullet", 110);
	g_EngineFuncs.CVarSetFloat("sk_plr_spore",100);
	g_EngineFuncs.CVarSetFloat("sk_plr_shockrifle", 15);
	g_EngineFuncs.CVarSetFloat("sk_plr_shockrifle_beam", 2);
	g_EngineFuncs.CVarSetFloat("sk_plr_displacer_other", 250);
	g_EngineFuncs.CVarSetFloat("sk_plr_displacer_radius", 300);
}


void npcsheal(){
	for( int i = 3; i < g_Engine.maxEntities; ++i ) {
		CBaseEntity@ ent = g_EntityFuncs.Instance( i );
		if( ent !is null ) {
			if( ent.pev.health <= 0.0 || ent.pev.health >= 10000.0 || ent.Classify() == CLASS_PLAYER_ALLY ) continue;
            
			
			if ( ent.pev.classname == "monster_alien_babyvoltigore" ){		
				ent.pev.health = 800;
			}else if ( ent.pev.classname == "monster_alien_controller" ){		
				ent.pev.health = 100;
			}else if ( ent.pev.classname == "monster_alien_grunt" ){			
				ent.pev.health = 500;
			}else if ( ent.pev.classname == "monster_alien_slave" ){	
				ent.pev.health = 100;
			}else if ( ent.pev.classname == "monster_alien_tor" ){
				ent.pev.health = 25000;
			}else if ( ent.pev.classname == "monster_alien_voltigore" ){
				
				
				ent.pev.health = 15000;
			}else if ( ent.pev.classname == "monster_apache" ){
				
				
				ent.pev.health = 1500;
			}else if ( ent.pev.classname == "monster_babycrab" ){
				
				
				ent.pev.health = 100;
			}else if ( ent.pev.classname == "monster_barnacle" ){
				
				
				ent.pev.health = 5;
			}else if ( ent.pev.classname == "monster_barney" ){
				
				
				ent.pev.health = 7;
				//g_EntityFuncs.DispatchKeyValue( ent.edict(), "displayname", "xdddd" );
			}else if ( ent.pev.classname == "monster_bigmomma" ){
				
				
				ent.pev.health = 12000;
			}else if ( ent.pev.classname == "monster_blkop_osprey" ){
				
				
				ent.pev.health = 12000;
			}else if ( ent.pev.classname == "monster_blkop_apache" ){
				
				
				ent.pev.health = 1500;
			}else if ( ent.pev.classname == "monster_bodyguard" ){
				
				
				ent.pev.health = 100;
			}else if ( ent.pev.classname == "monster_bullchicken" ){
				
				
				ent.pev.health = 400;
			}else if ( ent.pev.classname == "monster_chumtoad" ){
				
				
				ent.pev.health = 100;
			}else if ( ent.pev.classname == "monster_cleansuit_scientist" ){
				
				
				ent.pev.health = 43;
			}else if ( ent.pev.classname == "monster_gargantua" ){
				
				
				ent.pev.health = 2000;
			}else if ( ent.pev.classname == "monster_gonome" ){
				
				
				ent.pev.health = 500;
			}else if ( ent.pev.classname == "monster_headcrab" ){
				
				
				ent.pev.health = 200;
				g_EntityFuncs.DispatchKeyValue( ent.edict(), "displayname", "Headcrab vidoso" );
			}else if ( ent.pev.classname == "monster_houndeye" ){
				
				
				ent.pev.health = 200;
			}else if ( ent.pev.classname == "monster_human_assassin" ){
				ent.pev.speed = 4;
				ent.pev.maxspeed = 4;
				
				ent.pev.health = 100;
			}else if ( ent.pev.classname == "monster_human_grunt" ){
				ent.pev.speed = 4;
				ent.pev.maxspeed = 4;
				
				ent.pev.health = 100;
			}else if ( ent.pev.classname == "monster_human_grunt_ally" ){
				
				
				ent.pev.health = 200;
			}else if ( ent.pev.classname == "monster_human_medic_ally" ){
				
				
				ent.pev.health = 200;
			}else if ( ent.pev.classname == "monster_human_torch_ally" ){
				
				
				ent.pev.health = 300;
			}else if ( ent.pev.classname == "monster_hwgrunt" ){
				
				
				ent.pev.health = 800;
			}else if ( ent.pev.classname == "monster_ichthyosaur" ){
				
				
				ent.pev.health = 400;
				
			}else if ( ent.pev.classname == "monster_kingpin" ){
				
				
				ent.pev.health = 3200;
			}else if ( ent.pev.classname == "monster_leech" ){
				
				
				g_EntityFuncs.DispatchKeyValue( ent.edict(), "displayname", "farm" );
			}else if ( ent.pev.classname == "monster_male_assassin" ){
				
				
				ent.pev.health = 200;
			}else if ( ent.pev.classname == "monster_miniturret" ){
				
				
				ent.pev.health = 120;
			}else if ( ent.pev.classname == "monster_nihilanth" ){
				
				
				ent.pev.health = 40000;
			}else if ( ent.pev.classname == "monster_osprey" ){
				
				
				ent.pev.health = 12000;
			}else if ( ent.pev.classname == "monster_otis" ){
				
				
				ent.pev.health = 300;
			}else if ( ent.pev.classname == "monster_pitdrone" ){
				
				
				ent.pev.health = 500;
			}else if ( ent.pev.classname == "monster_robogrunt" ){
				
				
				ent.pev.health = 800;
			}else if ( ent.pev.classname == "monster_scientist" ){
				
				
				ent.pev.health = 100;
			}else if ( ent.pev.classname == "monster_sentry" ){
				
				
				ent.pev.health = 520;
			}else if ( ent.pev.classname == "monster_shockroach" ){
				
				
				ent.pev.health = 400;
			}else if ( ent.pev.classname == "monster_shocktrooper" ){
				
				
				ent.pev.health = 200;
			}else if ( ent.pev.classname == "monster_snark" ){
				ent.pev.health = 10;
			}else if ( ent.pev.classname == "monster_sqknest" ){
				
				
				ent.pev.health = 500;
			}else if ( ent.pev.classname == "monster_stukabat" ){
				
				
				ent.pev.health = 1000;
			}else if ( ent.pev.classname == "monster_tentacle" ){
				
				
				ent.pev.health = 1200;
			}else if ( ent.pev.classname == "monster_turret" ){
				ent.pev.health = 500;
			}else if ( ent.pev.classname == "monster_zombie" ){
				ent.pev.health = 700;
			}else if ( ent.pev.classname == "monster_zombie_barney" ){
				ent.pev.health = 700;
			}else if ( ent.pev.classname == "monster_zombie_soldier" ){
				ent.pev.health = 1000;
			}
		}
	}
	
}

void npcshealoff(){

	
	for( int i = 3; i < g_Engine.maxEntities; ++i ) {
		CBaseEntity@ ent = g_EntityFuncs.Instance( i );
		if( ent !is null ) {
			if( ent.pev.health <= 0.0 || ent.pev.health >= 10000.0 || ent.Classify() == CLASS_PLAYER_ALLY ) continue;
            
			
			if ( ent.pev.classname == "monster_alien_babyvoltigore" ){		
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_alien_controller" ){		
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_alien_grunt" ){			
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_alien_slave" ){	
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_alien_tor" ){
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_alien_voltigore" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_apache" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_babycrab" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_barnacle" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_barney" ){
				
				
				ent.pev.health = ent.pev.health;
				//g_EntityFuncs.DispatchKeyValue( ent.edict(), "displayname", "xdddd" );
			}else if ( ent.pev.classname == "monster_bigmomma" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_blkop_osprey" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_blkop_apache" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_bodyguard" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_bullchicken" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_chumtoad" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_cleansuit_scientist" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_gargantua" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_gonome" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_headcrab" ){
				
				
				ent.pev.health = ent.pev.health;
				g_EntityFuncs.DispatchKeyValue( ent.edict(), "displayname", "Headcrab vidoso" );
			}else if ( ent.pev.classname == "monster_houndeye" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_human_assassin" ){
				ent.pev.speed = 4;
				ent.pev.maxspeed = 4;
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_human_grunt" ){
				ent.pev.speed = 4;
				ent.pev.maxspeed = 4;
				
				ent.pev.health = 100;
			}else if ( ent.pev.classname == "monster_human_grunt_ally" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_human_medic_ally" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_human_torch_ally" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_hwgrunt" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_ichthyosaur" ){
				
				
				ent.pev.health = ent.pev.health;
				
			}else if ( ent.pev.classname == "monster_kingpin" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_leech" ){
				
				
				g_EntityFuncs.DispatchKeyValue( ent.edict(), "displayname", "farm" );
			}else if ( ent.pev.classname == "monster_male_assassin" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_miniturret" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_nihilanth" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_osprey" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_otis" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_pitdrone" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_robogrunt" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_scientist" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_sentry" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_shockroach" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_shocktrooper" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_snark" ){
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_sqknest" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_stukabat" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_tentacle" ){
				
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_turret" ){
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_zombie" ){
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_zombie_barney" ){
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_zombie_soldier" ){
				ent.pev.health = ent.pev.health;
			}
		}
	}
	
}

HookReturnCode voterealist( SayParameters@ pParams ){
    const CCommand@ pArguments = pParams.GetArguments();

    if ( pArguments.ArgC() >= 1 && pArguments.Arg(0).ToLowercase() == "voterealist" )
    {
        Vote@ ABCVote = Vote( 'ABC', 'Modo realista?', 15.0f, 600.0f );

        ABCVote.SetYesText( 'Sip :-)');
        ABCVote.SetNoText( 'No :-<' );
        ABCVote.SetVoteBlockedCallback( @ABCVoteBlocked );
        ABCVote.SetVoteEndCallback( @ABCVoteEnd );
        ABCVote.Start();

        return HOOK_CONTINUE;
    }
    return HOOK_CONTINUE;
}

void ABCVoteEnd( Vote@ pVote, bool fResult, int iVoters )
{
    if ( fResult ){
        g_PlayerFuncs.ClientPrintAll(HUD_PRINTTALK, "Modo realista activado!\n");
		RealistVote();

    }
    else
    {
        g_PlayerFuncs.ClientPrintAll(HUD_PRINTTALK, "No se obtuvo lo requerido\n");
    }
}

void ABCVoteBlocked(Vote@ pVote, float flTime)
{
    g_PlayerFuncs.ClientPrintAll(HUD_PRINTTALK, "[Info] todavia no se puede votar :(.\n");
}

void RealistVote(){
	CBasePlayer@ pCaller = g_ConCommandSystem.GetCurrentPlayer();
	CBaseEntity@ info_ent = g_EntityFuncs.Create("ambient_generic", pCaller.GetOrigin() + Vector(0, 60, 0), Vector(0, 0, 0), false);
	g_EntityFuncs.Create("ambient_generic", pCaller.GetOrigin() + Vector(0, 60, 0), Vector(0, 0, 0), false);
	g_SoundSystem.PlaySound( info_ent.edict(), CHAN_VOICE , sound3_1, VOL_NORM, 0, 0, PITCH_NORM, 0, false, g_vecZero );

	player_weapon();
	ent_efect();
    CfgServerOn();
	g_Hooks.RegisterHook(Hooks::Player::PlayerSpawn, @weapons);
	pCaller.RemoveAllItems(false);
	p_weapons( EHandle( pCaller ), 0 );	
	npcsheal();
	for( int i = 0; i < g_Engine.maxEntities; ++i ) {
		CBaseEntity@ pEntity = g_EntityFuncs.Instance( i );
		if( pEntity is null ) continue;
		while((@pEntity = g_EntityFuncs.FindEntityByClassname(pEntity, "monster_*")) !is null){
			multiplySpeed(pEntity);
			multiplyMaxSpeed(pEntity);
		}
	}
	
}

void random_music(){

}


void musicArf(const CCommand@ pArgs){
	CBasePlayer@ pCaller = g_ConCommandSystem.GetCurrentPlayer();
	CBaseEntity@ info_ent = g_EntityFuncs.Create("ambient_generic", pCaller.GetOrigin() + Vector(0, 60, 0), Vector(0, 0, 0), false);
	const uint music = pArgs.ArgC() >= 1 ? atoi( pArgs.Arg( 1 ) ) : 0;
	if( music == 1 ){
		g_SoundSystem.PlaySound( info_ent.edict(), CHAN_VOICE, sound3_1, VOL_NORM, 0, 0, PITCH_NORM, 0, false, g_vecZero );
	}
	else if( music == 2 ){
		g_SoundSystem.PlaySound( info_ent.edict(), CHAN_VOICE , sound3_1, VOL_NORM, 0, 0, PITCH_NORM, 0, false, g_vecZero );
	}
	else if( music == 3 ){
		g_SoundSystem.PlaySound( info_ent.edict(), CHAN_VOICE , sound3_1, VOL_NORM, 0, 0, PITCH_NORM, 0, false, g_vecZero );
	}
	else if( music == 4 ){
		g_SoundSystem.PlaySound( info_ent.edict(), CHAN_VOICE , sound3_1, VOL_NORM, 0, 0, PITCH_NORM, 0, false, g_vecZero );
	}
	else if( music == 5 ){
		g_SoundSystem.PlaySound( info_ent.edict(), CHAN_VOICE , sound3_1, VOL_NORM, 0, 0, PITCH_NORM, 0, false, g_vecZero );
	}
	else if( music == 6 ){
		g_SoundSystem.PlaySound( info_ent.edict(), CHAN_VOICE , sound3_1, VOL_NORM, 0, 0, PITCH_NORM, 0, false, g_vecZero );
	}
	else if( music == 7 ){
		g_SoundSystem.PlaySound( info_ent.edict(), CHAN_VOICE , sound3_1, VOL_NORM, 0, 0, PITCH_NORM, 0, false, g_vecZero );
	}
	else if( music == 8 ){
		g_SoundSystem.PlaySound( info_ent.edict(), CHAN_VOICE , sound3_1, VOL_NORM, 0, 0, PITCH_NORM, 0, false, g_vecZero );
	}
	else{
		 g_PlayerFuncs.ClientPrint(pCaller, HUD_PRINTTALK, "Las musicas son de 1 al 8\n");
	}
}


void fog()
{
	array<CBasePlayer@> pTargets;
	CBasePlayer@ pTarget = null;
	for(uint i = 0; i < pTargets.length(); i++)
	{
		@pTarget = pTargets[i];
		NetworkMessage msg(MSG_ONE_UNRELIABLE, NetworkMessages::Fog, pTarget.edict());
			msg.WriteShort(0); //id
			msg.WriteByte(0<=-1?0:1); //enable state
			msg.WriteCoord(0); //unused
			msg.WriteCoord(0); //unused
			msg.WriteCoord(0); //unused
			msg.WriteShort(0); //radius
			 msg.WriteByte(0>=0?0:0); //r
			msg.WriteByte(0); //g
			msg.WriteByte(0); //b
			msg.WriteShort(800); //start dist
			msg.WriteShort(2); //end dist
		msg.End();
	}
}

void fogoff()
{
	array<CBasePlayer@> pTargets;
	CBasePlayer@ pTarget = null;
	for(uint i = 0; i < pTargets.length(); i++)
	{
		@pTarget = pTargets[i];
		NetworkMessage msg(MSG_ONE_UNRELIABLE, NetworkMessages::Fog, pTarget.edict());
			msg.WriteShort(0); //id
			msg.WriteByte(0<=-1?0:1); //enable state
			msg.WriteCoord(0); //unused
			msg.WriteCoord(0); //unused
			msg.WriteCoord(0); //unused
			msg.WriteShort(0); //radius
			 msg.WriteByte(0>=0?0:0); //r
			msg.WriteByte(0); //g
			msg.WriteByte(0); //b
			msg.WriteShort(0); //start dist
			msg.WriteShort(0); //end dist
		msg.End();
	}
}

/*void PluginInit()
{	
	g_Module.ScriptInfo.SetAuthor( "Angela Luna" );
	g_Module.ScriptInfo.SetContactInfo("https://discord.gg/WrZJcRZvEZ");
	deadnpcs();
}

const string sprite5 = "sprites/tc/chatreaccion/f.spr";


void MapInit()
{
	deadnpcs();
}
void deadnpcs(){
	CBaseEntity@ thisMonster = null;

	while((@thisMonster = g_EntityFuncs.FindEntityByClassname(thisMonster, "monster_*")) !is null){
		if(( thisMonster.pev.deadflag & DEAD_DEAD )!= 0  || (thisMonster.pev.health < -60 ) ){
			CSprite@ ent_sprite = g_EntityFuncs.CreateSprite( sprite5, thisMonster.pev.origin +  Vector(0, 0, 100), true );
			ent_sprite.AnimateAndDie(5);
			
		
		}
	}
}

void AnimateAndDie(float flFramerate){


}



//Agradecimientos 
//Mario AR (sprites)
//KernCore (guia)

const string deadplr = "misc/tc/custom/oof.mp3";
const string deadplr0 = "misc/tc/custom/au.mp3";
const string sprite1 = "sprites/tc/dead.spr";
const string sprite2 = "sprites/tc/afknow.spr";
const string soundplr = "misc/tc/custom/au.mp3";
const string deadplr1 = "misc/tc/metes.mp3";
const string g_MalfunctionSound = 'parallax/message.wav';
const string sprite3 = "sprites/sandclock.spr";
array<string> g_stachel;
array<string> g_stachelActive; 
array<string> g_RPG;
array<string> g_RPGActive; 
CScheduledFunction@ g_pThinkFunc = null;
const string sound = 'misc/tc/custom/au.mp3';
const int satchelcount = 0;
const int RPGcount = 0;



void PluginInit() {
  g_Module.ScriptInfo.SetAuthor("Angela Luna");
  g_Module.ScriptInfo.SetContactInfo(" https://discord.gg/WrZJcRZvEZ");

  //g_Hooks.RegisterHook(Hooks::Weapon::WeaponPrimaryAttack, @stachel);
  //g_Hooks.RegisterHook(Hooks::Weapon::WeaponPrimaryAttack, @w_rpg);
	//g_Hooks.RegisterHook( Hooks::Player::PlayerKilled, @PlayerKilled1 );
	g_Hooks.RegisterHook( Hooks::Player::PlayerKilled, @PlayerKilled );


}



void MapInit() {
	
  for( uint i = 0; i < deadsounds.length(); ++i ){
		g_Game.PrecacheGeneric( "sound/" + deadsounds[i] );
		g_SoundSystem.PrecacheSound(string(deadsounds[i]));
  }
}


const array<string> deadsounds = {
  "misc/tc/metes.mp3",
  "misc/tc/au.mp3",
  "misc/tc/oof.mp3",
  "misc/tc/a.mp3"
};








HookReturnCode PlayerKilled( CBasePlayer@ pPlayer, CBaseEntity@, int iGib){

	if (!((pPlayer.pev.health < -360000 && iGib != GIB_NEVER) || iGib == GIB_ALWAYS)) {
	  pPlayer.pev.deadflag = DEAD_DEAD;
      pPlayer.pev.deadflag = DEAD_DYING;
      
        g_SoundSystem.PlaySound(pPlayer.edict(), CHAN_AUTO, string(deadsounds[i]) ,  0.55f, 0.65f, 0, 100, 0, true, pPlayer.pev.origin);
        pPlayer.ShowOverheadSprite(sprite3, 51.0f, 6.0f);
	}

	return HOOK_CONTINUE;
}


