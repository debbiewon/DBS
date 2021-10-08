% DBS data analysis
% LFP data
[filename, pathname] = uigetfile('*.csv');

dataLFP =xlsread([pathname filename]);

figure;
[v] = datevec(dataLFP(:,1)); %year month day hour minute second
tLFP = v(:,4)*3600 + v(:,5)*60+v(:,6);
lfp = dataLFP(:,2:end);
nCh = size(lfp, 2);
for i = 1:nCh,
subplot(nCh,1,i);
plot(tLFP, lfp(:,i))
end
Nfft = 2^12;
Xf = fft(lfp(:,1), Nfft);
figure;
fs = 1/ mean(diff(dataLFP(:,1)));
f = [0:2^12-1]/Nfft*fs;
plot(f, abs(Xf))