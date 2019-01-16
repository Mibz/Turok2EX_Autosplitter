state("horus_x64")
{
	string255 level : 0x7FD2C8, 0x4;
	long primagenHP : 0x7FE064;
	// 0x7FE068;
} 

/*
The reason for two primagenHP values is that one corresponds to his health in code
 the other the visual of his health bar on screen visible to the player
*/

init
{
		// by "level" clustered by map ID and roughly in order of usage
	
	vars.intro = "ls/(6)_cin_adon.map";					 // intro cinematic for timer start and the auto reset
	vars.hub = "ls/HUB.map";							 // the hub map
	
	vars.portOfAdia9 = "ls/Port_Of_Adia_9.map";
	vars.portOblivion = "ls/Port_Oblivion.map"; 	 // split 1
	vars.portTotem = "ls/Port_Totem.map"; 			 // split 2
	
	vars.enterROS = "ls/cinema_2_dinosoid.map";
	vars.riverOblivion = "ls/River_Oblivion.map";
	vars.riverOfSouls4 = "ls/RiverOfSouls_4.map";
	vars.riverTotem = "ls/River_Totem.map";			 // split 7
	
	vars.enterDM = "ls/cinema_3_A.map";
	vars.marshOblivion = "ls/Marsh_Oblivion.map";
	vars.deathMarsh3 = "ls/Death_Marsh_3.map";
	
	vars.blindOblivion = "ls/Blind_Oblivion.map";
	vars.blindLair6 = "ls/Blind_Lair_6.map";

	vars.enterHIVE = "cinema_5_top.map";
	vars.hiveOblivion = "ls/Hive_Oblivion.map";

	
	vars.lightOblivion = "ls/Light_Oblivion.map";
	
	vars.primagenBoss = "ls/Primagen_Boss.map"; 		// the final boss fight map
	vars.primagenCinematic = "ls/cinema_primagen.map";
	
	
		// TOTEM MAPS
	vars.portTotem = "ls/Port_Totem.map"; 			 // split 2
	vars.marshTotem = "ls/Marsh_Totem.map"; 		 // split 4
	vars.riverTotem = "ls/River_Totem.map";			 // split 7
	vars.hiveTotem = "ls/Hive_Totem.map";			 // split 16
	
		// COUNTERS FOR BOSS PHASES
	vars.primagenPhase = 0;
}

start
{
	vars.primagenPhase = 0;
	
	return (current.level == vars.intro);			 // starts timer on intro cinematic after selecting difficulty
}

/* 
===================================
	PROPOSED SPLITS
===================================

From Turok Speedrunners Discord #General
GrowthKasei 16/01/2019 at 5:36 PM
My ideal splits:

1. PoA Oblivion Room (Split on leaving)
2. Enter PoA Totem
3. Enter DM
4. Enter DM Totem 				// Marsh_Totem.map
5. Enter RoS
6. RoS Oblivion Room (Split on leaving)
7. Enter RoS Totem				<--- // DONE UP TO HERE 16/01/2019
8. Enter Hive
9. Hive Oblivion Room (Split on leaving)
10. Enter Lair
11. Lair Oblivion Room (Split on leaving)
12. Enter Lair Totem 				// Blind_Totem.map
13. Blind One (Split on kill)
14. Lightship Oblivion Room (Split on leaving)
15. Mother (Split on kill)
16. Enter Hive Totem				// Hive_Totem.map
17. Queen (Split on kill)
18. DM Oblivion Room (Split on leaving)
19. DM Trip 2 (Split on entering checkpoint)
20. Lair Trip 2 (Split on entering checkpoint Entrance)
20. PoA Trip 2 (Split on entering checkpoint Village)
21. Enter Primagen				// Primagen_Boss.map
22. End (Split on Primagen kill)
100% most likely not even 60% of these can be autosplitted

*/

split
{
	return (
		current.level == vars.portOfAdia9 && old.level == vars.portOblivion 			// split 1
		|| current.level == vars.portTotem && old.level == vars.portOfAdia9 			// split 2
		|| current.level == vars.enterDM && old.level != vars.enterDM 					// split 3
		|| current.level == vars.marshTotem && old.level != vars.marshTotem 			// split 4
		|| current.level == vars.enterROS && old.level != vars.enterROS					// split 5
		|| current.level == vars.riverOfSouls4 && old.level == vars.riverOblivion 		// split 6
		|| current.level == vars.riverTotem && old.level != vars.riverTotem 			// split 7		TEST THIS ONE																// split 7 ROS totem enter
		|| current.level == vars.deathMarsh3 && old.level == vars.marshOblivion
		|| current.level == vars.riverOfSouls4 && old.level == vars.riverOblivion 
		|| current.level == vars.blindLair6 && old.level == vars.blindOblivion
		);

			// new attempt at working code
	if(old.level == vars.primagenCinematic && current.level == vars.primagenBoss)
	{
		if(old.primagenHP == 0 && current.primagenHP == 100)
		{
			++vars.primagenPhase;
		}
		return (vars.primagenPhase == 2 && old.primagenHP != 0 && current.primagenHP == 0);
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
