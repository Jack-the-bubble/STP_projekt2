kk=4.5;
kknomp=[(kk+2.43)/kk (kk+2.11)/kk (kk+1.62)/kk (kk+1.24)/kk (kk+0.89)/kk (kk+0.57)/kk (kk+0.265)/kk (kk-0.01)/kk (kk-0.01)/kk  (kk-0.265)/kk (kk-0.49)/kk];
kknopr=[(kk+3.95)/kk (kk+3.32)/kk (kk+2.78)/kk (kk+2.33)/kk (kk+1.92)/kk (kk+1.55)/kk (kk+1.25)/kk (kk+0.97)/kk (kk+0.97)/kk (kk+0.7)/kk (kk+0.48)/kk];
kknomd=[(kk+4.03)/kk (kk+3.52)/kk (kk+2.97)/kk (kk+2.52)/kk (kk+2.68)/kk (kk+4.7)/kk (kk+18.25)/kk (kk+18.25)/kk 0 0 0];
ttnom=[1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.8 1.9 2];

plot (ttnom, kknomp)
hold on;
plot(ttnom, kknopr)
plot(ttnom, kknomd)

xlabel('To/Tonom')
ylabel('Ko/Konom')
legend('regulator PID ZN','regulator PID poprawiony', 'regulator DMC')