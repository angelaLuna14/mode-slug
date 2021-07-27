


//g_EntityFuncs.KillTarget
void PluginInit(){
	g_Module.ScriptInfo.SetAuthor( "Angela Luna" );
	g_Module.ScriptInfo.SetContactInfo( "https://discord.gg/vZDG886" );
	//ES:
	//Idea orirginal de Nakano
	//agreadecimientos a outbeast guia 
	// EN: 
	// Original idea by Nakano 
	// thanks to out beast guide	
	g_Hooks.RegisterHook( Hooks::Player::ClientSay, @voterealist);
	@cvar_Enabled = CCVar("mj_enabled", 1, "Enable or Disable MultiJump", ConCommandFlag::AdminOnly);
	@cvar_MjJump = CCVar("mj_maxjump", 2, "Set maximum multiple jump count", ConCommandFlag::AdminOnly);
	@cvar_AdminOnly = CCVar("mj_adminonly", 0, "Set 1 if only used Admins.", ConCommandFlag::AdminOnly);
	@cvar_MJOnly = CCVar("mj_mjonly", 0, "Set 1 if only used mj values is true", ConCommandFlag::AdminOnly);
}

CClientCommand g_playmode("mode", "Lista de reacciones", @playmodes, ConCommandFlag::AdminOnly);
CClientCommand g_m_list("m_list", "Lista de reacciones", @m_list);
CClientCommand g_weapon_1("weapon_1", "Lista de reacciones", @weapon_1, ConCommandFlag::AdminOnly);
CClientCommand g_weapon_2("weapon_2", "Lista de reacciones", @weapon_2, ConCommandFlag::AdminOnly);
CClientCommand g_weapon_3("weapon_3", "Lista de reacciones", @weapon_3, ConCommandFlag::AdminOnly);


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

const array<string> random_mode = 
{
	"misc/tc/mus/slug21.mp3"
};

array<string> r_Weapon = {
	"weapon_9mmhandgun",
	"weapon_357",
	"weapon_9mmAR",
	"weapon_crossbow",
	"weapon_shotgun",
	"weapon_rpg",
	"weapon_gauss",
	"weapon_egon",
	"weapon_uziakimbo",
	"weapon_medkit",
	"weapon_sniperrifle",
	"weapon_m249",
	"weapon_m16",
	"weapon_sporelauncher",
	"weapon_eagle",
	"weapon_displacer"
};

const array<string> g_remove = {

};

const array<string> g_RemoveEnts = {'func_healthcharger', 'func_recharge', 'item_healthkit', 'item_armorvest', 'item_battery' };

const array<string> deadnpcs = 
{
  "misc/tc/npcsdead/dead1.mp3",
  "misc/tc/npcsdead/dead2.mp3",
  "misc/tc/npcsdead/dead3.mp3"

};


CScheduledFunction@ t_reload = null;
CScheduledFunction@ god_mode = null;

array<EHandle> monsterList;
array<string> nameList;
array<Vector> posList;
CScheduledFunction@ refreshMonster;


const string sprite5 = "sprites/tc/chatreaccion/f.spr";

const array<string> P_ENTITIES = {FL_MONSTER};

const string soundx_3 = "misc/tc/x-3.mp3";
const string soundx_2 = "misc/tc/x-2.mp3";
const string sound_boos = "misc/tc/boos.mp3";
const string sound3_5 = "misc/tc/3-5.mp3";
const string sound3_4 = "misc/tc/3-4.mp3";
const string sound3_3 = "misc/tc/3-3.mp3";
const string sound3_2 = "misc/tc/3-2.mp3";
const string sound3_1a = "misc/tc/3-1.mp3";
const string sound3_1 = "misc/tc/mus/realist21.mp3";
const string m_s = "misc/tc/mus/mision1.mp3";
const string dead_s1 = "misc/tc/mus/dead.mp3";
const string dead_s2 = "misc/tc/mus/dead.mp3";
const string dead_s3 = "misc/tc/mus/dead.mp3";

array<int> Jumpedcound(33);
array<bool> DoJump(33);
int max_jump = 2;
CCVar@ cvar_Enabled;
CCVar@ cvar_MjJump;
CCVar@ cvar_AdminOnly;
CCVar@ cvar_MJOnly;

CScheduledFunction@ ent_s = null;
CScheduledFunction@ refresh_s = null;


//#include //
void playmodes(const CCommand@ pArgs){
	CBasePlayer@ pCaller = g_ConCommandSystem.GetCurrentPlayer();
	const string mode = pArgs.ArgC() >= 1 ?  pArgs.Arg( 1 )  : "";
	const string toggled = pArgs.ArgC() >= 3 ?  pArgs.Arg( 2 )  : "";

	if (g_PlayerFuncs.AdminLevel(pCaller) < ADMIN_YES){
	   g_PlayerFuncs.ClientPrint(pCaller, HUD_PRINTCONSOLE, "You have no access to this command.\n");
	}
	else{
		
		if( mode == "" )
		{

			
			
		}
		else if( mode == "rush" )
		{

			mode_rush();
			
		}
		else if( mode == "asdas312%asdas#$#")
		{

			g_PlayerFuncs.ClientPrint(pCaller, HUD_PRINTTALK, "prueba2 en proceso access denied \n");

		}
		if( toggled == "off")
		{

			mode_rushoff();
			RealistModeoff();
			random_weaponsoff();
			g_PlayerFuncs.ClientPrint(pCaller, HUD_PRINTTALK, "Se han cancelado todos los modos \n");

		}
		else if( mode == "realist")
		{
			int i = Math.RandomLong(0,random_mode.length()-1);

			PlayGenericSound( string(random_mode[i]), pCaller.GetOrigin() ).Use( pCaller, pCaller, USE_TOGGLE, 0.0f );
			realiston();

		}

		else if( mode == "w_random")
		{
			random_weapons();
			
			for (uint i = 0; i < r_Weapon.length(); i++) {
				string checkName = r_Weapon[i];
				if (checkName == "weapon_shotgun"){
					
				}
			}

		}


		else
		{
			g_PlayerFuncs.ClientPrint(pCaller, HUD_PRINTTALK, "revise en la lista de modos .m_list \n");
		}
	}


}



void m_list(const CCommand@ pArgs) {
  CBasePlayer@ pPlayer = g_ConCommandSystem.GetCurrentPlayer();

  g_PlayerFuncs.ClientPrint(pPlayer, HUD_PRINTCONSOLE, "--------------------Modos-----------------\n");
  g_PlayerFuncs.ClientPrint(pPlayer, HUD_PRINTCONSOLE, " rush | realist | w_random | pronto mas modos...\n");
  g_PlayerFuncs.ClientPrint(pPlayer, HUD_PRINTCONSOLE, "-----------------------------------------------\n");
}

const array<string> mod = 
{
	"exclusivehold",
	"m_flCustomRespawnTime"
};

const array<string> mod2 = 
{
	"1",
	"-1"
};

void weapon_1(const CCommand@ pArgs) {
	CBasePlayer@ pPlayer = g_ConCommandSystem.GetCurrentPlayer();
	const string szEntity = "weapon_rpg";
	CBaseEntity@ pEntity = g_EntityFuncs.Create( szEntity , pPlayer.pev.origin, Vector(0, 0, 0),  false);
	g_EntityFuncs.DispatchKeyValue( pEntity.edict(), "exclusivehold", "1");
	g_EntityFuncs.DispatchKeyValue( pEntity.edict(), "m_flCustomRespawnTime", "-1");
}

void weapon_2(const CCommand@ pArgs) {
	CBasePlayer@ pPlayer = g_ConCommandSystem.GetCurrentPlayer();
	const string szEntity = "weapon_displacer";
	CBaseEntity@ pEntity = g_EntityFuncs.Create( szEntity , pPlayer.pev.origin, Vector(0, 0, 0),  false);
	g_EntityFuncs.DispatchKeyValue( pEntity.edict(), "exclusivehold", "1");
	g_EntityFuncs.DispatchKeyValue( pEntity.edict(), "m_flCustomRespawnTime", "-1");
}

void weapon_3(const CCommand@ pArgs) {
	CBasePlayer@ pPlayer = g_ConCommandSystem.GetCurrentPlayer();
	const string szEntity = "weapon_grapple";
	CBaseEntity@ pEntity = g_EntityFuncs.Create( szEntity , pPlayer.pev.origin, Vector(0, 0, 0),  false);
	g_EntityFuncs.DispatchKeyValue( pEntity.edict(), "exclusivehold", "1");
	g_EntityFuncs.DispatchKeyValue( pEntity.edict(), "m_flCustomRespawnTime", "-1");
}


void mode_rush(){
	
	CBasePlayer@ pCaller = g_ConCommandSystem.GetCurrentPlayer();
	clear_map();
	pCaller.RemoveAllItems(false);
	@t_reload = g_Scheduler.SetInterval( "clear_map", 0.5f );
	g_Hooks.RegisterHook(Hooks::Player::PlayerSpawn, @speed);
	@god_mode = g_Scheduler.SetInterval( "g_mode", 0.1f );
	

}


void g_mode(){
	CBasePlayer@ pPlayer = null;


	for( int iPlayer = 1; iPlayer <= g_Engine.maxClients; ++iPlayer )
	{
		@pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayer );
		if( pPlayer is null || !pPlayer.IsConnected() )
			continue;

		if(pPlayer.IsAlive())
		{
			
			pPlayer.pev.takedamage = DAMAGE_NO;
		}
	}

	

}

void mode_rushoff(){
	CBasePlayer@ pCaller = g_ConCommandSystem.GetCurrentPlayer();
	g_Scheduler.RemoveTimer(t_reload);
	g_Hooks.RemoveHook(Hooks::Player::PlayerSpawn, @speed);



}

HookReturnCode speed(CBasePlayer@ pPlayer)
{   
	
	pPlayer.pev.maxspeed = 200;

	
    return HOOK_CONTINUE;
}

void clear_map(){
	
	CBaseEntity@ weapons = null;


	while( ( @weapons = g_EntityFuncs.FindEntityByClassname( weapons, "weapon_*" ) ) !is null ) 
	{
		
		if(weapons.pev.classname == "weapon_displacer" ){

		}
		else if (weapons.pev.classname == "weapon_rpg" ){


		}
		else if (weapons.pev.classname == "weapon_grapple" ){

			
		}
		else {
			g_EntityFuncs.Remove(weapons);
		}
		
	   
	}


	CBaseEntity@ ents = null;

	while( ( @ents = g_EntityFuncs.FindEntityByClassname( ents, "monster_*" ) ) !is null ) 
	{

		if ( ents.pev.netname == "sv_acmin" )
		{
				
		}
	
	   else 
	   	{
	   		g_EntityFuncs.Remove(ents);
	   	}
	}
	CBaseEntity@ item = null;


	while( ( @item = g_EntityFuncs.FindEntityByClassname( item, "item_*" ) ) !is null ) 
	{
		g_EntityFuncs.Remove(item);
	}


	CBaseEntity@ ammo = null;


	while( ( @ammo = g_EntityFuncs.FindEntityByClassname( ammo, "ammo_*" ) ) !is null ) 
	{
		g_EntityFuncs.Remove(ammo);
	}

	
}

// ////////////////////////////////////////////////// ////////////////////////////////////
//
// 	Script anti bunny hopping.
// 	Este script comprobará las velocidades de cada jugador y verá si pasan la mayor parte de su tiempo saltando como conejos.
// 	Si es así, su velocidad está restringida.
// 	El guión no es perfecto y puede resultar en falsos positivos si pasan mucho tiempo en el aire por otras razones.
//
// //////////////////////////////////////////////////////////////////////////////////////

/**
*	Stores player data.
*/
final class PlayerData {
	private CBasePlayer@ m_pPlayer;
	
	/**
	*	Last time we checked this.
	*/
	float m_flLastCheckTime = 0;
	
	/**
	*   Velocity at landingPoint.
	*/
	float m_flVelocityZ = 0;
	
	/**
	*	@return The player associated with this data.
	*/
	CBasePlayer@ Player
	{
		get const { return m_pPlayer; }
	}
	
	PlayerData( CBasePlayer@ pPlayer ){
		@m_pPlayer = pPlayer;
		
		ResetTrackingData();
	}
	
	void ResetTrackingData(){
		m_flVelocityZ = 0;
	}
}

/**
*	Player data array.
*/
array<PlayerData@> g_PlayerData;

const Cvar@ g_psv_gravity = null;
 
void internal_anti_bhop(){

	//Made for ModRiot & friends.

	
	//Cache the gravity pointer for performance reasons.
	@g_psv_gravity = g_EngineFuncs.CVarGetPointer( "sv_gravity" );
	
	//Check for velocity every 0.1 seconds.
	g_Scheduler.SetInterval( "ClampVelocities", 0.05 );
	
	g_PlayerData.resize( g_Engine.maxClients );
	
	g_Hooks.RegisterHook( Hooks::Player::ClientPutInServer, @ClientPutInServer );
	g_Hooks.RegisterHook( Hooks::Player::ClientDisconnect, @ClientDisconnect );
	
	CBasePlayer@ pPlayer = null;
	
	//In case the plugin is being reloaded, fill in the list manually to account for it. Saves a lot of console output.
	for( int iPlayer = 1; iPlayer <= g_Engine.maxClients; ++iPlayer ){
		@pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayer );
	   
		if( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		PlayerData data( pPlayer );
		@g_PlayerData[ pPlayer.entindex() - 1 ] = @data;
	}
}

void MapInit()
{
	//maxplayers normally can't be changed at runtime, but if that ever changes, account for it.
	g_PlayerData.resize( g_Engine.maxClients );

	for( uint uiIndex = 0; uiIndex < g_PlayerData.length(); ++uiIndex ){
		@g_PlayerData[ uiIndex ] = null;

	}
	for( uint i = 0; i < random_mode.length(); ++i )
	{
	  g_Game.PrecacheGeneric( "sound/" + string(random_mode[i]) );
	  g_SoundSystem.PrecacheSound(string(random_mode[i]));

	}
	for( uint i = 0; i < deadnpcs.length(); ++i )
	{
	  g_Game.PrecacheGeneric( "sound/" + string(deadnpcs[i]) );
	  g_SoundSystem.PrecacheSound(string(deadnpcs[i]));
	}
	g_Game.PrecacheGeneric( "sound/" + sound3_1 );
	g_Game.PrecacheGeneric( "sound/" + m_s );
	g_SoundSystem.PrecacheSound(m_s);
	g_SoundSystem.PrecacheSound(sound3_1);
	g_Game.PrecacheModel(sprite5);
	g_Game.PrecacheGeneric(sprite5);
	
}

HookReturnCode ClientPutInServer( CBasePlayer@ pPlayer )
{
	PlayerData data( pPlayer );
	@g_PlayerData[ pPlayer.entindex() - 1 ] = @data;

	return HOOK_CONTINUE;
}

HookReturnCode ClientDisconnect( CBasePlayer@ pPlayer )
{
	@g_PlayerData[ pPlayer.entindex() - 1 ] = null;

	return HOOK_CONTINUE;
}
 
 /**
 *	Checks all players on the server and clamps their velocity if they appear to be bunny hopping.
 */
void ClampVelocities()
{
	CBasePlayer@ pPlayer = null;
	
	for( int iPlayer = 1; iPlayer <= g_Engine.maxClients; ++iPlayer ){
		@pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayer );
	   
		if( pPlayer is null || !pPlayer.IsConnected() )
			continue;
		
		HandlePlayer( pPlayer );
	}
}

/**
*	Checks if the given player should have their velocity clamped for bunny hopping.
*/
void HandlePlayer( CBasePlayer@ pPlayer )
{
	PlayerData@ pData = g_PlayerData[ pPlayer.entindex() - 1 ];
	
	//The player last died before the previous check, so they haven't died since then. Nothing to reset.
	if( pPlayer.m_fDeadTime < pData.m_flLastCheckTime ){
		
		//Only check if the player is walking. If noclipping or on a ladder, this should be ignored.
		if( pPlayer.pev.movetype == MOVETYPE_WALK ){
			
			if( pData.m_flVelocityZ < -150.0f ){
				if( pPlayer.pev.velocity.z > pData.m_flVelocityZ ){
					
					float speed = sqrt(pPlayer.pev.velocity.x*pPlayer.pev.velocity.x+pPlayer.pev.velocity.y*pPlayer.pev.velocity.y);
					
					if(speed > 270.0f){
						float slowDown = 270.0f / speed;
						slowDown *= slowDown;
						
						if(slowDown < 0.5f) slowDown = 0.5f;
						
						pPlayer.pev.velocity.x = pPlayer.pev.velocity.x * slowDown;
						pPlayer.pev.velocity.y = pPlayer.pev.velocity.y * slowDown;
					}
					
					//g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "Anti-Bhop: " + sqrt(pPlayer.pev.velocity.x*pPlayer.pev.velocity.x+pPlayer.pev.velocity.y*pPlayer.pev.velocity.y) + "\n" );
				}
			}
			
			pData.m_flVelocityZ = pPlayer.pev.velocity.z;
		}
	}else{
		pData.ResetTrackingData();
	}

	pData.m_flLastCheckTime = g_Engine.time;
}




CCVar cvarProtectDuration( "evacion_dj", 1.5f, "Duration of spawn invulnerability", ConCommandFlag::AdminOnly );

void SpawnProtection(EHandle hPlayer, const int iTakeDamageIn)
{
    if( !hPlayer )
        return;
    
    CBasePlayer@ pPlayer = cast<CBasePlayer@>( hPlayer.GetEntity() );
    pPlayer.pev.takedamage = float( iTakeDamageIn );

    if( iTakeDamageIn == 0 )
        g_Scheduler.SetTimeout( "SpawnProtection",cvarProtectDuration.GetFloat() , hPlayer, 1 );	
}







HookReturnCode PlayerSpawn( CBasePlayer@ pPlayer )
{
	KeyValueBuffer@ nPysc = g_EngineFuncs.GetPhysicsKeyBuffer(pPlayer.edict());
	nPysc.SetValue("smj", "0");
	return HOOK_CONTINUE;
}
bool PluginAccessible(CBasePlayer@ cPlayer)
{
	if(cvar_Enabled.GetInt() == 0) return false;
	if(cPlayer is null || !cPlayer.IsConnected()) return false;
	if(!cPlayer.IsAlive())
	{
		return false;
	}
	if(cvar_AdminOnly.GetInt() == 1)
	{
		if(g_PlayerFuncs.AdminLevel(@cPlayer) <= 0) return false;
	}
	if(cvar_MJOnly.GetInt() == 1)
	{
		KeyValueBuffer@ nPysc = g_EngineFuncs.GetPhysicsKeyBuffer(cPlayer.edict());
		string cVal = nPysc.GetValue("smj");
		if(cVal != "1") return false;
	}
	return true;
}

HookReturnCode PlPreThink(CBasePlayer@ cPlayer, uint& out outvar)
{
	if(!PluginAccessible(cPlayer)) return HOOK_CONTINUE;
	max_jump = cvar_MjJump.GetInt();
	int player_id = cPlayer.entindex();
	int nbut = cPlayer.pev.button;
	int obut = cPlayer.pev.oldbuttons;
	int uflags = cPlayer.pev.flags;
	if((nbut & IN_JUMP) == IN_JUMP && (uflags & FL_ONGROUND != FL_ONGROUND) && (obut & IN_JUMP) != IN_JUMP)
	{
		if(Jumpedcound[player_id] < max_jump)
		{
			DoJump[player_id] = true;
			Jumpedcound[player_id]++;
			return HOOK_CONTINUE;
		}
	}
	if((nbut & IN_JUMP) == IN_JUMP && (uflags & FL_ONGROUND) == FL_ONGROUND)
	{
		Jumpedcound[player_id] = 0;
	}
	return HOOK_CONTINUE;
}
HookReturnCode PlPostThink(CBasePlayer@ cPlayer)
{
	if(!PluginAccessible(cPlayer)) return HOOK_CONTINUE;
	int player_id = cPlayer.entindex();
	if(DoJump[player_id])
	{
		Vector velocity;
		velocity = cPlayer.pev.velocity;
		velocity.z = Math.RandomFloat(265, 285);
		cPlayer.pev.velocity = velocity;
		DoJump[player_id] = false;
		SpawnProtection( EHandle( cPlayer ), 0 );	

	}
	return HOOK_CONTINUE;
}
HookReturnCode PlPutinServer( CBasePlayer@ pPlayer )
{
	int player_id = pPlayer.entindex();
	Jumpedcound[player_id] = 0;
	DoJump[player_id] = false;
	return HOOK_CONTINUE;
}











// effects for entities, this bug
HookReturnCode ent_efects(CBaseEntity@ pEntity)
{


	while((@pEntity = g_EntityFuncs.FindEntityByClassname(pEntity, "monster_*")) !is null){
		ent_efect();
		npcsheal();
		return HOOK_HANDLED;
	}
	

    return HOOK_CONTINUE;
}

void ent_efect(){

	CBaseEntity@ pEnt = null;

	for (uint i = 3; i < g_RemoveEnts.length(); ++i) {
		while( ( @pEnt = g_EntityFuncs.FindEntityByClassname( pEnt, g_RemoveEnts[i] ) ) !is null ) {
		   g_EntityFuncs.Remove(pEnt);
		}
	}


}


void clear_weapons(){
	CBaseEntity@ weapons = null;

	for (uint i = 3; i < g_RemoveEnts.length(); ++i) {
		while( ( @weapons = g_EntityFuncs.FindEntityByClassname( weapons, "weapon_*" ) ) !is null ) {
		   g_EntityFuncs.Remove(weapons);
		}
	}
	
}

//comand .realist 
void realiston()
{
	CBasePlayer@ pCaller = g_ConCommandSystem.GetCurrentPlayer();
	CBaseEntity@ info_ent = g_EntityFuncs.Create("ambient_generic", pCaller.GetOrigin() + Vector(0, 60, 0), Vector(0, 0, 0), false);
	g_EntityFuncs.Create("ambient_generic", pCaller.GetOrigin() + Vector(0, 60, 0), Vector(0, 0, 0), false);
	g_Hooks.RegisterHook( Hooks::Player::PlayerPreThink, @PlPreThink );
	g_Hooks.RegisterHook( Hooks::Player::PlayerPostThink, @PlPostThink );
	g_Hooks.RegisterHook( Hooks::Player::ClientPutInServer, @PlPutinServer );
	g_Hooks.RegisterHook( Hooks::Player::PlayerSpawn, @PlayerSpawn );
	@refresh_s = g_Scheduler.SetInterval( "ent_s", 0.0f );
	@refresh_s = g_Scheduler.SetInterval( "accion_ents", 0.0f );
	@g_ents = g_Scheduler.SetInterval( "ents", 0.25f );
	player_weapon();
	ent_efect();
	CfgServerOn();
	clear_weapons();
	g_Scheduler.ClearTimerList();
	monsterList.removeRange(0, monsterList.length());
	nameList.removeRange(0, nameList.length());
	posList.removeRange(0, posList.length());
	@refreshMonster = g_Scheduler.SetInterval("killdrop", 0.3, g_Scheduler.REPEAT_INFINITE_TIMES);
	pCaller.RemoveAllItems(false);
	p_weapons( EHandle( pCaller ), 0 );	
	sounds_m( EHandle( pCaller ), 0 );	
	npcsheal();
	for( int i = 0; i < g_Engine.maxEntities; ++i ) {
		CBaseEntity@ pEntity = g_EntityFuncs.Instance( i );
		if( pEntity is null ) continue;
		while((@pEntity = g_EntityFuncs.FindEntityByClassname(pEntity, "monster_*")) !is null){
			multiplySpeed(pEntity);
			multiplyMaxSpeed(pEntity);
		}
	}
	
	
	g_Hooks.RegisterHook(Hooks::Player::PlayerSpawn, @weapons);
	g_Hooks.RegisterHook( Hooks::Game::EntityCreated, @ent_efects );



	
}

//preache
array<SOUND_CHANNEL> channels = {CHAN_STATIC};

//disamble mode .realistoff
void RealistModeoff()
{
	CBasePlayer@ pCaller = g_ConCommandSystem.GetCurrentPlayer();
	if (g_PlayerFuncs.AdminLevel(pCaller) < ADMIN_YES)
	   g_PlayerFuncs.ClientPrint(pCaller, HUD_PRINTCONSOLE, "You have no access to this command.\n");
	else
		
		g_Scheduler.RemoveTimer(ent_s);
		g_Scheduler.RemoveTimer(refresh_s);
		for (uint i = 0; i < random_mode.length(); ++i) {
			for (uint g = 0; g < channels.length(); g++)
			{
			  g_SoundSystem.StopSound(pCaller.edict(), channels[g], string(random_mode[i]), false);
			}
		  
		}
		npcshealoff();
		player_weapon_disable();
		
		g_Scheduler.RemoveTimer(refreshMonster);
		g_Scheduler.RemoveTimer(g_ents );
		g_EngineFuncs.ServerCommand("mp_respawndelay 5 \n");
		g_EngineFuncs.ServerCommand("weaponmode_shotgun 0 \n"); 
		g_EngineFuncs.ServerCommand("weaponmode_9mmhandgun 0 \n"); 
		g_EngineFuncs.ServerCommand("weaponmode_displacer 0 \n"); 
		g_Hooks.RemoveHook( Hooks::Game::EntityCreated, @ent_efects );
		g_Hooks.RemoveHook(Hooks::Player::PlayerSpawn, @weapons);	
		g_Hooks.RemoveHook( Hooks::Player::PlayerPreThink, @PlPreThink );
		g_Hooks.RemoveHook( Hooks::Player::PlayerPostThink, @PlPostThink );
		g_Hooks.RemoveHook( Hooks::Player::ClientPutInServer, @PlPutinServer );
		g_Hooks.RemoveHook( Hooks::Player::PlayerSpawn, @PlayerSpawn );
		

		

	// buscar la manera que pare y que se cuente a todos los npcs

}


void accion_ents(CBasePlayer@ pPlayer){

	p_weapons( EHandle( pPlayer ), 0 );
}


CScheduledFunction@ g_ents = null;


void killdrop(){
	
	for(int i=0; i<int(monsterList.length()); i++){
		CBaseEntity@ thatMonster = monsterList[i];
		if(thatMonster is null || !thatMonster.IsAlive()){
			m_position(posList[i]);
	  	}
	}
	monsterList.removeRange(0, monsterList.length());
	nameList.removeRange(0, nameList.length());
	posList.removeRange(0, posList.length());
	CBaseEntity@ thisMonster = null;
	int monsterNumber = 0;
	while((@thisMonster = g_EntityFuncs.FindEntityByClassname(thisMonster, "monster_human_*")) !is null){
	  int relationship = thisMonster.IRelationshipByClass(CLASS_PLAYER);
	  if(thisMonster.IsAlive() && relationship != R_AL && relationship != R_NO){
		EHandle thisMonsterHandle = thisMonster;
		monsterList.insertLast(thisMonsterHandle);
		nameList.insertLast(thisMonster.GetClassname());
		posList.insertLast(thisMonster.GetOrigin());
	  }
	}
	CBaseEntity@ barney = null;
	while((@barney = g_EntityFuncs.FindEntityByClassname(barney, "monster_barney")) !is null){
		int relationship = barney.IRelationshipByClass(CLASS_PLAYER);
		if(barney.IsAlive() && relationship != R_AL && relationship != R_NO){
		  EHandle thisMonsterHandle = barney;
		  monsterList.insertLast(thisMonsterHandle);
		  nameList.insertLast(barney.GetClassname());
		  posList.insertLast(barney.GetOrigin());
		}
	}
	
	CBaseEntity@ otis = null;
	while((@otis = g_EntityFuncs.FindEntityByClassname(otis, "monster_otis")) !is null){
		int relationship = otis.IRelationshipByClass(CLASS_PLAYER);
		if(otis.IsAlive() && relationship != R_AL && relationship != R_NO){
		  EHandle thisMonsterHandle = otis;
		  monsterList.insertLast(thisMonsterHandle);
		  nameList.insertLast(otis.GetClassname());
		  posList.insertLast(otis.GetOrigin());
		}
	}


}
/*WARNING: Angelscript: CScheduler: could not add function 'entitys', function not found
WARNING: Angelscript: CScheduler: could not add function 'ent_s', function not found
WARNING: Angelscript: CScheduler: could not add function 'accion_ents', function not found
WARNING: Angelscript: CScheduler: could not add function 'ents', function not found
*/
void m_position( Vector position){
	CBaseEntity@ npcs = null;
	while((@npcs = g_EntityFuncs.FindEntityByClassname(npcs, "monster_*")) !is null){
		CSprite@ ent_sprite = g_EntityFuncs.CreateSprite( sprite5, position +  Vector(0, 0, 100), true );
		ent_sprite.AnimateAndDie(3);
		int i = Math.RandomLong(0,deadnpcs.length()-1);
		g_SoundSystem.PlaySound(npcs.edict(), CHAN_AUTO,string(deadnpcs[i]) ,  1.0f, 0.2f, 0, 100, 0, true, position);
	}


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
		pEntity.pev.speed *= 4;
	}

	else{
		pEntity.pev.speed = cKeyValues.GetKeyvalue("$f_originalSpeed").GetFloat() * 4;
	}

}

void multiplyMaxSpeed(CBaseEntity@ pEntity){
	CustomKeyvalues@ cKeyValues = pEntity.GetCustomKeyvalues();
	
	if(!cKeyValues.HasKeyvalue("$f_originalMaxSpeed")){
		cKeyValues.SetKeyvalue("$f_originalMaxSpeed", pEntity.pev.maxspeed);
		pEntity.pev.maxspeed *= 4;

	}

	else{
		pEntity.pev.maxspeed = cKeyValues.GetKeyvalue("$f_originalSpeed").GetFloat() * 4;
	}
}



HookReturnCode weapons(CBasePlayer@ pPlayer)
{   
	pPlayer.RemoveAllItems(false);
	p_weapons( EHandle( pPlayer ), 0 );

	
    return HOOK_CONTINUE;
}


//disarm the player and then arm him with weapon mode
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
		g_Scheduler.SetTimeout( "p_weapons", 0.9 , hPlayer, 9 );
		g_Scheduler.SetTimeout( "p_weapons", 1.0 , hPlayer, 10 );
		g_Scheduler.SetTimeout( "p_weapons", 1.8 , hPlayer, 11 );
        
    }
    if( weapon == 1 )
	{
		//g_EntityFuncs.Create("weapon_9mmhandgun", pPlayer.GetOrigin() + Vector(0, 0, 0), Vector(0, 0, 0),  false).KeyValue("m_flCustomRespawnTime", "-1");
		
    }
	if( weapon == 2 )
	{
		pPlayer.GiveNamedItem("weapon_9mmhandgun", 1000000);
		
    }
	if( weapon == 3 ){

		pPlayer.GiveNamedItem("ammo_9mmAR", 1000000);
		
    }
	if( weapon == 4 )
	{
		pPlayer.GiveNamedItem("ammo_9mmAR", 0, 0);
		

    }
	if( weapon == 5 )
	{
		
		pPlayer.GiveNamedItem("weapon_handgrenade", 0, 0);

    }
	if( weapon == 6 )
	{
		pPlayer.GiveNamedItem("ammo_9mmAR", 0, 0);

    }
	if( weapon == 7 )
	{
		pPlayer.GiveNamedItem("ammo_9mmAR", 0, 0);
    }
	if( weapon == 8 )
	{

		pPlayer.GiveNamedItem("weapon_medkit", 1000000, 1000000);

    }
	if( weapon == 9 )
	{
		pPlayer.GiveNamedItem("ammo_9mmAR", 0, 0);

    }
	if( weapon == 10 )
	{

		pPlayer.GiveNamedItem("weapon_crowbar", 0 , 0);

    }
        
}

void sounds_m(EHandle hPlayer, const int soundM)
{
	

	if( !hPlayer )
		return;

	CBasePlayer@ pPlayer = cast<CBasePlayer@>( hPlayer.GetEntity() );
	float( soundM );

	if( soundM == 0 ){
		g_Scheduler.SetTimeout( "sounds_m", 2.0 , hPlayer, 1 );
		
	}
	if( soundM == 1 )
	{
		CBaseEntity@ info_ent = g_EntityFuncs.Create("ambient_generic", pPlayer.GetOrigin() + Vector(0, 60, 0), Vector(0, 0, 0), false);
		g_SoundSystem.PlaySound( info_ent.edict(), CHAN_VOICE , m_s, VOL_NORM, 0, 0, PITCH_NORM, 0, false, g_vecZero );
		g_PlayerFuncs.ClientPrintAll(HUD_PRINTTALK, "Se activo el nuevo modo!\n");
		
	}



}

void player_weapon(){

	g_EngineFuncs.CVarSetFloat("sk_plr_9mm_bullet", 100);
	g_EngineFuncs.CVarSetFloat("sk_plr_9mm_bullet", 100);
	g_EngineFuncs.CVarSetFloat("sk_plr_357_bullet", 120);
	g_EngineFuncs.CVarSetFloat("sk_plr_9mmAR_bullet", 150);
	g_EngineFuncs.CVarSetFloat("sk_plr_9mmAR_grenade", 150);
	g_EngineFuncs.CVarSetFloat("sk_plr_buckshot", 225);
	g_EngineFuncs.CVarSetFloat("sk_plr_xbow_bolt_monster", 100);
	g_EngineFuncs.CVarSetFloat("sk_plr_rpg", 500);
	g_EngineFuncs.CVarSetFloat("sk_plr_gauss", 100);
	g_EngineFuncs.CVarSetFloat("sk_plr_egon_narrow", 25);
	g_EngineFuncs.CVarSetFloat("sk_plr_egon_wide", 25);
	g_EngineFuncs.CVarSetFloat("sk_plr_hand_grenade", 250);
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
	g_EngineFuncs.CVarSetFloat("sk_plr_crowbar", 150);

	
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
	g_EngineFuncs.CVarSetFloat("sk_plr_crowbar", 15);
}


void npcsheal(){
	for( int i = 0; i < g_Engine.maxEntities; ++i ) {
		CBaseEntity@ ent = g_EntityFuncs.Instance( i );
		if( ent !is null ) {
            
			if ( ent.pev.classname == "monster_alien_babyvoltigore" ){		
				ent.pev.health = 800;
			}else if ( ent.pev.classname == "monster_alien_controller" ){		
				ent.pev.health = 100;
			}else if ( ent.pev.classname == "monster_alien_grunt" ){			
				ent.pev.health = 500;
			}else if ( ent.pev.classname == "monster_alien_slave" ){	
				ent.pev.health = 100;
			}else if ( ent.pev.classname == "monster_alien_tor" ){
				ent.pev.health = 8000;
			}else if ( ent.pev.classname == "monster_alien_voltigore" ){
				
				
				ent.pev.health = 15000;
			}else if ( ent.pev.classname == "monster_apache" ){
				
				
				ent.pev.health = 1500;
			}else if ( ent.pev.classname == "monster_babycrab" ){
				
				
				ent.pev.health = 100;
			}else if ( ent.pev.classname == "monster_barnacle" ){
				
				
				ent.pev.health = 150;
			}else if ( ent.pev.classname == "monster_barney" ){
				
				
				ent.pev.health = 700;
				//g_EntityFuncs.DispatchKeyValue( ent.edict(), "displayname", "xdddd" );
			}else if ( ent.pev.classname == "monster_bigmomma" ){

				
				ent.pev.health = 40000;
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
				ent.pev.speed *= 4;
				ent.pev.maxspeed *= 4;
				
				ent.pev.health = 100;
			}else if ( ent.pev.classname == "monster_human_grunt" ){
				ent.pev.speed *= 4;
				ent.pev.maxspeed *= 4;
				if ( ent.pev.health == ent.pev.health ){
					g_EntityFuncs.DispatchKeyValue( ent.edict(), "displayname", "acmin" );
				}
				
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
				
				
				ent.pev.health = 800;
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
				ent.pev.speed *= 10;
				ent.pev.maxspeed *= 10;
			}else if ( ent.pev.classname == "monster_zombie_barney" ){
				ent.pev.health = 700;
				ent.pev.speed *= 10;
				ent.pev.maxspeed *= 10;
			}else if ( ent.pev.classname == "monster_zombie_soldier" ){
				ent.pev.health = 1000;
				ent.pev.speed *= 10;
				ent.pev.maxspeed *= 10;
			}

		}
	}
	
}

void npcshealoff(){

	
	for( int i = 0; i < g_Engine.maxEntities; ++i ) {
		CBaseEntity@ ent = g_EntityFuncs.Instance( i );
		if( ent !is null ) {
            
			
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
				ent.pev.speed /= 4;
				ent.pev.maxspeed /= 4;
				
				ent.pev.health = ent.pev.health;
			}else if ( ent.pev.classname == "monster_human_grunt" ){
				ent.pev.speed /= 4;
				ent.pev.maxspeed /= 4;
				
				ent.pev.health = ent.pev.health;
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
				ent.pev.speed /= 10;
				ent.pev.maxspeed /= 10;
			}else if ( ent.pev.classname == "monster_zombie_barney" ){
				ent.pev.health = ent.pev.health;
				ent.pev.speed /= 10;
				ent.pev.maxspeed /= 10;
			}else if ( ent.pev.classname == "monster_zombie_soldier" ){
				ent.pev.health = ent.pev.health;
				ent.pev.speed /= 10;
				ent.pev.maxspeed /= 10;
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

HookReturnCode disarm_r_w(CBasePlayer@ pPlayer)
{   
	
	core_r_W( EHandle( pPlayer ), 0 );
    return HOOK_CONTINUE;
}

void random_weapons(){
	
	g_Hooks.RegisterHook(Hooks::Player::PlayerSpawn, @disarm_r_w);
	CBasePlayer@ pPlayer;

	for( int iPlayer = 1; iPlayer <= g_Engine.maxClients; ++iPlayer ){
		@pPlayer = g_PlayerFuncs.FindPlayerByIndex( iPlayer );
	
		if( pPlayer is null || !pPlayer.IsConnected() )
		  continue;
		  
		  core_r_W( EHandle( pPlayer ), 0 );
	}

	
}

void core_r_W(EHandle hPlayer, const int weapon)
{
    if( !hPlayer )
        return;
      
    CBasePlayer@ pPlayer = cast<CBasePlayer@>( hPlayer.GetEntity() );
    float( weapon );

    if( weapon == 0 ){
        g_Scheduler.SetTimeout( "core_r_W", 0.1 , hPlayer, 1 );

        
    }
    if( weapon == 1 )
	{
		int i = Math.RandomLong(0,r_Weapon.length()-1);
		g_EntityFuncs.Create(string(r_Weapon[i]), pPlayer.GetOrigin() + Vector(0, 0, 0), Vector(0, 0, 0),  false).KeyValue("m_flCustomRespawnTime", "-1");
		
    }
        
}


void random_weaponsoff(){
	
	g_Hooks.RemoveHook(Hooks::Player::PlayerSpawn, @disarm_r_w);
}


