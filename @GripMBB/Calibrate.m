function Calibrate( obj )
% obj.Calibrate()
%
% Open a matlab figure, start reading, storing and plotting data.
% Press ENTER to save the current displayed Min and Max as downLimit and upLimit.
% Press ESCAPE to quit.
% Instructions are displayed in the command window for other manipulations


% Check
obj.AssertDataReady
obj.AssertIsConnected


%% Parameters

RefreshPeriod = 1/60; % roughtly
Window        = 10;   % seconds


%% Keys

% Setup keys

KbName('UnifyKeyNames');
esc                = KbName('escape');
setup              = KbName('return');

moveUp_upLimit     = KbName('e');
moveDown_upLimit   = KbName('d');

moveUp_downLimit   = KbName('r');
moveDown_downLimit = KbName('f');

correctBaseline    = KbName('b');

moveUp_both        = KbName('t');
moveDown_both      = KbName('g');

% Print keys usage

fprintf('\n')

fprintf('Press ESCAPE to exit calibration \n')
fprintf('Press RETURN to setup the current Min=downLmit and Max=upLimit values from the graph\n')
fprintf('\n')

fprintf('Press E to move UP   the Max=upLimit \n')
fprintf('Press D to move DOWN the Max=upLimit \n')
fprintf('\n')

fprintf('Press R to move UP   the Min=downLmit \n')
fprintf('Press F to move DOWN the Min=downLmit \n')
fprintf('\n')

fprintf('Press B to apply baseline correction \n')
fprintf('\n')

fprintf('Press T to move UP   both limits \n')
fprintf('Press G to move DOWN both limits \n')
fprintf('\n')


%% Prepare curves, figures

Scope = nan( round(Window/RefreshPeriod) , 1 ); % Grip Curve
Time  = zeros(size(Scope));

h = axes; % create a figure and save a pointer to the graph (to manipulate easily the refresh)
hold(h,'on')

limits = 0; % its just a flag


%% Oscilloscope

t0 = GetSecs;

do = 1;
while do
    
    % Sift all samples to the left
    Scope  = circshift(Scope,1);
    Time   = circshift(Time ,1);
    
    % Read ADC
    [Values, Times] = obj.DoADC;
    
    % Set the new values inside the vectors
    Scope(1) = Values ;
    Time(1)  = Times - t0;
    
    % Clear the previous graph
    cla(h)
    
    % Plot the grip force curve
    plot(h,Time,Scope,'Color','blue')
    
    % Keyboard ?
    [keyIsDown, ~, keyCode] = KbCheck;
    if keyIsDown
        
        if any(keyCode(setup))
            nonNanScope = Scope(~isnan(Scope));
            obj.upLimit   = max(nonNanScope);
            obj.downLimit = min(nonNanScope);
            limits = 1;
            
            fprintf('upLimit   = %g \n',obj.upLimit  )
            fprintf('downLimit = %g \n',obj.downLimit)
            fprintf(' -- diff  = %g \n',obj.upLimit - obj.downLimit)
            fprintf('\n')
            
        elseif any(keyCode(moveUp_upLimit))
            obj.upLimit = obj.upLimit + 1;
            fprintf('upLimit   = %g \n',obj.upLimit  )
            fprintf(' -- diff  = %g \n',obj.upLimit - obj.downLimit)
            fprintf('\n')
            
        elseif any(keyCode(moveDown_upLimit))
            obj.upLimit = obj.upLimit - 1;
            fprintf('upLimit   = %g \n',obj.upLimit  )
            fprintf(' -- diff  = %g \n',obj.upLimit - obj.downLimit)
            fprintf('\n')
            
        elseif any(keyCode(moveUp_downLimit))
            obj.downLimit = obj.downLimit + 1;
            fprintf('downLimit = %g \n',obj.downLimit)
            fprintf(' -- diff  = %g \n',obj.upLimit - obj.downLimit)
            fprintf('\n')
            
        elseif any(keyCode(moveDown_downLimit))
            obj.downLimit = obj.downLimit - 1;
            fprintf('downLimit = %g \n',obj.downLimit)
            fprintf(' -- diff  = %g \n',obj.upLimit - obj.downLimit)
            fprintf('\n')
            
        elseif any(keyCode(correctBaseline))
            fprintf('BEFORE baseline correction : \n')
            fprintf('upLimit   = %g \n',obj.upLimit  )
            fprintf('downLimit = %g \n',obj.downLimit)
            fprintf(' -- diff  = %g \n',obj.upLimit - obj.downLimit)
            obj.CorrectBaseline(Window/RefreshPeriod/2); % roughtly 5 seconds
            fprintf('AFTER baseline correction (5 sec windows) : \n')
            fprintf('upLimit   = %g \n',obj.upLimit  )
            fprintf('downLimit = %g \n',obj.downLimit)
            fprintf(' -- diff  = %g \n',obj.upLimit - obj.downLimit)
            fprintf('\n')
            
        elseif any(keyCode(moveUp_both))
            obj.upLimit   = obj.upLimit   + 1;
            obj.downLimit = obj.downLimit + 1;
            fprintf('upLimit   = %g \n',obj.upLimit  )
            fprintf('downLimit = %g \n',obj.downLimit)
            fprintf(' -- diff  = %g \n',obj.upLimit - obj.downLimit)
            fprintf('\n')
            
        elseif any(keyCode(moveDown_both))
            obj.upLimit   = obj.upLimit   - 1;
            obj.downLimit = obj.downLimit - 1;
            fprintf('upLimit   = %g \n',obj.upLimit  )
            fprintf('downLimit = %g \n',obj.downLimit)
            fprintf(' -- diff  = %g \n',obj.upLimit - obj.downLimit)
            fprintf('\n')
            
        elseif any(keyCode(esc))
            do = 0;
            
        end
        
    end
    
    % Fmax has been exceeded ?
    if limits
        obj.CorrectFmax(Window/RefreshPeriod)
    end
    
    % Plot the Up and Down limits, igf they have been setted
    if limits
        plot(h,[Time(end) Time(1)], [obj.upLimit   obj.upLimit  ],'Color','red')
        plot(h,[Time(end) Time(1)], [obj.downLimit obj.downLimit],'Color','red')
    end
    
    % Good looking graph
    ylim([0 780])
    xlim([Time(end) Time(1)])
    xlabel('time (s)')
    ylabel('ADC a.u.')
    
    % Show the new plots
    drawnow
    
end

% Close the figure
close(get(h,'Parent'))


end % function
