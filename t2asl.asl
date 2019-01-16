state("horus_x64")
{
	string255 level : 0x7FD2C8, 0x4;
	
	/*
	long primagenHP : 0x7FE064;
	// 0x7FE068;
	*/
} 

/*
The reason for two primagenHP values is that one corresponds to his health in code
 the other the visual of his health bar on screen visible to the player
*/

init
{
	vars.intro = "ls/(6)_cin_adon.map"; // intro cinematic for timer start and the auto reset
	vars.hub = "ls/HUB.map"; // the hub map
	vars.primagenBoss = "ls/Primagen_Boss.map"; // the final boss fight map
	vars.primagenCinematic = "ls/cinema_primagen.map";
	
	vars.portOblivion = "ls/Port_Oblivion.map";
	vars.portOfAdia9 = "ls/Port_Of_Adia_9.map";
	vars.riverOblivion = "ls/River_Oblivion.map";
	vars.riverOfSouls4 = "ls/RiverOfSouls_4.map";
	vars.marshOblivion = "ls/Marsh_Oblivion.map";
	vars.deathMarsh3 = "ls/Death_Marsh_3.map";
	vars.blindOblivion = "ls/Blind_Oblivion.map";
	// TODO get map name 
	vars.hiveOblivion = "ls/Hive_Oblivion.map";
	// TODO get map name
	vars.lightOblivion = "ls/Light_Oblivion.map";
	// TODO get map name
	
	vars.primagenPhase = 0;
}

start
{
	vars.primagenPhase = 0;
	
	return (current.level == vars.intro); // starts timer on intro cinematic after selecting difficulty
}

split
{
	return (current.level == vars.hub && old.level != vars.hub || current.level == vars.portOfAdia9 && old.level == vars.portOblivion || current.level == vars.deathMarsh3 && old.level == vars.marshOblivion || current.level == vars.riverOfSouls4 && old.level == vars.riverOblivion);

/* HUNDO SPLITS
split on leaving oblivion lairs, each is visited once so use hub split method
later keey splits involve travelling from specific levels,need exact pattern to split for
these travels are not in any% so splits will work on either category
*/

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
