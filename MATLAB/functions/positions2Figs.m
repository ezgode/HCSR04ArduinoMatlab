%F = positions2Figs(pos,h)
%Example
%   P = figPos(1, 1,1, [1 1], [1,1], 1)
%   F = positions2Figs(P,0.1)
function F = positions2Figs(varargin)
    optvar = {figPos(1,1),0.01,{}};
    optvar(1:length(varargin)) = varargin(:);
    P = optvar{1};
    h = optvar{2};
    
    if length(h) ==1 
        h = [h,h];
    end
    hx = h(1);
    hy = h(2);
    nFigs = size(P,1);
    F = gobjects(nFigs,1);
    for i = 1:nFigs
        %F(i) = newFigure(true,P(i,:)+[h h -2*h -6*h].*(min(P(i,3:4))*ones(1,4)));
        F(i) = newFigure(1,true,P(i,:)+[hx hy -2*hx -2*hy]);
    end
end