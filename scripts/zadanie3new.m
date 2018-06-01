s=tf('s')


% moje
 Kk=0.5012;
 Tk=19.95
 
 Ti=Tk/2;
 Td=Tk*0.12;
 
 G=Ko*exp(-To*s)/((T1*s+1)*(T2*s+1))

% Dawida
% Kk=1.538
% Tk=19.82;
% 
% Ti=Tk/2;
% Td=Tk*0.12;
% 
% Ko=1.5 ;To=5 ; T1=1.71 ;T2=5.55 ;
% C=pid(1, 1/Ti, Td);
% C=C*Kk*0.6
% 
% G=Ko*exp(-To*s)/((T1*s+1)*(T2*s+1))


step(1, 1); hold on;



% C=pid(Kk*0.6, 0.0214, 0.4469, 0.000001)



% moje
% C=pid(1, 1/Ti, Td);
% C=C*Kk*0.6

S=  G*C/(1+G*C)
step(S, 200)

% Kk=0.5012
% Kr=Kk*0.6
% Ki=0.0214
% Kd=0.4469
% Tf=0.0000001




