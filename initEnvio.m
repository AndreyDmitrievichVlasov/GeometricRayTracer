function initEnvio( varargin )
%INITENVIO Summary of this function goes here
%   Detailed explanation goes here
 %% ������� �1 (��� ������� � �������� �������� ���������� �������� ��� ������� ������ ��� ���� ������ clear all, � ��� �� ����� ������ ��������)
%clear all; close all;
if nargin~=0
    if varargin{1}
     folder_separator='\';
     opengl hardware
    else
     folder_separator='/';
    end
else
     folder_separator='\';
     opengl hardware
end
% opengl info
% opengl software

addpath([pwd strcat(folder_separator,'drawers')]);
addpath([pwd strcat(folder_separator,'sources')]);
addpath([pwd strcat(folder_separator,'surfaces')]);
addpath([pwd strcat(folder_separator,'tracing')]);
end

