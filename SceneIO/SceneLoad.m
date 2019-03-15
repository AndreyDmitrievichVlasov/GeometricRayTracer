function  [schema,sequence] = SceneLoad( path2file )
%SCENELOAD Summary of this function goes here
%   Detailed explanation goes here

% 
% splitedString = splitStr('aaa aaa aaa a',' ')
% 
% splitedString(1)

schema={};sequence=[];

fid = fopen(path2file, 'r');     % �������� ����� �� ������ 

elementID=1;

i=1;

line = fgets(fid);

while ischar(line)
    InputLines{i} = strsplit(line,' ');
    line = fgets(fid);
    i=i+1;
end
% strcmp(InputLines{58}{1}(1),'}')
% disp(size(InputLines{58}{1}))
finalLine=0;

    for k=1:length(InputLines)
            if strcmp('Sequense',InputLines{k}{1})
               for i=1:length(InputLines{k})-1
%                   class(InputLines{k}{i+1})
%                   InputLines{k}{i+1}
                  sequence(i)=str2num(InputLines{k}{i+1});
                end
            elseif strcmp('Struct',InputLines{k}(1))
                [structData, finalLine] = readStruct(InputLines,k);
                k=finalLine;
                schema{elementID}=structData;
                elementID=elementID+1;
            end
    end
end

function [structData, finalLine] = readStruct(Lines,startLine)
structData=[];
    finalLine=startLine+1;
%     finalLine
%     size(Lines)
    while ~strcmp(Lines{finalLine}{1}(1),'}')

        Lines{finalLine}{1}(:)
         if length(Lines{finalLine})<2
             finalLine=finalLine+1;
             continue;
        elseif strcmp(Lines{finalLine}{2},'Struct')
               
             field_name=Lines{finalLine}(1);
             [data, finalLine] = readStruct(Lines,finalLine)
             
             structData=setfield(structData,field_name,data);
        else
           
                [field_name,data] = processString(Lines{finalLine});
                if ~isempty(field_name)
                    structData=setfield(structData,field_name,data);
                end
                finalLine=finalLine+1;
%                 finalLine
%                     Lines{finalLine}{1}
%                 Lines{finalLine}
        end
        

    end
end

function [field_name,data] = processString(s_string)

if(length(s_string)==1||isempty(s_string)==0)
    field_name='';
    data=[];
    return;
end

field_name=s_string{1};

classType=s_string{2};

data=[];

    if strcmp(classType,'char')

          data = s_string{3}; 

    elseif strcmp(classType,'double')

    m=str2num(s_string{3});

    n=str2num(s_string{4});

    if m~=1&&n~=1
        data=zeros(m,n);
    elseif m==1&&n~=1
        data=(1:n)*0;
    elseif m~=1&&n==1
        data=(1:m)*0;
    end
%     size(data)
        for i=1:n
              for j=1:m
%                   s_string
%                 (i-1)*n+j+4
%                   search error here
              data(i,j) = num2str(s_string{(i-1)*n+j+4}); 
              end
        end

    end
end

