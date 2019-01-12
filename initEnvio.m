function [f] = initEnvio( windows )
%INITENVIO Summary of this function goes here
%   Detailed explanation goes here
 %% ������� �1 (��� ������� � �������� �������� ���������� �������� ��� ������� ������ ��� ���� ������ clear all, � ��� �� ����� ������ ��������)
clear all; close all;
if windows~=false
 opengl hardware
endif 
% opengl info
% opengl software
if windows
 folder_separator='\';
else
 folder_separator='/';
endif
addpath([pwd strcat(folder_separator,'drawers')]);
addpath([pwd strcat(folder_separator,'sources')]);
addpath([pwd strcat(folder_separator,'surfaces')]);
addpath([pwd strcat(folder_separator,'tracing')]);
end

