%% LFP recordings
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
ipg_acceleration = sqrt(data(:,2).^2 + data(:,3).^2 + data(:,4).^2);

figure;
plot(time_vec, ipg_acceleration)
title('IPG Internal Acceleration')

figure;
plot(f, abs(Xf))
axis([0 8 -inf 400])

%% Apple Watch Motion (acceleration) 
clear;
clc;
[time_vec, dt, fs, f, Xf, time, channels, data] = loadPatientData();
accel = sqrt(data(:,2).^2 + data(:,3).^2 + data(:,4).^2);

figure;
plot(time_vec, accel)
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
ipg_acceleration = sqrt(data(:,2).^2 + data(:,3).^2 + data(:,4).^2);
figure;
subplot(2,1,1)
plot(time_vec, ipg_acceleration)
title('IPG Internal Acceleration')

[time_vec, dt, fs, f, Xf, time, channels, data] = loadPatientData();
accel = sqrt(data(:,2).^2 + data(:,3).^2 + data(:,4).^2);

subplot(2,1,2)
plot(time_vec, accel)
title('Apple Watch Acceleration')

%% Internal Accelerataion and LFPs

clear;
clc;

[time_vec, dt, fs, f, Xf, time, channels, data] = loadPatientData();
figure(1);
subplot(2,1,1)
plot(time_vec, data(:,2:end))
title('LFPs')

figure(2);
subplot(2,1,1)
plot(f, abs(Xf))

[time_vec, dt, fs, f, Xf, time, channels, data] = loadPatientData();
ipg_acceleration = sqrt(data(:,2).^2 + data(:,3).^2 + data(:,4).^2);
figure(1);
subplot(2,1,2)
plot(time_vec, ipg_acceleration)
title('IPG Internal Acceleration')

figure(2);
subplot(2,1,2)
plot(f, abs(Xf))

%% Stimulation Therapy and Internal Acceleration   

[time_vec, dt, fs, f, Xf, time, channels, data] = loadPatientData();
