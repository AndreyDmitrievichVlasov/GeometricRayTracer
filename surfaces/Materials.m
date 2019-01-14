function [ refIndexData ] = Materials( nameOfMaterial )
keys= {'air','silica'};
%Silica glass data was tken from:  https://refractiveindex.info/?shelf=glass&book=fused_silica&page=Malitson
values={struct('Desciption','air','refractionIndexData',[     0          0         0         0         0        0   ]),...
             struct('Desciption','silica','refractionIndexData',[0.6961663  0.0684043 0.4079426 0.1162414 0.8974794 9.896161])};%silica
M = containers.Map(keys,values);
    if M.isKey(nameOfMaterial)
       refIndexData=M(nameOfMaterial);
    else
        refIndexData=M('silica');
    end
end

