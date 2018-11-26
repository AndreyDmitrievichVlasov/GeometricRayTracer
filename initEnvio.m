function  initEnvio()
%INITENVIO Summary of this function goes here
%   Detailed explanation goes here
 %% Костыль №1 (для доступа к функциям трейсера необходимо вызывать это функцию каждый раз поле вызова clear all, а так же перед первым запуском)
clear all; close all;
opengl hardware
% opengl info
% opengl software
addpath([pwd '\drawers']);
addpath([pwd '\sources']);
addpath([pwd '\surfaces']);
addpath([pwd '\tracing']);

end

