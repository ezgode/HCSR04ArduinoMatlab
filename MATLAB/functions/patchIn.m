%% [H] = patchIn(Ax,H,xdata,ydata,varargin)
function [H] = patchIn(Ax,H,xdata,ydata,zdata,Color,varargin)
    if ishandle(H)
        set(H,'XData',xdata,'YData',ydata);
        for k = 1:2:length(varargin)
            set(H,varargin{k},varargin{k+1});
        end
    elseif ~isempty(Ax)
        H = patch(xdata,ydata,zdata,Color,varargin{:},'Parent',Ax);
    else
        figure;
        axes;
        hold on;
        H = patch(xdata,ydata,zdata,Color,varargin{:});
    end
end   