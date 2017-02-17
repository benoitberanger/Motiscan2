function [Values, Times] = Read( obj )

[Values, Times] = ReadGripValue(obj.deviceName, obj.handle, obj.channels);

end
