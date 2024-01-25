function [Im,Line,S1]=Line_strelka4(A,Ms,Mask_,crop,threshold,thresholdX,Open,N);


cropA=crop(N,:);
A1=imcrop(A,cropA);
 Im=A1;
 
 A1=im2bw(A1,thresholdX(1,N));


Ms1=Mask_{1,N};
BW=immultiply(A1,Ms1);
SE1 = strel('square',4);
BW=imdilate(BW,SE1);


%figure,imshow(BW);
Ms1=Ms{5,N};
 %figure,imshow(Ms1);
 
 BW=immultiply(BW,Ms1);
%figure,imshow(BW);
%figure,imshow(BW);
 [L1,numObjects]=bwlabel(BW);
% 
 stats = regionprops(L1,'Area','Centroid');
 area=[stats.Area];
 max_area=max(area);
 big = find(area==max_area);
 S1=stats(big).Centroid;
  

A1=imcrop(A,cropA);
 
A1=im2bw(A1,thresholdX(1,N));


% A=imerode(A,SE1);
%A1 =bwareaopen(A1,Open(1,N));
 
 Ms1=Ms{6,N};
 BW=immultiply(A1,Ms1);
% figure,imshow(BW);
% figure,imshow(BW);
 [L1,numObjects]=bwlabel(BW);
% 
 stats = regionprops(L1,'Area','Centroid');
 area=[stats.Area];
 max_area=max(area);
 big = find(area==max_area);
 S2=stats(big).Centroid;
  
 
Centroid_C0 = zeros(2,2);
Centroid_C0(1,:)=S1;
Centroid_C0(2,:)=S2;
 
 
Line=polyfit(Centroid_C0(:,2),Centroid_C0(:,1),1);
 