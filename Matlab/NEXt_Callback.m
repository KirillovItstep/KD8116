function NEXt_Callback(varargin)
% следующий прибор

global EXIt vid...
       BEGin  NEXt PANel  IMAge text1_1 PROv PRInt_Er VISion...
       text3 axes1f1 text1f1 text2f1 VISion2...
       
           
 
   



set(text1_1,'Visible','on')
set(text1_1,'String','Подключите разъём, вставте прибор в гнездо и нажмите кнопку!');
set(axes1f1, 'Visible','off');
delete (axes1f1);
set(BEGin,'visible','on'); 
set(VISion,'visible','on');
set(VISion2,'visible','off');
set(EXIt,'visible','on'); 
set(PROv,'visible','off'); 
set(IMAge,'visible','off'); 
set(text3 ,'visible','off');  
set(PANel ,'visible','off'); 
set(text1f1,'visible','off'); 
set(text2f1,'visible','off');
set(PRInt_Er,'visible','off');
set(findobj('tag', 'VISion2'),'Visible','off');
delete (text1f1);
set(NEXt,'Visible','off' );
uicontrol(BEGin);
% figure(figure000); 
pause(2);   
