clear all
clc
header = blockEdfLoad('s14.edf');
[header, signalHeader, signalCell] = blockEdfLoad('s14.edf'); 
%%signal without decomposition 
% for i=1:19 
%     Saif(i,:)=signalCell{i};
% end
% p=plot(Saif(:,1:100)');
% title('EEG Signal')

%decomposition signal using bandpass filter
for i=1:19 
    Saif(i,:)=signalCell{i};
    Fs=250;
    dalta(i,:)=bandpass(Saif(i,:),[0.1,4],Fs);
    theta(i,:)=bandpass(Saif(i,:),[5,9],Fs);
    aplha(i,:)=bandpass(Saif(i,:),[10,14],Fs);
    beta(i,:)=bandpass(Saif(i,:),[15,31],Fs);
    gama(i,:)=bandpass(Saif(i,:),[32,100],Fs);
end
% 
% subplot(5,1,1)
% p=plot(dalta(:,1:100)');
% title('Dalta Signal')
% subplot(5,1,2)
% p=plot(theta(:,1:100)');
% title('Theta Signal')
% subplot(5,1,3)
% p=plot(aplha(:,1:100)');
% title('Aplha Signal')
% subplot(5,1,4)
% p=plot(beta(:,1:100)');
% title('Beta Signal')
% subplot(5,1,5)
% p=plot(gama(:,1:100)');
% title('Gama Signal')

% start = fix(250*2.1324);
% stop = fix(250*50.5636);
data = dalta(:,:)';
data1 = theta(:,:)';
data2 = aplha(:,:)';
data3 = beta(:,:)';
data4 =gama(:,:)';
coun=0;
for k=1:250:size(data,1)-249
    k
    coun=coun+1;
     for  j=1:19
         x=data(k:k+249,j);
         x1=data1(k:k+249,j);
         x2=data2(k:k+249,j);
         x3=data3(k:k+249,j);
         x4=data4(k:k+249,j);
%           r=0.2*std(x);
%           r1=0.2*std(x1);
%           r2=0.2*std(x2);
%           r3=0.2*std(x3);
%           r4=0.2*std(x4);
         apen = wentropy(x,'shannon');
         apen1 = wentropy(x1,'shannon');
         apen2 = wentropy(x2,'shannon');
         apen3 = wentropy(x3,'shannon');
         apen4 = wentropy(x4,'shannon');
         DData(coun,5*(j-1)+1:5*j)=[apen apen1 apen2 apen3 apen4];
     end 
end 
xlswrite('s14_bandpass+shannon.xlsx',[DData]);
