/*
Individual level autosplitter, starts on player 
taking control at the start of each level - splits 
when entering the hub. Intended for single split layouts.

One thing - if you are in the starting location of a 
level and reload a save from that area it wont start 
the timer due to the timer starting only when  
starting in that location which it did you never left 
it you are still there.
*/

state("horus_x64", "1.5.9")
{
  // memSize 0x8DD000
  string40 level : 0x7F2CD0, 0x0, 0x4;

	// string255 level : 0x7FD2C8, 0x4; // Why does this make 'of' lowercase?
	//	long bossHP : 0x7FE064; // This location used for all bosses health when active  NOT USED
	// 0x7FE068;
}

state("horus_x64", "debug_inventory") 
{
  // memSize 0x8BB1000
  // fileSize 10,682,880
  string40 level : 0x8AE4670, 0x0, 0x4;
}

state("horus_x64", "playfab")
{
  // memSize 0x8BB1000
  // fileSize 10,681,344
  string40 level : 0x8AE4650, 0x0, 0x4;
}

init
{
    // Call this action to print debug messages, e.g. vars.debug("Split on map: " + current.level)
    vars.debug = (Action<string>)((msg) => print("[Turok 2 ASL] " + msg));

    // The version is found by checking how much memory the process reserves against known values
    int memSize = modules.First().ModuleMemorySize;
    vars.debug("memSize: " + memSize);
    if (memSize == 0x8DD000) version = "1.5.9";
    else if (memSize == 0x8BB1000) version = "debug_inventory";
    // else if (memSize == 0x) version = "playfab";
    else 
    {
        version = "1.5.9";
        vars.debug("Couldn't detect version, defaulting to 1.5.9");
    }

    // IMPORTANT LOCATION
    vars.hub = "ls/HUB.map";  // the hub map
    vars.hubLowerCase = "ls/hub.map";

    // PORT OF ADIA LOCATION
    vars.portStartLocation = "ls/Port_Of_Adia_1.map";  // where player receives control
    vars.portStartLowerCase = "ls/port_of_adia_1.map";

    // RIVER OF SOULS LOCATION
    vars.riverStartLocation = "ls/RiverOfSouls_1.map";  // where player receives control
    vars.riverStartLowerCase = "ls/riverofsouls_1.map";

    // DEATH MARSHES LOCATION
    vars.deathStartLocation = "ls/Death_Marsh_1.map";  // where player receives control
    vars.deathStartLowerCase = "ls/death_marsh_1.map";  

    // HIVE OF THE MANTIDS LOCATION
    vars.hiveStartLocation = "ls/HIVE_TOP.map";  // where player receives control
    vars.hiveStartLowerCase = "ls/hive_top.map";

    // LAIR OF THE BLIND ONES LOCATION
    vars.blindEntrance = "ls/Blind_Lair_1.map";
    vars.blindEntranceLowerCase = "ls/blind_lair_1.map";

    // LIGHTSHIP LOCATION
    vars.light1 = "ls/Lightship_1.map";
    vars.Light = "ls/lightship_1.map";
}

start
{	
	return 
    (
    current.level == vars.portStartLocation && old.level != vars.portStartLocation
    || current.level == vars.portStartLowerCase && old.level != vars.portStartLowerCase
    || current.level == vars.riverStartLocation && old.level != vars.riverStartLocation
    || current.level == vars.riverStartLowerCase && old.level != vars.riverStartLowerCase
    || current.level == vars.deathStartLocation && old.level != vars.deathStartLocation
    || current.level == vars.deathStartLowerCase && old.level != vars.deathStartLowerCase
    || current.level == vars.blindEntrance && old.level != vars.blindEntrance
    || current.level == vars.blindEntranceLowerCase && old.level != vars.blindEntranceLowerCase
    || current.level == vars.hiveStartLocation && old.level != vars.hiveStartLocation
    || current.level == vars.hiveStartLowerCase && old.level != vars.hiveStartLowerCase
    || current.level == vars.light1 && old.level != vars.light1 
    || current.level == vars.Light && old.level != vars.Light
    );
}

split
{
	return
  (
    current.level == vars.hub && old.level != vars.hub
    || current.level == vars.hubLowerCase && old.level != vars.hubLowerCase
  );
}

reset
{

}

isLoading
{

}

gameTime
{

}

exit
{

}

update
{

}
