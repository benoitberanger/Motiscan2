function DataMemoryAllocation( obj , dim )
% obj.DataMemoryAllocation( dim )
%
% Create obj.data matrix wich will receive the ADC values and timestamp.
% This memmory allocation is important optimise the computation time and
% keep it constant.

if nargin < 2
    dim = 5e5;
end

assert( isscalar(dim) && dim==round(dim) && dim>0, ...
    'dim must be a positive integer, usually quite big, such as 50,000. ')

obj.dim  = dim;        % save the value
obj.data = nan(dim,2); % memory allocation
obj.idx  = 0;          % ( instead of [] )

end
