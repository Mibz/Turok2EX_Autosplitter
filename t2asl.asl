state("horus_x64")
{
	string255 level : 0x7FD2C8, 0x4;
	long bossHP : 0x7FE064; // This location used for all bosses health when active
	// 0x7FE068;
} 

/*
The reason for two primagenHP values is that one corresponds to his health in code
 the other the visual of his health bar on screen visible to the player
*/

init
{
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
	vars.marshOblivion = "ls/Marsh_Oblivion.map";
	vars.deathMarsh3 = "ls/Death_Marsh_3.map";
	
		// HIVE OF THE MANTIDS LOCATIONS
	vars.enterHIVE = "ls/cinema_5_top.map";
	vars.hiveOblivion = "ls/Hive_Oblivion.map";
	vars.hive4 = "ls/Hive_4.map";
	vars.hiveBreedingGrounds = "ls/Hive_8.map";

		// LAIR OF THE BLIND ONES LOCATIONS
	vars.blindEntrance = "ls/Blind_Lair_1.map";
	vars.enterLAIR = "ls/cinema_4_A.map";
	vars.blindOblivion = "ls/Blind_Oblivion.map";
	vars.blindLair6 = "ls/Blind_Lair_6.map";
	vars.blindTotem = "ls/Blind_Totem.map";	
	vars.blindBoss = "ls/Blind_One_Boss.map";

		// LIGHTSHIP LOCATIONS
	vars.enterLS = "ls/cinema_6_E.map";
	vars.lightOblivion = "ls/Light_Oblivion.map";
	vars.light10 = "ls/Lightship_10.map";
	vars.primagenBoss = "ls/Primagen_Boss.map"; 		// the final boss fight map
	vars.primagenCinematic = "ls/cinema_primagen.map";
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
		current.level == vars.portOfAdia9 && old.level == vars.portOblivion 			// split on leaving Oblivion lair in Port of Adia
		|| current.level == vars.portTotem && old.level == vars.portOfAdia9				// split on entering POA Totem
		|| current.level == vars.enterDM && old.level != vars.enterDM 					// split Death Marshes portal entered
		|| current.level == vars.marshTotem && old.level == vars.deathMarsh3 			// split on entering the DM Totem 
		|| current.level == vars.enterROS && old.level != vars.enterROS					// split River Of Souls portal entered
		|| current.level == vars.riverOfSouls4 && old.level == vars.riverOblivion 		// split leaving Oblivion Lair
		|| current.level == vars.riverTotem && old.level == vars.riverOfSouls8 			// split ROS totem enter
		|| current.level == vars.enterHIVE && old.level != vars.enterHIVE 				// split on entering HIVE portal
		|| current.level == vars.hive4 && old.level == vars.hiveOblivion 				// split on leaving Hive Oblivion Room
		|| current.level == vars.enterLAIR && old.level != vars.enterLAIR				// split on entering blind ones portal
		|| current.level == vars.blindLair6 && old.level == vars.blindOblivion			// split on leaving Lair Oblivion Room
		|| current.level == vars.blindTotem && old.level == vars.blindLair6				// split on entering Blind Totem
		// 13. Blind One (Split on kill) NOT POSSIBLE YET - FOLLOWING SPLIT IS WHEN GROWTH SPLITS IN VOD https://www.twitch.tv/videos/364886943
		|| current.level == vars.enterLS && old.level != vars.enterLS					// split on entering LS portal -- DELETE WHEN BOSS DEATH SPLIT DONE
		|| current.level == vars.light10 && old.level == vars.lightOblivion				// split on leaving lightship oblivion lair
		// 15. Mother (Split on kill) NOT POSSIBLE YET
		|| current.level == vars.hub && old.level == vars.mother						// split on returning to the HUB after mother fight
		|| current.level == vars.hiveTotem && old.level == vars.hiveBreedingGrounds		// split entering Hive Totem
		// 17. Queen (Split on kill) NOT POSSIBLE YET
		|| current.level == vars.deathMarsh3 && old.level == vars.marshOblivion			// split on leaving Oblivion lair of Death Marshes
		|| current.level == vars.deathMarsh3 && old.level == vars.adonSavePortal		// DM trip 2
		|| current.level == vars.blindEntrance && old.level == vars.adonSavePortal
		|| current.level == vars.portVillage && old.level == vars.adonSavePortal		// split on warping from hub to adia village (PoA Trip 2)
		|| current.level == vars.hiveBreedingGrounds && old.level == vars.adonSavePortal // split on hive trip 2 
		// delete whichever growth chooses 
		|| current.level == vars.primagenCinematic && old.level == vars.hub				// splits on the final fight cinematic beginning
		|| current.level == vars.primagenBoss && old.level == vars.primagenCinematic	// splits on the final fight beginning
		
		/*
	UNABLE TO DO AT THIS TIME
	
	13. Blind One (Split on kill)
	15. Mother (Split on kill)
	17. Queen (Split on kill)
	22. End (Split on Primagen kill)
		*/
		);
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
