function [] = LFPplot(data, time, channels)

figure;
plot(time, data(:, 2:end))
title('LFPs')
legend('channel 0', 'channel 1', 'channel 2', 'channel 3')

figure;
for i = 1:channels-1
subplot(channels-1,1,i);
plot(time, data(:,i+1))
end
title('LFP channels')