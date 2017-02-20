%% Reset

close all
clear
clc
IOPort('CloseAll')
clear classes

%% Initialize

d='SerialMBB';
c=2;

g=GripMBB()


%% Allocate memory for the data stream

% g.DataMemoryAllocation(1e5);
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

n = 105;
t = zeros(n,1);
for i = 1:n
    
    tic
    [Values, Times] = g.DoADC;
    t(i) = toc*1000; % ms
    
end
plot(t)

[Values1, Times1] = g.GetLastADC;
g.ClearEmptyData
[Values2, Times2] = g.GetLastADC;


%% Close connection

g.Close;

g
