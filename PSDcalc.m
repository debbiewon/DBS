% needs work
function  [] = PSDcalc(input,Nfft,fs)

figure;
N = length(input);
for len = 100:400:N; 
%     window = kaiser(len, 4.53);
    Lwin = round((len/1000)*fs);
    window = hamming(Lwin);
    noverlap = round(0.5*Lwin);
    pwelch(input, window, [], [], fs); % [] = default values 
%     title(sprintf('Hamming Window size:%d ms window', window_size));
    pause;
end