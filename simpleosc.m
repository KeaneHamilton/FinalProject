fs = 44100; % Hz
BPM =130;




x = readmidi('%PLACE MIDI FILE NAME HERE WITH SINGLE QUOTES%');
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
triangletone= @(l,t) repmat([linspace(-1,1,t*fs/2),linspace(-1,1,t*fs/2)], 1, round(l/t));
sqrtone= @(l,t) repmat([ones(1, floor(t*fs/2)), -1*ones(1, ceil(t*fs/2))], 1, round(l/t));


for iNote = 1 : numel(melodyBeats)
freq = midifreq(melodyNotes(iNote));
duration = melodyBeats(iNote);
offset = (duration/(1/freq))-round(duration/(1/freq));
waveform= sqrtone(duration, 1/freq);
Decay = linspace(1, 0.2,length(waveform));
tone =amp * Decay .* waveform ;
melody = [melody, tone];
end


audiowrite('melodytest.wav',melody, fs);






