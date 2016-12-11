%% NEW_FIGURE creates a new figure. 
% F = New_Figure(flag,figpos);
function F = newFigure(nS,varargin)    
    MonPos = get(0,'MonitorPosition');
    if size(MonPos,1)<nS
        nS = 1;
    end
    
    varopt = {true, [MonPos(nS,1) MonPos(nS,2) MonPos(nS,3) MonPos(nS,4)]};
    varopt(1:length(varargin)) = varargin(:);
    Flag = varopt{1};
    figPos = varopt{2};

    global END_SIM;

    F = figure('Position',figPos);        
    if Flag
        set(F,'WindowButtonDownFcn',@MouseDownClick);
    end

    function MouseDownClick(src,data)
        if strcmp(src.SelectionType,'open')
            END_SIM = true;
            fprintf('Simulation stopped by the user\n');
        end
    end    
end  