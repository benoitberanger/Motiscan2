function Calibrate( obj )

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
            
        elseif any(keyCode(moveUp_upLimit))
            upLimit = upLimit + 1;
            
        elseif any(keyCode(moveDown_upLimit))
            upLimit = upLimit - 1;
            
        elseif any(keyCode(moveUp_downLimit))
            downLimit = downLimit + 1;
            
        elseif any(keyCode(moveDown_downLimit))
            downLimit = downLimit - 1;
            
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
    
    % Show the new plots
    drawnow
    
end

end % function