% DBS data analysis
% LFP data
clear all;

[filename, pathname] = uigetfile('*.csv', 'Choose the IPG acceleration data');

data =xlsread([pathname filename]);

% [v] = datevec(data(:,1)); %year month day hour minute second
% t = v(:,4)*3600 + v(:,5)*60+v(:,6);
% 
t = data(:,1);
tConv = datetime(t,'ConvertFrom','epochtime','Epoch','1970-01-01','TicksPerSecond',1,'TimeZone','UTC');
tConv.TimeZone = 'America/New_York';

figure;
accel = data(:,2:end);
nCh = size(accel, 2);
for i = 1:nCh,
subplot(nCh,1,i);
plot(tConv, accel(:,i))
end

[filename, pathname] = uigetfile('*.csv', 'Choose the Apple Watch acceleration data');

dataApple =xlsread([pathname filename]);
tApp = dataApple(:,1);
tConvApp = datetime(tApp,'ConvertFrom','epochtime','Epoch','1970-01-01','TicksPerSecond',1,'TimeZone','UTC');

figure;
accelApp = dataApple(:,2:end);
nCh = size(accel, 2);
for i = 1:nCh,
subplot(nCh,1,i);
plot(tConvApp, accelApp(:,i))
end

labels = {'a_x' 'a_y' 'a_z'}
figure;
for i = 1:nCh,
subplot(nCh,1,i);
plot(tConv, accel(:,i))
hold on;
plot(tConvApp, accelApp(:,i))
ax = gca;
ax.XAxis.Limits = [tConvApp(1) tConvApp(end)];
ylabel(labels{i});
end

% Nfft = 2^12;
% Xf = fft(lfp(:,1), Nfft);
% figure;
% fs = 1/ mean(diff(data(:,1)));
% f = [0:2^12-1]/Nfft*fs;
% plot(f, abs(Xf))