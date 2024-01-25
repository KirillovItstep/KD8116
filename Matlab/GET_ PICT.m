load 'infodat8071_6(0000)';
sobj = serial(PORTstr,'BaudRate',9600);
fopen(sobj);

vid= videoinput('winvideo', ID_camera, 'RGB24_640x480');
set(vid,...
    'FrameGrabInterval'        ,1,...
    'FramesPerTrigger'         ,160,...
    'Timeout'                  ,150,...
    'TriggerRepeat'           ,Inf);
triggerconfig(vid, 'Manual');
try
    set(getselectedsource(vid),'BacklightCompensation',Camera.BacklightCompensation);
    set(getselectedsource(vid),'WhiteBalanceMode',Camera.WhiteBalanceMode);
    set(getselectedsource(vid),'Contrast',     Camera.Contrast);
    set(getselectedsource(vid),'Brightness',   Camera.Brightness);
    set(getselectedsource(vid),'WhiteBalance', Camera.WhiteBalance);
    pause(0.5);
catch
    err = lasterror;
    errordlg(err.message);
end

preview(vid);

y=[uint8('@') 0 0 ];%запрос контроллера
x1=[uint8('@') 0 0 0 0 0];%ответ контроллера

x=[uint8('@') 1 2 1 0];%выключение прибора;Набор1
fwrite(sobj,x);
pause(0.2)
fwrite(sobj,x);
pause(0.2)
x=[uint8('@') 1 2 1 32];%включение прибора;Набор1
fwrite(sobj,x);
pause(0.2)
fwrite(sobj,x);
pause(0.2)

x=[uint8('@') 2 2 5 64+4+2];%13.5 вольт
fwrite(sobj,x)
pause(0.2)
fwrite(sobj,x);

x=[uint8('@') 1 2 1 32+64];%включение прибора;Набор1,подсветка шкалы
fwrite(sobj,x);
pause(0.2)
fwrite(sobj,x);
pause (3);

fabric =getsnapshot(vid);
save('fabric','fabric');

fclose(sobj) % disconnecting the instrument


pause(0.1)
delete(vid)
%
clear vid

clear all



clear all

pause(3);
load 'fabric'
imshow(fabric);


