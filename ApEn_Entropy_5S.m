clear all
clc
clear all;
header = blockEdfLoad('h14.edf');
[header, signalHeader, signalCell] = blockEdfLoad('h14.edf'); 
for i=1:19 
    Saif(i,:)=signalCell{i};
end
% start = fix (256*801.9844);
% stop = fix (256*831.7891);
data= Saif(:,:)';
coun=0;
for k=1:1250:size(data,1)-1249
    k
    coun=coun+1;
     for  j=1:19
        r=0.2*std(data(k:k+249,j));
         apen = ApEn(2,r,data(k:k+249,j),1);
         DData(coun,j)=apen;
     end 
end 
xlswrite('h14_ApEn.xlsx',[DData]);





