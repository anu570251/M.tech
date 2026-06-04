clc;
clear;
close all;

%% =====================================================
% 7 YAGI-UDA ANTENNAS IN HEXAGONAL ARRAY
% 6 antennas around + 1 at center
% Operating Frequency : 206.5 MHz
%% =====================================================

%% Frequency
fc = 206.5e6;

%% Constants
c = physconst('LightSpeed');

%% Wavelength
lambda = c/fc;

%% Hexagon Radius / Spacing
d = lambda;

%% =====================================================
% CREATE SINGLE YAGI-UDA
%% =====================================================

singleYagi = yagiUda;

singleYagi.NumDirectors = 5;

%% Reflector Length
singleYagi.ReflectorLength = 0.7820;

%% Director Lengths
singleYagi.DirectorLength = [ ...
    0.5472 ...
    0.5427 ...
    0.5609 ...
    0.4712 ...
    0.6101 ];

%% Reflector Spacing
singleYagi.ReflectorSpacing = 0.4743;

%% Director Spacing
singleYagi.DirectorSpacing = [ ...
    0.3137 ...
    0.1314 ...
    0.5203 ...
    0.2776 ...
    0.1381 ];

%% =====================================================
% HEXAGONAL ARRAY COORDINATES
%% =====================================================

theta = 0:60:300;

x_outer = d*cosd(theta);
y_outer = d*sind(theta);

%% Center element
x = [0 x_outer];
y = [0 y_outer];

%% Z coordinates
z = zeros(size(x));

%% =====================================================
% CREATE CONFORMAL ARRAY
%% =====================================================

array7 = phased.ConformalArray( ...
    'Element',singleYagi,...
    'ElementPosition',[x;y;z]);

%% =====================================================
% VIEW ARRAY GEOMETRY
%% =====================================================

figure;

viewArray(array7);

title('7-Yagi Hexagonal Array');

%% =====================================================
% 3D RADIATION PATTERN
%% =====================================================

figure;

pattern(array7,...
        fc,...
        -180:1:180,...
        -90:1:90,...
        'CoordinateSystem','polar',...
        'Type','directivity');

title('7-Yagi Hexagonal Array Pattern');

%% =====================================================
% AZIMUTH PATTERN
%% =====================================================

figure;

patternAzimuth(array7,fc);

grid on

title('7-Yagi Hexagonal Array Azimuth Pattern');

%% =====================================================
% ELEVATION PATTERN
%% =====================================================

figure;

patternElevation(array7,fc);

grid on

title('7-Yagi Hexagonal Array Elevation Pattern');

%% =====================================================
% DISPLAY PARAMETERS
%% =====================================================

disp('-----------------------------------');
disp('7-YAGI HEXAGONAL ARRAY');
disp('-----------------------------------');

disp(['Frequency = ',num2str(fc/1e6),' MHz']);

disp(['Wavelength = ',num2str(lambda),' meters']);

disp(['Hexagon Radius d = ',num2str(d),' meters']);

disp('-----------------------------------');