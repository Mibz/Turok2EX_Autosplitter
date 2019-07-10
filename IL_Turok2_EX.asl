// For use only when loading a save at the start of a level, will end when reaching the HUB
// Intended for single split layouts

state("horus_x64")
{
	string255 level : 0x7FD2C8, 0x4;
	//	long bossHP : 0x7FE064; // This location used for all bosses health when active  NOT USED
	// 0x7FE068;
}

init
{
		// IMPORTANT LOCATION
	vars.hub = "ls/HUB.map";							// the hub map
    vars.hubLowerCase = "ls/hub.map";
	
		// PORT OF ADIA LOCATION
    vars.portStartLocation = "ls/Port_Of_Adia_1.map";   // where player receives control
	vars.portStartLowerCase = "ls/port_of_adia_1.map";

		// RIVER OF SOULS LOCATION
    vars.riverStartLocation = "ls/RiverOfSouls_1.map";  // where player receives control
	vars.riverStartLowerCase = "ls/riverofsouls_1.map";

		// DEATH MARSHES LOCATION
    vars.deathStartLocation = "ls/Death_Marsh_1.map";    // where player receives control
    vars.deathStartLowerCase = "ls/death_marsh_1.map";  
	
		// HIVE OF THE MANTIDS LOCATION
    vars.hiveStartLocation = "ls/HIVE_TOP.map";    // where player receives control
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
	return (current.level == vars.hub && old.level != vars.hub);
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
