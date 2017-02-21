function DumpData( obj )
% obj.DumpData()
%
% Clear reset data and idx. Usually called after Calibration.

obj.AssertDataReady

obj.DataMemoryAllocation(obj.dim)

end
