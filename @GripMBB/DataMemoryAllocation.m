function DataMemoryAllocation( obj , dim )

assert( isscalar(dim) && dim==round(dim) && dim>0, ...
    'dim must be a positive integer, usually quite big, such as 50,000. ')

obj.dim  = dim;
obj.data = zeros(dim,2); % memory allocation
obj.idx  = 0;            % ( instead of [] )

end
