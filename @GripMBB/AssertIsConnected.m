function AssertIsConnected( obj )

assert( ~isempty(obj.handle) , 'Need a pointer (handle) for the connction. Use Initialize.' )

end
