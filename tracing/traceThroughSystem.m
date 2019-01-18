function [ raysIn, raysMiddle, raysOut ] = traceThroughSystem( raysIn,varargin)
%TRACETHROUGHSYSTEM Summary of this function goes here
%   Detailed explanation goes here
    if nargin==0
        raysMiddle=[];
        raysOut=[];
    elseif nargin==1

    elseif nargin==2

    end
end
% трассировка по указанном в orderSequence порядку лучей через элементы из
% списка opticalElements
function [raysIn, raysMiddle, raysOut ] = traceByOrder(opticalElements,orderSequence,raysIn)
    if isempty(orderSequence)
        [raysIn, raysMiddle, raysOut ] = traceAsArray(opticalElements,raysIn);
         return;
    end
    if isempty(opticalElements)
        raysMiddle=[]; raysOut=[];
        return;
    end
end

% трассировка списка opticalElements в порядке следования элементов

function [raysIn, raysMiddle, raysOut ] = traceAsArray(opticalElements,raysIn)
    if isempty(opticalElements)
        raysMiddle=[]; raysOut=[];
        return;
    end

    for i=1:length(opticalElements)
        [raysIn, raysMiddle, raysOut ] = traceThrough(opticalElements{i},raysIn);
    end
end

function [raysIn, raysMiddle, raysOut ] = traceThrough(opticalElement,raysIn)
    if strcmp(opticalElement.type,'surface')
      [raysIn ,raysOut]=processSurface(opticalElement,raysIn);
      raysMiddle=[];
      return;
    elseif strcmp(opticalElement.type,'lens')
      [ raysIn, raysMiddle, raysOut ] = traceThroughtLens( opticalElement, raysIn);
      return;
    end
end
function [raysIn ,raysOut]=processSurface(quadSurface,raysIn)
l=length(quadSurface.extraDataType);
    if strcmp(quadSurface.extraDataType(l-1:l),'DG')
        [ raysIn ,raysOut] = difractionFromQuad(quadSurface,raysIn);
        return;
    elseif strcmp(quadSurface.type,'mirror')
        [raysOut,raysIn]=reflectFormQuad(quadSurface,raysIn);
        return;
    elseif strcmp(quadSurface.type,'surface')
        [raysIn]=quadintersect(quadSurface,raysIn);
        raysOut=[];
        return;
    end
end
