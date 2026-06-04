clc;
clear;
close all;

%% =====================================================
% 3 YAGI-UDA ANTENNAS IN TRIANGULAR FORMATION
% Operating Frequency : 206.5 MHz
%% =====================================================

%% Frequency
fc = 206.5e6;

%% Constants
c = physconst('LightSpeed');

%% Wavelength
lambda = c/fc;

%% Spacing
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
% TRIANGULAR ARRAY POSITIONS
%% =====================================================

% Equilateral triangle coordinates

x = [ ...
     0 ...
     d ...
     d/2 ];

y = [ ...
     0 ...
     0 ...
     sqrt(3)*d/2 ];

z = [0 0 0];

%% =====================================================
% CREATE CONFORMAL ARRAY
%% =====================================================

array3 = phased.ConformalArray( ...
    'Element',singleYagi,...
    'ElementPosition',[x;y;z]);

%% =====================================================
% VIEW ARRAY GEOMETRY
%% =====================================================

figure;

viewArray(array3);

title('3-Yagi Triangular Array');

%% =====================================================
% 3D RADIATION PATTERN
%% =====================================================

figure;

pattern(array3,...
        fc,...
        -180:1:180,...
        -90:1:90,...
        'CoordinateSystem','polar',...
        'Type','directivity');

title('3-Yagi Triangular Array Pattern');

%% =====================================================
% AZIMUTH PATTERN
%% =====================================================

figure;

patternAzimuth(array3,fc);

grid on

title('3-Yagi Triangular Array Azimuth Pattern');

%% =====================================================
% ELEVATION PATTERN
%% =====================================================

figure;

patternElevation(array3,fc);

grid on

title('3-Yagi Triangular Array Elevation Pattern');

%% =====================================================
% DISPLAY PARAMETERS
%% =====================================================

disp('-----------------------------------');
disp('3-YAGI TRIANGULAR ARRAY');
disp('-----------------------------------');

disp(['Frequency = ',num2str(fc/1e6),' MHz']);

disp(['Wavelength = ',num2str(lambda),' meters']);

disp(['Spacing d = ',num2str(d),' meters']);

disp('-----------------------------------');