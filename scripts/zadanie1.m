
run('init')

G = tf([Ko],[T1*T2 T1+T2 1],'InputDelay', To)
z=c2d(G, 0.5, 'zoh')

% step(G,'-',z,'--')

