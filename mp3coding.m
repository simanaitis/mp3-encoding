clear y Fs  

% Read file info into
filename = 'ChillingMusic.wav';
[sampleData,samplingRate] = audioread(filename);

% Extract a segment of it
duration = round(0.0004*samplingRate); % 400 ms
audioSegment = sampleData(1:5500+duration-1);

% Plot it in a time domain
figure(1);
plot(audioSegment); 
title('Time domain');

% Apply FFT transformation convert from time domain to fq domain
df=samplingRate/length(audioSegment);
frequency_audio=-samplingRate/2:df:samplingRate/2-df; % f % frequency points
FFT_audio_in=fftshift(fft(audioSegment))/length(fft(audioSegment));

% Plot it in frequency domain
figure(2);
plot(frequency_audio,mag2db(abs(FFT_audio_in)));
title('Frequency domain');
xlabel('Frequency(Hz)');
ylabel('Power (DB)');



