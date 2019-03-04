clear y Fs  

filename = 'ChillingMusic.wav';
[sampleData,samplingRate] = audioread(filename, 'native');
% Sampling data is two dimensional array


% cut 4 sec
% Maybe I am doing something wrong cause
% Povilas: ok, toliau kai prieš konvertuojant i dažniu erdve reikia prideti 0 padding ?
% Kestutis Jankauskas: o kam?
% Kestutis Jankauskas: konvertuoji gi ne visa informacija iš karto, o po porcija
% Kestutis Jankauskas: Paddingas naudojamas, jei didesnes raiškos dažniu erdveje reikia
% sampleData = originalSampleData(1:(samplingRate*4));

% sound(sampleData,samplingRate);
figure(1);
    
% Signal in time domain
duration = length(sampleData)/samplingRate;
plot(sampleData); 

% Signal in frequency domain
figure(2);
FFT_audio_in=fftshift(fft(sampleData))/length(fft(sampleData));
plot(frequency_audio,abs(FFT_audio_in));
title('FFT of Input Audio');
xlabel('Frequency(Hz)');
ylabel('Power (Amplitude)');

% Apply psycho accustic mode:
% 1) apply masking of similar frequencies
% by filtering out similar fq bins if they fall threshold of given fq power

% Povilas: kaip apskaiciuoti masking threshold ?
% Kestutis Jankauskas: Pats neskaiciavau niekada, reikia pasirausti standarte
% Kestutis Jankauskas: turi buti intervalas, kurio ribose aukštos amplitudes konkretus dažnis "uždengia" artimus mažesnes amplitudes dažnius
% Kestutis Jankauskas: Ir dar yra tylos riba.. ty kiekvienas dažnis turi skirtinga amplitudes riba, kur ausis beveik negirdi.. o žemiau - visai negirdi
% Kestutis Jankauskas: bet cia viskas turi atsiremti i konstantu rinkini
% Kestutis Jankauskas: Jis turi buti standarte



% Povilas: Del phantom beat notes, kaip apskaiciuoti varying amplitude ?
% Kestutis Jankauskas: Nemanau kad to reikia
% Kestutis Jankauskas: Cia gaunasi automatiškai, kai panašus dažniai skamba kartu, automatiškai gaunasi periodiniai rezonavimai ir anuliavimai
% Povilas: bet mp3 pakeicia du tokius dažnius vienu, kuriu amplitute kinta, o žmogaus ausis ar orginalus du garsai ar vienas naujas bendras, su kintanciu amplitute, girdi taip pat, tai pat mp3 sutaupo atminties 
% Kestutis Jankauskas: Jei spesit, galima
% Povilas: tai demo coding ketinu padaryti taip 1) nuskaitau wav faile atsikerpu 4 sec 2) nupiešiu time domain grafika 3) ftt ir nupiešiu frequency domain grafika 4) panaudoju masking threshold nupiešiu nauja frequency grafika. Dar galvojau, pritaikyit phantom beat notes ir intermodulation.
% Kestutis Jankauskas: Šiaip standarte turetu buti irašyta, jei nerasit - galima sugalvot formule
% Kestutis Jankauskas: Na butu labai faina, jei spetum..
% Kestutis Jankauskas: Bet cia laikyk kaip rezerva


