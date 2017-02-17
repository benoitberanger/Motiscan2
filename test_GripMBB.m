close all
clear
clc

d='SerialMBB';
c=2;

g=GripMBB();
g.Initialize(d,c);

g.Calibrate;

g.Close;
