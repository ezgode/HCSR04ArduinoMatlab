%% Information
%Author : Ezequiel G. Debada.
%Data   : 2106-04-09

%% Initialization
close all;clear all;clc;
global END_SIM;
END_SIM = false;
addpath('./functions');
Sensor = HCSR04;
Obst = Obstacle([0,0,0],[30 1 30]); 
%% Create serial object for Arduino
BackGroundColor = [1 1 1]*0.5;
MaxDist = 30;
baudrate = 9600;
%baudrate = 1200;
s = serial('COM3','BaudRate',baudrate); % change the COM Port number as needed
s.ReadAsyncMode = 'manual';
set(s,'InputBufferSize',100);
P = figPos(3,3,1,[2 2],[1 1],1);
F = positions2Figs(P,0.00);
F.Color = BackGroundColor;
drawnow;
%% Connect the serial port to Arduino
try
    fopen(s);
catch err
    fclose(instrfind);
    %error('Make sure you select the correct COM Port where the Arduino is connected.');
end

Flag_Initializing = true;
Ax = position2Axes([0 0 1 .3; 0 .3 1 .7],0.04);
            Ax(2).Color  = BackGroundColor;
            Ax(2).XColor = BackGroundColor;
            Ax(2).YColor = BackGroundColor;
            Ax(2).ZColor = BackGroundColor;
            Ax(2).XTick = [];Ax(2).YTick = [];Ax(2).ZTick = [];
xlabel(Ax(1),'x (cm)');ylabel(Ax(1),'y (cm)');zlabel(Ax(1),'z (cm)');
text(00,00,25,'double clik on this Figure to Stop the script','Parent',Ax(2),'FontSize',15,'horizontalAlignment','center')
H1 = [];xdata = [];ydata = [];
Sensor.plot(Ax(2));drawnow;
Ax(2).CameraPosition = [-571.0349 112.8916 240.0107];drawnow;
axis(Ax(2),'equal');drawnow;
Ax(2).YLim = [-MaxDist 8.3];drawnow;

while(Flag_Initializing)
    while(strcmp(s.TransferStatus,'read'))
        pause(0.01);
    end    
    %readasync(s);
    %sms = fscanf(s);
    Flag_Initializing = false;
end
%% 
cnt = 0;
bufferSize = 100;
filterGain = 0.45;
ydata = zeros(1,bufferSize);
xdata = (-bufferSize+1):0;

%try

while ~END_SIM
    cnt = cnt + 1;
    %Read sensor
    Data = 0;
    %sms = fscanf(s);
    %fprintf('%s',sms);
    %dat = textscan(sms,'%f');
    dat = {rand*20};
    xdata = [xdata(2:end),cnt];
    newY = min(MaxDist, ydata(end) + (dat{1}-ydata(end))*filterGain);
    Dat = newY+Sensor.Geom.Cil_Height*0.5;
    Obst.setPos([0 -Dat 0]);
    Sensor.setData( Dat );
    ydata = [ydata(2:end),newY];
        
    H1 = plotIn(Ax(1),H1,xdata,ydata,'LineWidth',2);
    Ax(1).XLim = xdata(end) + bufferSize*[-1 1];
    Ax(1).YLim = [0 MaxDist];     
    Obst.plot(Ax(2));
    Sensor.plotDist(Ax(2));
    drawnow;
end
fclose(s);
%catch
%    fclose(s);
%    warning('Script finished after error');
%end