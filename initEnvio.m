function initEnvio( varargin )
%INITENVIO Summary of this function goes here
%   Detailed explanation goes here
 %% ������� �1 (��� ������� � �������� �������� ���������� �������� ��� ������� ������ ��� ���� ������ clear all, � ��� �� ����� ������ ��������)
%clear all; close all;
% How to add folder and all its subfolders to the search path:
% addpath(genpath('matlab/myfiles'))
if nargin~=0
 if varargin{1}
  opengl hardware
 end
else
 opengl hardware
end
% opengl info
% opengl software
addpath([pwd strcat(folder_separator,'GUI')]);
addpath(genpath(pwd));
%addpath([pwd strcat(folder_separator,'sources')]);
%addpath([pwd strcat(folder_separator,'surfaces')]);
%addpath([pwd strcat(folder_separator,'tracing')]);
end

