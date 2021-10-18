%% LFP recordings
clear;
clc;

[time_vec, fs, channels, data] = loadPatientData();
LFPplot(data, time_vec, channels);

Nfft = 2^10;
[f, Xf] = fftcalc(data(:,2:end), Nfft, fs);
figure;
plot(f, abs(Xf))
legend('channel 0', 'channel 1', 'channel 2', 'channel 3')
axis([0 35 -inf inf]) % betas waves are in the 10-32 Hz range

%% IPG Internal Motion (acceleration)
clear;
clc;

[time_vec, fs, channels, data] = loadPatientData();
ipg_accel = sqrt(data(:,2).^2 + data(:,3).^2 + data(:,4).^2);

figure;
plot(time_vec, ipg_accel)
title('IPG Internal Acceleration')

%% Apple Watch Motion (acceleration) 
clear;
clc;
[time_vec, fs, channels, data] = loadPatientData();
apple_accel = sqrt(data(:,2).^2 + data(:,3).^2 + data(:,4).^2);

figure;
plot(time_vec , apple_accel)
title('Apple Watch Acceleration (no gravity)')

%% Therapy
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

%% Internal Acceleration and Apple Watch Acceleration  %plot spectra (fft) and plot the PSD of both accelerations
clear;
clc;
% Patient 6KOZ - August 18, 2021
% Patient E395 - August 13, 2021, doesn't seem useful
% Only two patients and dates with simultaneous IPG acceleration and Apple
% Watch Acceleration recordings

[time_vec, fs, channels, data] = loadPatientData();
ipg_accel = sqrt(data(:,2).^2 + data(:,3).^2 + data(:,4).^2);
ipg_time = time_vec;

figure(1);
ax(1) = subplot(2,1,1)
plot(ipg_time, ipg_accel)
title('IPG Internal Acceleration')
Nfft = 2^10;

figure(2);
[ipg_f, ipg_Xf] = fftcalc(ipg_accel, Nfft, fs);
subplot(2,1,1)
plot(ipg_f, abs(ipg_Xf))

[time_vec, fs, channels, data] = loadPatientData();
apple_accel = sqrt(data(:,2).^2 + data(:,3).^2 + data(:,4).^2);
apple_time = time_vec;

figure(1)
ax(2) = subplot(2,1,2)
plot(apple_time, apple_accel)
title('Apple Watch Acceleration')
% linkaxes(ax, 'x');

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

%% LFPs and Internal Accelerataion

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

%% LFP, Internal Acceleration and Stimulation Therapy
clear;
clc;

[time_vec, fs, channels, data] = loadPatientData();
lfp_time = time_vec;

figure;
ax(1) = subplot(3,1,1)
plot(lfp_time, data(:,2:end))
title('LFPs')
legend('channel 0', 'channel 1', 'channel 2', 'channel 3')

[time_vec, fs, channels, data] = loadPatientData();
ipg_accel = sqrt(data(:,2).^2 + data(:,3).^2 + data(:,4).^2);
ipg_time = time_vec;
ax(2) = subplot(3,1,2)
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