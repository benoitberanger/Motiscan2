%% Reset

close all
clear
clc
IOPort('CloseAll')
clear classes

%% Initialize

d='SerialMBB';
c=2;

fprintf('Initialize \n')
g=GripMBB()


%% Allocate memory for the data stream

fprintf('Allocate memory for the data stream \n')

% g.DataMemoryAllocation(5e5);
g.DataMemoryAllocation();
g.AssertDataReady

g


%% Calibrate upLimit and downLimit

g.Initialize(d,c);
g.AssertIsConnected
g.Calibrate;
g.AssertIsCalibrated
g.AssertReadyToRecord


%% Do continuous ADC
% and plot how long it taks (in ms) to do each ADC

n = 105;
t = zeros(n,1);
for i = 1:n
    
    tic
    [Values, Times] = g.DoADC;
    t(i) = toc*1000; % ms
    
end
plot(t)

fprintf('Before ClearEmptyData \n')
g
g.ClearEmptyData
fprintf('After ClearEmptyData \n')
g

%% Close connection

g.Close;
fprintf('After closing the connection \n')
g
