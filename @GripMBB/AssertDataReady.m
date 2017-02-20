function AssertDataReady( obj )
% obj.AssertDataReady()
%
% Raise an error if obj.data is not properly oreoared

assert( numel(obj.data)>0 , 'data is not ready. Use DataMemoryAllocation' )

end
