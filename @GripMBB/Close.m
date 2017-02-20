function Close( obj )
% obj.Close()
%
% Try to close the connection to the device

try
    
    CloseGripDevice(obj.deviceName, obj.handle)
    obj.handle = []; % delete the pointer
    fprintf('Connection closed \n')
    
catch err
    
    fprintf('Connection NOT closed properly \n')
    warning(err.messge)
    
end

end % function
