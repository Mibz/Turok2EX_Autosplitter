state("horus_x64")
{
	// level ID but not the title unlike the first turok, havent tracked title down so no auto reset yet
	string255 level : 0x7FD2C8, 0x4; 
	long primagenHP : 0x7FE064; // was a static address POGGERS
// 0x7FE068; // , 0x0; i am quite sure it was no offset
} 

init
{
	vars.intro = "ls/(6)_cin_adon.map"; // intro cinematic for timer start
	vars.hub = "ls/HUB.map";
	vars.primagenBoss = "ls/Primagen_Boss.map"; // the final boss fight map
	vars.primagenPhase = 0; //set counter for the three phases of the final boss fight
}

start
{
	vars.primagenPhase = 0; // set variable back to zero - thought this may have been why it only worked the first time
	return (current.level == vars.intro); // starts timer on intro cinematic after selecting difficulty
}

split
{
	// splits on entering the hub
	return (current.level == vars.hub && old.level != vars.hub); 

	// splits on primagen's health reaching zero on the last phase - UPDATE: broke it, dont know how 
	if(old.level == vars.primagenBoss && current.level == vars.primagenBoss)
	{
		if(old.primagenHP == 0 && current.primagenHP == 100) {++vars.primagenPhase;}
		return (vars.primagenPhase == 2 && old.primagenHP != 0 && current.primagenHP == 0);
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

}

update
{

}
