s=tf('s');
G = tf([Ko],[T1*T2 T1+T2 1],'InputDelay', To);
% parametry z Z-N
% Kr=0.3019
% Ti=Kr*1/9.975
% Td=Kr*2.394

% Kr=0.019;
% Ti=0;
% Td=0;

 
% Kr=0.3019;
% Ti=Kr*1/9.975;
% Td=Kr*2.394;
Tf=0.5;

% C=pid(Kr, Ti, Td, Tf);

% Yold=feedback(G, C)



% Yold=C*G;




step(Yold)
hold on
step(G)

legend('Yold', 'G')

% Kk=0.5032;
% Tk=19.95;
