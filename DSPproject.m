pic= imread("ProjectPicture2.tif") % take a photo name must be ProjectPicture2.tif



figure(1)
pic_b=full_contrast(pic);
imshow(full_contrast(pic_b));
title("Original Picture")
xlabel("x axis")
ylabel("y axis")

%getdown is a 2D downsampler function located end of the code
pic1=getdown(pic_b,4);
figure(2)
imshow(pic1)
title("Downsampled by 4 (512*512)")
xlabel("x axis")
ylabel("y axis")
pic2=getdown(pic1,4);
figure(3)
imshow(full_contrast(pic2))
title("Downsampled by 16 (128*128)")
xlabel("x axis")
ylabel("y axis")




pic3=getdown(pic2,4);
figure(4)
imshow(full_contrast(pic3))
title("Downsampled by 64 (32*32)")
xlabel("x axis")
ylabel("y axis")

%%


PIC=fft2(pic_b); %fft2 is 2D fast fourier transform
issymmetric(PIC)
f1=filt(2048);

A=PIC.*f1;

a=ifft2((A))

a1=getdown(a,4);
a2=getdown(a1,4);
a3=getdown(a2,4);

figure(11)
imshow(full_contrast(a1))
title("original image filtered then downsampled(M=4)")
xlabel("512 * 512 ")
figure(12)
imshow(full_contrast(a2))
title("original image filtered with a ideal lpf then downsampled (M=16)")
xlabel("128* 128 ")

figure(13)
imshow(full_contrast(a3))
title("original image filtered with a ideal lpf then dwonsampled (M=64)")
xlabel("32 * 32 ")



figure(5)
imshow(a)
title("original image filtered with a ideal lpf")
xlabel("2048 * 2048 ")









% PIC1=fft2(pic1);
% 
% f2=filt(512);
% 
% B=PIC1.*f2;
% 
% b=ifft2(B)
% figure(6)
% imshow(b)
% title("downsampled (4) image then filtered with a ideal lpf")
% xlabel("512* 512 ")
% 
% c=fft2(pic2);
% 
% figure(3)
% 
% imshow(c)
% 
% 
% d=fft2(pic3);
% 
% 
% figure(7)
% 
% imshow(d)
%% 3-approximations
   mag=abs(PIC);
   mag1=abs(PIC);

  M_list=zeros(1,20);
for u=1:1:20
   M=max(mag,[],"all");
   M_list(1,u)=M;
   for i=1:1:2048
       for j=1:1:2048
           if mag(i,j)==M
               mag(i,j)=1;
           end
       end
   end
   
end

for u=1:1:20
    f=M_list(1,u);
    for i=1:1:2048
        for j=1:1:2048
            if mag1(i,j)==f
               k1(1,u)=i
               k2(1,u)=j
            end
        end
    end
end
figure(20)
stem3(k1,k2,M_list)
title("20 Biggest DFT Coefficients")
xlabel("k1 index")
ylabel("k2 index")
zlabel("Amplitude of the Complex Entry")


%%
PUC=fft2(pic);
issymmetric(PUC)
[x,y]=size(PUC);
 k=10^4;
 n=1;
 t=1;
 while t==1
    for i=1:1:x
        for j=1:1:y
            if PUC(i,j) < k
                PUC(i,j)=1;
            end
        end
    end
 
  
   
   r = nnz(PUC)/(x*y);  
   k=k+5*(1/n);

   

   if r <= n
       t=0
       k=k-5 
   for i=1:1:x
       for j=1:1:y
           PUC(i,j)=PUC(j,i);
        end
    end
       pic_v=ifft2(PUC);
       figure(9)
       imshow(pic_v)
       issymmetric(PUC)
       title("created image with"+n+"ratio")
   end


 issymmetric(PUC)


 end 
         
   



%%

% function [mask]=createmask(D)
% 
%     mask1=fspecial("disk",D/2) ==0 ;
% 
%     mask1=double(mask1);
% 
%     mask=mask1(1:D,1:D);
% 
%     
% end

function y = filt(D) % ideal low pass filter
h1=zeros(D,1);
h2=zeros(1,D);
    for i=1:1:D/8
       h1(i,1)=1;
       h2(1,i)=1; 
    end
    y=h1*h2;
   for i=1:1:D/8

    y(D-i+1,:)=y(1,:);
    
    
   end
  for i=1:1:D/8
   y(:,D+1-i)=y(:,1);

  end
end

function [picdown]=getdown(pic,m)
    pic1=downsample(pic,m);
    picdown=downsample(pic1.',m);
    picdown=picdown.';
end

function pic = full_contrast(I)
 pic=imadjust(I,stretchlim(I),[]);
end
