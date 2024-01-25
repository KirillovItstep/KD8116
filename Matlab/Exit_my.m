function  Exit_my(varargin)
% выход
global figure1  vid sobj...
       
   timer_off;
      delete(figure1 );
     delete(findobj('tag','figure_vid')); 
% x=[uint8('@') 1 2 1 0];%выключен прибор
% fwrite(sobj,x);

pause(1.5)

      fclose(sobj) % disconnecting the instrument
      
      
      pause(0.1)
      delete(vid)
     %
     clear vid
    
     clear all
       
  function timer_off(varargin)
T = timerfind('Name','Timer_1');
stop(T)
delete(T)
     
       
       
   
