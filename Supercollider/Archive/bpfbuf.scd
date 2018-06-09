(
SynthDef(\bpfbuf, {
	|atk=0, sus=2.5, rel=1, c1=1, c2=(-1), buf=0, rate=1, spos=0, freq=40, rq=1, bpfmix=0, pan=0, amp=1, out=0, note=1, loop=0|
	var sig, env;
	//env = EnvGen.kr(Env([0,1,1,0], [atk,sus,rel], [c1,0,c2]), doneAction:2);
	env = EnvGen.kr(Env.linen(atk,sus,rel), doneAction:2);
	sig = PlayBuf.ar(1, buf, rate*BufRateScale.ir(buf)*note, startPos:spos, loop:loop);
	//sig = XFade2.ar(sig, BPF.ar(sig, freq, rq, 1/rq.sqrt), bpfmix*2-1);
	sig = sig*env;
	sig = Pan2.ar(sig, pan, amp);
	Out.ar(out, sig);
}
).add;
)