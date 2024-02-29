clear all
clc
clear all;
header = blockEdfLoad('h03.edf');
[header, signalHeader, signalCell] = blockEdfLoad('h03.edf'); 
for i=1:19 
    Saif(i,:)=signalCell{i};
end
% start = fix (256*801.9844);
% stop = fix (256*831.7891);
data= Saif(:,:)';
coun=0;
for k=1:250:size(data,1)-250
    k
    coun=coun+1;
     for  j=1:19
        r=0.2*std(data(k:k+249,j));
         apen = ApEn(2,r,data(k:k+249,j),1);
         DData(coun,j)=apen;
     end 
end 
xlswrite('h03.xlsx',[DData]);





