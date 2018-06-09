/*
 Cataract Startup

 If you get a message to start a piece that is not you fade out and stop

*/
"Starting up Composition: Cataract".postln;
(

~cataract_directory = ~project_directory +/+ "Cataract/";

~cataract_startup_files = [
	"Cataract_Defs.scd",
	"Cataract_Audio.scd",
	"Cataract_MIDI.scd"
];

~cataract_startup_files.do{ |afile|
	afile = ~cataract_directory +/+ "Supercollider" +/+ afile;
	afile = afile.standardizePath;
	if(File.exists(afile), {afile.load});
};

// setup
~cataract_play = {
	~cataract_MIDI.play();
	~cataract_audio.play();
};
~cataract_stop = {
	~cataract_MIDI.stop();
};
~cataract_free = {
	~cataract_MIDI.free();
};

)