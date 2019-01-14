clear all; close all;clc;initEnvio();

mir=getMirror(45,-700,[0 0 0],[0 0 0]);
% function [ mir ] = getMirror(aperture,r,orient,pos)
rays=paraxialSpot([0 0 -20],45);
[rays_Out,rays]=reflectFormQuad(mir,rays);
length(rays_Out)
