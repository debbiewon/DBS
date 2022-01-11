%% Load in data
clc;
clear;
close all;

lfp_data = datastore('C:\Users\eroja\Downloads\patientE395_oct072021_neural_data.csv','Type','tabulartext');
LFPdata = readall(lfp_data);
LFPdata = LFPdata.Variables;

apple_data = datastore('C:\Users\eroja\Downloads\patientE395_oct072021_apple_accel.csv','Type','tabulartext');
apple_accel = readall(apple_data);
apple_accel = apple_accel(:,2:end).Variables;

ipg_accel_data = datastore('C:\Users\eroja\Downloads\patientE395_oct072021_ipg_accel.csv','Type','tabulartext');
ipg_accel = readall(ipg_accel_data);
ipg_accel = ipg_accel(:,2:end).Variables;

% lfp_dt = mean(diff(LFPdata(:,1))); 
% LFP_fs = round(1/lfp_dt);
% apple_dt = mean(diff(apple_accel(:,1))); 
% apple_fs = round(1/apple_dt);
% ipg_accel_dt = mean(diff(ipg_accel(:,1))); 
% ipg_accel_fs = round(1/ipg_accel_dt);

%% Split data
splitamt = 0.6;
Nlfp = size(LFPdata, 1);
Napple= size(apple_accel, 1);
Nipg_accel = size(ipg_accel,1);

Nlfpsplit = round(Nlfp*splitamt);
Napplesplit = round(Napple*splitamt);
Nipg_accelsplit = round(Nipg_accel*splitamt);

lfp_train = LFPdata(1:Nlfpsplit,2:end);
lfp_test = LFPdata(Nlfpsplit+1:end,2:end);
apple_trainaccel = apple_accel(1:Napplesplit,2:end);
apple_testaccel = apple_accel(Napplesplit+1:end,2:end);
ipg_trainaccel = ipg_accel(1:Nipg_accelsplit,2:end);
ipg_testaccel = ipg_accel(Nipg_accelsplit+1:end, 2:end);

tLFP = datetime(LFPdata(1:Nlfpsplit,1),'ConvertFrom','epochtime','Epoch','1970-01-01','TicksPerSecond',1,'TimeZone','UTC');
tLFP.TimeZone = 'America/New_York';

tapple = datetime(apple_accel(1:Napplesplit,1),'ConvertFrom','epochtime','Epoch','1970-01-01','TicksPerSecond',1,'TimeZone','UTC');
tapple.TimeZone = 'America/New_York';

tipg_accel = datetime(ipg_accel(1:Nipg_accelsplit,1),'ConvertFrom','epochtime','Epoch','1970-01-01','TicksPerSecond',1,'TimeZone','UTC');
tipg_accel.TimeZone = 'America/New_York';
%% Filter LFPs
% ax(1) = subplot(2,1,1);
% plot(tLFP, lfp_train)
% title('Original LFPs')

% [b,a] = butter(7, [10/(LFP_fs/2) 40/(LFP_fs/2)]);
% bandpass_lfp = filter(b,a, lfp_train);
% ax(2) = subplot(2,1,2);
% plot(tLFP, bandpass_lfp)
% title('Filtered bandpass LFPs')
% linkaxes(ax,'x');
%% Plot apple watch and IPG acceleration
APPLE_accel = sqrt(apple_trainaccel(:,1).^2 + apple_trainaccel(:,2).^2 + apple_trainaccel(:,3).^2);
figure;
ax(1) = subplot(2,1,1);
% plot(tapple, APPLE_accel)
plot(tapple, apple_trainaccel)

IPG_accel = sqrt(ipg_trainaccel(:,1).^2 + ipg_trainaccel(:,2).^2 + ipg_trainaccel(:,3).^2);
ax(2) = subplot(2,1,2);
% plot(tipg_accel, IPG_accel)
plot(tipg_accel, ipg_trainaccel)
% linkaxes(ax,'x');