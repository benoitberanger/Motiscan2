function Initialize( obj, deviceName, channels )

%% Check the channels

assert( isscalar(channels) && channels==round(channels) , ...
    'For the moment, ony single channel is supported : 1 or 2 but not [ 1 2 ]')

%% Initialize

% Use the functions from MBB team to drive the grips
obj.handle = InitializeGrip(deviceName, channels);
fprintf('Connection opened \n')

obj.deviceName = deviceName;
obj.channels   = channels;

end
