function  GlobalDelete( dataKey )
%GLOBALDELETE Summary of this function goes here
%   Detailed explanation goes here
    if ~ischar(dataKey)
     disp('Wrong key type')
     return;
    end
    if ElementsSet.isKey(dataKey)
        ElementsSet.delete(dataKey);
    else
     disp('No such key found');    
    end
end

