function [time_vec, dt, fs, f, Xf, time, channels, data] = loadPatientData()

[fname, pname] = uigetfile('*.csv', 'Pick a patient data file');
data = xlsread([pname fname]);

[time, channels] = size(data);
time = data(:,1);

dt = mean(diff(time)); 
fs = round(1/dt);
% time = (0:length(time)-1)/fs;
time_vec = datetime(time, 'convertfrom', 'posixtime', 'Format', 'MM/dd/yy HH:mm:ss.SSS');

e = ceil(log2(fs/0.5));
Nfft = 2^e;
% Nfft = 2^19; 
f = ((0:Nfft-1)/Nfft)*fs; 
Xf = fft(data(:,2:end), Nfft);
