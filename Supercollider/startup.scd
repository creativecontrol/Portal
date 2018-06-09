/*
 startup file for portal
   1. start the server
   2. set up audio and busses
   3. set up OSC controls
   4. load each project startup
*/

~project_directory = "/Users/tcfr33/Documents/Projects/Portal/";

~compositions = ["Cataract","Demo"]

~startup_files = [
	"SuperCollider/Choreographer.scd",
	"SuperCollider/Sensor_Control.scd",
	"Cataract/Cataract_Startup.scd",
];

~startup_files.do{ |afile|
	afile = ~project_directory +/+ afile;
	afile = afile.standardizePath;
	if(File.exists(afile), {afile.load});
}