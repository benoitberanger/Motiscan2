function Close( obj )

try
    
    CloseGripDevice(obj.deviceName, obj.handle)
    obj.handle = []; % delete the pointer
    fprintf('Connection closed \n')
    
catch err
    
    fprintf('Connection NOT closed properly \n')
    warning(err.messge)
    
end

end % function
