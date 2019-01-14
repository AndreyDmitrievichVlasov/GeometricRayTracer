function initEnvio( windows )
%INITENVIO Summary of this function goes here
%   Detailed explanation goes here
 %% ������� �1 (��� ������� � �������� �������� ���������� �������� ��� ������� ������ ��� ���� ������ clear all, � ��� �� ����� ������ ��������)
%clear all; close all;
if windows
 opengl hardware
end 
% opengl info
% opengl software
if windows
 folder_separator='\';
else
 folder_separator='/';
end
addpath([pwd strcat(folder_separator,'drawers')]);
addpath([pwd strcat(folder_separator,'sources')]);
addpath([pwd strcat(folder_separator,'surfaces')]);
addpath([pwd strcat(folder_separator,'tracing')]);
end

