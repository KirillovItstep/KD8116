function VASion1_Callback(varargin)
% ������ �������� ����������

global figure1  EXIt...
       BEGin  NEXt PANel  IMAge PROv PRInt_Er  axes1f1 VISion...
       text1_1  text3 text4 axes1f1  text1f1 text2f1...
       left bottom widht height vid sobj...
       cena xc1 yc1 ...
       Ms MsStr2 MsStr5 ...
       dopusk Shkala Datchik NameUnitDatcik zummer...
       Otklonenie PopCentrsEnd_strl popinter...
       Goden...
       crop   threshold thresholdX thresholdLed Open NumShkal...
       ER_Soob...
       inter Images Centrs_metki CentrsEnd_strl n X Prov_1 ImLed figure000
%   figure(figure000);
 SCRsize=(get(0,'MonitorPositions'));
widht=SCRsize(3);
height=SCRsize(4)-19;

% exist(findobj('tag','figure_vid'))
%   if exist(findobj('tag','figure_vid'))~=0 
%  delete(findobj('tag','figure_vid'));
%     end
% pause(2)
figure_vid = figure...
  ('Color'           , [0.8 0.8 0.8],...
  'NumberTitle'     ,'off', ...
  'Name'            ,'�����',...
  'Tag'             ,'figure_vid',...
  'PaperSize'       ,[20.98 29.68],...
  'PaperType'       ,'a4letter',...
  'Position'        , [10 height/3-20 widht/1.5 (widht/2)],...
  'Resize'          , 'on',...
  'Menu'            ,'none');
vidRes = get(vid, 'VideoResolution');
nBands = get(vid, 'NumberOfBands');
hImage = image( zeros(vidRes(2), vidRes(1),nBands) );
preview(vid, hImage);
  SOOB2=0;
     
      %tic 

 y=[uint8('@') 0 0 ];%������ �����������
 x1=[uint8('@') 0 0 0 0 0];%����� �����������
 
 
try
%    
% 
set(text1_1     ,'Visible','off');    
set(EXIt        ,'Visible','on');
set(BEGin       ,'Visible','off');   
set(IMAge       ,'Visible','off'); 
set(VISion       ,'Visible','off'); 
set(findobj('tag', 'VISion2'),'Visible','off');
set(PANel                 ,'Visible','on');
set(text3,   'HorizontalAlignment' ,'center',...
    'String'              ,'���������',...
    'Visible'             ,'on');

  for kk=1:4
    set(text4,     'HorizontalAlignment' ,'center',...
        'String'              ,'--',...
        'Visible'             ,'on');pause(0.2)
    set(text4,     'HorizontalAlignment' ,'center',...
        'String'              ,'|',...
        'Visible'             ,'on');pause(0.2)
    end
%     

SOOB2=6;
x=[uint8('@') 1 2 1 32];%��������� �������;�����1
fwrite(sobj,x);
pause(0.2)
fwrite(sobj,x);
pause(0.2)
x=[uint8('@') 2 2 5 64+4+2];%13.5 �����
fwrite(sobj,x)
 for kk=1:4
    set(text4,     'HorizontalAlignment' ,'center',...
        'String'              ,'--',...
        'Visible'             ,'on');pause(0.2)
    set(text4,     'HorizontalAlignment' ,'center',...
        'String'              ,'|',...
        'Visible'             ,'on');pause(0.2)
    end

x=[uint8('@') 1 2 1 32+64];%��������� �������;�����1,��������� �����
fwrite(sobj,x);pause(0.2)
fwrite(sobj,x);
pause(0.2)
SOOB2=1; 
%x1=fread(sobj,6);

set(text3,'String','��������� �����');

 for kk=1:10
    set(text4,     'HorizontalAlignment' ,'center',...
        'String'              ,'--',...
        'Visible'             ,'on');pause(0.2)
    set(text4,     'HorizontalAlignment' ,'center',...
        'String'              ,'|',...
        'Visible'             ,'on');pause(0.2)
    end
 
 
 
SOOB2=6; 
x=[uint8('@') 1 2 1 32];%�������� ������
fwrite(sobj,x);pause(0.2)
fwrite(sobj,x);
pause(0.2)
SOOB2=2; 


%x1=fread(sobj,6);

% 
% 
% set(text3,'String','�������� ');
% 
% set(PANel,'Visible','on');
% 
% 
% 
% %% ����������  ����� ������� ��� ��������� 1 (N- �����
% % ����������)
% 
% 
% 
% set(text3,'HorizontalAlignment','center','String','����� 1');
% SOOB2=6;
% x=[uint8('@') 1 2 1 32];%��������� �������;�����1
% fwrite(sobj,x);
% SOOB2=2; 
% pause(3) 
% 
% %**********************
% 
% 
% 
% set(text3,'HorizontalAlignment','center','String','����� 2');
% SOOB2=6;
% x=[uint8('@') 1 2 2 32];%��������� �������;�����2
% fwrite(sobj,x);
% SOOB2=2; 
% pause(8) 
% 
% 
% % ����������)
% 
% set(text3,'HorizontalAlignment','center','String','����� 3');
% SOOB2=6;
% x=[uint8('@') 1 2 4 32];%��������� �������;�����3
% fwrite(sobj,x);
% SOOB2=2; 
% pause(8) 
% 
% 
% 
% 
% 
% %% ����������  ����� ������� ��� ��������� 4 (N- �����
% % ����������)
% 
% 
% set(text3,'HorizontalAlignment','center','String','����� 4');
% SOOB2=6;
% x=[uint8('@') 1 2 8 32];%��������� �������;�����4
% fwrite(sobj,x);
% SOOB2=2; 
% pause(8)
% 
% SOOB2=6;
% x=[uint8('@') 1 2 1 32];%��������� �������;�����1
% fwrite(sobj,x);
% SOOB2=2; 
% pause(3) 
% 
% 
% 
% 
% set(text3,'HorizontalAlignment','center','String','�������� ����������');
% % %% ����������  ����� �������  ���������� ��� ��������� 12 ����� (NC- �����
% % % ���������� ���������� - ��������� ���������  )
% 
% % 
% NC=6;
% set(text3,'HorizontalAlignment','center','String','���������� 12 B');
% SOOB2=6;
% x=[uint8('@') 2 2 4 128+32+16];%12 �����
% fwrite(sobj,x)
% SOOB2=2; 
% pause(3)
% 
% 
% 
% 
% set(text3,'HorizontalAlignment','center','String','���������� 13 B');
% %% ����������  ����� �������  ���������� ��� ��������� 13 ����� (NC- �����
% % % ���������� ���������� - ��������� ���������  )
% SOOB2=6;
% x=[uint8('@') 2 2 5 16+4];%13 �����
% fwrite(sobj,x)
% SOOB2=2; 
% pause(5)
% 
% 
%  
% 
% 
% set(text3,'HorizontalAlignment','center','String','���������� 15 B');
% %% ����������  ����� �������  ���������� ��� ��������� 15 ����� (NC- �����
% % % ���������� ���������� - ��������� ���������  )
% SOOB2=6;
% x=[uint8('@') 2 2 5 4+8+16+64+128];%15 �����
% fwrite(sobj,x)
% SOOB2=2; 
% pause(5)
% 
% 
% set(text3,'HorizontalAlignment','center','String','���������� 16 B');
% % ����������  ����� �������  ���������� ��� ��������� 16 ����� (NC- �����
% % % ���������� ���������� - ��������� ���������  )
% SOOB2=6;
% x=[uint8('@') 2 2 6 64];%16 �����
% fwrite(sobj,x)
% SOOB2=2; 
% pause(5)
% 
% 
% set(text3,'HorizontalAlignment','center','String','���������� 13,5 B');
% SOOB2=6;
% x=[uint8('@') 2 2 5 64+4+2];%13.5 �����
% fwrite(sobj,x)
% SOOB2=2; 
% pause(0.5)






set(text3,'String','���������� ��. ������');
%����������� ���������� ��������� ����������� 
SOOB2=6;

x=[uint8('@') 1 2 1 128+32+16+8+4+2+1];%��������� �������;�����1,��������� �����
fwrite(sobj,x);
for kk=1:10
    set(text4,     'HorizontalAlignment' ,'center',...
        'String'              ,'--',...
        'Visible'             ,'on');pause(0.2)
    set(text4,     'HorizontalAlignment' ,'center',...
        'String'              ,'|',...
        'Visible'             ,'on');pause(0.2)
    end
% % 
% 
% %����������� ����������������� �������
% fwrite(sobj,y);
% pause(0.2)
% x1=fread(sobj,6);
% 
%     if bitand(x1(4),2)==0
%     zummer=1;
%     else
%     zummer=0;
%     end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


SOOB2=6;
x=[uint8('@') 1 2 1 32];
fwrite(sobj,x);pause(0.2);
fwrite(sobj,x);pause(0.2);
Z=[48    36    34    40   160 33  ];
   for j=1:6
       if j~=5
 x=[uint8('@') 1 2 1 Z(j)];
fwrite(sobj,x);pause(0.2)
fwrite(sobj,x);pause(0.2)
for kk=1:3
    set(text4,     'HorizontalAlignment' ,'center',...
        'String'              ,'--',...
        'Visible'             ,'on');pause(0.2)
    set(text4,     'HorizontalAlignment' ,'center',...
        'String'              ,'|',...
        'Visible'             ,'on');pause(0.2)
    end

       else
       end
   end


 

SOOB2=6;
x=[uint8('@') 1 2 1 0];%����������
fwrite(sobj,x);
pause(0.2)







    
    
set(text3          ,'Visible','off');
set(PANel          ,'Visible','off');
set(text4          ,'Visible','off');
set(BEGin          ,'visible','on'); 
% set(findobj('tag', 'VISion2'),'Visible','on');
set(EXIt           ,'Visible','on');
set(IMAge          ,'Visible','off');  
set(VISion       ,'Visible','on');     

set(BEGin,'KeyPressFcn','NEXt_Callback');
          uicontrol(BEGin);
% 
% set(NEXt           ,'visible','on');
% set(NEXt           ,'string','��������� ������'); 

axes1f1 = axes...
 ('Parent'                ,figure1);
 set(gca,...
  'Visible'               ,'off');
 set(axes1f1,...
  'Position'              ,[0.0 0.61 0.3 0.25]);
   set(axes1f1,...
     'Visible'            ,'off');

 
 text1f1=uicontrol(figure1,...
  'Style'                 ,'text', ...
  'Backgroundcolor'       ,[0.8 0.8 0.8],...
  'FontSize'              ,12,...
  'FontWeight'            ,'bold',...
  'FontName'              ,'Arial',...
  'HorizontalAlignment'   ,'center',...
  'Units'                 ,'normalized', ...
  'Position'              , [0.0 0.50 0.3 0.1] ,...
  'Visible'               ,'off');    

% figure(figure000);

closepreview(vid);



 %toc

  catch
 switch SOOB2;
%   
      case 1 % 
fabric =getsnapshot(vid);

 x=[uint8('@') 2 2 5 64+4+2];%13.5 �����
fwrite(sobj,x)
pause(0.1)
   
    
    
x=[uint8('@') 1 2 1 0];%�������� ������
fwrite(sobj,x);
pause(0.1)
%%x1=fread(sobj,6);

axes1f1 = axes...
 ('Parent'                ,figure1);
 set(gca,...
  'Visible'               ,'off');
 set(axes1f1,...
  'Position'              ,[0.0 0.61 0.3 0.25]);
   set(axes1f1,...
     'Visible'            ,'on');
 axes1f1;imshow(fabric);hold on ; 
 
 text1f1=uicontrol(figure1,...
  'Style'                 ,'text', ...
  'Backgroundcolor'       ,[0.8 0.8 0.8],...
  'FontSize'              ,12,...
  'FontWeight'            ,'bold',...
  'FontName'              ,'Arial',...
  'HorizontalAlignment'   ,'center',...
  'Units'                 ,'normalized', ...
  'Position'              , [0.0 0.50 0.3 0.1] ,...
  'Visible'               ,'off');    
    
   set( text1f1,...
      'Foregroundcolor'       ,'r',...
      'String'                ,'��� ��������� ��� ��������� �����',...
      'Visible'               ,'on');  
    
    
set(text3          ,'Visible','off');
set(PANel          ,'Visible','off');
set(text4          ,'Visible','off');
set(BEGin          ,'visible','off'); 
set(NEXt           ,'visible','on');
set(EXIt           ,'Visible','on');
set(IMAge          ,'Visible','off');           
% %           

    case 2
%          
   fabric =getsnapshot(vid);
   
    x=[uint8('@') 2 2 5 64+4+2];%13.5 �����
fwrite(sobj,x)
pause(0.1)
   
    
    
x=[uint8('@') 1 2 1 0];%�������� ������
fwrite(sobj,x);
pause(0.1)
%%x1=fread(sobj,6);

axes1f1 = axes...
 ('Parent'                ,figure1);
 set(gca,...
  'Visible'               ,'off');
 set(axes1f1,...
  'Position'              ,[0.0 0.61 0.3 0.25]);
   set(axes1f1,...
     'Visible'            ,'on');
 axes1f1;imshow(fabric);hold on ;      
         
  text1f1=uicontrol(figure1,...
  'Style'                 ,'text', ...
  'Backgroundcolor'       ,[0.8 0.8 0.8],...
  'FontSize'              ,12,...
  'FontWeight'            ,'bold',...
  'FontName'              ,'Arial',...
  'HorizontalAlignment'   ,'center',...
  'Units'                 ,'normalized', ...
  'Position'              , [0.0 0.50 0.3 0.1] ,...
  'Visible'               ,'off');    
         
         
         
set(NEXt,'Visible','off' );          
       
set(text3,'Visible','on');
set(PANel,'Visible','on');
set(text3,'HorizontalAlignment','center','String','������ �������');  
 
  
set( text1f1,...
      'Foregroundcolor'       ,'r',...
      'String'                ,'�������� � ���������� ��� ����� ������ ',...
      'Visible'               ,'on');  
    
    
set(text3          ,'Visible','on');
set(PANel          ,'Visible','on');
set(text4          ,'Visible','off');
set(BEGin          ,'visible','off'); 
set(NEXt           ,'visible','on');
set(EXIt           ,'Visible','on');
set(IMAge          ,'Visible','off');


set(text1_1,'Visible','on');
set(text1_1,'String','��������� ����������!'); 
set(EXIt,'KeyPressFcn','Exit_my' );




uicontrol(EXIt); 


% % % % 
case 3

set(NEXt,'Visible','off' );          
       
set(text3,'Visible','on');
set(PANel,'Visible','on');
set(text3,'HorizontalAlignment','center','String','������ �������� ����� infopop8071.m ');  
%set(text24,'visible','on','Background',[0.8 0.8 0.8],...
                %'ForegroundColor',[1 0 0], 'String',''); 
  


set(BEGin1,'Visible','off' ) ;
set(text1_1,'Visible','on');
set(text1_1,'String','������� ������ "�����"!'); 
set(EXIt,'KeyPressFcn','Exit_my' );
set(EXIt,'Visible','on');


%set(text23,'String','');
%set(text24,'String','');
set(text2_2,'String','');
uicontrol(EXIt); 

case 4

set(NEXt,'Visible','off' );          
       
set(text3,'Visible','on');
set(PANel,'Visible','on');
set(text3,'HorizontalAlignment','center','String','������ �������� ����� inforez8071.m ');  
%set(text24,'visible','on','Background',[0.8 0.8 0.8],...
                %'ForegroundColor',[1 0 0], 'String',''); 
  


set(BEGin1,'Visible','off' ) ;
set(text1_1,'Visible','on');
set(text1_1,'String','������� ������ "�����"!'); 
set(EXIt,'KeyPressFcn','Exit_my' );
set(EXIt,'Visible','on');


%set(text23,'String','');
%set(text24,'String','');
set(text2_2,'String','');
uicontrol(EXIt); 

 case 6
     
set(NEXt,'Visible','off' );   
set(text3,'Visible','on');
set(PANel,'Visible','on');
set(text3,'HorizontalAlignment','center','String','���� �����������');  
set(text4          ,'Visible','off');
set(BEGin          ,'visible','off'); 
set(NEXt           ,'visible','on');
set(EXIt           ,'Visible','on');
set(IMAge          ,'Visible','off');           
% %                    
set(text1_1,'Visible','on');
set(text1_1,'String','������� �������� �����'); 
set(EXIt,'KeyPressFcn','Exit_my' );




uicontrol(EXIt); 


 end
end
  delete(findobj('tag','figure_vid'));