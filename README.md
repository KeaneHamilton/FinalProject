# FinalProject

**My actual product is simpleosc.m I use two of the other included .m scripts but they all have cross-dependencies so I had to inclued them all**

**I have also included some MIDI files for you to run you can also use your own but they must be single track**

This program takes a single track MIDI input and produces a desired audio output with a sampling rate (Fs). Most
simply, it parses through the input file to gain note frequency and length,and writes these values to other matrices
where a loop runs through each pair of values and produces a tone. In the following I will go more in depth on the
aforementioned steps.

MIDI PARSING:

This program uses a set of matlab scripts optained from https://github.com/kts/matlab-midi/tree/master/src to read
and gather information from MIDI files. I had planned on writing my own scripts for reading MIDI but this was
available and convenient. The readmidi () function reads a midi file into memory and the midiInfo() function produces
a matrix of note events which include, among other elements: note, note start time, and note end time. I then write
this information to a new matrix where I subtract note start time form note end time, yielding me a matrix of notes
and note lengths. Notes are written to melodyNotes and note lengths are written to melodyBeats.


WAVEFORM AND TONE GENERATION:

The function sawtone produces a sawtooth waveform for a given note length (l) and period (t). The following for loop
increments through melodyBeats and melodyNotes, producing a tone for each pair. The input from melodyBeats is length
in seconds. The input from melodyNotes is an integer bellow 127 which is then converted into a frequency using the
midifreq () function based on the MIDI protocol. After generated the tone is multiplied by an amplitude coefficient
to control the volume of the output. The tone is also multiplied by a Decay matrix, a simple linear downramp, to
lower the amplitude of the tone as time passes, giving more definition to each note.After the tone is generated it is
passed to melody[] to be stored for later.

The audiowrite function is then used to output the values stored in melody[] at the given sample rate.
