%% LFP recordings %patient lfp
clear;
clc;

[time_vec, dt, fs, f, Xf, time, channels, data] = loadPatientData();

figure;
plot(time_vec,data(:,2:end))
title('LFPs')
legend('channel 0', 'channel 1', 'channel 2', 'channel 3')

figure;
for i = 1:channels-1
subplot(channels-1,1,i);
plot(time_vec, data(:,i+1))
end
title('LFP channels')

figure;
plot(f, abs(Xf))
title('LFPs FFT')
xlabel('Frequency(Hz)')
ylabel('Magnitude')
legend('channel 0', 'channel 1', 'channel 2', 'channel 3')

%% IPG Internal Motion (acceleration)
clear;
clc;

[time_vec, dt, fs, f, Xf, time, channels, data] = loadPatientData();
ipg_accel = sqrt(data(:,2).^2 + data(:,3).^2 + data(:,4).^2);

figure;
plot(time_vec, ipg_accel)
title('IPG Internal Acceleration')

figure;
plot(f, abs(Xf))
axis([0 8 -inf 400])

%% Apple Watch Motion (acceleration) 
clear;
clc;
[time_vec, dt, fs, f, Xf, time, channels, data] = loadPatientData();
apple_accel = sqrt(data(:,2).^2 + data(:,3).^2 + data(:,4).^2);

figure;
plot(time_vec, apple_accel)
title('Apple Watch Acceleration (no gravity)')

% figure;
% plot(f, abs(Xf))
% axis([0 20 -inf 400])

%% Therapy
clear;
clc;

[time_vec, dt, fs, f, Xf, time, channels, data] = loadPatientData();

freq = data(:,2);
therapy = data(:,3);

figure;
subplot(2,1,1);
stem(time_vec, therapy)
title('Therapy State')
ylim([-0.05 1.1])

subplot(2,1,2);
stem(time_vec, freq)
title('Therpay Frequency')

%% Internal Acceleration and Apple Watch Acceleration
clear;
clc;
% Patient 6KOZ - August 18, 2021
% Patient E395 - August 13, 2021, doesn't seem useful
% Only two patients and dates with simultaneous IPG acceleration and Apple
% Watch Acceleration recordings

[time_vec, dt, fs, f, Xf, time, channels, data] = loadPatientData();
ipg_accel = sqrt(data(:,2).^2 + data(:,3).^2 + data(:,4).^2);
figure;
ax(1) = subplot(2,1,1)
plot(time_vec, ipg_accel)
title('IPG Internal Acceleration')

[time_vec, dt, fs, f, Xf, time, channels, data] = loadPatientData();
apple_accel = sqrt(data(:,2).^2 + data(:,3).^2 + data(:,4).^2);

ax(2) = subplot(2,1,2)
plot(time_vec, apple_accel)
title('Apple Watch Acceleration')
linkaxes(ax, 'x');

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

[time_vec, dt, fs, f, Xf, time, channels, data] = loadPatientData();
figure;
ax(1) = subplot(2,1,1)
plot(time_vec, data(:,2:end))
title('LFPs')

[time_vec, dt, fs, f, Xf, time, channels, data] = loadPatientData();
ipg_accel = sqrt(data(:,2).^2 + data(:,3).^2 + data(:,4).^2);

ax(2) = subplot(2,1,2)
plot(time_vec, ipg_accel)
title('IPG Internal Acceleration')
linkaxes(ax, 'x');



%% LFP, Internal Acceleration and Stimulation Therapy

[time_vec, dt, fs, f, Xf, time, channels, data] = loadPatientData();

figure;
ax(1) = subplot(3,1,1)
plot(time_vec,data(:,2:end))
title('LFPs')
legend('channel 0', 'channel 1', 'channel 2', 'channel 3')

[time_vec, dt, fs, f, Xf, time, channels, data] = loadPatientData();
ipg_accel = sqrt(data(:,2).^2 + data(:,3).^2 + data(:,4).^2);

ax(2) = subplot(3,1,2)
plot(time_vec, ipg_accel)
title('IPG Internal Acceleration')

[time_vec, dt, fs, f, Xf, time, channels, data] = loadPatientData();

therapy = data(:,3);

ax(3) = subplot(3,1,3);
stem(time_vec, therapy)
title('Therapy State')
ylim([-0.05 1.1])
linkaxes(ax, 'x');