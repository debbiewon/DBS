clc;
clear;

[filename, pathname] = uigetfile('*.csv', 'Choose the LFP data');

dataLFP=xlsread([pathname filename]);
tLFP = dataLFP(:,1);
tConvLFP= datetime(tLFP,'ConvertFrom','epochtime','Epoch','1970-01-01','TicksPerSecond',1,'TimeZone','UTC');
tConvLFP.TimeZone = 'America/New_York';

figure;
LFP = dataLFP(:,2:end);
plot(tConvLFP, LFP)
title('LFP')

[filename, pathname] = uigetfile('*.csv', 'Choose the IPG acceleration data');

data =xlsread([pathname filename]);
t = data(:,1);
tConv = datetime(t,'ConvertFrom','epochtime','Epoch','1970-01-01','TicksPerSecond',1,'TimeZone','UTC');
tConv.TimeZone = 'America/New_York';

figure;
accel = data(:,2:end);
plot(tConv, accel)
title('IPG accel')

[filename, pathname] = uigetfile('*.csv', 'Choose the Apple watch data');

dataApp=xlsread([pathname filename]);
tApp= dataApp(:,1);
tConvApp= datetime(tApp,'ConvertFrom','epochtime','Epoch','1970-01-01','TicksPerSecond',1,'TimeZone','UTC');
tConvApp.TimeZone = 'America/New_York';

figure;
App= dataApp(:,2:end);
plot(tConvApp, App)
title('Apple accel')

figure;
subplot(3,1,1)
plot(tConvLFP, LFP)
ylabel('LFP')
subplot(3,1,2)
plot(tConv, accel)
ylabel('IPG acc')
subplot(3,1,3)
plot(tConvApp, App)
ylabel('Apple acc')

ax = gca;
ax.XAxis.Limits = [tConvApp(1) tConvApp(end)];