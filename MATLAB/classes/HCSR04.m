classdef HCSR04 < handle
    %HSR10 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Geom       %Relevant dimensions
        Data
        Pos
        Ori
        handle3DPlot
        handleDistPlot
    end
    
    methods
        %Constructor
        function obj = HCSR04
            obj.Data = 0;
            obj.Ori = 0;
            obj.Pos = [0 0 0];
            %Cilinders geometry
            obj.Geom.Cil_Radius = 8;
            obj.Geom.Cil_Height = 15-1.2;
            obj.Geom.Cil_Sep = 27;
            
            %Board Geometry
            obj.Geom.Board_Height = 20;
            obj.Geom.Board_Length = 45;
            obj.Geom.Board_thickness = 1.2;
            
            obj.solveGeometry;
            
            obj.handle3DPlot = gobjects(49);
            obj.handleDistPlot   = gobjects(2,1);
        end
        %% SET
        function setData(obj,d), obj.Data = d;                          end
        %% GET
        function R = getData(obj), R = obj.Data;                        end
        function R = getCil_Pos(obj,idx), R = obj.Geom.Cil_Pos(idx,:);  end
        
        %% SolveGometry 
        function solveGeometry(obj)
            obj.Geom.Cil_Pos = [[-0.5*obj.Geom.Cil_Sep,0,0] + obj.Pos;
                [0.5*obj.Geom.Cil_Sep,0,0] + obj.Pos];
            obj.Geom.Board_Pos = [0 obj.Geom.Cil_Height/2+0.8 0] + obj.Pos;            
            obj.Geom.Face = cell(3,1);
            obj.Geom.Face{1} = Gen.Cilinder(obj.Geom.Cil_Pos(1,:), obj.Geom.Cil_Radius, obj.Geom.Cil_Height, 20);
            obj.Geom.Face{2} = Gen.Cilinder(obj.Geom.Cil_Pos(2,:), obj.Geom.Cil_Radius, obj.Geom.Cil_Height, 20);
            obj.Geom.Face{3} = Gen.Cube(obj.Geom.Board_Pos,[obj.Geom.Board_Length obj.Geom.Board_thickness obj.Geom.Board_Height],0);
        end
        
        %% plot
        function plot(obj,Ax)
            Col = [1 1 1]*.8;
            hcont = 0;
            for i = 1:length(obj.Geom.Face)
                for j = 1:size(obj.Geom.Face{i},1)
                    hcont = hcont + 1;
                    F = obj.Geom.Face{i}{j};
                    obj.handle3DPlot(hcont) = patchIn(Ax,obj.handle3DPlot(hcont),F(1,:),F(2,:),F(3,:),Col);        
                end
            end          
        end
        %% plot Dist
        function plotDist(obj,Ax)
            xdata = [0 0];
            ydata = [-obj.Geom.Cil_Height*0.5 , -obj.getData];
            %plot line 
            obj.handleDistPlot(1) = plotIn(Ax,obj.handleDistPlot(1),xdata,ydata,'LineWidth',2);
            %plot measure
            obj.handleDistPlot(2) =textIn(Ax,obj.handleDistPlot(2),mean(xdata),mean(ydata),0,sprintf('%6.3f cm',obj.getData),...
                'HorizontalAlignment','center','VerticalAlignment','bottom',...
                'FontSize',16);
        end
        %% Demo
        function animaDemo(obj,F)
            Obs = Obstacle([0 -80 0], 3);

            BackGroundColor = [1 1 1]*0.7;

            Tsim = 230;
            
            xdata = 1:1:Tsim;
            
            ydata{1} = xdata*0;
            ydata{1}(2:20) = 1;
            ydata{2} = xdata*0;
            ydata{3} = xdata*0;
            ydata{4} = xdata*0;
            ydata{3}([80:180]+30) = 1;                        
            
            ks = [7 8 12 13 17 18 22 23 27 28 32 33]+30;
            ydata{2}(ks) = 1;ydata{4}(ks+142) = 1;
            
            %Create Figure and axes,
            %F = Draw.New_Figure(false);
            F.Color = BackGroundColor;
            Ax = position2Axes([0.3 0 0.7 1;
                                     0.0 4/6 0.4 1/6;
                                     0.0 3/6 0.4 1/6;
                                     0.0 2/6 0.4 1/6;
                                     0.0 1/6 0.4 1/6],0.02,{'Parent',F});
            
            Ax(1).Color  = BackGroundColor;
            Ax(1).XColor = BackGroundColor;
            Ax(1).YColor = BackGroundColor;
            Ax(1).ZColor = BackGroundColor;

            for k = 1:size(Ax,1)
                Ax(k).XTick = [];Ax(k).YTick = [];Ax(k).ZTick = [];
                Ax(k).NextPlot = 'add';
            end
            Ax(1).CameraPosition = [-1029.4   -0522.8    0601.2];

            %Plot sensor and obstacle
            obj.plot(Ax(1));
            Obs.plot(Ax(1));
        
            axis(Ax(1),'equal');
                
            nWaves{1} = 6;
            nWaves{2} = 6;

            H{1} = cell(nWaves{1},2);
            R{1} = ([1:nWaves{1}]-1)*-5-30;
            C{1} = cell(nWaves{1},1);

            H{2} = cell(nWaves{2},2);
            R{2} = ([1:nWaves{2}]-1)*-5-75-30;
            C{2} = cell(nWaves{2},1);

            Ax(1).YLim = Ax(1).YLim;
            Ax(1).XLim = Ax(1).XLim;
            Ax(1).ZLim = Ax(1).ZLim;

            Htime{1} = [];
            Htime{2} = [];
            Htime{3} = [];
            Htime{4} = [];
            
            for k = 2:5
                Ax(k).XLim = [1 Tsim];
                Ax(k).YLim = [0 1];
            end
            FS =12;
            ylabel(Ax(2),sprintf('Trigger\nInput'),'FontSize',FS);
            ylabel(Ax(3),sprintf('Echo Pulse\nOuput'),'FontSize',FS);
            ylabel(Ax(4),sprintf('Sonic Burst\nfrom module'),'FontSize',FS);
            ylabel(Ax(5),sprintf('Echo Pulse\nInput'),'FontSize',FS);
            

            for k = 1:Tsim
                R{1} = R{1} + ones(size(R{1}));
                R{2} = R{2} + ones(size(R{2}));
                Color{1} = [1 0 0];
                Color{2} = [0 1 0];
                ThRange{1} = [-pi+pi/5 0-pi/5];
                ThRange{2} = [-pi+pi/5 0-pi/5]+pi;
                POS{1} = obj.getCil_Pos(1);
                POS{2} = Obs.getPos;
                if k == 10
                    text(4,1.1,'10\mu s','Parent',Ax(2),'FontSize',FS);
                end
                if k == 60
                    text(27,1.1,'8 Cycle Sonic Burst','Parent',Ax(3),'FontSize',FS);
                end                
                for j = 1:2
                    for i = 1:nWaves{j}
                        C{j}{i,1} = circle(POS{j}, max(0,R{j}(i)), 60, ThRange{j});
                        H{j}{i,1} = plotIn(Ax(1),H{j}{i,1},C{j}{i,1}(:,1),C{j}{i,1}(:,2),'Color',Color{j},'LineWidth',2);
                    end
                end
                ColLine = [0 0 0;1 0 0;0 0 1;0 1 0];
                for i = 1:4
                    Htime{i} = stairsIn(Ax(i+1), Htime{i}, xdata(1:k), ydata{i}(1:k),'LineWidth',2,'Color',ColLine(i,:));
                end
                drawnow;
                %saveImg(F,sprintf('%03d.png',k),'./Gifs/00Animation/',2200/1080,2.5);
                %pause(0.1)
            end
        end
    end
    
end

