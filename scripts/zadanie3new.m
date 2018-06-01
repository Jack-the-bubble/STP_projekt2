
run('init')


 Kk=0.5012;
 Tk=19.95
 
 Ti=Tk/2;
 Td=Tk*0.12;
 
 Tik=7;
 Tdk=1.4;
 
 Kk=0.2
 G = tf([Ko],[T1*T2 T1+T2 1],'InputDelay', To);
 for i=-1:1
    Ti=Tik+i*0.6;
     for j=-1:1
        Td=Tdk+j*0.6;
        C=pid(1, 1/Ti, Td);
        C=C*Kk*0.6
        S=  G*C/(1+G*C)
        step(S, 90)
        hold on
    end
 end
legend('Ti=6.4 Td=0.8', 'Ti=6.4 Td=1.4', 'Ti=6.4 Td=2', 'Ti=7 Td=0.8', 'Ti=7 Td=1.4', 'Ti=7 Td=2', 'Ti=7.6 Td=0.8', 'Ti=7.6 Td=1.4', 'Ti=7.6 Td=2')