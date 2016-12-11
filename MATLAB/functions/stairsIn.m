%% stair_in
% [H] = plot_in(Ax,H,xdata,ydata,varargin)
function [H] = stairsIn(Ax,H,xdata,ydata,varargin)            
    % [H] = plot_in(Ax,H,xdata,ydata,varargin)
    if ~isempty(H)
        set(H,'XData',xdata,'YData',ydata);
    elseif ~isempty(Ax)
        H = stairs(xdata,ydata,varargin{:},'Parent',Ax);
    else
        figure;
        axes;
        hold on;
        H = stairs(xdata,ydata,varargin{:});
    end 
end  