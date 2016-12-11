classdef Obstacle < handle
    %OBSTACLE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        faces
        handle3Dplot
        pos
        size
    end
    
    methods
        function obj = Obstacle(P,Siz)
            if length(Siz) == 1
                Siz = ones(1,3)*Siz;
            end
            obj.setSize(Siz);            
            obj.setPos(P);
            obj.handle3Dplot = [];
            %obj.solveGeometry;
        end
        
        %% SET
        function setPos(obj,p), obj.pos = p; obj.solveGeometry();    end
        function setSize(obj,s), obj.size = s; end
        %% GET
        function R = getPos(obj,p),  R = obj.pos; end
        function R = getSize(obj,s), R = obj.size; end        
        
        %%
        function solveGeometry(obj)
            obj.faces = Gen.Cube(obj.pos,obj.size,0);
        end
        
        %% f
        function plot(obj,Ax)
            Color = [1 0 0];
            obj.handle3Dplot = Draw.patch_in(Ax,obj.handle3Dplot,obj.faces,Color);
        end
    end
    
end

