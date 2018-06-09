/*
 Cataract Defs

 All definitions for Synths and MIDI

*/
"Loading Cataract Definitions".postln;

(
s.doWhenBooted({
	// audio file buffer looper
	// TODO: need to add a gate for on off
	SynthDef(\cataract_loopBuf, { | out = 0, bufnum = 0, gate = 0 |
		sig = PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), loop:1);
		env = env = EnvGen.kr(Env.asr, gate);
		sig = sig*env;
		Out.ar(out, sig);
	}).add;

	// MIDI Sampler built for samples with a base frequency of 440Hz
	(
		SynthDef(\cataract_sampler, {
			|atk=0, sus=1, rel=0.5, buf=0, midinote=0, rate=1, spos=0,
			pan=0.5, basefreq=440, veloc=1, out=0, note=1, loop=0|
			var sig, env;
			env = EnvGen.kr(Env.linen(atk,sus,rel), doneAction:2);
			sig = PlayBuf.ar(1, buf, rate*BufRateScale.kr(buf)*
				(midinote.midicps/basefreq), startPos:spos, loop:loop);
			sig = sig*env;
			sig = Pan2.ar(sig, pan, veloc);
			Out.ar(out, sig);
		}
		).add;
	)

	//	makes sure the SynthDef is loaded before attempting to use it
	s.sync;

})
)