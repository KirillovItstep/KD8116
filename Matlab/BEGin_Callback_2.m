function BEGin_Callback(varargin)
% Кнопка проверки KD8071_4

global figure1  EXIt...
    BEGin  NEXt PANel  IMAge PROv PRInt_Er  axes1f1 VISion VISion2...
    text1_1  text3 text4  text1f1 text2f1...
    vid sobj popinter...
    cena xc1 yc1  Color_Menu...
    Ms  ...
    dopusk Shkala  zummer...
    Otklonenie PopCentrsEnd_strl  ImLed OtklonenieLedSum Led...
    Goden...
    crop   threshold thresholdX thresholdLed  thresholdOSV Open NumShkal...
    inter Images Centrs_metki CentrsEnd_strl n X Prov_1


SCRsize=(get(0,'MonitorPositions'));
widht=SCRsize(3);
height=SCRsize(4)-19;


load ('areaS');
y=[uint8('@') 0 0 ];%запрос контроллера
x1=[uint8('@') 0 0 0 0 0];%ответ контроллера

areaS=areaS1;
n=NumShkal; %Кол-во циферблатов

Popravka=zeros(n,4);
Prov_1=1;

try
    %
    SOOB2=3;
   % Поправки
    F=fopen('infopop8071.m','r');
    Popravka=fscanf(F,'%g',[4 n]);
    Prov_1=fscanf(F,'%g',1);
    %popinter=fscan(F,'%g',[2,n]);
    
    fclose(F);
    %
    set(text1_1     ,'Visible','off');
    set(EXIt        ,'Visible','on');
    set(BEGin       ,'Visible','off');
    set(IMAge       ,'Visible','off');
    set(NEXt        ,'Visible','off');
    set(VISion      ,'Visible','off');
    set(VISion2      ,'Visible','off');
    prompt={'Введите № прибора'};
    N_d= my_inputdlg(prompt);
    if isequal (N_d,1)
        N_device =N_d{1,1};
    else
        Tf=clock;
        str=mat2str(Tf);
        
        N_device=strcat('noname_',str(2:5),str(7),str(9:10),str(12),str(14),str(16:17));
        
    end
    
    
    figure_vid = figure...
        ('Color'           , [0.8 0.8 0.8],...
        'NumberTitle'     ,'off', ...
        'Name'            ,'Видео',...
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
    set(findobj('tag', 'VISion2'),'Visible','off');
    set(PANel                 ,'Visible','on');
    set(text3,     'HorizontalAlignment' ,'center',...
        'String'              ,'ВКЛЮЧЕНИЕ','Foregroundcolor' ,'k',...
        'Visible'             ,'on');
    
    set(text4,     'HorizontalAlignment' ,'center',...
        'String'              ,'|',...
        'Visible'             ,'on');
    SOOB2=6;
    x=[uint8('@') 1 2 1 0];%выключение прибора;Набор1
    fwrite(sobj,x);
    pause(0.2)
    fwrite(sobj,x);
    pause(0.2)
    
    for kk=1:4
        set(text4,     'HorizontalAlignment' ,'center',...
            'String'              ,'--',...
            'Visible'             ,'on');pause(0.2)
        set(text4,     'HorizontalAlignment' ,'center',...
            'String'              ,'|',...
            'Visible'             ,'on');pause(0.2)
    end
    
    
    
    
    
    %
    
    %
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % %КАЛИБРОВКА
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %
    %   % ошибка калибровки
    %
    % SOOB2=6;
    
    
    
    Centrs_metki=ones(4,2,n);
    CentrsEnd_strl=ones(5,2,n);
    
    set(text3, 'String' ,'КАЛИБРОВКА','Visible'             ,'on');
    SOOB2=6;
    x=[uint8('@') 1 2 1 32];%включение прибора;Набор1
    fwrite(sobj,x);
    pause(0.2)
    fwrite(sobj,x);
    pause(0.2)
    
    x=[uint8('@') 2 2 5 64+4+2];%13.5 вольт
    fwrite(sobj,x)
    pause(0.2)
    fwrite(sobj,x);
    for kk=1:8
        set(text4,     'HorizontalAlignment' ,'center',...
            'String'              ,'--',...
            'Visible'             ,'on');pause(0.2)
        set(text4,     'HorizontalAlignment' ,'center',...
            'String'              ,'|',...
            'Visible'             ,'on');pause(0.2)
    end
       fabric1 =getsnapshot(vid);
        
    set(text3,'String','Подсветка шкалы');
    x=[uint8('@') 1 2 1 32+64];%включение прибора;Набор1,подсветка шкалы
    fwrite(sobj,x);
    pause(0.2)
    fwrite(sobj,x);
    SOOB2=1;
    for kk=1:8
        set(text4,     'HorizontalAlignment' ,'center',...
            'String'              ,'--',...
            'Visible'             ,'on');pause(0.2)
        set(text4,     'HorizontalAlignment' ,'center',...
            'String'              ,'|',...
            'Visible'             ,'on');pause(0.2)
    end

    fabric =getsnapshot(vid);
%         figure,imshow(fabric);
    
    
    % определение исправности подсветки
    S=0;S1=0;S11=0;
    n=6;
    for k=1:6
        %         if k==5
        %         else
        cropA=crop(k,:);
        A=imcrop(fabric,cropA);
        A=im2bw(A,thresholdOSV(k)-0.1);
        
        BW=immultiply(A,Ms{2,k});
        %              figure,imshow(BW);
        [L1,numObjects]=bwlabel(BW);
        if numObjects~=0
            S=S+1;
        end
        BW=immultiply(A,Ms{5,k});
        %          BW1=immultiply(A1,Ms{6,k});
        %          BW2=immultiply(~BW1,BW);
        [L1,numObjects1]=bwlabel(BW);
        
        if numObjects1~=0
            stats = regionprops(L1,'Area');
            area=[stats.Area];
            max_area=max(area);
            big = find(area==max_area);
            areaS1(k)=area(big);
        else
            areaS1(k)=0;
        end
        
        if areaS1(k)/areaS(k)<0.6
            S1=S1+1;
        end
    end
    if  S1>0
        
        figure_ss = figure...
            ('Color'           , [0.8 0.8 0.8],...
            'NumberTitle'     ,'off', ...
            'Name'            ,'Подсветка',...
            'Tag'             ,'figure_ss',...
            'PaperSize'       ,[20.98 29.68],...
            'PaperType'       ,'a4letter',...
            'Position'        , [10 height/3-20 widht/1.5 (widht/2)],...
            'Resize'          , 'on',...
            'Menu'            ,'none');
        imshow(fabric);
        
        ss = questdlg('Возможно нет подсветки стрелки', ...
            'Подсветка', ...
            'Продожить проверку','Закончить проверку','Продожить проверку');
        % Handle response
        switch ss
            case 'Продожить проверку'
                S11=0;
                delete (figure_ss);
               
            case 'Закончить проверку'
                S11=1;
                delete (figure_ss);
               
            otherwise
                S11=0;
                delete (figure_ss);
                
        end
        
    end
   
    if S>=6 && S11==0
        
        % вычисление ц/м меток и положения стрелки Выкл (N- номер
        % циферблата)
        SOOB2=1;
        
        for N=1:n
            %             if N~=5
            Centrs_metkiX=METKI(fabric,Ms,crop, threshold, Open,N);
            Centrs_metki(:,:,N)=Centrs_metkiX;
            %             else
            %             end
            
        end
        
        
        
        
        %         SOOB2=6;
        %         x=[uint8('@') 1 2 1 0];%выключен прибор
        %         fwrite(sobj,x);
        %         pause(0.2)
        %         fwrite(sobj,x);
        %         SOOB2=2;
        %
        %         pause(0.1)
        %         %x1=fread(sobj,6);
        %         pause(2)
        %         fabric =getsnapshot(vid);
        
        
        for N=1:n
            %             if N~=5
            [Im,Line,Centroid,MSN]=Line_strelka(fabric1,Ms,crop,threshold,thresholdX,Open,N,X);
            LineS{1,N}=Line;
            %Images{1,N}=Im;
            Mask_{1,N}=MSN;
            CentrsEnd_strl(1,:,N)=Centroid;
            %             else
            %             end
        end
        
        %
        SOOB2=2; % ошибка при проверке Прибора
        % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % %%%%%%            ПРОВЕРКА ПРИБОРА
        % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %
        %
        set(text3,'String','ПРОВЕРКА ');
        
        set(PANel,'Visible','on');
        
        
        
        
        
        %% вычисление  линии стрелки для положения 1 (N- номер
        % циферблата)
        
        
        
        set(text3,'HorizontalAlignment','center','String','ТОЧКА 1');
        SOOB2=6;
        x=[uint8('@') 1 2 1 32];%включение прибора;Набор1
        fwrite(sobj,x);
        pause(0.2)
        fwrite(sobj,x);
        SOOB2=2;
        for kk=1:10
            set(text4,     'HorizontalAlignment' ,'center',...
                'String'              ,'--',...
                'Visible'             ,'on');pause(0.2)
            set(text4,     'HorizontalAlignment' ,'center',...
                'String'              ,'|',...
                'Visible'             ,'on');pause(0.2)
        end
        
        %**********************
        
        fabric =getsnapshot(vid);
        
        
        
        
        for N=1:n-1
            [Im,Line,Centroid,MSN]=Line_strelka(fabric,Ms,crop,threshold,thresholdX,Open,N,X);
            %LineS{2,N}=Line;
            Images{1,N}=Im;
            CentrsEnd_strl(2,:,N)=Centroid;
        end
        
        
        %
        %% вычисление  линии стрелки для положения 2 (N- номер
        % циферблата)
        
        
        
        set(text3,'String','ТОЧКА 2');
        SOOB2=6;
        x=[uint8('@') 1 2 2 32];%включение прибора;Набор2
        fwrite(sobj,x);
        pause(0.2)
        fwrite(sobj,x);
        SOOB2=7;
        for kk=1:18
            set(text4,     'HorizontalAlignment' ,'center',...
                'String'              ,'--',...
                'Visible'             ,'on');pause(0.2)
            set(text4,     'HorizontalAlignment' ,'center',...
                'String'              ,'|',...
                'Visible'             ,'on');pause(0.2)
        end
        
        fabric =getsnapshot(vid);
        
        
        for N=1:n-1
            [Im,Centroid]=Line_strelka1(fabric,Ms,Mask_,crop,threshold,thresholdX,Open,N);
            %LineS{3,N}=Line;
            Images{2,N}=Im;
            CentrsEnd_strl(3,:,N)=Centroid;
        end
        
        
        %
        %% вычисление  линии стрелки для положения 3 (N- номер
        % циферблата)
        
        set(text3,'String','ТОЧКА 3');
        SOOB2=6;
        x=[uint8('@') 1 2 4 32];%включение прибора;Набор3
        fwrite(sobj,x);
        pause(0.2)
        fwrite(sobj,x);
        SOOB2=7;
        for kk=1:18
            set(text4,     'HorizontalAlignment' ,'center',...
                'String'              ,'--',...
                'Visible'             ,'on');pause(0.2)
            set(text4,     'HorizontalAlignment' ,'center',...
                'String'              ,'|',...
                'Visible'             ,'on');pause(0.2)
        end
        
        fabric =getsnapshot(vid);
        
        
        
        
        for N=1:n-1
            [Im,Centroid]=Line_strelka1(fabric,Ms,Mask_,crop,threshold,thresholdX,Open,N);
            %LineS{4,N}=Line;
            Images{3,N}=Im;
            CentrsEnd_strl(4,:,N)=Centroid;
        end
        
        
        
        
        %% вычисление  линии стрелки для положения 4 (N- номер
        % циферблата)
        
        
        set(text3,'String','ТОЧКА 4');
        SOOB2=6;
        x=[uint8('@') 1 2 8 32];%включение прибора;Набор4
        fwrite(sobj,x);
        pause(0.2)
        fwrite(sobj,x);
        SOOB2=2;
        for kk=1:18
            set(text4,     'HorizontalAlignment' ,'center',...
                'String'              ,'--',...
                'Visible'             ,'on');pause(0.2)
            set(text4,     'HorizontalAlignment' ,'center',...
                'String'              ,'|',...
                'Visible'             ,'on');pause(0.2)
        end
        
        fabric =getsnapshot(vid);
        
        
        for N=1:n-1
            [Im,Line,Centroid]=Line_strelka4(fabric,Ms,Mask_,crop,threshold,thresholdX,Open,N);
            LineS{5,N}=Line;
            Images{4,N}=Im;
            CentrsEnd_strl(5,:,N)=Centroid;
        end
        
        
        
        
        set(text3,'String','Проверка напряжения');
        % %% вычисление  линии стрелки  напряжения для положения 12 вольт (NC- номер
        % % циферблата напряжения - последний циферблат  )
        
        %
        NC=6;
        set(text3,'String','Напряжение 12 B');
        SOOB2=6;
        x=[uint8('@') 2 2 4 128+32+16];%12 вольт
        fwrite(sobj,x);
        pause(0.2)
        fwrite(sobj,x)
        SOOB2=2;
        for kk=1:12
            set(text4,     'HorizontalAlignment' ,'center',...
                'String'              ,'--',...
                'Visible'             ,'on');pause(0.2)
            set(text4,     'HorizontalAlignment' ,'center',...
                'String'              ,'|',...
                'Visible'             ,'on');pause(0.2)
        end
        
        
        
        fabric =getsnapshot(vid);
        [Im,Centroid]=Line_strelka1(fabric,Ms,Mask_,crop,threshold,thresholdX,Open,NC);
        % LineS{2,NC}=Line;
        Images{1,NC}=Im;
        CentrsEnd_strl(2,:,NC)=Centroid;
        
        set(text3,'String','Напряжение 13 B');
        %% вычисление  линии стрелки  напряжения для положения 13 вольт (NC- номер
        % % циферблата напряжения - последний циферблат  )
        SOOB2=6;
        x=[uint8('@') 2 2 5 16+4];%13 вольт
        fwrite(sobj,x);
        pause(0.2)
        fwrite(sobj,x)
        SOOB2=2;
        for kk=1:12
            set(text4,     'HorizontalAlignment' ,'center',...
                'String'              ,'--',...
                'Visible'             ,'on');pause(0.2)
            set(text4,     'HorizontalAlignment' ,'center',...
                'String'              ,'|',...
                'Visible'             ,'on');pause(0.2)
        end
        
        
        fabric =getsnapshot(vid);
        
        [Im,Centroid]=Line_strelka1(fabric,Ms,Mask_,crop,threshold,thresholdX,Open,NC);
        
        Images{2,NC}=Im;
        CentrsEnd_strl(3,:,NC)=Centroid;
        
        
        set(text3,'String','Напряжение 15 B');
        %% вычисление  линии стрелки  напряжения для положения 15 вольт (NC- номер
        % % циферблата напряжения - последний циферблат  )
        SOOB2=6;
        x=[uint8('@') 2 2 5 4+8+16+64+128];%15 вольт
        fwrite(sobj,x);
        pause(0.2)
        fwrite(sobj,x)
        SOOB2=2;
        for kk=1:14
            set(text4,     'HorizontalAlignment' ,'center',...
                'String'              ,'--',...
                'Visible'             ,'on');pause(0.2)
            set(text4,     'HorizontalAlignment' ,'center',...
                'String'              ,'|',...
                'Visible'             ,'on');pause(0.2)
        end
        
        fabric =getsnapshot(vid);
        
        [Im,Centroid]=Line_strelka1(fabric,Ms,Mask_,crop,threshold,thresholdX,Open,NC);
        % LineS{4,NC}=Line;
        Images{3,NC}=Im;
        CentrsEnd_strl(4,:,NC)=Centroid;
        
        set(text3,'String','Напряжение 16 B');
        % вычисление  линии стрелки  напряжения для положения 16 вольт (NC- номер
        % % циферблата напряжения - последний циферблат  )
        SOOB2=6;
        x=[uint8('@') 2 2 6 64];%16 вольт
        fwrite(sobj,x);
        pause(0.2)
        fwrite(sobj,x)
        SOOB2=2;
        for kk=1:10
            set(text4,     'HorizontalAlignment' ,'center',...
                'String'              ,'--',...
                'Visible'             ,'on');pause(0.2)
            set(text4,     'HorizontalAlignment' ,'center',...
                'String'              ,'|',...
                'Visible'             ,'on');pause(0.2)
        end
        fabric =getsnapshot(vid);
        
        [Im,Line,Centroid]=Line_strelka4(fabric,Ms,Mask_,crop,threshold,thresholdX,Open,NC);
        LineS{5,NC}=Line;
        Images{4,NC}=Im;
        CentrsEnd_strl(5,:,NC)=Centroid;
        
        set(text3,'String','Напряжение 13,5 B');
        SOOB2=6;
        x=[uint8('@') 2 2 5 64+4+2];%13.5 вольт
        fwrite(sobj,x);
        pause(0.2)
        fwrite(sobj,x)
        SOOB2=2;
        pause(0.1)
        
        %центр вращения стрелки
        inter=ones(n,2);
        popinter=zeros(n,2);
        for N=1:n
            %             if N~=5
            line0=LineS{1,N};
            line1=LineS{5,N};
            INT=[1 ,-line0(1); 1, -line1(1)] \ [line0(2); line1(2)];
            inter(N,:)=INT;
            %             else
            %             end
        end
        
        inter=inter+popinter;
        
        
        %         PopCentrsEnd_strl(:,:,1) =...
        %              [0     0;     0     0;     -0.2     -0.5;     -1     0;    0     0.0];
        %
        %
        %         PopCentrsEnd_strl(:,:,2) =...
        %              [0     0;     0     0;     0    0;     0    0.0;     0    0.0];
        %
        %
        %         PopCentrsEnd_strl(:,:,3) =...
        %             [ -0.5     0;     0    0;     0     0;     0     0;     0     0];
        %
        %
        %         PopCentrsEnd_strl(:,:,4) =...
        %             [ 0     0;     0.0     0.0;     0.5      0.0;    0.5     0;    -0.5     -0.5];
        %
        %
        %         PopCentrsEnd_strl(:,:,5) =...
        %              [0     0;     0    0;     -0.2     0;    -1     -1;     0     0];
        %
        %
        %         PopCentrsEnd_strl(:,:,6) =...
        %              [0     0;     0     0.0;     0     0;     0     0;     0     0];
        %
        %         CentrsEnd_strl
        %
        CentrsEnd_strl=CentrsEnd_strl+PopCentrsEnd_strl;
        % наклон меток
        
        Orient_metok=zeros(n,4);
        for N=1:n
            %             if N~=5
            for i=1:4
                S1x=Centrs_metki(i,1,N);
                S1y=Centrs_metki(i,2,N);
                S2x=inter(N,1);
                S2y=inter(N,2);
                OrientX=atan((S2y-S1y)/(S2x-S1x))*180/pi;
                
                if (S1x<S2x)&&(S1y<S2y)
                    Orient_metok(N,i)=OrientX;
                elseif (S1x>=S2x)&&(S1y<S2y)
                    Orient_metok(N,i)=180 +OrientX;
                elseif (S1x>=S2x)&&(S1y>=S2y)
                    Orient_metok(N,i)=180 +OrientX;
                elseif (S1x<S2x)&&(S1y>=S2y)
                    Orient_metok(N,i)=360 +OrientX;
                else
                end
                
            end
            %             else
            %             end
        end
        
        
        
        
        % цена деления шкал
        Cena= ones(n,1);
        
        
        for N=1:n
            %             if N~=5
            A= Orient_metok(N,1);
            B= Orient_metok(N,4);
            
            
            
            r=(B-A);
            if abs(r)>180
                r=360-abs(r);
            end
            
            
            Cena(N,1)=Shkala(N)/r;
            %             else
            %             end
        end
        
        
        
        % угол стрелок
        for N=1:n
            %             if N~=5
            for i=2:5
                S1x=CentrsEnd_strl(i,1,N);
                S1y=CentrsEnd_strl(i,2,N);
                S2x=inter(N,1);
                S2y=inter(N,2);
                OrientX=atan((S2y-S1y)/(S2x-S1x))*180/pi;
                
                if (S1x<S2x)&&(S1y<S2y)
                    Orient_strel(N,i-1)=OrientX;
                elseif (S1x>=S2x)&&(S1y<S2y)
                    Orient_strel(N,i-1)=180 +OrientX;
                elseif (S1x>=S2x)&&(S1y>=S2y)
                    Orient_strel(N,i-1)=180 +OrientX;
                elseif (S1x<S2x)&&(S1y>=S2y)
                    Orient_strel(N,i-1)=360 +OrientX;
                else
                end
            end
            %             else
            %             end
        end
        
        
        Otklonenie=zeros(n,5);
        
        for N=1:n
            %             if N~=5
            for i=1:4
                
                A= Orient_metok(N,i);
                B= Orient_strel(N,i);
                
                r=B-A;
                if abs(r)>180
                    if A>270
                        r=360-abs(r);
                    elseif B>270
                        r=abs(r)-360;
                    end
                end
                
                
                
                Otklonenie(N,i)=r*Cena(N);
                Otklonenie(N,i)= Otklonenie(N,i)+Popravka(N,i);
            end
            
            %             else
            %             end
        end
        
        
        
        
        
        set(text3,'string','Светимость ав. диодов');
        %Определение светимости аварийных светодиодов
        SOOB2=6;
        
        x=[uint8('@') 1 2 1 128+32+16+8+4+2+1];%включение прибора;Набор1,аварийные диоды
        fwrite(sobj,x);
        pause(0.2)
        fwrite(sobj,x);
        pause(0.1)
        
        
        %Определение работоспособности зуммера
        %         flushinput(sobj);
        %         fwrite(sobj,y);
        %         while (sobj.BytesAvailable<6)
        %             pause(0.1);
        %             sobj.BytesAvailable;
        %         end
        %         pause(0.1)
        %         x1=fread(sobj,6);
        %
        %         if bitand(x1(4),2)==0
        %             zummer=1;
        %         else
        %             zummer=0;
        %         end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        pause(0.5)
        fabric =getsnapshot(vid);
        SOOB2=2;
        for N=1:6
            %             if N~=5
            A=fabric;
            cropA=crop(N,:);
            A=imcrop(A,cropA);
            A=im2bw(A,thresholdLed(1,N));
            %figure,imshow(A);
            Ms1=Ms{7,N};
            %figure,imshow(Ms1);
            BW=immultiply(A,Ms1);
            %  figure,imshow(BW);
            %                 OpenX=Open(1,N);
            %                 BW =bwareaopen(BW,OpenX);
            [L1,numObjects]=bwlabel(BW);
            if numObjects>=1
                Otklonenie(N,5)=0;
            else
                Otklonenie(N,5)=1 ;
            end
            %             else
            %             end
        end
        
        SOOB2=6;
        
        x=[uint8('@') 1 2 1 32];
        fwrite(sobj,x);
        pause(0.2)
        fwrite(sobj,x);pause(0.2)
        Z=[48    36    34    40    160 33  ];
        z0=0;
        for j=1:6
            %             if j==5
            %             else
            x=[uint8('@') 1 2 1 Z(j)];
            fwrite(sobj,x);
            pause(0.2)
            fwrite(sobj,x);
            
            if j==2||j==3
                flushinput(sobj);
                fwrite(sobj,y);
                while (sobj.BytesAvailable<6)
                    pause(0.1);
                    sobj.BytesAvailable;
                end
                pause(0.1)
                x1=fread(sobj,6);
                
                if bitand(x1(4),2)==0
                    z0=z0+1;
                else
                    
                end
                
            end
            for kk=1:2
                set(text4,     'HorizontalAlignment' ,'center',...
                    'String'              ,'--',...
                    'Visible'             ,'on');pause(0.2)
                set(text4,     'HorizontalAlignment' ,'center',...
                    'String'              ,'|',...
                    'Visible'             ,'on');pause(0.2)
                %     end
                fabric =getsnapshot(vid);
                pause(0.1)
                ImLed{j}=fabric;
            end
        end
        if z0==2
            zummer=1;
        else
            zummer=0;
        end
        for j=1:6
            %             if j~=5
            SOOB2=2;
            for N=1:6
                %                     if N~=5
                A=ImLed{j}; cropA=crop(N,:);
                A=imcrop(A,cropA);
                A=im2bw(A,thresholdLed(1,N));
                % figure,imshow(A);
                Ms1=Ms{7,N};
                BW=immultiply(A,Ms1);
                %                          figure,imshow(BW);
                %                         OpenX=Open(1,N);
                %                         BW =bwareaopen(BW,OpenX);
                [L1,numObjects]=bwlabel(BW);
                if numObjects>=1
                    OtklonenieLed(N,j)=1;
                else
                    OtklonenieLed(N,j)=0 ;
                end
                %                     end
            end
            %             end
        end
        
        OtklonenieLedSum=sum(OtklonenieLed);
        Led=0;
        for i=1:6
            %             if i~=5
            if OtklonenieLedSum(i)==1
                Led=Led+1;
            end
            %             else
            %             end
        end
        
        
        Goden=zeros(n, 1);
        for N=1:n
            %             if N~=5
            for i=1:5
                if ((abs(dopusk(N,i)))-(abs(Otklonenie(N,i))))>=0
                    Goden(N,1)=Goden(N,1);
                else
                    Goden(N,1)=Goden(N,1)+1;
                end
            end
            %             else
            %             end
        end
        
        
        
        SOOB2=6;
        x=[uint8('@') 1 2 1 0];%выключение
        fwrite(sobj,x);
        pause(0.2)
        fwrite(sobj,x);
        for kk=1:4
            set(text4,     'HorizontalAlignment' ,'center',...
                'String'              ,'--',...
                'Visible'             ,'on');pause(0.2)
            set(text4,     'HorizontalAlignment' ,'center',...
                'String'              ,'|',...
                'Visible'             ,'on');pause(0.2)
        end
        SOOB2=2;
        fabric =getsnapshot(vid);
        
        delete(findobj('tag','figure_vid'));
        
        axes1f1 = axes...
            ('Parent'                ,figure1);
        set(gca,...
            'Visible'               ,'off');
        set(axes1f1,...
            'Position'              ,[0.0 0.61 0.3 0.25]);
        set(axes1f1,...
            'Visible'            ,'on');
        axes(axes1f1);imshow(fabric);hold on ;
        
        text1f1=uicontrol(figure1,...
            'Style'                 ,'text', ...
            'Backgroundcolor'       ,[0.8 0.8 0.8],...
            'FontSize'              ,14,...
            'FontWeight'            ,'bold',...
            'FontName'              ,'Arial',...
            'HorizontalAlignment'   ,'center',...
            'Units'                 ,'normalized', ...
            'Position'              , [0.0 0.50 0.3 0.1] ,...
            'Visible'               ,'off');
        
        text2f1=uicontrol(figure1,...
            'Style'                 ,'text', ...
            'Backgroundcolor'       ,[0.8 0.8 0.8],...
            'FontSize'              ,12,...
            'FontWeight'            ,'bold',...
            'FontName'              ,'Arial',...
            'HorizontalAlignment'   ,'center',...
            'Units'                 ,'normalized', ...
            'Position'              , [0.0 0.47 0.3 0.1] ,...
            'Visible'               ,'off');
        
        
        Color_Menu=[0 0 0 0 0 0 0];
        
        for N=1:n
            %             if N~=5
            if Goden(N)==0
                xc1=inter(N,1);
                yc1=inter(N,2);
                plot(crop(N,1)+xc1 , crop(N,2)+ yc1,'g*','LineWidth',15);
                Color_Menu(N)=1;
            else
                xc1=inter(N,1);
                yc1=inter(N,2);
                plot(crop(N,1)+xc1 , crop(N,2)+ yc1,'r*','LineWidth',15);
                Color_Menu(N)=0;
            end
            %             else
            %             end
        end
        
        %          Color_Menu(5)= Color_Menu(6) ;
        
        G=any(Goden);
        %  G=0;
        %  zummer=1;
        %
        if G==0
            
            if zummer==1 && Led==NumShkal
                set( text1f1,...
                    'Foregroundcolor'       ,'g',...
                    'String'                ,' Г О Д Е Н',...
                    'Visible'               ,'on');
                Color_Menu(7)=1;
            elseif zummer~=1 && Led==NumShkal
                set( text1f1,...
                    'Foregroundcolor'       ,'r',...
                    'String'                ,' Н Е Г О Д Е Н',...
                    'Visible'               ,'on');
                set( text2f1,...
                    'Foregroundcolor'       ,'r',...
                    'String'                ,' неисправна цепь зуммера',...
                    'Visible'               ,'on');
                Color_Menu(7)=1;
            elseif zummer==1 && Led~=NumShkal
                set( text1f1,...
                    'Foregroundcolor'       ,'r',...
                    'String'                ,' Н Е Г О Д Е Н',...
                    'Visible'               ,'on');
                set( text2f1,...
                    'Foregroundcolor'       ,'r',...
                    'String'                ,' неисправна цепь ав. диодов',...
                    'Visible'               ,'on');
                Color_Menu(7)=0;
            elseif zummer~=1 && Led~=NumShkal
                set( text1f1,...
                    'Foregroundcolor'       ,'r',...
                    'String'                ,' Н Е Г О Д Е Н',...
                    'Visible'               ,'on');
                set( text2f1,...
                    'Foregroundcolor'       ,'r',...
                    'String'                ,' неисправна цепь зуммера и ав. диодов',...
                    'Visible'               ,'on');
                Color_Menu(7)=0;
            end
        else
            if zummer==1 && Led==NumShkal
                set( text1f1,...
                    'Foregroundcolor'       ,'r',...
                    'String'                ,'  Н Е Г О Д Е Н',...
                    'Visible'               ,'on');
                set( text2f1,...
                    'Foregroundcolor'       ,'r',...
                    'String'                ,'',...
                    'Visible'               ,'on');
                Color_Menu(7)=1;
            elseif zummer~=1 && Led==NumShkal
                set( text1f1,...
                    'Foregroundcolor'       ,'r',...
                    'String'                ,' Н Е Г О Д Е Н',...
                    'Visible'               ,'on');
                set( text2f1,...
                    'Foregroundcolor'       ,'r',...
                    'String'                ,' неисправна цепь зуммера',...
                    'Visible'               ,'on');
                Color_Menu(7)=1;
            elseif zummer==1 && Led~=NumShkal
                set( text1f1,...
                    'Foregroundcolor'       ,'r',...
                    'String'                ,' Н Е Г О Д Е Н',...
                    'Visible'               ,'on');
                set( text2f1,...
                    'Foregroundcolor'       ,'r',...
                    'String'                ,' неисправна цепь ав. диодов',...
                    'Visible'               ,'on');
                Color_Menu(7)=0;
            elseif zummer~=1 && Led~=NumShkal
                set( text1f1,...
                    'Foregroundcolor'       ,'r',...
                    'String'                ,' Н Е Г О Д Е Н',...
                    'Visible'               ,'on');
                set( text2f1,...
                    'Foregroundcolor'       ,'r',...
                    'String'                ,' неисправна цепь зуммера и ав. диодов',...
                    'Visible'               ,'on');
                Color_Menu(7)=0;
            end
            
        end
        
        %кнопка "изображений"
        
        IMAge=uicontrol(figure1,...
            'Style'                ,'pushbutton', ...
            'Foregroundcolor'      ,   'k',...
            'Backgroundcolor'      ,[0.7 0.7 0.7],...
            'FontSize'             ,12,...
            'FontWeight'           ,'normal',...
            'FontName'             ,'Arial',...
            'Units'                ,'normalized', ...
            'Position'             ,[0.05 0.4 0.2 0.05] ,...
            'String'               ,'ПОДРОБНО ',...
            'Visible'              ,'on',...
            'callback'             ,'Im_KD8071');
        
        
        
        
        
        
        
        set(NEXt,'KeyPressFcn','NEXt_Callback');
        uicontrol(NEXt);
        
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % %     ЗАПИСЬ В ФAЙЛ
        % %**************************************************************************
        % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        SOOB2=4;
        
        F=fopen('inforez8071.m','r');
        
        NameFolder=fscanf(F,'%s',1); %имя папки в которую пишет результат"
        
        fclose(F);
        [stats,msg]=mkdir(NameFolder);
        %
        Tf=clock;
        str=mat2str(Tf);
        
        Tfstr=strcat(str(2:5),str(7),str(9:10),str(12),str(14),str(16:17));
        
        
        Rasshirenie='.tmp';
        
        
        
        
        NameFale=strcat(NameFolder,N_device,Rasshirenie);
        
        F=fopen(NameFale,'w');
        
        for N=1:n
            %                 if N~=5
            fprintf(F,'%s','(');
            for i=1:5
                fprintf(F,'%2.1f', Otklonenie(N,i));
                fprintf(F,'%s', ' ');
            end
            fprintf(F,'%s', ')');
            
            %                 else
            %                 end
        end
        fprintf(F,'%s \n ','');
        
        if (G==0)&& (zummer==1)
            
            fprintf(F,'%s', '+');
            
            
        else
            
            fprintf(F,'%s', '-');
            
            
        end
        
        
        fclose(F);
        
        %  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %         if (G~=0)&& (Prov_1==1)
        % %             closepreview(vid);
        %             % % появление кнопки проверки по отдельности.
        %             PRInt_Er=uicontrol(figure1,...
        %                 'Style'                ,'pushbutton', ...
        %                 'Foregroundcolor'      ,   'k',...
        %                 'Backgroundcolor'      ,[0.7 0.7 0.7],...
        %                 'FontSize'             ,12,...
        %                 'FontWeight'           ,'normal',...
        %                 'FontName'             ,'Arial',...
        %                 'Units'                ,'normalized', ...
        %                 'Position'             ,[0.05 0.2 0.2 0.05] ,...
        %                 'String'               ,'На регулировку ',...
        %                 'Visible'              ,'off',...
        %                 'callback'             ,'NEXt_Callback_Er');
        %
        %
        %             set(text3          ,'Visible','off');
        %             set(PANel          ,'Visible','off');
        %             set(text4          ,'Visible','off');
        %             set(BEGin          ,'visible','off');
        %             set(NEXt           ,'visible','on');
        %             set(NEXt           ,'string','ПОЛНАЯ ПРОВЕРКА');
        %             set(EXIt           ,'Visible','on');
        %             set(IMAge          ,'Visible','on');
        %             set(PROv           ,'Visible','on');
        %             set(PRInt_Er        ,'Visible','on');
        %         else
        
        % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        delete(findobj('tag','figure_vid'));
        set(text3          ,'Visible','off');
        set(PANel          ,'Visible','off');
        set(text4          ,'Visible','off');
        set(BEGin          ,'visible','off');
        set(NEXt           ,'visible','on');
        set(NEXt           ,'string','CЛЕДУЮЩИЙ ПРИБОР');
        set(EXIt           ,'Visible','on');
        set(IMAge          ,'Visible','on');
        set(PROv           ,'Visible','off');
        set(PRInt_Er       ,'Visible','off');
        %         end
        % %
    else
        
        SOOB2=6;
        x=[uint8('@') 2 2 5 64+4+2];%13.5 вольт
        fwrite(sobj,x);
        pause(0.2)
        fwrite(sobj,x)
        
        pause(0.1)
        
        delete(findobj('tag','figure_vid'));
        
        x=[uint8('@') 1 2 1 0];%выключен прибор
        fwrite(sobj,x);
        pause(0.2)
        fwrite(sobj,x);
        SOOB2=2;
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
        axes(axes1f1);imshow(fabric);hold on ;
        
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
            'String'                ,'Нет подсветки шкалы или неправильное расположение прибора',...
            'Visible'               ,'on');
       if S11~=0
           if S1>0
            set( text1f1,...
                'Foregroundcolor'       ,'r',...
                'String'                ,'Нет подсветки стрелки',...
                'Visible'               ,'on');
        end
       end   
        set(text3          ,'Visible','off');
        set(PANel          ,'Visible','off');
        set(text4          ,'Visible','off');
        set(BEGin          ,'visible','off');
        set(NEXt           ,'visible','on');
        set(EXIt           ,'Visible','on');
        set(IMAge          ,'Visible','off');
        set( VISion2,'Visible','off');
        set( VISion1,'Visible','off');
    end
    
    set(NEXt,'KeyPressFcn','NEXt_Callback');
    uicontrol(NEXt);
    
    %
    toc
    %
    
catch
    switch SOOB2;
        %
        case 1 %
            fabric =getsnapshot(vid);
            
            x=[uint8('@') 2 2 5 64+4+2];%13.5 вольт
            fwrite(sobj,x)
            pause(0.1)
            
            delete(findobj('tag','figure_vid'));
            
            x=[uint8('@') 1 2 1 0];%выключен прибор
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
            axes(axes1f1);imshow(fabric);hold on ;
            
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
                'String'                ,'Нет освещения или подсветки шкалы',...
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
            
            x=[uint8('@') 2 2 5 64+4+2];%13.5 вольт
            fwrite(sobj,x)
            pause(0.1)
            
            delete(findobj('tag','figure_vid'));
            
            x=[uint8('@') 1 2 1 0];%выключен прибор
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
            axes(axes1f1);imshow(fabric);hold on ;
            
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
            
            set(text3,'Visible','off');
            set(PANel,'Visible','off');
            set(text3,'HorizontalAlignment','center','String','ОШИБКА ПОВЕРКИ','Foregroundcolor','r');
            
            
            set( text1f1,...
                'Foregroundcolor'       ,'r',...
                'String'                ,'Проблемы с освещением  ',...
                'Visible'               ,'on');
            
            
            set(text3          ,'Visible','off');
            set(PANel          ,'Visible','off');
            set(text4          ,'Visible','off');
            set(BEGin          ,'visible','off');
            set(NEXt           ,'visible','on');
            set(EXIt           ,'Visible','on');
            set(IMAge          ,'Visible','off');
            
            
            set(text1_1,'Visible','on');
            set(text1_1,'String','Проверьте соединения!');
            set(EXIt,'KeyPressFcn','Exit_my' );
            
            
            
            
            uicontrol(EXIt);
            
            % % % %
        case 3
            
            set(NEXt,'Visible','off' );
            
            set(text3,'Visible','on');
            set(PANel,'Visible','on');
            set(text3,'HorizontalAlignment','center','String','ОШИБКА ЗАПИСИ РЕЗУЛЬТАТА ПРОВЕРКИ ');
            %set(text24,'visible','on','Background',[0.8 0.8 0.8],...
            %'ForegroundColor',[1 0 0], 'String','');
            delete(findobj('tag','figure_vid'));
            
            
            set(BEGin,'Visible','off' ) ;
            set(text1_1,'Visible','on');
            set(text1_1,'String','Нажмите кнопку "ВЫХОД"!');
            set(EXIt,'KeyPressFcn','Exit_my' );
            set(EXIt,'Visible','on');
            
            
            %set(text23,'String','');
            %set(text24,'String','');
            %             set(text2_2,'String','');
            uicontrol(EXIt);
            
        case 4
            
            set(NEXt,'Visible','off' );
            
            set(text3,'Visible','off');
            set(PANel,'Visible','off');
            set(text3,'HorizontalAlignment','center','String','ОШИБКА ЗАГРУЗКИ ФАЙЛА inforez8071.m ');
            %set(text24,'visible','on','Background',[0.8 0.8 0.8],...
            %'ForegroundColor',[1 0 0], 'String','');
            
            
            
            set(BEGin,'Visible','off' ) ;
            set(text1_1,'Visible','on');
            set(text1_1,'String','Нажмите кнопку "ВЫХОД"!');
            set(EXIt,'KeyPressFcn','Exit_my' );
            set(EXIt,'Visible','on');
            delete(findobj('tag','figure_vid'));
            
            %set(text23,'String','');
            %set(text24,'String','');
            set(text2_2,'String','');
            uicontrol(EXIt);
            
        case 6
            
            set(NEXt,'Visible','off' );
            set(text3,'Visible','on');
            set(PANel,'Visible','on');
            set(text3,'HorizontalAlignment','center','String','СБОЙ КАЛИБРАТОРА');
            set(text4          ,'Visible','off');
            set(BEGin          ,'visible','off');
            set(NEXt           ,'visible','on');
            set(EXIt           ,'Visible','on');
            set(IMAge          ,'Visible','off');
            % %
            set(text1_1,'Visible','on');
            set(text1_1,'String','Начните проверку снова');
            set(EXIt,'KeyPressFcn','Exit_my' );
            delete(findobj('tag','figure_vid'));
            
            
            
            uicontrol(EXIt);
            
        case 7
            %
            fabric =getsnapshot(vid);
            
            x=[uint8('@') 2 2 5 64+4+2];%13.5 вольт
            fwrite(sobj,x)
            pause(0.1)
            
            
            
            x=[uint8('@') 1 2 1 0];%выключен прибор
            fwrite(sobj,x);
            pause(0.1)
            %%x1=fread(sobj,6);
            delete(findobj('tag','figure_vid'));
            axes1f1 = axes...
                ('Parent'                ,figure1);
            set(gca,...
                'Visible'               ,'off');
            set(axes1f1,...
                'Position'              ,[0.0 0.61 0.3 0.25]);
            set(axes1f1,...
                'Visible'            ,'on');
            axes(axes1f1);imshow(fabric);hold on ;
            
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
            
            set(text3,'Visible','off');
            set(PANel,'Visible','off');
            set(text3,'HorizontalAlignment','center','String','ОШИБКА ПОВЕРКИ','Foregroundcolor','r');
            
            
            set( text1f1,...
                'Foregroundcolor'       ,'r',...
                'String'                ,'Проблемы с освещением или стрелка на "0" ',...
                'Visible'               ,'on');
            
            
            set(text3          ,'Visible','off');
            set(PANel          ,'Visible','off');
            set(text4          ,'Visible','off');
            set(BEGin          ,'visible','off');
            set(NEXt           ,'visible','on');
            set(EXIt           ,'Visible','on');
            set(IMAge          ,'Visible','off');
            
            
            set(text1_1,'Visible','on');
            set(text1_1,'String','Проверьте соединения!');
            set(EXIt,'KeyPressFcn','Exit_my' );
            
            
            
            
            uicontrol(EXIt);
            
            
            
    end
    
end




