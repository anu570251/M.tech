clc;
clear;
close all;

%% =====================================================
% 2-ELEMENT YAGI-UDA ARRAY
%% =====================================================

%% Frequency
fc = 206.5e6;

%% Constants
c = physconst('LightSpeed');

lambda = c/fc;

%% Array spacing
d = lambda/2;

%% =====================================================
% CREATE SINGLE YAGI
%% =====================================================

singleYagi = yagiUda;

singleYagi.NumDirectors = 5;

singleYagi.ReflectorLength = 0.7820;

singleYagi.DirectorLength = [ ...
    0.5472 ...
    0.5427 ...
    0.5609 ...
    0.4712 ...
    0.6101 ];

singleYagi.ReflectorSpacing = 0.4743;

singleYagi.DirectorSpacing = [ ...
    0.3137 ...
    0.1314 ...
    0.5203 ...
    0.2776 ...
    0.1381 ];

%% =====================================================
% CREATE 2-ELEMENT ARRAY
%% =====================================================

array2 = phased.ULA( ...
    'Element',singleYagi,...
    'NumElements',2,...
    'ElementSpacing',d,...
    'ArrayAxis','y');

%% =====================================================
% VIEW ARRAY GEOMETRY
%% =====================================================

figure;
viewArray(array2);

title('2-Element Yagi-Uda Array');

%% =====================================================
% ARRAY RADIATION PATTERN
%% =====================================================

figure;

pattern(array2,...
        fc,...
        -180:0.1:180,...
        -90:0.1:90,...
        'CoordinateSystem','polar',...
        'Type','directivity');

title('2-Element Yagi-Uda Array Pattern');