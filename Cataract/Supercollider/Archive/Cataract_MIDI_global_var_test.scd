// MIDI file player infinite loop

~cataract_MIDI_files_path = PathName.new(~cataract_directory +/+ "MIDI/");
~cataract_MIDI_samples_path = PathName.new(~cataract_directory +/+ "Audio/samples/");

(
// read in all the midi files
~cataract_load_MIDI = {
	~cataract_MIDI_files = Array.new();
	~cataract_MIDI_files_path.entries.do({ |path|
		~cataract_MIDI_files = ~cataract_MIDI_files.add(SimpleMIDIFile.read(path.fullPath));
	});
};

// load all the audio samples
~cataract_load_samples = {
	~cataract_samples = Dictionary.new;
	~cataract_MIDI_samples_path.entries.do{
		arg subfolder;
		~cataract_samples = ~cataract_samples.add(
			subfolder.folderName.asSymbol ->
			Array.fill(
				subfolder.entries.size,
				{
					arg i;
					Buffer.read(s, subfolder.entries[i].fullPath);
				}
			)
		);
	};
};

// generate patterns from the MIDI files
~cataract_create_patterns = {
	~cataract_patterns = Array.new();
	~cataract_MIDI_files.do{ |entry|
		entry.postln;
		~cataract_patterns = ~cataract_patterns.add(entry.generatePatternSeqs);
	};
};

// load samples and patterns into Pdefs for playing
~cataract_create_pattern_defs = {
	~cataract_pattern_defs = Array.new();
	~cataract_patterns.do{ |pattern, i|
		~cataract_pattern_defs = ~cataract_pattern_defs.add(
			Pdef(\cataract_instrument ++ i,
				Pbind(
					\instrument, \cataract_sampler,
					\buf, Pfunc({~cataract_samples[i]}),
					[\midinote, \dur, \veloc], Pseq(~cataract_patterns[i][0], inf)
				)
			);
		);
	};
};

~cataract_MIDI_play = {
	~cataract_pattern_defs.do{ |pdef, i|
		pdef.postln;

	};
};
~cataract_MIDI_stop = {
	~cataract_pattern_defs
};
)

~cataract_load_MIDI.();
~cataract_load_samples.();
~cataract_create_patterns.();
~cataract_create_pattern_defs.();
~cataract_MIDI_play.();

~cataract_pattern_defs[0].player.play

~cataract_MIDI_files.size
~cataract_patterns.do{|patt| patt.postln;};
~cataract_patterns[1][0]
~cataract_samples[\bass]

(
Pdef(\blues,
	Pbind(
		\instrument, \cataract_sampler,
		\buf, Pfunc({~cataract_samples[\bass]}),
		[\midinote, \dur, \veloc], Pseq(~cataract_patterns[0], inf)
	)
);
)

p = EventPatternProxy.new;

p.source = Pdef(\blues);
p.play

Pdef(\blues).play;
Pdef(\blues).stop;





