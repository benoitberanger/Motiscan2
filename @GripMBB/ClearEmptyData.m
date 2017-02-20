function ClearEmptyData( obj )
% obj.ClearEmptyData()
%
% Delete empty elements in obj.data

obj.data(isnan(obj.data(:,1)),:) = [];

end
