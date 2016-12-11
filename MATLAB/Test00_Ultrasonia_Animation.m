close all; close all; clc;
addpath ./functions/
% Create Sensor and Obstacle
Sensor = HCSR04;
P = figPos(3,3,1,[2 2],[1 1],1);
F = positions2Figs(P,0.00);
Sensor.animaDemo(F);
