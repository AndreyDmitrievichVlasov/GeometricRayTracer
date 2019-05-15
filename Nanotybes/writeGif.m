function  writeGif( path2file,data,timeoffset)
%WRITEGIF Summary of this function goes here
%   Detailed explanation goes here

maxVal=max(max(max(data)));
minVal=min(min(min(data)));
map=jet(256);
%  map=gray(256);
    if length(timeoffset)==size(data,3)
            for k=1:size(data,3)    
                  o=256*(data(:,:,k)-minVal)/(maxVal-minVal); 
                  if k == 1
                                imwrite(uint8(o),map,strcat(path2file,'.gif'),'gif','LoopCount',Inf,'DelayTime',timeoffset(k));
                 else
                                imwrite(uint8(o),map,strcat(path2file,'.gif'),'gif','WriteMode','append','DelayTime',timeoffset(k));
                  end
            end
    else
           for k=1:size(data,3)    
                   o=256*(data(:,:,k)-minVal)/(maxVal-minVal); 
%                     o=data(:,:,k);
                  if k == 1
                                imwrite(uint8(o),map,strcat(path2file,'.gif'),'gif','LoopCount',Inf,'DelayTime',timeoffset);
                 else
                                imwrite(uint8(o),map,strcat(path2file,'.gif'),'gif','WriteMode','append','DelayTime',timeoffset);
                  end
            end
            for k=1:size(data,3)-1    
%                 o=data(:,:,size(data,3)-k);
                  o=256*(data(:,:,size(data,3)-k)-minVal)/(maxVal-minVal); 
%                   if k == 1
%                                 imwrite(uint8(o),map,strcat(path2file,'.gif'),'gif','LoopCount',Inf,'DelayTime',timeoffset);
%                  else
                                imwrite(uint8(o),map,strcat(path2file,'.gif'),'gif','WriteMode','append','DelayTime',timeoffset);
%                   end
            end
    end
    
end

