/*
 Cataract Audio

*/



"Starting up Cataract Audio".postln;

// setup variables
~cataract_audio_files_path = PathName.new(~cataract_directory +/+ "Audio/Cataract Falls Trail/chosen/");

// function should be executed when called

(
~cataract_load_buffers = {
	~cataract_audio = Array.new;
	~cataract_audio_files_path.entries.do({ |path|
		~cataract_audio = ~cataract_audio.add(Buffer.read(s,path.fullPath));
	});

	// play all the water sounds
	~cataract_water = Array.new;
	~cataract_audio.do({ |item, i|
		~cataract_water = ~cataract_water.add(
			Synth(\cataract_loopBuf, [
				\out, i,
				\bufnum, ~cataract_audio[i]]
		));
	});
};

~cataract_release_all = {
	~cataract_close_gates.();
	~cataract_water.do({ |item, i|
		item.free;
	});
	~cataract_audio.do({ |item, i|
		item.free;
	});

};

~cataract_open_gates = {
	~cataract_water.do({ |item, i|
		item.set([\gate, 1];
	});
};

~cataract_close_gates = {
	~cataract_water.do({ |item, i|
		item.set([\gate, 0];
	});
};

)