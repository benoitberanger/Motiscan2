function [Values, Times] = DoADC( obj )
% [Values, Times] = obj.DoADC()
%
% Read current ADC an save it into obj.data

% Read
[Values, Times] = obj.Read;

% Store
obj.idx = obj.idx + 1;
obj.data(obj.idx,:) = [Values, Times];

end
