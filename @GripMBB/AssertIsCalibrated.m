function AssertIsCalibrated( obj )

assert( ~isempty(obj.upLimit  ) , 'upLimit is not set. Use Calibration' )
assert( ~isempty(obj.downLimit) , 'downLimit is not set. Use Calibration' )

end
