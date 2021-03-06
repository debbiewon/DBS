%% LFP recordings - pick which filter works best, also nfft
clear;
clc;

[LFP_time, LFP_fs, LFP_channels, LFP_data] = loadPatientData();
LFPplot(LFP_data, LFP_time, LFP_channels);

[b,a] = butter(20,40/(LFP_fs/2),'low');
lowpass_lfp = filter(b,a, LFP_data(:,2:end));
figure;
plot(LFP_time, lowpass_lfp)
title('Filtered lowpass LFPs')

% can also do a 7th order 10-40 Hz passband(works fine with fs~500Hz)
[b,a] = butter(7, [10/(LFP_fs/2) 40/(LFP_fs/2)]);
bandpass_lfp = filter(b,a, LFP_data(:,2:end));
figure;
plot(LFP_time, bandpass_lfp)
title('Filtered bandpass LFPs')

[f, Xf, Nfft] = fftcalc(LFP_data(:,2:end), LFP_fs);
figure;
plot(f, abs(Xf))
axis([0 35 -inf inf]) % betas waves are in the 10-32 Hz range
title('Original LFP freq. spectrum')

[f, Xf, Nfft] = fftcalc(lowpass_lfp, LFP_fs);
figure;
plot(f, abs(Xf))
axis([0 35 -inf inf])
title('Lowpass LFP freq. spectrum')

% check bandpass, freq spectrum seems off
[f, Xf, Nfft] = fftcalc(bandpass_lfp, LFP_fs);
figure;
plot(f, abs(Xf))
axis([0 35 -inf inf])
title('Bandpass LFP freq. spectrum')
%% IPG Internal Motion (acceleration)- plot PSD
clear;
clc;

[IPG_time, IPG_fs, IPG_channels, IPG_data] = loadPatientData();
ipg_accel = sqrt(IPG_data(:,2).^2 + IPG_data(:,3).^2 + IPG_data(:,4).^2);

figure;
plot(IPG_time, ipg_accel)
title('IPG Internal Acceleration')

% [f, Xf, Nfft] = fftcalc(ipg_accel, fs);
% figure;
% plot(f, abs(Xf))
% title('Acceleration freq. spectrum')

% Nfft = 2^12;
% PSDcalc(ipg_accel,Nfft,fs);

figure;
pwelch(ipg_accel, [], [], [], IPG_fs); 
%% Apple Watch Motion (acceleration) - plot PSD
clear;
clc;
[apple_time, apple_fs, apple_channels, apple_data] = loadPatientData();
apple_accel = sqrt(apple_data(:,2).^2 + apple_data(:,3).^2 + apple_data(:,4).^2);

figure;
plot(apple_time , apple_accel)
title('Apple Watch Acceleration (no gravity)')

% [f, Xf, Nfft] = fftcalc(apple_accel, fs);
% figure;
% plot(f, abs(Xf))
% title('Acceleration freq. spectrum')

figure;
pwelch(apple_accel, [], [], [], apple_fs); 

%% Therapy - ok for now
clear;
clc;

[therapy_time, therapy_fs, therapy_channels, therapy_data] = loadPatientData();
freq = therapy_data(:,2);
therapy = therapy_data(:,3);

figure;
subplot(2,1,1);
stem(therapy_time , therapy)
title('Therapy State')
ylim([-0.05 1.1])

subplot(2,1,2);
stem(therapy_time , freq)
title('Therpay Frequency')

%% Internal Acceleration and Apple Watch Acceleration - plot spectra (fft) and plot the PSD of both accelerations
% Patient 6KOZ has brief overlaps on Aug. 18th, 2021 and Oct. 27th, 2021
% Patient RZCH has brief overlaps on Sep. 27th, 2021
clear;
clc;

[ipg_time, ipg_fs, ipg_channels, ipg_data] = loadPatientData();
ipg_accel = sqrt(ipg_data(:,2).^2 + ipg_data(:,3).^2 + ipg_data(:,4).^2);

figure(1);
ax(1) = subplot(2,1,1);
plot(ipg_time, ipg_accel)
title('IPG Internal Acceleration')
 
% figure(2);
% [ipg_f, ipg_Xf,Nfft] = fftcalc(ipg_accel, fs);
% subplot(2,1,1)
% plot(ipg_f, abs(ipg_Xf))
% title('IPG Internal Acceleration FFT')

figure(2)
subplot(2,1,1)
pwelch(ipg_accel, [], [], [], fs); 

[apple_time, apple_fs, apple_channels, apple_data] = loadPatientData();
apple_accel = sqrt(apple_data(:,2).^2 + apple_data(:,3).^2 + apple_data(:,4).^2);

figure(1)
ax(2) = subplot(2,1,2);
plot(apple_time, apple_accel)
title('Apple Watch Acceleration')
linkaxes(ax, 'x');

figure(2)
subplot(2,1,2)
pwelch(apple_accel, [], [], [], fs);

% figure(2);
% [apple_f, apple_Xf, Nfft] = fftcalc(apple_accel, fs);
% subplot(2,1,2)
% plot(apple_f, abs(apple_Xf))
% title('Apple Watch Acceleration FFT')
% axis([0 30 -inf inf])
% align = finddelay(apple_accel, ipg_accel);

% figure;
% axes(ax(1));
% plot(apple_accel(align+1:end))

% aligned = alignsignals(apple_accel, ipg_accel);

% % this aligns the ends of the signals, don't think that's what we want
% figure;
% subplot(2,1,2)
% plot(aligned)

% subplot(2,1,1)
% plot(ipg_accel)

%% LFPs and Internal Accelerataion - ok for now

clear;
clc;

[lfp_time, lfp_fs, lfp_channels, lfp_data] = loadPatientData();

figure;
ax(1) = subplot(2,1,1)
plot(lfp_time, lfp_data(:,2:end))
title('LFPs')

[ipg_time, ipg_fs, ipg_channels, ipg_data] = loadPatientData();
ipg_accel = sqrt(ipg_data(:,2).^2 + ipg_data(:,3).^2 + ipg_data(:,4).^2);

ax(2) = subplot(2,1,2)
plot(ipg_time, ipg_accel)
title('IPG Internal Acceleration')
linkaxes(ax, 'x');

%% LFP, Internal Acceleration and Stimulation Therapy - ok for now
clear;
clc;

[lfp_time, lfp_fs, lfp_channels, lfp_data] = loadPatientData();

figure;
ax(1) = subplot(3,1,1);
plot(lfp_time, lfp_data(:,2:end))
title('LFPs')
legend('channel 0', 'channel 1', 'channel 2', 'channel 3')

[ipg_time, ipg_fs, ipg_channels, ipg_data] = loadPatientData();
ipg_accel = sqrt(ipg_data(:,2).^2 + ipg_data(:,3).^2 + ipg_data(:,4).^2);
ax(2) = subplot(3,1,2);
plot(ipg_time, ipg_accel)
title('IPG Internal Acceleration')

[therapy_time, therapy_fs, therapy_channels, therapy_data] = loadPatientData();
therapy = therapy_data(:,3);

ax(3) = subplot(3,1,3);
stem(therapy_time, therapy)
title('Therapy State')
ylim([-0.05 1.1])
linkaxes(ax, 'x');

%% LFP, Internal Acceleration  and Apple Watch Acceleration - ok for now


[lfp_time, lfp_fs, lfp_channels, lfp_data] = loadPatientData();

figure;
ax(1) = subplot(3,1,1);
plot(lfp_time, lfp_data(:,2:end))
title('LFPs')
legend('channel 0', 'channel 1', 'channel 2', 'channel 3')

[ipg_time, ipg_fs, ipg_channels, ipg_data] = loadPatientData();
ipg_accel = sqrt(ipg_data(:,2).^2 + ipg_data(:,3).^2 + ipg_data(:,4).^2);

ax(2) = subplot(3,1,2);
plot(ipg_time, ipg_accel)
title('IPG Internal Acceleration')

[apple_time, apple_fs, apple_channels, apple_data] = loadPatientData();
apple_accel = sqrt(apple_data(:,2).^2 + apple_data(:,3).^2 + apple_data(:,4).^2);

ax(3) = subplot(3,1,3);
plot(apple_time, apple_accel)
title('Apple Watch Acceleration')
linkaxes(ax, 'x');