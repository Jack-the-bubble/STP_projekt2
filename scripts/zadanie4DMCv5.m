a1=1.676; a0=0.6966; b1=0.05029; b0=0.04458; 
s(1:12)=0;
u(1:250)=1;
y(1:12)=0;


D=120;
N=120;
Nu=100;

Yzad=ones(N, 1);

% wyznaczenie wektora s
deltau(1)=1
for i=2 : 250
    deltau(i)=u(i)-u(i-1);
end

for i=13 : 250
    y(i)=b1*u(i-11)+b0*u(i-12)+a1*y(i-1)- a0*y(i-2);
    Usum=0;
    for k=1 : i-1
       Usum=Usum+s(i-k)*deltau(k+1); 
    end
    s(i) = (y(i)-0-Usum)/deltau(1);
end

% % Macierz M

M=zeros(N, Nu);
for i=1:Nu
    for k=1 : N
        M(k+i-1, i)=s(k);
        if k+i-1 == N
            break
        end
    end
end

% % wektor dU

L=1;
Lambda=eye(Nu)*L;

% styknie policzyc raz
K=(M'*M+Lambda)^-1*M'

% to chyba tez styknie raz?
for i=1 : D-1;
    for k=1 : N;
        if k+i > D;
            Mp(k, i)=s(D)-s(i);
            continue
        end
        Mp(k, i)=s(k+i)-s(i);
        
    end
end

% to trza z kazda iteracja
k=13;

Ynow=ones(N, 1)*y(k);


dUp=zeros(N-1, 1)

Yo=Ynow+Mp*dUp;

Uopt=K*(Yzad-Yo);
przeszSter=zeros(12, 1);
przeszSter=[przeszSter ; Uopt(1)];
przeszWyj=zeros(12, 1);
przeszWyj=[przeszWyj; b1*przeszSter(k-11)+b0*przeszSter(k-12)+a1*przeszWyj(k-1)- a0*przeszWyj(k-2)];

for k = 14 : 2000
     Ynow=ones(N, 1)*przeszWyj(k-1);
     for i = 1 : N-2
          dUp(N-i)=dUp(N-i-1);
     end
     dUp(1)=Uopt(1)-dUp(1);
     Yo=Ynow+Mp*dUp;
     Uopt=K*(Yzad-Yo);
     nowyY=Yo+M*Uopt;
     przeszWyj=[przeszWyj; nowyY(1)];
     przeszSter=[przeszSter ; Uopt(1)];
%      przeszWyj=[przeszWyj; b1*przeszSter(k-11)+b0*przeszSter(k-12)+a1*przeszWyj(k-1)- a0*przeszWyj(k-2)];
end

stairs(przeszWyj)
figure
stairs(przeszSter)