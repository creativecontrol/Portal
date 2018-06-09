//infinite audio file player

//setup the audio server
(
Server.local.options.numOutputBusChannels = 16;
Server.local.options.outputStreamsEnabled;
s.boot;
)
//load in the samples
(
~audio = Array.new;

~folder = PathName.new("/Users/tcfr33/Documents/Projects/Portal/Audio/Cataract Falls Trail/chosen/");


~folder.entries.do({
	arg path;
	~audio = ~audio.add(Buffer.read(s,path.fullPath));

});
)

//audio file buffer looper
(
SynthDef(\loopBuf, {| out = 0, bufnum = 0 |
    Out.ar(out,
        PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), loop:1)
    )
}).add
)

// play all the water sounds
(
~water=Array.new;
~audio.do({ |item, i|
	~water=~water.add(Synth(\loopBuf, [\out, i, \bufnum, ~audio[i]]));
})

)

//kill the water
(
~water.do({|bit| bit.free; });
)


