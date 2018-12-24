state("horus_x64")
{
	string255 level : 0x7FD2C8, 0x4;
	long primagenHP : 0x7FE064; // was a static address POGGERS
// 0x7FE068; // , 0x0;
} 

init
{
	vars.intro = "ls/(6)_cin_adon.map";
	vars.hub = "ls/HUB.map";
	vars.primagenBoss = "ls/Primagen_Boss.map";
	vars.primagenPhase = 0;
}

start
{
	vars.primagenPhase = 0;
	return (current.level == vars.intro); // starts on intro cinematic after selecting difficulty
}

split
{
	// splits on entering the hub
	return (current.level == vars.hub && old.level != vars.hub); 

	// splits on primagen's health reaching zero on the last phase
	if(old.level == vars.primagenBoss && current.level == vars.primagenBoss)
	{
		if(old.primagenHP == 0 && current.primagenHP == 100) ++vars.primagenPhase;
		return vars.primagenPhase == 2 && old.primagenHP != 0 && current.primagenHP == 0;
	}
	
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
	timer.IsGameTimePaused = true; 
}

update
{

}
