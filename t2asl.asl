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
	
	// vars.primagenPhase = 0;
}

start
{
	// vars.primagenPhase = 0;
	
	return (current.level == vars.intro); // starts timer on intro cinematic after selecting difficulty
}

split
{
	return (current.level == vars.hub && old.level != vars.hub); 

	/*
	if(old.level == vars.primagenBoss && current.level == vars.primagenBoss)
	{
		if(old.primagenHP == 0 && current.primagenHP == 100) {++vars.primagenPhase;}
		return (vars.primagenPhase == 2 && old.primagenHP != 0 && current.primagenHP == 0);
	}
	*/
	
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
