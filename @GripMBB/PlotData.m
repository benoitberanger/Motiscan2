function PlotData( obj )
% obj.PlotData()
%
% Plot the whole data

assert( obj.idx > 0 , 'No data available, nothing to plot.' )

figure

p = plot(...
    obj.data(1:obj.idx,2) - obj.data(1,2) , ... % X
    obj.data(1:obj.idx,1) ...                   % Y
    );

% Good looking graph
axis tight % for X
ylim([0 780])
xlabel('time (s)')
ylabel('ADC a.u.')

if ~isempty( which('ScrollPlot') )
    ScrollPlot(p,'axis','xy')
end

end
