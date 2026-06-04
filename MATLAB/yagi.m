clc;
clear;
close all;

%% Operating Frequency
fc = 206.5e6;
c = physconst('LightSpeed');
lambda = c/fc;

%% Create Yagi-Uda Antenna
singleYagi = yagiUda;

%% Number of Directors
singleYagi.NumDirectors = 5;

%% Element Lengths (meters)

singleYagi.ReflectorLength = 0.7820;

singleYagi.DirectorLength = [ ...
    0.5472 ...
    0.5427 ...
    0.5609 ...
    0.4712 ...
    0.6101 ];

%% Element Spacing

singleYagi.ReflectorSpacing = 0.4743;

singleYagi.DirectorSpacing = [ ...
    0.3137 ...
    0.1314 ...
    0.5203 ...
    0.2776 ...
    0.1381 ];

%% Display Geometry
figure;
show(singleYagi);

title('Single Yagi-Uda');

%% 3D Radiation Pattern
figure;
pattern(singleYagi,fc);

title('Single Yagi Radiation Pattern');

%% =====================================
% Array Spacing
%% =====================================

d = lambda/2;