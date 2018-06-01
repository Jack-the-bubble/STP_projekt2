a1=1.676; a0=0.6966; b1=0.05029; b0=0.04458; 
s(1:12)=0;
u(1:250)=1;
y(1:12)=0;


D=120;
N=120;
Nu=119;

Yzad(1:N)=5;

% wyznaczenie wektora s
deltau(1)=1
for i=2 : 250;
    deltau(i)=u(i)-u(i-1);
end

for i=13 : 250;
    y(i)=b1*u(i-11)+b0*u(i-12)+a1*y(i-1)- a0*y(i-2);
    Usum=0;
    for k=1 : i-1
       Usum=Usum+s(i-k)*deltau(k+1); 
    end
    s(i) = (y(i)-0-Usum)/deltau(1);
end

L=1;
Lambda=eye(Nu)*L;

dUk(1)=1;
dUk(2:D-1)=0;

Ynow(1:N)=y(1);
Yzad(1:N)=2;

for i=1 : D-1;
    for k=1 : N;
        if k+i > D;
            Mp(k, i)=s(D)-s(i);
            continue
        end
        Mp(k, i)=s(k+i)-s(i);
        
    end
end

M=zeros(N, Nu);
for i=1:Nu;
    for k=1 : N;
        M(k+i-1, i)=s(k);
        if k+i-1 == N;
            break
        end
    end
end

K=(M'*M+Lambda)^-1*M';


Pom=Mp*dUk';
Pom2=ones(N, 1)*(Yzad(1)-Ynow(1));
Pom3=Pom2-Pom;
dUk=K*Pom3;
% dUk=K*(Yzad'-Ynow'-Mp*dUk)

U(1:12)=0;
Ypraw(1:12)=0;

U(13)=dUk(1);
Ypraw(13)=b1*U(2)+b0*U(1)+a1*Ypraw(12)- a0*Ypraw(11);

for i=14:50
    Ynow(1:N)=Ypraw(i-1);
    Pom=Mp*dUk;
    Pom2=ones(N, 1)*(Yzad(i)-Ynow(1));
    Pom3=Pom2-Pom;
    dUk=K*Pom3;
%     dUk=K*((Yzad')-(Ynow')-Mp*(dUk'));
    U(i)=dUk(1)+U(i-1);
    Ypraw(i)=b1*U(i-11)+b0*U(i-12)+a1*Ypraw(i-1)- a0*Ypraw(i-2);    
end

stairs(Ypraw)