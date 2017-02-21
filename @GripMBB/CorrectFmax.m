function CorrectFmax( obj , NrSamples )
% obj.CorrectFmax( NrSamples )
%
% If upLimit==Fmax is exeeded during over 'NrSamples', this becomes the new upLimit==Fmax.


%% Checkup parameters

if nargin < 2
    NrSamples = 10 * 60; % 10 seconds x 60 samples/second
end

assert( isscalar(NrSamples) && NrSamples>0 && NrSamples==round(NrSamples), ...
    'NrSamples must be a positive integer, usually 10sec x 60sample/sec = 600')

obj.AssertDataReady
obj.AssertIsCalibrated


%% Is Fmax==upLmit reached

if obj.idx >= NrSamples
    data = obj.data( obj.idx-NrSamples+1 : obj.idx , 1 );
else
    data = obj.data( 1                   : obj.idx , 1 );
end

newFmax = data(data>obj.upLimit);

if ~isempty(newFmax)
    
    if max(newFmax) >= 767
        warning('GripMBB:CorrectFmax:NewUpLimitTooHigh',...
            'The new Fmax is beyond saturation.')
    end
    
    obj.upLimit = max(newFmax);
    fprintf('New Fmax : \n')
    fprintf('upLimit   = %g \n',obj.upLimit  )
    fprintf('downLimit = %g \n',obj.downLimit)
    fprintf(' -- diff  = %g \n',obj.upLimit - obj.downLimit)
    fprintf('\n')
    
end


end
