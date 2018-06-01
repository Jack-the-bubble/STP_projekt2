%inicjalizacja 
a1=-1.6375; a0=0.6703; b1=0.035; b0=0.0307; 
r2=3; r1=-7.14, r0=4.26; 
kk=100 %koniec symulacji 
%warunki początkowe 
u(1:4)=0; y(1:4)=0; 
yzad(1:9)=0; yzad(10:kk)=1; 
e(1:4)=0;                      
for k= 5:kk; %główna pętla symulacyjna 
%symulacja obiektu 
     y(k)=b1*u(k-3)+b0*u(k-4)-a1*y(k-1)- a0*y(k-2); 
%uchyb regulacji 
     e(k)=yzad(k)-y(k); 
%sygnał sterujcy regulatora PID 
     u(k)=r2*e(k-2)+r1*e(k-1)+r0*e(k)+u(k-1); 
end; 
%wyniki symulacji 
figure; stairs(u); 
title('u'); xlabel('k'); 
figure; stairs(y); hold on; stairs(yzad,':'); 
title('yzad, y'); xlabel('k')