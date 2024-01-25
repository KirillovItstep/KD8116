function NEXt_Callback_Er(varargin)
% следующий прибор

global figure1  EXIt...
       SOOB1 BEGin  NEXt PANel  IMAge text1_1 PROv PRInt_Er...
       text2  text3 text4 axes1f1 text1f1 text2f1...
       SOOb2...
       left bottom widht height vid sobj NumShkal...
       Otklonenie
       
   n=NumShkal; %Кол-во циферблатов    
     
   
set(text3          ,'Visible','off');
set(PANel          ,'Visible','off');
set(text4          ,'Visible','off');
set(BEGin          ,'visible','off'); 
set(NEXt           ,'visible','on');
set(NEXt           ,'string','CЛЕДУЮЩИЙ ПРИБОР');
set(EXIt           ,'Visible','on');
set(IMAge          ,'Visible','off'); 
set(PROv           ,'Visible','off');
set(PRInt_Er        ,'Visible','off');

 F=fopen('inforez8071.m','r');

NameFolder=fscanf(F,'%s',1); %имя папки в которую пишет результат"

 fclose(F);     %
% 
Tf=clock;
str=mat2str(Tf);

Tfstr=strcat(str(2:5),str(7),str(9:10),str(12),str(14),str(16:17));

Rasshirenie='.tnp';

NameFale=strcat(NameFolder,Tfstr,Rasshirenie);

 
F=fopen(NameFale,'w');
% 
% 
 for N=1:n
     if N~=5
   fprintf(F,'%s', '(');   
     for i=1:5
     fprintf(F,'%2.1f', Otklonenie(N,i));
     fprintf(F,'%s', ' ');
     end
 fprintf(F,'%s', ')');
 end
 end
fclose(F); 
 