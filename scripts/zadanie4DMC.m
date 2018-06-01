a1=1.676; a0=0.6966; b1=0.05029; b0=0.04458; 
s(1:12)=0;
u(1:250)=1;

for k=13 : 250
   s(k)=b1*u(k-11)+b0*u(k-12)+a1*s(k-1)- a0*s(k-2);  
end
length(s)
stairs([1:250], s)

D=120;
N=120;
Nu=N-20;

M=zeros(N, Nu-1);

for i=1: Nu-1 % Numer kolumny
    for n=1: N  % Numer wiersza
        M(n+i-1, i)=s(n);
        if n+i-1 == N
            break
        end
    end
end
        
M    

% wyzdaczanie delta U(k-i)

% K=(M'*Ksi*M+Lambda)^-1*M'*Ksi
yzad=ones(N, 1);

yzad=yzad*4.5;

L=100
Ksi=eye(N);
Lambda=eye(Nu-1);
Lambda= Lambda*L;

K=((M'*Ksi*M+Lambda)^-1)*M'*Ksi

deltaU=[u(2)-u(1)];
for i = 3 : N
    deltaU=[deltaU ; u(i) - u(i-1)];
end

y=ones(N, 1);
y=y*s(k);


for i=1 : D-1
    x=1;
    for n=1 : N
        Mp(n, i)=s(x+i)-s(i);
        x=x+1;
    end
end

Mp;

U=K*(yzad-y-Mp*deltaU);

stairs(U)


