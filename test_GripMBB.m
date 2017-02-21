%% Reset

close all
clear
clc
IOPort('CloseAll')


%% Initialize

d='SerialMBB';
c=2;

fprintf('Initialize \n')
obj=GripMBB()


%% Allocate memory for the data stream

fprintf('Allocate memory for the data stream \n')

% obj.DataMemoryAllocation(5e5);
obj.DataMemoryAllocation();

obj


%% Calibrate upLimit and downLimit

obj.Initialize(d,c);
obj.Calibrate;

obj.DumpData;


%% Do continuous ADC
% and plot how long it taks (in ms) to do each ADC

n = 256;
t = zeros(n,1);
for i = 1:n
    tic
    [Values, Times] = obj.DoADC;
    t(i) = toc*1000; % ms
end
figure('name','time (in ms) to fetch current ADC and save it into obj.data','numbertitle','off')
plot(t)
xlabel('ADC number')
ylabel('time (ms)')

fprintf('Before ClearEmptyData \n')
obj
obj.ClearEmptyData
fprintf('After ClearEmptyData \n')
obj


%% Close connection

obj.Close;
fprintf('After closing the connection \n')
obj
