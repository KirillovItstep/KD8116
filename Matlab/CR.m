
%%%%%%%%%%%%%%%% ÎÁÐÅÇÊÀ %%%%%%%%%%%%%%%%%%%
clear all
load 'infodat8071_6(0000)';
load 'fabric';
for k=1:6
   
        [I,cropA]=imcrop(fabric);
        
        crop(k,:)=cropA;
end
clear ('fabric','cropA','k','I');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%% ÌÀÑÊÈ%%%%%%%%%%%%%%%%%%%%%%%
clear all; %םמלונ טםהטךאעמנא (גמכüעלוענ-  N=6)
load 'infodat8071_6(0000)';
load 'fabric';
N=1;
for k=1:4

        cropA=crop(N,:);
        A=imcrop(fabric,cropA);
        A=im2bw(A,thresholdOSV(k)-0.1);
        Ms{k,N}=roipoly(A);
 
        
end
 for k=5:8
   cropA=crop(N,:);
        A=imcrop(fabric,cropA);
        
        Ms{k,N}=roipoly(A);
   
end
clear ('fabric','A','k','N');