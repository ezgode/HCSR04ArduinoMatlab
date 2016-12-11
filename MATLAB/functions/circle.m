%% [ Coor ] = circle(C, R, Res, Thetas, mod)
function [ Coor ] = circle(varargin)
    %[ Coor ] = circle(C, R, Res, Thetas, mod)
    varopt = {[0 0], 1, 50, [0,2*pi], 0};
    varopt(1:length(varargin)) = varargin(:);

    C       = varopt{1};
    R       = varopt{2};
    Res     = varopt{3};
    Thetas  = varopt{4};
    mod     = varopt{5};

    %Check that Theta(2) is bigger.
    Thetas(2) = Thetas(2) + 2*pi*(Thetas(2)<Thetas(1));

    switch mod
        case 0 
            Points = Res;
        case 1 
            Points = ceil(R*(Thetas(end)-Thetas(1))/Res);
    end

    Theta = Thetas(1):(Thetas(2)-Thetas(1))/(Points-1):Thetas(2);

    for k = 1:length(R)

        x = C(1)+cos(Theta)*R(k);
        y = C(2)+sin(Theta)*R(k);

        if length(R)>1
            Coor{k,1}=[x',y'];
        else
            Coor=[x',y'];
        end
    end

end