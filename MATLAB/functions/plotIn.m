%% plot_in
% [H] = plot_in(Ax,H,xdata,ydata,varargin)
function [H] = plotIn(Ax,H,xdata,ydata,varargin)            
    % [H] = plot_in(Ax,H,xdata,ydata,varargin)
    if ishandle(H)
        set(H,'XData',xdata,'YData',ydata);
        for k = 1:2:length(varargin)
            set(H,varargin{k},varargin{k+1});
        end
    elseif ~isempty(Ax)
        H = plot(xdata,ydata,varargin{:},'Parent',Ax);
    else
        figure;
        axes;
        hold on;
        H = plot(xdata,ydata,varargin{:});
    end 
end