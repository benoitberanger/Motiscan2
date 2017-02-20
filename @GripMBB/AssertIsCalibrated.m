function AssertIsCalibrated( obj )
% obj.AssertIsCalibrated()
%
% Raise an error if upLimit and downLimit were not setted durun the
% Calibration

assert( ~isempty(obj.upLimit  ) , 'upLimit is not set. Use Calibration' )
assert( ~isempty(obj.downLimit) , 'downLimit is not set. Use Calibration' )

end
