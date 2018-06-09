/*
 infinite audio file player
 CLI version
 tested as functional for 2 channels 5/31
*/

// setup variables
~audio_files_path = "/Users/tcfr33/Documents/Projects/Portal/Audio/Cataract Falls Trail/chosen/";

// boot the server
//s = Server.local.boot;
Server.default = Server.remote(\remote, NetAddr("127.0.0.1", 57111));
s.boot;

// execute function once server is fully booted
(
s.waitForBoot({
// audio file buffer looper
SynthDef(\loopBuf, {| out = 0, bufnum = 0 |
    Out.ar(out,
        PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), loop:1)
    )
}).add;

//	makes sure the SynthDef is loaded before attempting to use it
s.sync;

~audio = Array.new;

~folder = PathName.new(~audio_files_path);


~folder.entries.do({
	arg path;
	~audio = ~audio.add(Buffer.read(s,path.fullPath));
});

// play all the water sounds

~water=Array.new;

~audio.do({ |item, i|
	~water=~water.add(Synth(\loopBuf, [\out, i, \bufnum, ~audio[i]]));
});
})

)
