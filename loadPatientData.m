function [time_vec, fs, channels, data] = loadPatientData()

[fname, pname] = uigetfile('*.csv', 'Pick a patient data file');
data = xlsread([pname fname]);

[time, channels] = size(data);
time = data(:,1);

dt = mean(diff(time)); 
fs = round(1/dt);
% time = (0:length(time)-1)/fs;
% time_vec = datetime(time, 'convertfrom', 'posixtime', 'Format', 'MM/dd/yy HH:mm:ss.SSS');
time_vec = datetime(time,'ConvertFrom','epochtime','Epoch','1970-01-01','TicksPerSecond',1,'TimeZone','UTC');
% time_vec = datetime(time,'ConvertFrom','epochtime','Epoch','1970-01-01','TicksPerSecond',1,'TimeZone','America/New_York');