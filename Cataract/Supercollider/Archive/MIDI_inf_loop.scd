// MIDI file player infinite loop

m=SimpleMIDIFile.read("/Users/tcfr33/Downloads/2018-05-25_133436_01.mid");  //midi seq in [1]
m=SimpleMIDIFile.read("/Users/tcfr33/Documents/Projects/Portal/MIDI/BBK_tk1.mid"); //midi seq in [0]
m.noteEvents
q = m.generatePatternSeqs;

// Sound buffer player
(
SynthDef(\bpfbuf, {
	|atk=0, sus=2.5, rel=1, c1=1, c2=(-1), buf=0, rate=1, spos=0, freq=40, rq=1, bpfmix=0, pan=0, veloc=1, out=0, note=1, loop=0|
	var sig, env;
	//env = EnvGen.kr(Env([0,1,1,0], [atk,sus,rel], [c1,0,c2]), doneAction:2);
	env = EnvGen.kr(Env.linen(atk,sus,rel), doneAction:2);
	sig = PlayBuf.ar(1, buf, rate*BufRateScale.kr(buf)*note, startPos:spos, loop:loop);
	//sig = XFade2.ar(sig, BPF.ar(sig, freq, rq, 1/rq.sqrt), bpfmix*2-1);
	sig = sig*env;
	sig = Pan2.ar(sig, pan, veloc/127);
	Out.ar(out, sig);
}
).add;
)

// Read all samples in
(
b=[];
b = Dictionary.new;
PathName("/Users/tcfr33/Documents/Projects/Portal/Audio/Cataract Falls Trail/samples").entries.do{
	arg subfolder;
	b.add(
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
)

~trans = 0;
(
Pdef(\blues,
	Pbind(
		\instrument, \bpfbuf,
		\buf, b[\bass],
		\note, 61,
		[\midinote, \dur, \veloc], Pseq(q[1], inf)
	)
);
)

(
Pdef(\blues,
	Pbind(
	\instrument, \singrain,
	\ctranspose, Pfunc{~trans},
	[\midinote, \dur], Pseq(q[1], inf)
));
)

(
Pdef(\blues,
	Pbind(
	\ctranspose, Pfunc{~trans},
		[\midinote, \dur], Pseq(q[0], inf).select({|note| 60 < note < 63})
));
)

Pdef(\blues).play;
Pdef(\blues).stop;





