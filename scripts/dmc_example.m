s=[0.7585 1.0376 1.1403 1.1780];
D=4;
N=4;
Nu=2;
L=1;
Lambda=eye(Nu)*L;

dUk=[1 0 0]';
y=s;
Yzad(1:N)=2;

for i=1 : D-1
    for k=1 : N
        if k+i > D
            Mp(k, i)=s(D)-s(i);
            continue
        end
        Mp(k, i)=s(k+i)-s(i);
        
    end
end

M=zeros(N, Nu);
for i=1:Nu
    for k=1 : N
        M(k+i-1, i)=s(k);
        if k+i-1 == N
            break
        end
    end
end

K=(M'*M+Lambda)^-1*M';


Mp*dUk;
dUk=K*(Yzad-y-Mp*dUk)

U(1)=dUk(1);
Ypraw(1)=s(1);

for i=2:50
    
    U(i)=dUk(1)+U(i-1);
    
end
