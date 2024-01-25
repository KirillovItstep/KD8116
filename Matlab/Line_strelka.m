function [Im,Line,S1,M]=Line_strelka(A,Ms,crop,threshold,thresholdX,Open,N,X)

N;
cropA=crop(N,:);
A1=imcrop(A,cropA);
 Im=A1;
%figure,imshow(A1);

 
 A2=im2bw(A1,thresholdX(1,N)-X(N));
 M=~A2;
  Ms1=Ms{8,N};  
 A1= im2bw(A1,thresholdX(1,N));    
 A1=immultiply(A1,Ms1);
%thresholdX


 Ms1=Ms{5,N};

 BW=immultiply(A1,Ms1);
% figure,imshow(BW);
 [L1,numObjects]=bwlabel(BW);
% N
% numObjects
 stats = regionprops(L1,'Area','Centroid');
 area=[stats.Area];
 max_area=max(area);
 big = find(area==max_area);
 S1=stats(big).Centroid;
 
 

A1=imcrop(A,cropA);
 
A1=im2bw(A1,thresholdX(1,N));

% figure,imshow(A1);
% A=imerode(A,SE1);
%A1 =bwareaopen(A1,Open(1,N));
 
 Ms1=Ms{6,N};
 BW=immultiply(A1,Ms1);
% figure,imshow(BW);
 [L1,numObjects]=bwlabel(BW);
% N
% numObjects 
 stats = regionprops(L1,'Area','Centroid');
 area=[stats.Area];
 max_area=max(area);
 big = find(area==max_area);
 S2=stats(big).Centroid;
  
 
Centroid_C0 = zeros(2,2);
Centroid_C0(1,:)=S1;
Centroid_C0(2,:)=S2;
 
  %figure,imshow(BW);
Line=polyfit(Centroid_C0(:,2),Centroid_C0(:,1),1);
 
