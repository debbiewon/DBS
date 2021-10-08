% DBS data analysis
% LFP data
[filename, pathname] = uigetfile('*.csv');

data =xlsread([pathname filename]);

figure;
[v] = datevec(data(:,1)); %year month day hour minute second
t = v(:,4)*3600 + v(:,5)*60+v(:,6);

accel = data(:,2:end);
nCh = size(accel, 2);
for i = 1:nCh,
subplot(nCh,1,i);
plot(t, accel(:,i))
end
Nfft = 2^12;
Xf = fft(lfp(:,1), Nfft);
figure;
fs = 1/ mean(diff(data(:,1)));
f = [0:2^12-1]/Nfft*fs;
plot(f, abs(Xf))