function Close( obj )

try
    
    CloseGripDevice(obj.deviceName, obj.handle)
    
    fprintf('Connection closed \n')
    
catch err
    
    fprintf('Connection NOT closed properly \n')
    warning(err.messge)
    
end

end % function
