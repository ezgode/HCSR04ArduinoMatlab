%% Ax = Position2Axes(P,h)
function Ax = position2Axes(varargin)
    optvar = {[0 0 1 1],0.1,[]};
    optvar(1:length(varargin)) = varargin(:);

    P = optvar{1};
    h = optvar{2};
    otherVars = optvar(3:end);
    if isempty(otherVars{1})
        otherVars = {};
    end
    if length(h)==1
        h = [h,h];
    end
    naxes = size(P,1);
    %Ax = cell(naxes,1);
    Ax = gobjects(naxes,1);
    for i = 1:naxes
        Ax(i) = axes('Position',P(i,:)+[2*h(1) h(2) -3*h(1) -2*h(2)],otherVars{:});
        Ax(i).NextPlot = 'add';
    end
end  