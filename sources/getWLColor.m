function [ color ] = getWLColor( waveLength )
%GETWLCOLOR Summary of this function goes here
%   Detailed explanation goes here


maxWave=0.78;%mkm
minWave=0.380;%mkm

colors = dlmread('rgb2lam.dat'); %jet(32);

idx = floor(size(colors,1)*(waveLength - minWave)/(maxWave - minWave));
    if idx<=0
        idx=1;
    end
    if idx>size(colors,1)
        idx=size(colors,1);
    end
    
    color=colors(idx,:);
end

