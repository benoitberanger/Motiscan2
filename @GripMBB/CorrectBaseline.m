function CorrectBaseline( obj, NrSamples )
% obj.CorrectBaseline( NrSamples )
%
% Compute the mean value over 'NrSamples' and make it the new baseline
% value.


if nargin < 2
    NrSamples = 10 * 60; % 10 seconds x 60 samples/second
end

assert( isscalar(NrSamples) && NrSamples>0 && NrSamples==round(NrSamples), ...
    'NrSamples must be a positive integer, usually 10sec x 60sample/sec = 600')

obj.AssertDataReady

if obj.idx >= NrSamples
    
    newbaseline = round(mean( obj.data( obj.idx-NrSamples+1 : obj.idx , 1 ) ));
    
    newupLimit = obj.upLimit - obj.downLimit + newbaseline;
    
    if newupLimit > 768
        warning('GripMBB:CorrectBaseline:NewUpLimitTooHigh',...
            ['According to the new baseline, the new Fmax is byond saturation. \n'...
            'Baseline correction is not applied. \n'])
    else
        obj.upLimit   = newupLimit;
        obj.downLimit = newbaseline;
    end
    
else
    warning('GripMBB:CorrectBaseline','Not enough samples to compute baseline')
    
end

end
