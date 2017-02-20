function Calibrate( obj )
% obj.Calibrate()
%
% Open a matlab figure, start reading and plotting data. Press ENTER to
% save the current Min and Max as downLimit and upLimit


% Check
obj.AssertIsConnected


%% Parameters

RefreshPeriod = 1/60; % roughtly
Window        = 10; % seconds


%% Keys

KbName('UnifyKeyNames');
esc                = KbName('escape');
setup              = KbName('return');

moveUp_upLimit     = KbName('e');
moveDown_upLimit   = KbName('d');

moveUp_downLimit   = KbName('r');
moveDown_downLimit = KbName('f');

fprintf('\n')

fprintf('Press ESCAPE to exit calibration \n')
fprintf('Press ENTER to exit to setup the current Min=downLmit and Max=upLimit values from the graph\n')
fprintf('\n')

fprintf('Press E to move UP the Max=upLimit \n')
fprintf('Press D to move DOWN the Max=upLimit \n')
fprintf('\n')

fprintf('Press R to move UP the Min=downLmit \n')
fprintf('Press F to move DOWN the Min=downLmit \n')
fprintf('\n')

%% Prepare curves, figures, limits

Scope         = nan( round(Window/RefreshPeriod) , 1 ); % Grip Curve
Time          = zeros(size(Scope));

h = axes; % create a figure and save pointer to the graph
hold on

upLimit   = []; % value of the limit
downLimit = []; % value of the limit
limits = 0;     % flag


%% Oscilloscope

t0 = GetSecs;

do = 1;
while do
    
    % Sift all samples to the left
    Scope  = circshift(Scope,1);
    Time   = circshift(Time ,1);
    
    % Read ADC
    [Values, Times] = obj.Read;
    
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
            upLimit   = max(nonNanScope);
            downLimit = min(nonNanScope);
            limits = 1;
            
            fprintf('upLimit   = %g \n',upLimit  )
            fprintf('downLimit = %g \n',downLimit)
            fprintf(' -- diff  = %g \n',upLimit - downLimit)
            fprintf('\n')
            
        elseif any(keyCode(moveUp_upLimit))
            upLimit = upLimit + 1;
            fprintf('upLimit   = %g \n',upLimit  )
            fprintf(' -- diff  = %g \n',upLimit - downLimit)
            fprintf('\n')
            
        elseif any(keyCode(moveDown_upLimit))
            upLimit = upLimit - 1;
            fprintf('upLimit   = %g \n',upLimit  )
            fprintf(' -- diff  = %g \n',upLimit - downLimit)
            fprintf('\n')
            
        elseif any(keyCode(moveUp_downLimit))
            downLimit = downLimit + 1;
            fprintf('downLimit = %g \n',downLimit)
            fprintf(' -- diff  = %g \n',upLimit - downLimit)
            fprintf('\n')
            
        elseif any(keyCode(moveDown_downLimit))
            downLimit = downLimit - 1;
            fprintf('downLimit = %g \n',downLimit)
            fprintf(' -- diff  = %g \n',upLimit - downLimit)
            fprintf('\n')
            
        elseif any(keyCode(esc))
            do = 0;
            
        end
        
    end
    
    % Plot the Up and Down limits, igf they have been setted
    if limits
        plot(h,[Time(end) Time(1)], [upLimit upLimit],'Color','red')
        plot(h,[Time(end) Time(1)], [downLimit downLimit],'Color','red')
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

% Save the values
obj.upLimit   = upLimit;
obj.downLimit = downLimit;


end % function
