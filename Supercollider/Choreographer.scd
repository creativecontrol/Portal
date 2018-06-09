/*
Portal Choreographer

This is the main entry point for the portal audio program

*/

// Setup and boot the Server
Server.local.options.numOutputBusChannels = 16;
Server.local.options.outputStreamsEnabled;
s.boot;

// Setup OSC controls for the Choreographer
// use the standard port for listening 57120
~oscaddress = NetAddr("127.0.0.1", 57120);

(
// piece 1
OSCdef.new(\piece1, { |msg|
	switch(msg[1], play, {~cataract_play.()}, stop, {~cataract_stop.()}, "unknown call".postln)}, '/piece1');
// piece2
OSCdef.new(\piece2, { |msg|
	switch(msg[1], \play, {"playing".postln}, \stop, {"stop".postln}, {"unknown call".postln});}, '/piece2');
// piece3
OSCdef.new(\piece3, { |msg|
	switch(msg[1], \play, {"playing".postln}, \stop, {"stop".postln}, {"unknown call".postln});}, '/piece3');
)
