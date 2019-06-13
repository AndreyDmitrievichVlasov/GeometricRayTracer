function [ ] = redot()
%REDOT Summary of this function goes here
%   Detailed explanation goes here
%DOT2 Summary of this function goes here
%   Detailed explanation goes here
childs = get(gcf,'Children');

for i=1:length(childs)
    if strcmp(get(childs(i),'Tag'),'Colorbar')
        YColorTickLabel=get(childs(i),'YTickLabel');
       for k=1:size(YColorTickLabel,1)
            z=strfind(YColorTickLabel(k,:),'.');
            YColorTickLabel(k,z)=',';
            clear z;
       end 
       set(childs(i),'YTickLabel',YColorTickLabel);
    end
end




YA=get(gca,'YTickLabel');

for i=1:size(YA,1)

    z=strfind(YA(i,:),'.');
    YA(i,z)=',';
    clear z;
end


set(gca,'YTickLabel',YA);

XA=get(gca,'XTickLabel');
for i=1:size(XA,1)

    z=strfind(XA(i,:),'.');
    XA(i,z)=',';
    clear z;
  
end


set(gca,'XTickLabel',XA);


end

