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
frequency_points=-samplingRate/2:df:samplingRate/2-df; % frequency points
FFT_audio_in=fftshift(fft(audioSegment))/length(fft(audioSegment));
freqency_magniute=abs(FFT_audio_in);
freqency_magniute_in_decibels=abs(mag2db(freqency_magniute));

% Plot it in frequency domain
figure(2);
plot(frequency_points,freqency_magniute_in_decibels);
title('Frequency domain');
xlabel('Frequency(Hz)');
ylabel('Power (DB)');

% Apply psycho accustic model: 
% Part 1 masking of similar frequencies
% Convert frequency_points to barks
barks = arrayfun(@calculateBark, frequency_points);

index = 1;
indexToRemove = [];
for bark = barks
    comparingToIndex = 1;
    for comparingToBark = barks
        if comparingToBark == bark
            comparingToIndex = comparingToIndex + 1;
            continue
        end
        delta_critical_band_rate_difference = comparingToBark - bark;
        volume_of_comparing_to_bark = freqency_magniute_in_decibels(comparingToIndex);
        volume_of_current_bark =  freqency_magniute_in_decibels(index);
        if(isBelowThreshold(delta_critical_band_rate_difference, volume_of_current_bark, volume_of_comparing_to_bark))
            indexToRemove = [indexToRemove, index];
            break
        end
        comparingToIndex = comparingToIndex + 1;
    end
    index = index + 1;
end

% Remove masked frequencies 
frequency_points(indexToRemove)=[];
freqency_magniute_in_decibels(indexToRemove)=[];

% Plot it
figure(3);
plot(frequency_points,freqency_magniute_in_decibels);
title('Frequency domain without masked frequencies');
xlabel('Frequency(Hz)');
ylabel('Power (DB)');


function y = calculateBark(x)
    y = 13*atan(0.00076/ x) + 3.5*atan((x/7500)^2);
end

function is = isBelowThreshold(delta, a_volume, b_volume)
%    THIS PART HAVEN'T BEEN IMPLEMENTED YET
    is = 0 > 1;
%     if delta > -14 && delta < -12 
%         is = not(b_volume < 45) || a_volume > 83;
%        
%     end
end




