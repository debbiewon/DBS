function [f, Xf] = fftcalc(input, Nfft, fs)

% e = ceil(log2(fs/0.5));
% Nfft = 2^e;
% Nfft = 2^19; 

f = ((0:Nfft-1)/Nfft)*fs;
Xf = fft(input, Nfft);
