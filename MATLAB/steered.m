clc;
clear;
close all;

%% =====================================================
% 7-ELEMENT YAGI-UDA HEXAGONAL ARRAY
% Operating Frequency : 206.5 MHz
%% =====================================================

%% Frequency
fc = 206.5e6;

%% Constants
c = physconst('LightSpeed');

%% Wavelength
lambda = c/fc;

%% Array Spacing
d = lambda/2;

%% =====================================================
% CREATE SINGLE YAGI-UDA ANTENNA
%% =====================================================

singleYagi = yagiUda;

%% Number of Directors
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

%% Element Spacing

% Reflector to Driven Element
singleYagi.ReflectorSpacing = 0.4743;

% Director Spacing
singleYagi.DirectorSpacing = [ ...
    0.3137 ...
    0.1314 ...
    0.5203 ...
    0.2776 ...
    0.1381 ];

%% =====================================================
% SHOW SINGLE YAGI GEOMETRY
%% =====================================================

figure;
show(singleYagi);

title('Single Yagi-Uda Antenna');

%% =====================================================
% SINGLE YAGI RADIATION PATTERN
%% =====================================================

figure;
pattern(singleYagi,fc);

title('Single Yagi Radiation Pattern');

%% =====================================================
% CREATE 7-ELEMENT HEXAGONAL ARRAY
%% =====================================================

theta = 0:60:300;

x = [0 d*cosd(theta)];
y = [0 d*sind(theta)];
z = zeros(size(x));

array7 = phased.ConformalArray( ...
    'Element',singleYagi,...
    'ElementPosition',[x;y;z]);

%% =====================================================
% VIEW ARRAY GEOMETRY
%% =====================================================

figure;
viewArray(array7);

title('7-Element Yagi-Uda Hexagonal Array');

%% =====================================================
% BEAM STEERING
%% =====================================================

steeringAngle = [30;0];

sv = phased.SteeringVector( ...
        'SensorArray',array7,...
        'PropagationSpeed',c);

weights = sv(fc,steeringAngle);

%% =====================================================
% 3D RADIATION PATTERN
%% =====================================================

figure;

pattern(array7,...
        fc,...
        -180:1:180,...
        -90:1:90,...
        'CoordinateSystem','polar',...
        'Type','directivity',...
        'Weights',weights);

title('7-Element Yagi-Uda Array Pattern');

colorbar

%% =====================================================
% AZIMUTH PATTERN
%% =====================================================

figure;

patternAzimuth(array7,...
               fc,...
               'Weights',weights);

title('7-Element Array Azimuth Pattern');

grid on

%% =====================================================
% ELEVATION PATTERN
%% =====================================================

figure;

patternElevation(array7,...
                 fc,...
                 'Weights',weights);

title('7-Element Array Elevation Pattern');

grid on

%% =====================================================
% DISPLAY IMPORTANT VALUES
%% =====================================================

disp('-----------------------------------');
disp('7-ELEMENT YAGI HEXAGONAL ARRAY');
disp('-----------------------------------');

disp(['Frequency = ',num2str(fc/1e6),' MHz']);

disp(['Wavelength = ',num2str(lambda),' meters']);

disp(['Element Spacing d = ',num2str(d),' meters']);

disp('Beam Steering:');

disp(['Azimuth = ',num2str(steeringAngle(1)),' deg']);

disp(['Elevation = ',num2str(steeringAngle(2)),' deg']);

disp('-----------------------------------');