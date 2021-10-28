%% LFP recordings - pick which filter works best, also nfft
clear;
clc;

[time_vec, fs, channels, data] = loadPatientData();
LFPplot(data, time_vec, channels);

[b,a] = butter(20,40/(fs/2),'low');
lowpass_lfp = filter(b,a, data(:,2:end));
figure;
plot(time_vec, lowpass_lfp)
title('Filtered lowpass LFPs')

% can also do a 7th order 10-40 Hz passband(works fine with fs~500Hz)
[b,a] = butter(7, [10/(fs/2) 40/(fs/2)]);
bandpass_lfp = filter(b,a, data(:,2:end));
figure;
plot(time_vec, bandpass_lfp)
title('Filtered bandpass LFPs')

[f, Xf, Nfft] = fftcalc(data(:,2:end), fs);
figure;
plot(f, abs(Xf))
axis([0 35 -inf inf]) % betas waves are in the 10-32 Hz range
title('Original LFP freq. spectrum')

[f, Xf, Nfft] = fftcalc(lowpass_lfp, fs);
figure;
plot(f, abs(Xf))
axis([0 35 -inf inf])
title('Lowpass LFP freq. spectrum')

% check bandpass, freq spectrum seems off
[f, Xf, Nfft] = fftcalc(bandpass_lfp, fs);
figure;
plot(f, abs(Xf))
axis([0 35 -inf inf])
title('Bandpass LFP freq. spectrum')
%% IPG Internal Motion (acceleration)- plot PSD
clear;
clc;

[time_vec, fs, channels, data] = loadPatientData();
ipg_accel = sqrt(data(:,2).^2 + data(:,3).^2 + data(:,4).^2);

figure;
plot(time_vec, ipg_accel)
title('IPG Internal Acceleration')

% [f, Xf, Nfft] = fftcalc(ipg_accel, fs);
% figure;
% plot(f, abs(Xf))
% title('Acceleration freq. spectrum')

% Nfft = 2^12;
% PSDcalc(ipg_accel,Nfft,fs);

figure;
pwelch(ipg_accel, [], [], [], fs); 
%% Apple Watch Motion (acceleration) - plot PSD
clear;
clc;
[time_vec, fs, channels, data] = loadPatientData();
apple_accel = sqrt(data(:,2).^2 + data(:,3).^2 + data(:,4).^2);

figure;
plot(time_vec , apple_accel)
title('Apple Watch Acceleration (no gravity)')

[f, Xf, Nfft] = fftcalc(apple_accel, fs);
figure;
plot(f, abs(Xf))
title('Acceleration freq. spectrum')

%% Therapy - ok for now
clear;
clc;

[time_vec, fs, channels, data] = loadPatientData();
freq = data(:,2);
therapy = data(:,3);

figure;
subplot(2,1,1);
stem(time_vec , therapy)
title('Therapy State')
ylim([-0.05 1.1])

subplot(2,1,2);
stem(time_vec , freq)
title('Therpay Frequency')

%% Internal Acceleration and Apple Watch Acceleration - plot spectra (fft) and plot the PSD of both accelerations
% Patient 6KOZ has brief overlaps on August 18, 2021
clear;
clc;

[time_vec, fs, channels, data] = loadPatientData();
ipg_accel = sqrt(data(:,2).^2 + data(:,3).^2 + data(:,4).^2);
ipg_time = time_vec;

figure(1);
ax(1) = subplot(2,1,1);
plot(ipg_time, ipg_accel)
title('IPG Internal Acceleration')
Nfft = 2^19;

figure(2);
[ipg_f, ipg_Xf] = fftcalc(ipg_accel, Nfft, fs);
subplot(2,1,1)
plot(ipg_f, abs(ipg_Xf))

[time_vec, fs, channels, data] = loadPatientData();
apple_accel = sqrt(data(:,2).^2 + data(:,3).^2 + data(:,4).^2);
apple_time = time_vec;

figure(1)
ax(2) = subplot(2,1,2);
plot(apple_time, apple_accel)
title('Apple Watch Acceleration')
linkaxes(ax, 'x');

figure(2);
[apple_f, apple_Xf] = fftcalc(apple_accel, Nfft, fs);
subplot(2,1,2)
plot(apple_f, abs(apple_Xf))
axis([0 30 -inf inf])
% align = finddelay(apple_accel, ipg_accel);
%
% figure;
% axes(ax(1));
% plot(apple_accel(align+1:end))

% aligned = alignsignals(apple_accel, ipg_accel);
%
% % this aligns the ends of the signals, don't think that's what we want
% figure;
% subplot(2,1,2)
% plot(aligned)
%
% subplot(2,1,1)
% plot(ipg_accel)

%% LFPs and Internal Accelerataion - ok for now

clear;
clc;

[time_vec, fs, channels, data] = loadPatientData();
lfp_time = time_vec;

figure;
ax(1) = subplot(2,1,1)
plot(lfp_time, data(:,2:end))
title('LFPs')

[time_vec, fs, channels, data] = loadPatientData();
ipg_accel_time = time_vec;
ipg_accel = sqrt(data(:,2).^2 + data(:,3).^2 + data(:,4).^2);

ax(2) = subplot(2,1,2)
plot(ipg_accel_time, ipg_accel)
title('IPG Internal Acceleration')
linkaxes(ax, 'x');

%% LFP, Internal Acceleration and Stimulation Therapy - ok for now
clear;
clc;

[time_vec, fs, channels, data] = loadPatientData();
lfp_time = time_vec;

figure;
ax(1) = subplot(3,1,1);
plot(lfp_time, data(:,2:end))
title('LFPs')
legend('channel 0', 'channel 1', 'channel 2', 'channel 3')

[time_vec, fs, channels, data] = loadPatientData();
ipg_accel = sqrt(data(:,2).^2 + data(:,3).^2 + data(:,4).^2);
ipg_time = time_vec;
ax(2) = subplot(3,1,2);
plot(ipg_time, ipg_accel)
title('IPG Internal Acceleration')

[time_vec, fs, channels, data] = loadPatientData();
time_time = time_vec;
therapy = data(:,3);

ax(3) = subplot(3,1,3);
stem(time_time, therapy)
title('Therapy State')
ylim([-0.05 1.1])
linkaxes(ax, 'x');

%% LFP, Internal Acceleration  and Apple Watch Acceleration - ok for now


[time_vec, fs, channels, data] = loadPatientData();
lfp_time = time_vec;

figure;
ax(1) = subplot(3,1,1);
plot(lfp_time, data(:,2:end))
title('LFPs')
legend('channel 0', 'channel 1', 'channel 2', 'channel 3')

[time_vec, fs, channels, data] = loadPatientData();
ipg_accel = sqrt(data(:,2).^2 + data(:,3).^2 + data(:,4).^2);
ipg_time = time_vec;

ax(2) = subplot(3,1,2);
plot(ipg_time, ipg_accel)
title('IPG Internal Acceleration')

[time_vec, fs, channels, data] = loadPatientData();
apple_accel = sqrt(data(:,2).^2 + data(:,3).^2 + data(:,4).^2);
apple_time = time_vec;

ax(3) = subplot(3,1,3);
plot(apple_time, apple_accel)
title('Apple Watch Acceleration')
linkaxes(ax, 'x');