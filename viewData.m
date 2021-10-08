% DBS data analysis
[filename, pathname] = uigetfile('*.csv');

data =xlsread([pathname filename]);

figure;
plot(data(:,1))
plot(data(:,1), data(:,2))
for i = 1:4,
subplot(4,1,i);
plot(data(:,1), data(:,i+1))
end
Nfft = 2^12;
Xf = fft(data(:,2), Nfft);
figure;
mean(diff(data(:,1)))
fs = 1/ans
f = [0:2^12-1]/Nfft*fs;
plot(f, abs(Xf))