function [H] = textIn(Ax,H,xdata,ydata,zdata,string,varargin)            
    % [H] = plot_in(Ax,H,xdata,ydata,varargin)
    if ishandle(H)
        set(H,'Position',[xdata,ydata,zdata],'String',string);
    elseif ~isempty(Ax)
        H = text(xdata,ydata,zdata,string,varargin{:},'Parent',Ax);
    else
        figure;
        axes;
        hold on;
        H = text(xdata,ydata,zdata,string,varargin{:});
    end 
end 