// MIDI file player infinite loop

m=SimpleMIDIFile.read("/Users/tcfr33/Documents/Projects/Portal/MIDI/BBK_tk3.mid");

q = m.generatePatternSeqs;
q[0].size;

~trans = 0;

(
Pdef(\blues,
	Pbind(
	\ctranspose, Pfunc{~trans},
	[\midinote, \dur], Pseq(q[0], inf)
));
)

(
Pdef(\blues,
	Pbind(
	\ctranspose, Pfunc{~trans},
	[\midinote, \dur], Pfunc{~list}
));
)

// edit a list using true false statements (annoying to string ors together
(
~list = q[0].collect({
	arg bit, i;
	if((bit[0]>65) || (bit[0]<62), {['rest',bit[1]]}, {bit});
});
)
~list.size;


//change one or more scale values based on a switch list
(
~case = q[0].collect({
	arg bit, i;
	var out = switch (bit[0],
		'rest', 'rest',
		62, 102,
		65, 2,
		bit[0]
	);
	[out,bit[1]];

})
)

q[0][0][0].note;

((~note.value + ~gtranspose + ~root) / ~stepsPerOctave + ~octave)*12.0
f = {|midinote| midinote / 12.0  ;

f = {arg i; (i+5).postln};

f.value(2);

(
~scale = q[0].collect({
	arg bit, i;
	var out = switch(bit[0],

		bit[0]
	);
	[out, bit[1]];
})
)

Pdef(\blues).play;
Pdef(\blues).stop;
