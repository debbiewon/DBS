function [f, Xf, Nfft] = fftcalc(input, fs)

e = ceil(log2(fs/0.5));
% e = nextpow2(length(input))
Nfft = 2^e;
% Nfft = 2^19; 

f = ((0:Nfft-1)/Nfft)*fs;
Xf = fft(input, Nfft);
