/*
*/

(
~cataract_audio = (
	cataract_audio_files_path: PathName.new(~cataract_directory +/+ "Audio/Cataract Falls Trail/chosen/"),
	cataract_audio: Array.new(),
	cataract_water: Array.new(),
	init: { |self|
		self.load_buffers();
		self.play_sounds();
	},
	load_buffers: { |self|
		self.cataract_audio_files_path.entries.do({ |path|
			self.cataract_audio = self.cataract_audio.add(Buffer.read(s,path.fullPath));
		});
	},
	play_sounds: { |self|
		self.cataract_audio.do({ |item, i|
			self.cataract_water = self.cataract_water.add(
				Synth(\cataract_loopBuf, [
				\out, i,
				\bufnum, ~cataract_audio[i]]
			));
		})
	},
	play: { |self|
		self.cataract_water.do({ |item, i|
			item.set([\gate, 1];
		});
	},
	stop: { |self|
		self.cataract_water.do({ |item, i|
			item.set([\gate, 0];
		});
	},
	free: { |self|
		self.stop();
		self.cataract_water.do({ |item, i|
			item.free;
		});
		self.cataract_audio.do({ |item, i|
			item.free;
		});
	}
)
)
