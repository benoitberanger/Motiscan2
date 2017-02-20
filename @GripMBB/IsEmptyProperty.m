function IsEmptyProperty( obj , propertyname )
% obj.IsEmptyProperty( PropertyName )
%
% Raise an error if obj.'PropertyName' is empty

% Fetch caller object
[~, objName, ~] = fileparts(obj.Description);

if isempty(obj.(propertyname))
    error( 'No data in %s.%s' , objName , propertyname )
end

end
