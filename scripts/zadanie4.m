%przed uruchomieniem skrytpu nalezy odpalic program zadanie1.m

%inicjalizacja 
run('init')


kknom=Ko/4.5;
Ttnom=To/5;

zet=20
    
Ko=4.5+zet/10;

run('zadanie1')



aa1=z.Denominator{1}; bb1=z.Numerator{1}; 
a1=-aa1(2); a0=aa1(3);b1=bb1(2);b0=bb1(3);
Kk=0.5012;
Tk=19.95;


Kr=Kk*0.6;
Ti=Tk/2;
Td=Tk*0.12;

%  Lepsze parametry
Ti=7;
Td=2.2;

Te=0.5;

r2=Kr*Td/Te; r1=Kr*(Te/(2*Ti)-2*Td/Te-1); r0=Kr*(1+Te/(2*Ti)+Td/Te); 
kk=200; %koniec symulacji 
%warunki początkowe 
u(1:z.InputDelay+2)=0; y(1:z.InputDelay+2)=0; 
% yzad(1:2)=0; 
yzad(1:kk)=2;

% ????
e(1:z.InputDelay+2)=yzad(1)-y(1);  
% e(1:12)=0;

 for k= z.InputDelay+3:kk; %główna pętla symulacyjna 
 %symulacja obiektu 
      y(k)=b1*u(k-z.InputDelay-1)+b0*u(k-z.InputDelay-2)+a1*y(k-1)- a0*y(k-2); 
 %uchyb regulacji 
      e(k)=yzad(k)-y(k); 
 %sygnał sterujcy regulatora PID 
      u(k)=r2*e(k-2)+r1*e(k-1)+r0*e(k)+u(k-1); 

 end
%wyniki symulacji 

%  figure; stairs(u); 
%  title('u'); xlabel('k'); 
stairs(y); hold on; 
title('yzad, y'); xlabel('k')


% kknom=[kknom Ko/4.5];
% Ttnom=[Ttnom To/5];

% figure
% plot(Ttnom, kknom);