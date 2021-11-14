clear;
clc;

% Plotting Internal acceleration and apple watch acceleration
[ipg_time_vec, ipg_fs, ipg_channels, ipg_data] = loadPatientData();
ipg_accel = sqrt(ipg_data(:,2).^2 + ipg_data(:,3).^2 + ipg_data(:,4).^2);

% figure(1);
% ax(1) = subplot(2,1,1);
% plot(ipg_time_vec, ipg_accel)
% title('IPG Internal Acceleration')
figure;
ax(1) = subplot(2,1,1);
plot(ipg_data(:,1), ipg_accel)
title('IPG Internal Acceleration')

[apple_time_vec, apple_fs, apple_channels, apple_data] = loadPatientData();
apple_accel = sqrt(apple_data(:,2).^2 + apple_data(:,3).^2 + apple_data(:,4).^2);

% figure(1)
% ax(2) = subplot(2,1,2);
% plot(apple_time_vec, apple_accel)
% title('Apple Watch Acceleration')
% linkaxes(ax, 'x');


ax(2) = subplot(2,1,2);
plot(apple_data(:,1), apple_accel)
title('Apple watch Acceleration')
linkaxes(ax, 'x');

lag_time = finddelay(apple_data(:,1), ipg_data(:,1));

axes(ax(1));
plot(apple_data(lag_time+1:end))

aligned = alignsignals(apple_accel, ipg_accel);

% this aligns the ends of the signals, don't think that's what we want
figure;
subplot(2,1,2)
plot(aligned)

subplot(2,1,1)
plot(ipg_accel)