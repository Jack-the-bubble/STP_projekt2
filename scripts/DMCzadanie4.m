% Dane z zadania
run('init')

STIME=1500;
D = 125;    % Horyzont dynamiki wybrany 125
N = 20;     % Horyzont predykcji, najlepszy 18
Nu = 1;     % Horyzont sterowania, najlepszy 1
lambda = 15;

zet=-14;
Ko=4.5+zet/10;

run('zadanie1')

opoz=z.InputDelay;


aa1=z.Denominator{1}; bb1=z.Numerator{1}; 
a1=aa1(2); a0=aa1(3);b1=bb1(2);b0=bb1(3);

kk = STIME;
Y = zeros(kk,1);

U = ones(kk,1);
% U(1:opoz+2) = 0;





% Odpowiedz skokowa 
aaa1=-1.6755; aaa0=0.6966; bbb1=0.0503; bbb0=0.0446;
for k = 13:kk
        Y(k) = bbb1*U(k-11) + bbb0*U(k-12) - aaa1*Y(k-1) - aaa0*Y(k-2);
end


% stairs(U);
% hold on;
% stairs(Y);


    
% S = Y(14:D+14);
S=Y(1:D);

% Macierz Mp 
MP = zeros(N, D-1);
for i = 1:D-1
    for j = 1:N
        if (i + j) <= D-1
            MP(j,i) = S(i+j) - S(i);
        else
            MP(j,i) = S(D) - S(i);
        end
    end
end

% Macierz M
M = zeros(N, Nu);
for i = 1:N
    for j = 1:Nu
        if(j<=i)
            M(i,j) = S(i-j+1);
        end
    end
end

kk = STIME;             % Dlugosc symulacji
U = zeros(kk,1);      
Y = zeros(kk,1);      
deltaUp = zeros(D-1,1);      % Zmiany sterowania z poprzednich chwil
Yzad = ones(kk+N,1);  % Stala wartosc skoku 
% ALgorytm DMC - przygotowanie do petli glownej
K = ((M'*M + lambda*eye(Nu))^-1)*M';
ke = sum(K(1,:));
ku = K(1,:)*MP;
for k = opoz+3:kk 
    Y(k) = b1*U(k-opoz-1) + b0*U(k-opoz-2) - a1*Y(k-1) - a0*Y(k-2);
    deltaUk = ke*(Yzad(k) - Y(k))- ku*deltaUp; % zmiana sterowania w obecnej chwili
    deltaUp = [deltaUk; deltaUp(1:end-1)];  % Przeszle zmiany
    U(k) = U(k-1) + deltaUk;
end

% stairs(0:STIME-100, U(13:STIME-100+13));
% hold on;
stairs(0:STIME-100, Y(13:STIME-100+13));
hold on;

 xlabel('okres (k)');


% ylabel('wartosc sterowania u(k)');
% legend('L=5', 'L=15', 'L=25', 'L=35', 'L=45');

% legend('N=24', 'N=22', 'N=20', 'N=18', 'N=16');
% legend('Nu=1', 'Nu=2', 'Nu=3', 'Nu=4', 'Nu=5');
