function Close( obj )

try 

    CloseGripDevice(obj.deviceName, obj.handle)

    fprintf('Connexion closed \n')

catch err
    
    fprintf('Connexion NOT closed properly \n')
    warning(err.messge)
    
end

end
