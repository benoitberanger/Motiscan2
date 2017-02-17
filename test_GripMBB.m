close all
clear
clc
IOPort('CloseAll')
clear classes

d='SerialMBB';
c=2;

g=GripMBB();

g.DataMemoryAllocation(1e5);
g.AssertDataReady

g.Initialize(d,c);
g.AssertIsConnected;
g.Calibrate;
g.AssertIsCalibrated
g.AssertReadyToRecord
g.Close;

g
