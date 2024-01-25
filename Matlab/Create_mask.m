clear all
load 'infodat8071_6(0000)';
load 'fabric';
for k=1:6
%     if k==5
%     else
        cropA=crop(k,:);
        A=imcrop(fabric,cropA);
        A=im2bw(A,thresholdOSV(k)-0.1);
        Ms{2,k}=roipoly(A);% рисование маски на вторую отметку%
        
        
%     end
    
end
clear ('fabric','A','k');