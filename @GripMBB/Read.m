function [Values, Times] = Read( obj )
% [Values, Times] = obj.Read()
%
% Get the last ADC values

obj.AssertIsConnected;

[Values, Times] = ReadGripValue(obj.deviceName, obj.handle, obj.channels);

end
