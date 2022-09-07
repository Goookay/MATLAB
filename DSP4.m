n=0:1:255;
x_n=cos((pi*n.^2)/255);
N=length(n)
figure(1)
stem(n,x_n)
title("x[n]")
xlabel("n")
ylabel("x[n]")
k=0:1:255;
H_0=(1/sqrt(2))*(1+exp(-j*2*pi*k/N));

X_k=fft(x_n);

X_0k=H_0.*X_k;

x_0=ifft(X_0k);
figure(2)
stem(n,x_0)
title("x_0[n]")
xlabel("n")
ylabel("x_0[n]")
H_1=(1/sqrt(2))*(1-exp(-j*2*pi*k/N));


X_k=fft(x_n);

X_2k=H_1.*X_k;

x_2=ifft(X_2k);
figure(3)
stem(n,x_2)
title("x_1[n]")
xlabel("n")
ylabel("x_1[n]")

v_0=downsample(x_0,2);
t=0:1:127;
figure(4)
stem(t,v_0)
title("v_0[n]")
xlabel("n")
ylabel("v_0[n]")


v_1=downsample(x_2,2);



figure(5)

stem(t,v_1)

title("v_1[n]")
xlabel("n")
ylabel("v_1[n]")
%%
y_0=upsample(v_0,2);

figure(6)
stem(n,y_0)

title("y_0[n]")
xlabel("n")
ylabel("y_0[n]")




y_1=upsample(v_1,2);
figure(7)
stem(n,y_1)
title("y_1[n]")
xlabel("n")
ylabel("y_1[n]")

%%

Y_0=fft(y_0);

Y_1=fft(y_1);


F_0= (1/sqrt(2))*(1+exp(-j*2*pi*k/N));
F_1=(1/sqrt(2))*(1-exp(-j*2*pi*k/N));



Y = Y_0.*F_0+Y_1.*F_1;


y=ifft(Y);


figure(31)
stem(n,y)
title("y[n]")
xlabel("n")
ylabel("y[n]")


for i=1:1:256
if x_n(i)==y(i)
    disp("yes")

end

end







