% Skrypt przeznaczony do wyznaczania obszarow stabilnosci cyfrowego
% algorytmu PID oraz algorytmu DMC (sprawdzanie odpornosci na opoznienie)

% Wyznaczanie parametrow regulatorow
zadanie4DMC;
% zadanie4PID;

% Stale wartosci
Tp = 0.5;
T1 = 1.87;
T2 = 5.31;

% Zmienne
K0 = 4.5*0.1;
T0 = 10;
% Wspolczynniki licznika oraz mianownika transmitancji dyskretnej
[NUMD, DEND] = c2dm(K0, [T1*T2, T1+T2, 1], Tp, 'zoh');
b1 = NUMD(2);
b0 = NUMD(3);
a1 = DEND(2);
a0 = DEND(3);

op = T0/Tp;  % Opoznienie obiektu

% Czas symulacji oraz wartosc zadana
EOS = 1000 + 3 + op;    % Koniec symulacji
Yzad = ones(1,EOS);     % Stala trajektoria zadana
% Warunki poczatkowe rowne 0
Y = zeros(EOS,1);
U = zeros(EOS,1);
E = zeros(EOS,1);

% % Symulacja algorytmu PID
% for k = 3+op:EOS 
% Y(k) = b1*U(k-1-op) + b0*U(k-2-op) - a1*Y(k-1) - a0*Y(k-2);
% E(k) = Yzad(k) - Y(k);
% % Sygna³ sterujacy regulatora PID w wersji cyfrowej
% U(k)=r2*E(k-2)+r1*E(k-1)+r0*E(k)+ U(k-1);
% end
% 
% figure(1)
% stairs(0:EOS-3-op, Y(3+op:EOS),'LineWidth', 1.2);
% hold on;
% stairs(0:EOS-3-op, Yzad(3+op:EOS),'LineWidth', 1.2);
% legend('Sygnal wyjsciowy', 'Wartosc zadana');
% title('Regulator PID'); xlabel('Numer probki (k)');
% grid on;
% hold off;
D=125;
N=18;
Nu=1;


% Symulacja algorytmu DMC
deltaUp = zeros(D-1,1);      % Przyrosty sterowania z przeszlosci
Y = zeros(EOS,1);
U = zeros(EOS,1);

for k = 3+op:EOS 
    Y(k) = b1*U(k-1-op) + b0*U(k-2-op) - a1*Y(k-1) - a0*Y(k-2);
    % Algorytm DMC
    deltaUk = ke*(Yzad(k) - Y(k))- ku*deltaUp; % Aktualny przyrost sterowania
    deltaUp = [deltaUk; deltaUp(1:end-1)];     % Przeszle przyrosty
    U(k) = U(k-1) + deltaUk;
end

figure(2)
stairs(0:EOS-3-op, Y(3+op:EOS),'LineWidth', 1.2);
hold on;
stairs(0:EOS-3-op, Yzad(3+op:EOS),'LineWidth', 1.2);
title('Regulator DMC'); xlabel('Numer probki (k)');
legend('Sygnal wyjsciowy', 'Wartosc zadana');
grid on;
hold off;