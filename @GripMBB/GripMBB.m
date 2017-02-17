classdef GripMBB < handle
    %GripMBB Class to manipulate easily the grip force designed for MBB
    %team
    
    %% Properties
    
    properties
        
        % Parameters
        
        deviceName % 'UsbCED' | 'SerialMBB' | 'MIE'
        channels   % 1 | 2 | [1 2]
        
        % Internal variables
        
        handle     % pointer to the serial port used by PTB
        
        
    end % properties
    
    
    %% Methods
    
    methods
        
        % -----------------------------------------------------------------
        %                           Constructor
        % -----------------------------------------------------------------
        function obj = GripMBB( )
            % obj = GripMBB( ) % create empty object
        end
        
        
    end % methods
    
    
end % class
