clear all
clc
header = blockEdfLoad('h14.edf');
[header, signalHeader, signalCell] = blockEdfLoad('h14.edf'); 
for i=1:19 
    Saif(i,:)=signalCell{i};
end
% figure;
% p=plot(Saif(:,1:100)');
% title('EEG Signal')
%start = fix (250); %start and stop time
%stop = fix (250);
%data= Saif(:,start:stop)';
data= Saif(:,:)';
%plot(data)
coun=0;
for k=1:1250:size(data,1)-1249
    k
    coun=coun+1;
     for  j=1:19 %Dalta
         a = fft(data(k:k+255,j));
         a = a.*conj(a);
         a= sqrt(a);
         b=a;
         b=b/norm(b(1:100));
         %plot(a(1:30));
         dalta(coun,j) = sum(b(2:5));        
         theta(coun,j) = sum (b(6:9));
         aplha(coun,j) = sum (b(10:14));
         beta(coun,j) = sum (b(15:31));
         gama(coun,j) = sum (b(32:100));
    end 
end 


% subplot(5,1,1)
% p=plot(dalta(1:100,1:19)');
% title('Dalta Signal')
% subplot(5,1,2)
% p=plot(theta(1:100,1:19)');
% title('Theta Signal')
% subplot(5,1,3)
% p=plot(aplha(1:100,1:19)');
% title('Aplha Signal')
% subplot(5,1,4)
% p=plot(beta(1:100,1:19)');
% title('Beta Signal')
% subplot(5,1,5)
% p=plot(gama(1:100,1:19)');
% title('Gama Signal')

xlswrite('h14_FFT.xlsx',[dalta theta aplha beta gama]);
