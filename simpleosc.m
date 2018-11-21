fs = 44100; % Hz
BPM =130;




x = readmidi('SadMachine.mid');
y = midiInfo(x);
y(:,[1,2,4,7,8])= [];
z = [y(:,1), y(:,3) - y(:,2)];



midifreq = @(m) 440*2.^((m-69)/12);
amp = 1/3;

melodyBeats = z'(2,:);
melodyNotes = z'(1,:);
melody = [];

beats2sec = @(b) b * (1/BPM) * 60;

sawtone= @(l,t) repmat(linspace(-1,1,t*fs), 1, round(l/t));



for iNote = 1 : numel(melodyBeats)
freq = midifreq(melodyNotes(iNote));
%duration = beats2sec(melodyBeats(iNote));
duration = melodyBeats(iNote);
offset = (duration/(1/freq))-round(duration/(1/freq));
waveform= sawtone(duration, 1/freq);
D = linspace(1, 0.2,length(waveform));
tone =amp * D .* waveform ;
melody = [melody, tone];
end


audiowrite('melodytest.wav',melody, fs);





triwaveform= [linspace(-1, 1, T/2),linspace(1,-1,T/2)];
tone4= repmat(1/3.* sqrwaveform, 1, 1000);
tone5= repmat(1/3.* sawwaveform, 1, 1000);
tone6= repmat(1/3.* triwaveform, 1, 1000);
tone = (1/3)*sin(2*pi*freq1 * (1:fs)/ fs);
tone2 = (1/3)*sin(2*pi*freq2 * (1:fs)/ fs);
tone3 = (1/3)*sin(2*pi*freq3 * (1:fs)/ fs);


[1.5,1.5,1.5,0.5,0.5,1,0.5,0.5,1.5,1.5,1.5,0.5,0.5,1,0.5,0.5];
[63,63,63,70,67,70,67,65,63,63,63,70,67,70,67,65];
