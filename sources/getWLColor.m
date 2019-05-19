function [ color ] = getWLColor( waveLength )
%GETWLCOLOR Summary of this function goes here
%   Detailed explanation goes here


maxWave=1.5;%mkm
minWave=0.15;%mkm

colors=jet(32);

idx = floor(32*(waveLength - minWave)/(maxWave - minWave));
    if idx<=0
        idx=1;
    end
    if idx>32
        idx=32;
    end
    
    color=colors(idx,:);
end

