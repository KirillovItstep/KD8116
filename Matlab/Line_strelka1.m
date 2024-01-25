function [Im,S1]=Line_strelka1(A,Ms,Mask_,crop,threshold,thresholdX,Open,N);


cropA=crop(N,:);
A1=imcrop(A,cropA);
 Im=A1;
 
A1=im2bw(A1,thresholdX(1,N));

% figure,imshow(A1);
Ms1=Mask_{1,N};
BW=immultiply(A1,Ms1);

SE1 = strel('square',4);
BW=imdilate(BW,SE1);
%figure,imshow(BW);
Ms1=Ms{5,N};
%figure,imshow(Ms1);
 
 BW=immultiply(BW,Ms1);
 
%  figure,imshow(BW);
 [L1,numObjects]=bwlabel(BW);
% 
 stats = regionprops(L1,'Area','Centroid');
 area=[stats.Area];
 max_area=max(area);
 big = find(area==max_area);
 S1=stats(big).Centroid;
 
 


 
Centroid_C0 = zeros(2,2);
Centroid_C0(1,:)=S1;
%