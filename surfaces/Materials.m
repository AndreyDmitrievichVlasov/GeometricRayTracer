function [ refIndexData ] = Materials( nameOfMaterial )
keys= {'air','silica','SK16','F2'};
%Silica glass data was tken from:  https://refractiveindex.info/?shelf=glass&book=fused_silica&page=Malitson
values={struct('Desciption','air','refractionIndexData',[     0          0         0         0         0        0   ]),...
        struct('Desciption','silica','refractionIndexData',[0.6961663  0.0684043 0.4079426 0.1162414 0.8974794 9.896161]),...
        struct('Desciption','SK16','refractionIndexData',  [1.343177740  7.04687339*10^-3 2.41144399*10^-1 2.29005*10^-2 9.94317969*10^-1 9.27508526*10]),...
        struct('Desciption','F2','refractionIndexData',[1.34533359  9.97743871*10^-3 2.09073176*10^-1 4.70450767*10^-2 9.37357162*10^-1 1.11886764*10^2])};%silica
M = containers.Map(keys,values);
    if M.isKey(nameOfMaterial)
       refIndexData=M(nameOfMaterial);
    else
        disp('No such key found')
        refIndexData=M('silica');
    end
end

