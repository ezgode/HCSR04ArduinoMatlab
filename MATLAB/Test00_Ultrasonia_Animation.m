close all; close all; clc;
addpath ./functions/
% Create Sensor and Obstacle
Sensor = HCSR04;
P = figPos(1,1,1,[1 1],[1 1],2);
F = positions2Figs(P,0.00);
Sensor.animaDemo(F);
