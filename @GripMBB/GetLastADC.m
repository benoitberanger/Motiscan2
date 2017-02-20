function [Values, Times] = GetLastADC( obj )
% [Values, Times] = obj.GetLastADC()
%
% Output is the last ADC recored and stored in obj.data

Values = obj.data(obj.idx,1);
Times  = obj.data(obj.idx,2);

end
