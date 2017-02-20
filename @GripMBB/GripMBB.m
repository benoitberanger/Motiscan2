classdef GripMBB < handle
    %GripMBB Class to manipulate easily the grip force designed for MBB
    %team
    
    %% Properties
    
    properties
        
        timesStamp % when the object is created
        
        deviceName % 'UsbCED' | 'SerialMBB' | 'MIE'
        channels   % 1 | 2 | [ 1 2 ]
        
        handle     % pointer to the serial port used by PTB
        
        upLimit    % upper limit => force max + baseline
        downLimit  % lower limit => baseline (i.e. the zero)
        
        dim        % dimension : number if lines in the data (after initialization)
        idx        % index : which sample(line) are we in the data
        data       % data = zeros(dim,2), where the columns are [ GripValue , TimeStamp ]
        
    end % properties
    
    
    %% Methods
    
    methods
        
        % -----------------------------------------------------------------
        %                           Constructor
        % -----------------------------------------------------------------
        function obj = GripMBB( )
            % obj = GripMBB( ) % create empty object
            
            obj.timesStamp = datestr(now);
            
        end
        
        
    end % methods
    
    
end % class
