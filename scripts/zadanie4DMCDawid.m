% Dane z zadania
Tp = 0.5;

% Wpolczynniki rownania roznicowego
% a1=-1.676; a0=0.6966; b1=0.05029; b0=0.04458; 
run('init')



zet=182.5;
    
Ko=4.5+zet/10;

run('zadanie1')

opoz=z.InputDelay;


aa1=z.Denominator{1}; bb1=z.Numerator{1}; 
a1=aa1(2); a0=aa1(3);b1=bb1(2);b0=bb1(3);

% Czas symulacji oraz wartosc zadana
kk = 400; % Koniec symulacji
U = ones(kk,1);
U(1:opoz+2) = 0;  % Wymuszenie rowne 1 od momentu rozpoczecia symulacji
Y = zeros(kk,1); % Kolejne probki odpowiedzi skokowej


D = 125;          % Horyzont dynamiki  125
N = 18;     % Horyzont predykcji zmniejszany co 2, najlepszy 18
Nu = 1;           % Horyzont sterowania 1
lambda = 15;     % Ograniczenie zmian sterowania

% Odpowiedz skokowa 
% W obiekcie wystepuje opoznienie rowne dwunastu okresom próbkowania, 
% a wiec symulacje mozna rozpoczac od chwili k = 13 (odpowiada to
% poczatkowi symulacji w chwili 0s)
aaa1=-1.6755; aaa0=0.6966; bbb1=0.0503; bbb0=0.0446;
for k = 13:kk
        Y(k) = bbb1*U(k-11) + bbb0*U(k-12) - aaa1*Y(k-1) - aaa0*Y(k-2);
end
% Zapis kolenjnych probek od momentu rozpoczecia symulacji (bez chwili 0)


% stairs(U);
% hold on;
% stairs(Y);


S = Y(14:D+14);
    
% Wykres odpowiedzi skokowej
%     figure(1);
%     stairs(0:D,Y(13:D+13), 'LineWidth', 1.1);
%     hold on;
%     stairs(0:D,U(13:D+13), 'LineWidth', 1.1);
%     title('Odpowiedz skokowa');
%     xlabel('Numer probki (k)');
%     legend('Sygnal wyjsciowy', 'Sygnal sterujacy');
%     hold off;

% Tworzenie macierzy MP i M
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

M = zeros(N, Nu);
for i = 1:N
    for j = 1:Nu
        if(j<=i)
            M(i,j) = S(i-j+1);
        end
    end
end

% Czas symulacji oraz wartosc zadana
kk = 350;             % Koniec symulacji
U = zeros(kk,1);      % Wartosci sterowania
Y = zeros(kk,1);      % Wyjscie obiektu
deltaUp = zeros(D-1,1);      % Przyrosty sterowania z przeszlosci
Yzad = ones(kk+N,1)*2;  % Stala wartosc zadana na calym horyznocie predykcji
Yzad(1:opoz+2) = 0;
% Symulacja ukladu regulacji z wykorzystaniem algorytmu DMC
K = ((M'*M + lambda*eye(Nu))^-1)*M';
ke = sum(K(1,:));
ku = K(1,:)*MP;
for k = opoz+3:kk 
    Y(k) = b1*U(k-opoz-1) + b0*U(k-opoz-2) - a1*Y(k-1) - a0*Y(k-2);
    % Algorytm DMC
    deltaUk = ke*(Yzad(k) - Y(k))- ku*deltaUp; % Aktualny przyrost sterowania
    deltaUp = [deltaUk; deltaUp(1:end-1)];  % Przeszle przyrosty
    U(k) = U(k-1) + deltaUk;
end

% figure(2);
% stairs(0:60, U(13:73));
% hold on;
% stairs(0:kk-13, Yzad(13:end-N),'LineWidth', 1.1);

stairs(0:280, Y(13:293));
hold on;

xlabel('okres (k)');
% ylabel('wartosc sterowania u(k)');
% legend('L=5', 'L=10', 'L=15', 'L=20', 'L=25');
grid on;

% hold off;



