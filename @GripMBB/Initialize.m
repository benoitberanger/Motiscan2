function Initialize( obj, deviceName, channels )

% Use the functions from MBB team to drive the grips
obj.handle = InitializeGrip(deviceName, channels);

obj.deviceName = deviceName;
obj.channels   = channels;

end
