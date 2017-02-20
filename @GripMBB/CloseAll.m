function CloseAll( obj )
% obj.CloseAll()
%
% Close all Serial Port coonections opened via PTB IOPort function

IOPort('CloseAll');
obj.handle = [];

end
