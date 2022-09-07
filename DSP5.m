%% a part

n=0:1:99;

h_n=0.94.^n;

x_n1=audioread('pentakill1.mp3');

x_n2= x_n1.';

x_n3 = x_n2(1,:);

x_n4= x_n3(4*10^5:5*(10^5)-1);

N_x = length(x_n4);

N_h=100;

N=N_h+N_x-1;
h_n1=[h_n zeros(1,N-N_h)];
x_n=[x_n4 zeros(1,N-N_x)];

count=0;
% this implementation was the easiest one however lots of multiplication
% involved
% I had limited time otherwise I would lower the count 
y1=zeros(1,102400);
for n=1:(N_x + N_h-1)
    y1(n)=0;
    for k=1:n
        y1(n)=y1(n)+h_n1(k)*x_n(n-k+1);
        count=count+1;
    end
end


%%




%% b part
N_s1=925;
N_s=1024;
im=sqrt(-1);
x_n5=[x_n4 zeros(1,1024*100-N_x+275)];
index=1;
h_n2=[h_n zeros(1,924)];
U=zeros(1024);
    for k=0:1:1023
        for n=0:1:1023
        l=exp(-im*2*pi*k*(n)/N_s);
        U(k+1,n+1)=l;
        end
        H=h_n2*U;
        %this dft is true
    end 

   % I have a problem right here I 
for i=0:99
    h=i*N_s1;
    x_n6=x_n5(1+h:925+h);
    x_n7=[x_n6 zeros(1,99)];
    for k=0:1:1023
        for n=0:1:1023
        p=exp(-im*2*pi*k*(n+h)/N_s);
        W(k+1,n+1)=p;
        end
    end 
    g=x_n7*W;

    f=g.*H;

    f_1=ifft(f);

    X(i+1,:)=f_1;
end
d=zeros(1,102400);
    for i=1:1:99
        for j=1:1:1024
            if j <= 925
            d(1,j+1024*(i-1)) = X(i,j);
            else
            d(1,j+1024*(i-1))= X(i,j)+X(i+1,j-925);
            end
            
           
        end
    end


y2=d;

 
%% C part
X1=fft(x_n5);
h_n3=[h_n2 zeros(1,101376)];
H1=fft(h_n3);

XH=H1.*X1;

y3=ifft(XH);

%% D part
diff=zeros(1,102400);
for i=1:1:length(y1)
    diff(i)=(y1(i)-y2(i))^2;
end
diff2=zeros(1,102400);

for i=1:1:length(y1)
    diff2(i)=(y1(i)-y3(i))^2;
end

diff3=zeros(1,102400);

for i=1:1:length(y1)
    diff3(i)=(y2(i)-y3(i))^2;
end

a=sum(diff,'all');
b=sum(diff2,'all');
c=sum(diff3,'all');
error=[a b c]
%%


% for i=1:1:N_h
%     for j=1:1:N_x
%         y1_n(j)=h_n(i)*x_n(j);
%     end
% end
% for i=1:1:length(y1_n)
%     y_n(i)=y1_n(i);
% end
% 
% for i=2:1:N_h
%     y2_n=zeros(1,length(x_n)+1);
%     for j=1:1:N_x
%         y2_n(j+i-1)=x_n(j);
%     end
%     for k=1:1:N_h
%         for u=1:1:N_x
%         y1_n(u)=h_n(k)*y2_n(u);
%         end
%     end
%     for l=1:1:length(y1_n)
%         y_n(l)=y_n(l)+y1_n(l);
%     end
% end
% 
% for i=1:1:length(y_c)
% 
%     if y_c(i)==y_n(i)
%         disp("Congrats");
%     end
%end