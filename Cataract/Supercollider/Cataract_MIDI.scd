/*
 Cataract MIDI

 TODO: add scale filtering
*/

(
~cataract_MIDI = (
	cataract_MIDI_files_path: PathName.new(~cataract_directory +/+ "MIDI/"),
	cataract_MIDI_samples_path: PathName.new(~cataract_directory +/+ "Audio/samples/"),
	cataract_MIDI_files: Array.new(),
	cataract_samples: Dictionary.new(),
	cataract_patterns: Array.new(),
	cataract_pattern_defs: Array.new(),
	init: { |self|
		"initializing cataract".postln;
		self.load_MIDI();
		self.load_samples();
		self.create_patterns();
		self.create_patterns_defs();
	},
	// load all MIDI file
	load_MIDI: { |self|
		self.cataract_MIDI_files_path.entries.do({ |path|
			self.cataract_MIDI_files = self.cataract_MIDI_files.add(SimpleMIDIFile.read(path.fullPath));
		});
	},
	load_samples: { |self|
		self.cataract_MIDI_samples_path.entries.do({ |subfolder|
			self.cataract_samples = self.cataract_samples.add(
				subfolder.folderName.asSymbol -> Array.fill(
					subfolder.entries.size, { |i|
						Buffer.read(s, subfolder.entries[i].fullPath);
				})
			);
		});
	},
	create_patterns: { |self|
		self.cataract_MIDI_files.do({ |entry|
			self.cataract_patterns = self.cataract_patterns.add(entry.generatePatternSeqs);
		});
		// free the MIDI files, they are not needed anymore
		self.cataract_MIDI_files = Array.new();
	},
	create_pattern_defs: { |self|
		self.cataract.patterns.do({ |pattern, i|
			self.cataract_pattern_defs = self.cataract_pattern_defs.add(
				Pdef(\cataract_instrument ++ i,
					Pbind(
						\instrument, \cataract_sampler,
						\buf, Pfunc({~cataract_samples[i]}),
						[\midinote, \dur, \veloc], Pseq(~cataract_patterns[i][0], inf)
					)
			));
		});
	},
	play: { |self|
		self.cataract.pattern_defs.do({ |pdef, i|
			pdef.play;
		});
	},
	stop: { |self|
		self.cataract.pattern_defs.do({ |pdef, i|
			pdef.stop;
		});
	},
	free: { |self|
		// free all the samples
		self.cataract_samples.do{ |buf|
			buf.free;
		};
	}
) // end of cataract MIDI class
)

~cataract_MIDI.init();
