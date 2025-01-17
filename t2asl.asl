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

// state("horus_x64", "playfab")
// {
//   // memSize 0x8BB1000
//   // fileSize 10,681,344
//   string40 level : 0x8AE4650, 0x0, 0x4;
// }

init
{
    // Call this action to print debug messages, e.g. vars.debug("Split on map: " + current.level)
    vars.debug = (Action<string>)((msg) => print("[Turok 2 ASL] " + msg));

    // The version is found by checking how much memory the process reserves against known values
    int memSize = modules.First().ModuleMemorySize;
    vars.debug("memSize: " + memSize);
    if (memSize == 0x8DD000) version = "1.5.9";
    else if (memSize == 0x8BB1000) version = "debug_inventory";
    // else if (memSize == 0x8BB1000) version = "playfab";
    else 
    {
        version = "1.5.9";
        vars.debug("Couldn't detect version, defaulting to 1.5.9");
    }

		// IMPORTANT LOCATIONS
	vars.intro = "ls/(6)_cin_adon.map";					 // intro cinematic for timer start and the auto reset
	vars.hub = "ls/HUB.map";							 // the hub map
	vars.adonSavePortal = "ls/Adon_SavePortal.map";
	vars.finalKeyPlaced = "ls/cinema_hubportal.map";
	
		// PORT OF ADIA LOCATIONS
	vars.portOfAdia9 = "ls/Port_Of_Adia_9.map";
	vars.portOblivion = "ls/Port_Oblivion.map"; 	 // split 1
	vars.portTotem = "ls/Port_Totem.map"; 			 // split 2
	vars.portVillage = "ls/Port_Of_Adia_5.map";		 // split for return to POA for Primagen Key
	
		// RIVER OF SOULS LOCATIONS
	vars.enterROS = "ls/cinema_2_dinosoid.map";
	vars.riverOblivion = "ls/River_Oblivion.map";
	vars.riverOfSouls4 = "ls/RiverOfSouls_4.map";
	vars.riverOfSouls8 = "ls/RiverOfSouls_8.map"; 	// location of the totem
	vars.riverTotem = "ls/River_Totem.map";			// split 7
	
		// DEATH MARSHES LOCATIONS
	vars.enterDM = "ls/cinema_3_A.map";
	vars.beforeMarshTotem = "ls/Death_Marsh_8.map";
	vars.marshTotem = "ls/Marsh_Totem.map"; 		 // split 4
	vars.marshOblivion = "ls/Marsh_Oblivion.map";
	vars.deathMarsh3 = "ls/Death_Marsh_3.map";
	
		// HIVE OF THE MANTIDS LOCATIONS
	vars.enterHIVE = "ls/cinema_5_top.map";
	vars.hiveOblivion = "ls/Hive_Oblivion.map";
	vars.hive4 = "ls/Hive_4.map";
	vars.hiveBreedingGrounds = "ls/Hive_8.map";
	vars.queen = "ls/Queen_Boss.map";

		// LAIR OF THE BLIND ONES LOCATIONS
	vars.enterLAIR = "ls/cinema_4_A.map";
	vars.blindEntrance = "ls/Blind_Lair_1.map";
	vars.blindOblivion = "ls/Blind_Oblivion.map";
	vars.blindLair6 = "ls/Blind_Lair_6.map";
	vars.blindTotem = "ls/Blind_Totem.map";	
	vars.blindBoss = "ls/Blind_One_Boss.map";

		// LIGHTSHIP LOCATIONS
	vars.enterLS = "ls/cinema_6_E.map";
	vars.lightOblivion = "ls/Light_Oblivion.map";
	vars.light2 = "ls/Lightship_2.map";					// where the adon save portal / checkpoint is located
	vars.light10 = "ls/Lightship_10.map";				// where the oblivion portal is located
	vars.primagenBoss = "ls/Primagen_Boss.map"; 		// the final boss fight map
	vars.primagenCinematic = "ls/cinema_primagen.map";	// plays before and after the fight 
	vars.light1 = "ls/Lightship_1.map";
	vars.mother = "ls/Mother_Boss.map";
	
		// TOTEM MAPS FOR REFERENCE
	vars.portTotem = "ls/Port_Totem.map"; 			 // split 2
	vars.marshTotem = "ls/Marsh_Totem.map"; 		 // split 4
	vars.riverTotem = "ls/River_Totem.map";			 // split 7
	vars.hiveTotem = "ls/Hive_Totem.map";			 // split 16
	vars.blindTotem = "ls/Blind_Totem.map";			 // split 12
}

start
{	
	return (current.level == vars.intro);			 // starts timer on intro cinematic after selecting difficulty
}

split
{

	if(timer.Run.CategoryName == "100%")
	{
		return
		(
			current.level == vars.portOfAdia9 && old.level == vars.portOblivion 			// split on leaving Oblivion lair in Port of Adia
			|| current.level == vars.portTotem && old.level == vars.portOfAdia9				// split on entering POA Totem
			|| current.level == vars.enterDM && old.level != vars.enterDM 					// split Death Marshes portal entered
			|| current.level == vars.marshTotem && old.level == vars.beforeMarshTotem 		// split on entering the DM Totem 
			|| current.level == vars.enterROS && old.level != vars.enterROS					// split River Of Souls portal entered
			|| current.level == vars.riverOfSouls4 && old.level == vars.riverOblivion 		// split leaving Oblivion Lair
			|| current.level == vars.riverTotem && old.level == vars.riverOfSouls8 			// split ROS totem enter
			|| current.level == vars.enterHIVE && old.level != vars.enterHIVE 				// split on entering HIVE portal
			|| current.level == vars.hive4 && old.level == vars.hiveOblivion 				// split on leaving Hive Oblivion Room
			|| current.level == vars.enterLAIR && old.level != vars.enterLAIR				// split on entering blind ones portal
			|| current.level == vars.blindLair6 && old.level == vars.blindOblivion			// split on leaving Lair Oblivion Room
			|| current.level == vars.blindTotem && old.level == vars.blindLair6				// split on entering Blind Totem
			|| current.level == vars.blindBoss && old.level == vars.blindTotem				// split on entering boss lair
			|| current.level == vars.hub && old.level == vars.blindBoss						// splits on returning to hub
			|| current.level == vars.light10 && old.level == vars.lightOblivion				// split on leaving lightship oblivion lair
			|| current.level == vars.mother && old.level == vars.light1						// splits on start of Mother fight
			|| current.level == vars.hub && old.level == vars.mother						// split on returning to the HUB after mother fight
			|| current.level == vars.hiveTotem && old.level == vars.hiveBreedingGrounds		// split entering Hive Totem
			|| current.level == vars.queen && old.level == vars.hiveTotem 					// splits on start of queen fight
			|| current.level == vars.hub && old.level == vars.queen							// splits on return to hub after queen fight
			|| current.level == vars.deathMarsh3 && old.level == vars.marshOblivion			// split on leaving Oblivion lair of Death Marshes
			|| current.level == vars.deathMarsh3 && old.level == vars.adonSavePortal		// DM trip 2
			|| current.level == vars.blindEntrance && old.level == vars.adonSavePortal		// lair trip 2
			|| current.level == vars.portVillage && old.level == vars.adonSavePortal		// split on warping from hub to adia village (PoA Trip 2)
			|| current.level == vars.hiveBreedingGrounds && old.level == vars.adonSavePortal // split on hive trip 2 
			|| current.level == vars.primagenBoss && old.level == vars.primagenCinematic	// splits on the final fight beginning
			|| current.level == vars.primagenCinematic && old.level == vars.primagenBoss	// splits on death!
		);
	}
	
	if(timer.Run.CategoryName == "Any%")
	{
		return
		(
			current.level == vars.portTotem && old.level != vars.portTotem 					// splits entering PoA Totem
			|| current.level == vars.enterDM && old.level != vars.enterDM 					// splits on entering Death Marshes portal
			|| current.level == vars.enterROS && old.level != vars.enterROS					// splits on entering RoS portal
			|| current.level == vars.enterHIVE && old.level != vars.enterHIVE				// splits on entering Hive portal
			|| current.level == vars.enterLAIR && old.level != vars.enterLAIR		// splits on entering Lair portal
			|| current.level == vars.enterLS && old.level != vars.enterLS					// splits on entering Lightship portal
			|| current.level == vars.adonSavePortal && old.level == vars.light2				// splits on entering checkpoint from Lightship, backtracking starts at either Village, 3 or breeding
			|| current.level == vars.primagenBoss && old.level == vars.primagenCinematic	// splits on the final fight beginning #8
			|| current.level == vars.primagenCinematic && old.level == vars.primagenBoss	// splits on death! #9
		);
	}
	
}

reset
{
	 return current.level == vars.intro && old.level != vars.intro;
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
