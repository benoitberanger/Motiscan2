function AssertReadyToRecord( obj )
% obj.AssertReadyToRecord()
%
% Raise an error if the object is not completly ready to to ADC and record
% data

obj.AssertDataReady
obj.AssertIsConnected
obj.AssertIsCalibrated

end
