function ElementFieldEditForm(fieldName)


s_size=GlobalGet('Screensize');
L=300;
padding=10;
fig_handler=figure('Units', 'pixels', 'pos',[s_size(3)/2-150 s_size(4)/2-50 L 100],'MenuBar','None','NumberTitle','Off');
set(fig_handler,'Name',fieldName);
if strcmp(fieldName,'Position')
    pannel_handler = uipanel(fig_handler,'Title',['Element ',num2str(GlobalGet('ActiveTableRow')),' XYZ coordinates'], 'Position',[0.005 0.005 0.99 0.99]);
elseif strcmp(fieldName,'Angles')
    pannel_handler = uipanel(fig_handler,'Title',['Element ',num2str(GlobalGet('ActiveTableRow')),' ABC angles'], 'Position',[0.005 0.005 0.99 0.99]);
elseif strcmp(fieldName,'Aperture')
    pannel_handler = uipanel(fig_handler,'Title',['Element ',num2str(GlobalGet('ActiveTableRow')),' WH aperure'], 'Position',[0.005 0.005 0.99 0.99]);
end

aspect=0.6;

text_plus_label=L/3-padding;

text_length   = 0.6*text_plus_label;

label_length = (1-0.6)*text_plus_label;

EL=GlobalGet('ElementsList');
EL=EL{GlobalGet('ActiveTableRow')};


textFieldLabelX = uicontrol('parent', pannel_handler ,'pos',[1                  40 label_length 30],'String', 'X, [mm]:','style','text');
textFieldX        = uicontrol('parent', pannel_handler ,'pos',[1+label_length    40 text_length 30],'style','edit','String',num2str(EL.position(1)));


textFieldLabelY = uicontrol('parent', pannel_handler ,'pos',[1+label_length + text_length+padding 40 label_length 30],'String', 'Y, [mm]:','style','text');
textFieldY         = uicontrol('parent', pannel_handler ,'pos',       [1+2*label_length + text_length+padding     40 text_length 30],'style','edit','String',num2str(EL.position(2)));


textFieldLabelZ = uicontrol('parent', pannel_handler ,'pos',[1+2*(label_length + text_length+padding) 40 label_length 30],'String', 'Z, [mm]:','style','text');
textFieldZ        = uicontrol('parent', pannel_handler ,'pos',       [1+2*(label_length + text_length+padding)+label_length 40 text_length 30],'style','edit','String',num2str(EL.position(3)));

acceptButton  = uicontrol('parent', pannel_handler ,'pos',[0  0 295 30],'String', 'Accept element shift','style','pushbutton');

end


