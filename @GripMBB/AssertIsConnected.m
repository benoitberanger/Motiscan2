function AssertIsConnected( obj )
% obj.AssertIsConnected()
%
% Raise an error if there is no connection is not ready

assert( ~isempty(obj.handle) , 'Need a pointer (handle) for the connction. Use Initialize.' )

end
