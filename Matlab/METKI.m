function Centrs_metki=METKI(A,Ms,crop,threshold,Open,N)
cropA=crop(N,:);
A=imcrop(A,cropA);
 
A=im2bw(A,threshold(N)-0.1);

 Centrs_metki=ones(3,2);

% if N~=6
 for i=1:4
  
  Ms1=Ms{i,N};
 BW=immultiply(A,Ms1);
% figure,imshow(BW);
 [L1,numObjects]=bwlabel(BW);
% 
 stats = regionprops(L1,'Area','Centroid');
 area=[stats.Area];
 max_area=max(area);
 big = find(area==max_area);
%  

% 
 Centrs_metki(i,:)=stats(big).Centroid;

  end
