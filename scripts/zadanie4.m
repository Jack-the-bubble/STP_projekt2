%przed uruchomieniem skrytpu nalezy odpalic program zadanie1.m

%inicjalizacja 
run('zadanie1')



a1=1.676; a0=0.6966; b1=0.05029; b0=0.04458; 

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
u(1:12)=0; y(1:12)=0; 
% yzad(1:2)=0; 
yzad(1:kk)=2;

% ????
e(1:12)=yzad(1)-y(1);  
% e(1:12)=0;

 for k= 13:kk; %główna pętla symulacyjna 
 %symulacja obiektu 
      y(k)=b1*u(k-11)+b0*u(k-12)+a1*y(k-1)- a0*y(k-2); 
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