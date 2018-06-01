a1=1.676; a0=0.6966; b1=0.05029; b0=0.04458; 
s(1:12)=0;
u(1:250)=1;
y(1:12)=0;


D=120;
N=120;
Nu=100;

Yzad(1:N)=5;

% Y=Yo+M*dU
% Yo=Yk+Mp*dUp
% dU=(M'*Ksi*M+Del)^-1*M'*Ksi*(Yzad-Yo)

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


% Wyznaczenie skladowej swobodnej
% % Macierz Mp

% for i=1 : D-1
%     for k=1 : N
%         Mp(k, i)=s(k+i)-s(i);
%     end
% end

for i=1 : D-1;
    for k=1 : N;
        if k+i > D;
            Mp(k, i)=s(D)-s(i);
            continue
        end
        Mp(k, i)=s(k+i)-s(i);
        
    end
end

% %  Wektor Yk

k=14;

Yk(1:N)=y(k)


% % wektor dUp


dUp(1)=1;
dUp(2:D-1)=0;
% for i=1 : D-1
%     dUp(i)=u(k-i);
% end

% odpowiedz swobodna
Yo=Yk'+Mp*dUp';

% odpowiedz wymuszona

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

L=100;
Lambda=eye(Nu)*L;

% styknie policzyc raz
K=(M'*M+Lambda)^-1*M'


dU=K*(Yzad'-Yo);

% % wyjscie regulatora

y=Yo+M*dU;


yost=y(1);

stairs(dU)
figure;
stairs(y)

