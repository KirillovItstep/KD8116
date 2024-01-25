function VASion2_Callback(varargin)
global  sobj vid ...
    SA1 SA2 SA3 SA4 Power  Z
SCRsize=(get(0,'MonitorPositions'));
widht=SCRsize(3);
height=SCRsize(4)-19;

y=[uint8('@') 0 0 ];%запрос контроллера
x=[uint8('@') 0 0 0 0 0];%ответ контроллера
% vid = videoinput('winvideo', 1,'RGB24_640x480');
% %  Z=[48    36    34    40    160 33  ];
Z=0;A=1;zummer=1;
figure000 = figure...
    ('Color'           , [0.925 0.914 0.844],...
    'PaperPosition'   ,[0.25 2.5 8 6],...
    'NumberTitle'     ,'off', ...
    'Name'            ,'KD8071',...
    'Tag'             ,'figure0',...
    'PaperSize'       ,[20.98 29.68],...
    'PaperType'       ,'a4letter',...
    'Position'        , [widht/4  height/4 widht/1.5 height/1.5],...%     'Position'        , [0.45 0.64 0.5 0.285],...
    'Resize'          , 'off',...
    'Menu'            ,'none',...
    'WindowStyle'     ,'modal',...
    'CloseRequestFcn' ,@myclosereq2);

hp1 = uipanel('Parent',figure000,...
    'Title'           ,'',...
    'FontName'        ,'Arial',...
    'FontSize'        ,8,...
    'Units'           ,'normalized',...
    'Position'        ,[0.03 0.1 0.94 0.88]);
% Create the button group.
hbg1 = uibuttongroup('parent',hp1,'visible','off','Position',[.82 .6 .17 .392],'Title','Контроль');
% Create three radio buttons in the button group.
u0 = uicontrol('Style','Radio','String','точка 1',...
    'Units'           ,'normalized','tag','u0',...
    'pos',[.1 .8 .8 .1],'parent',hbg1,'HandleVisibility','off');
u1 = uicontrol('Style','Radio','String','точка 2',...
    'Units'           ,'normalized','tag','u1',...
    'pos',[.1 .6 .8 .1],'parent',hbg1,'HandleVisibility','off');
u2 = uicontrol('Style','Radio','String','точка 3',...
    'Units'           ,'normalized','tag','u2',...
    'pos',[.1 .4 .8 .1],'parent',hbg1,'HandleVisibility','off');
u3 = uicontrol('Style','Radio','String','точка 4',...
    'Units'           ,'normalized','tag','u3',...
    'pos',[.1 .2 .8 .1],'parent',hbg1,'HandleVisibility','off');
% Initialize some button group properties.
set(hbg1,'SelectionChangeFcn',@selcbk);
% set(hbg1,'SelectedObject',[]);  % No selection
set(hbg1,'Visible','on');

hp_volt = uipanel('Parent',hp1,...
    'Title'           ,'Напряжение',...
    'FontName'        ,'Arial',...
    'FontSize'        ,8,...
    'Units'           ,'normalized',...
    'Position'        ,[.82 .505 .17 .09]);

hpp_volt=uicontrol('Parent'    ,hp_volt,...
    'style'           ,'popup',...
    'units'           ,'normalized', ...
    'position'        ,[0.02 0.6 0.5 0.4 ],...
    'fontsize'        ,9,...
    'tag'             , 'hpp_volt',...
    'Backgroundcolor' ,[1 1 1],...
    'String'          ,'13.5|12|13|15|16',...
    'Callback'        , @setVolt);
ht_volt=uicontrol('Parent'    ,hp_volt,...
    'style'           ,'text',...
    'units'           ,'normalized', ...
    'position'        ,[0.51 0.3 0.4 0.65 ],...
    'fontsize'        ,10,...
    'Backgroundcolor' ,[0.925 0.914 0.844],...
    'String'          ,'вольт');


hp_diod = uipanel('Parent',hp1,...
    'Title'           ,'Светодиоды',...
    'FontName'        ,'Arial',...
    'FontSize'        ,8,...
    'Units'           ,'normalized',...
    'Position'        ,[.82 .05 .17 .45]);

SA1=uicontrol('Parent'    ,hp_diod,...
    'style'           ,'checkbox',...
    'units'           ,'normalized', ...
    'position'        ,[0.15 0.83 0.7 0.12 ],...
    'fontsize'        ,10,...
    'Callback'        , @setSA1,...
    'String'          ,' -1');
SA2=uicontrol('Parent'    ,hp_diod,...
    'style'           ,'checkbox',...
    'units'           ,'normalized', ...
    'position'        ,[0.15 0.7 0.7 0.12 ],...
    'fontsize'        ,10,...
    'Callback'        , @setSA2,...
    'String'          ,' -2');
SA3=uicontrol('Parent'    ,hp_diod,...
    'style'           ,'checkbox',...
    'units'           ,'normalized', ...
    'position'        ,[0.15 0.57 0.7 0.12 ],...
    'fontsize'        ,10,...
    'Callback'        , @setSA3,...
    'String'          ,' -3');

SA4=uicontrol('Parent'    ,hp_diod,...
    'style'           ,'checkbox',...
    'units'           ,'normalized', ...
    'position'        ,[0.15 0.44 0.7 0.12 ],...
    'fontsize'        ,10,...
    'Callback'        , @setSA4,...
    'String'          ,' -4');

SA5=uicontrol('Parent'    ,hp_diod,...
    'style'           ,'checkbox',...
    'units'           ,'normalized', ...
    'position'        ,[0.15 0.31 0.7 0.12 ],...
    'fontsize'        ,10,...
    'Callback'        , @setSA5,...
    'String'          ,' -5');
SA6=uicontrol('Parent'    ,hp_diod,...
    'style'           ,'checkbox',...
    'units'           ,'normalized', ...
    'position'        ,[0.15 0.19 0.8 0.12 ],...
    'fontsize'        ,10,...
    'Callback'        , @setSA6,...
    'String'          ,' - подсветка');
% get(SA6)

SA7=uicontrol('Parent'    ,hp_diod,...
    'style'           ,'text',...
    'units'           ,'normalized', ...
    'position'        ,[0.15 0.05 0.2 0.08 ],...
    'Backgroundcolor' ,[.0 1 .0],...
    'fontsize'        ,10,...
    'String'          ,'');
uicontrol('Parent'    ,hp_diod,...
    'style'           ,'text',...
    'units'           ,'normalized', ...
    'position'        ,[0.45 0.05 0.5 0.08 ],...
    'fontsize'        ,10,...
    'String'          ,'зуммер');




Panel_Video= uipanel('Parent',hp1,'FontSize',12,'Title','',...
    'BackgroundColor',[0.8 0.8 0.8],...
    'Position',[0.01 0.02 0.8 0.96],'Visible','on');
axses1=axes('Parent',Panel_Video','Position',[0.02 0.09 0.96 0.8218 ],'Box','off','TickLength',[0 0],'Visible','on');
vidRes = get(vid, 'VideoResolution');
nBands = get(vid, 'NumberOfBands');
% nBands=3;
% % hImage = image( zeros(VerticalStol, HorizontalStol,3),'parent',findobj('tag', 'axes1_hsp1_3'),'HitTest','off' );
hImage = image( zeros(vidRes(2), vidRes(1), nBands));
preview(vid, hImage);




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hp2 = uipanel('Parent',figure000,...
    'Title'           ,'',...
    'FontName'        ,'Arial',...
    'FontSize'        ,8,...
    'Units'           ,'normalized',...
    'Position'        ,[0.03 0.02 0.77 0.08]);


hp3 = uipanel('Parent',figure000,...
    'Title'           ,'',...
    'FontName'        ,'Arial',...
    'FontSize'        ,8,...
    'Units'           ,'normalized',...
    'Position'        ,[0.8 0.02 0.17 0.08]);
Power=uicontrol('Parent'    ,hp3,...
    'style'           ,'pushbutton',...
    'units'           ,'normalized', ...
    'position'        ,[0.1 0.1 0.8 0.8 ],...
    'backgroundcolor'  ,[.0 .0 .0],...
    'foregroundcolor'  ,[1 1 1],...
    'fontsize'        ,10,...
    'Callback'        , @setPower,...
    'String'          ,'ВКЛ АКБ');

% set([ u0 u1 u2 u3 hpp_volt SA1 SA2 SA3 SA4 SA5 SA6 SA7 Power],'enable','off');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% subfunction %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    function selcbk(hObject,eventdata)
        
        switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
            
            case 'u0'
                % Code for when radiobutton1 is selected.
                A=1;
                x=[uint8('@') 1 2 A Z];
                pause(0.1)
                fwrite(sobj,x);
                
            case 'u1'
                % Code for when radiobutton2 is selected.
                A=2;
                x=[uint8('@') 1 2 A Z];
                pause(0.1)
                fwrite(sobj,x);
                
                
            case 'u2'
                % Code for when togglebutton1 is selected.
                A=4;
                x=[uint8('@') 1 2 A Z];
                pause(0.1)
                fwrite(sobj,x);
                
            case 'u3'
                % Code for when togglebutton2 is selected.
                A=8;
                x=[uint8('@') 1 2 A Z];
                pause(0.1)
                fwrite(sobj,x);
                % Continue with more cases as necessary.
            otherwise
                % Code for when there is no match.
        end
    end

    function setVolt(source,eventdata)
        val = get(source,'Value');
        if val==1
            x=[uint8('@') 2 2 5 64+4+2];%13.5 вольт
            fwrite(sobj,x);
        elseif val==2
            x=[uint8('@') 2 2 4 128+32+16];%12 вольт
            fwrite(sobj,x);
        elseif val==3
            x=[uint8('@') 2 2 5 16+4];%13 вольт
            fwrite(sobj,x);
        elseif val==4
            x=[uint8('@') 2 2 5 4+8+16+64+128];%15 вольт
            fwrite(sobj,x);
        elseif val==5
            x=[uint8('@') 2 2 6 64];%16 вольт
            fwrite(sobj,x);
        end
    end

%     function setU(source,eventdata)
%         val = get(source,'Value');
%         A=get(source,'String');
%         U=A(val,:);
%         x=['@3' U char(13)];fwrite(sobj,x);pause(0.02);
%     end

    function setSA1(source,eventdata)
        
        if  (get(source,'Value') == get(source,'Max'))
            
            Z=Z+16;
            x=[uint8('@') 1 2 A Z];
            pause(0.1)
            fwrite(sobj,x);
        else
            Z=Z-16;
            x=[uint8('@') 1 2 A Z];
            pause(0.1)
            fwrite(sobj,x);
        end
        pause(0.2)
        zummer=Zummer;
        if zummer==1
            set(SA7,'Backgroundcolor',[1 0 0]);
        else
            set(SA7,'Backgroundcolor',[0 1 0]) ;
        end
    end

    function setSA2(source,eventdata)
        
        if (get(source,'Value') == get(source,'Max'))
            Z=Z+4;
            x=[uint8('@') 1 2 A Z];
            
            fwrite(sobj,x);
        else
            Z=Z-4;
            x=[uint8('@') 1 2 A Z];
            
            fwrite(sobj,x);
        end
        pause(0.2)
        zummer=Zummer;
        if zummer==1
            set(SA7,'Backgroundcolor',[1 0 0]);
        else
            set(SA7,'Backgroundcolor',[0 1 0]) ;
        end
    end

    function setSA3(source,eventdata)
        if (get(source,'Value') == get(source,'Max'))
            Z=Z+2;
            x=[uint8('@') 1 2 A Z];
            pause(0.1)
            fwrite(sobj,x);
        else
            Z=Z-2;
            x=[uint8('@') 1 2 A Z];
            
            fwrite(sobj,x);
        end
        pause(0.2)
        zummer=Zummer;
        if zummer==1
            set(SA7,'Backgroundcolor',[1 0 0]);
        else
            set(SA7,'Backgroundcolor',[0 1 0]) ;
        end
    end

    function setSA4(source,eventdata)
        if (get(source,'Value') == get(source,'Max'))
            Z=Z+8;
            x=[uint8('@') 1 2 A Z];
            pause(0.1)
            fwrite(sobj,x);
        else
            Z=Z-8;
            x=[uint8('@') 1 2 A Z];
            
            fwrite(sobj,x);
        end
        pause(0.1)
        zummer=Zummer;
        if zummer==1
            set(SA7,'Backgroundcolor',[1 0 0]);
        else
            set(SA7,'Backgroundcolor',[0 1 0]) ;
        end
    end
    function setSA5(source,eventdata)
        if (get(source,'Value') == get(source,'Max'))
            Z=Z+1;
            x=[uint8('@') 1 2 A Z];
            pause(0.1)
            fwrite(sobj,x);
        else
            Z=Z-1;
            x=[uint8('@') 1 2 A Z];
            pause(0.1)
            fwrite(sobj,x);
        end
        pause(0.1)
        zummer=Zummer;
        if zummer==1
            set(SA7,'Backgroundcolor',[1 0 0]);
        else
            set(SA7,'Backgroundcolor',[0 1 0]) ;
        end
    end
    function setSA6(source,eventdata)
        a=get(Power,'Backgroundcolor');
        if (get(source,'Value') == get(source,'Max'))
            Z=Z+64;
            if a(1)==1
                
                x=[uint8('@') 1 2 A Z];
                pause(0.1)
                fwrite(sobj,x);
            end
        else
            Z=Z-64 ;
            x=[uint8('@') 1 2 A Z];
            pause(0.1)
            fwrite(sobj,x);
        end
        
    end

    function setPower(source,eventdata)
        
        a=get(source,'Backgroundcolor');
        if a(1)==0
            Z=Z+32;
            x=[uint8('@') 1 2 A Z];%включение прибора;Набор1
            fwrite(sobj,x);% включить питание
            x=[uint8('@') 2 2 5 64+4+2];%13.5 вольт
            fwrite(sobj,x)
            set(source,'Backgroundcolor',[1 0 0],'string','ВЫКЛ АКБ','Foregroundcolor',[0 0 0]);
            set(findobj('tag', 'hpp_volt'),'Value',1);
        elseif a(1)==1
            Z=Z-32;
            x=[uint8('@') 1 2 A Z];%
            fwrite(sobj,x);
            set(source,'Backgroundcolor',[0 0 0],'string','ВКЛ АКБ','Foregroundcolor',[1 1 1]);
            if (get(SA6,'Value')==get(SA6,'Max'))
                set(SA6,'Value',get(SA6,'Min'));
                Z=Z-64;
                x=[uint8('@') 1 2 A Z];%
                fwrite(sobj,x);
            end
        end
        %          get(SA1,'Value')
        
    end

%

    function zummer=Zummer(source,eventdata)
        flushinput(sobj);
        fwrite(sobj,y);
        pause(0.2)
        
        while (sobj.BytesAvailable<6)
            pause(0.1);
            sobj.BytesAvailable;
        end
        
        x1=fread(sobj,6);
        
        
        if bitand(x1(4),2)==0
            zummer=1;
        else
            zummer=0;
        end
    end


    function myclosereq2(source,eventdata)
        
        x=[uint8('@') 1 2 0 0];fwrite(sobj,x);
        pause(0.1)
        x=[uint8('@') 0 0 0 0];fwrite(sobj,x);
        pause(0.1)
        closereq;
    end
%     function activate(source,eventdata)
%         try
%             val=get(hPort,'Value');
%             a=get(hPort,'String');
%             PORTstr=a(val,:);
%             sobj = serial(PORTstr,'BaudRate',9600);
%             fopen(sobj);
%             sobj.Terminator='CR';
%             pause(0.01);
%             x=[uint8('@') 0 0 0 0];fwrite(sobj,x);
%             %             x=['@2' int2str(Dout) char(13)];fwrite(sobj,x);pause(0.1);
%             %             x=['@0' freq_G2 char(13)];fwrite(sobj,x);pause(0.02);% устоновить частоту генератора G2
%             %             x=['@1' freq_G3 char(13)];fwrite(sobj,x);pause(0.02);% устоновить частоту генератора G3
%             set([ u0 u1 u2 u3 hpp_volt SA1 SA2 SA3 SA4 SA5 SA6 SA7  Power],'enable','on');
%             set(hPort,'style','text'); set(hbPort,'Visible','off');set(hPort,'String',PORTstr);
%         catch
%             err = lasterror;
%             errordlg(err.message);
%         end
%     end
end
