% View Therapy data
[filename, pathname] = uigetfile('*.csv');

[data, txt] =xlsread([pathname filename]);

[v] = datevec(data(:,1)); %year month day hour minute second
freq = data(:,2);
therapy = data(:,3);
t = v(:,4)*3600 + v(:,5)*60+v(:,6);

subplot(2,1,1);
stem(t, therapy)

subplot(2,1,2);
stem(t, freq)

