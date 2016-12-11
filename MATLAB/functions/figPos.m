function P = figPos(varargin)
    %P = figPos(rows, columns,nfigs, iniPos, [slotsx,slotsy], sc)
    optvar = {1,1,1,[1,1],[1,1],1};
    if nargin==1
        nfigs = varargin{1};
        fils = floor(sqrt(nfigs));
        cols = ceil( nfigs/fils);
        varargin = { fils,cols, nfigs};
    end            
    optvar(1:length(varargin)) = varargin(:);
    
    rows    = optvar{1};
    cols    = optvar{2};
    nfigs   = optvar{3};
    pos     = optvar{4};
    slot    = optvar{5};
    sc      = optvar{6};
    
    P = zeros(nfigs,4);
    pCnt = 0;
    MonPos = get(0,'MonitorPosition');
    sc      = min(sc,size(MonPos,1));
    figs = 0;
    cnt = 0;
    
    for f = 1:nfigs
        c = pos(f,1);
        r = pos(f,2);
        xpos = (c-1)*1/cols;
        ypos = (r-1)*1/rows;
        xwidth = 1/cols*slot(f,1);
        ywidth = 1/rows*slot(f,2);
        %P(f,:) = [xpos, ypos, xwidth, ywidth].*([MonPos(sc,3:4),MonPos(sc,3:4)]-[0 100 0 100]) +[MonPos(sc,1:2),0,0];     
        P(f,:) = [xpos, ypos, xwidth, ywidth].*([MonPos(sc,3:4),MonPos(sc,3:4)]-[0 35 0 35]) +[MonPos(sc,1:2),0,0];        
    end
end  