clc; clear; close all;
tic

%Normalna distribucija brzina
V=normalna(0.4,0.7,270);
omega=normalna(-0.7,0.7,270);

%Translatorno kretanje
t=1;
omega1=omega;
tetat=zeros(1,50);
xt=zeros(1,50);
yt=zeros(1,50);
for i=1:49
    xt(i+1)=xt(i)+V(i)*cos(omega1(i)*t*pi/180);
    yt(i+1)=yt(i)+V(i)*sin(omega1(i)*t*pi/180);
    tetat(i+1)=tetat(i)+omega1(i)*t;
end
figure('Name','Translatorno kretanje')
plot(xt,yt,'Marker','o','MarkerFaceColor','red')
axis([-1 20 -0.2 0.2]);
title('Translatorno kretanje')
xlabel('x') 
ylabel('y')

A=transpose([1:50; V(1:50); omega(1:50); xt; yt; tetat]);
filename = 'translatorno realno kretanje.xlsx';
xlswrite(filename,A);

%Kretanje po putanji oblika kvadrata
tetakv=zeros(1,160);
xkv=zeros(1,160);
ykv=zeros(1,160);
omega1=omega;
a=51;
for i=1:159
    xkv(i+1)=xkv(i)+V(a)*cos(omega1(a)*t*pi/180);
    ykv(i+1)=ykv(i)+V(a)*sin(omega1(a)*t*pi/180);
    
    if (i==40) || (i==80) || (i==120)
        omega1=omega1+90;
    end
    if i==40
        omega2=omega+90;
    end
    if i==80
        omega3=omega2+90;
    end
    if i==120
        omega4=omega3+90;
    end
    tetakv(i+1)=tetakv(i)+omega1(a)*t;
    a=a+1;
end
omegakv=[omega(51:90) omega2(91:130) omega3(131:170) omega4(171:210)];
figure('Name','Kretanje po trajektoriji kvadratnog oblika')
plot(xkv,ykv,'Marker','o','MarkerFaceColor','red')
title('Kretanje po trajektoriji kvadratnog oblika')
xlabel('x') 
ylabel('y')

A=transpose([1:160; V(51:210); omega(51:90) omega2(91:130) omega3(131:170) omega4(171:210); xkv; ykv; tetakv]);
filename = 'Kvadratno realno kretanje.xlsx';
xlswrite(filename,A);

%Kretanje po putanji oblika kruznice
omegakr=zeros(1,60)
tetakr=zeros(1,60);
xkr=zeros(1,60);
ykr=zeros(1,60);
omega1=omega;
for i=1:59
    xkr(i+1)=xkr(i)+V(a)*cos(omega1(a)*t*pi/180);
    ykr(i+1)=ykr(i)+V(a)*sin(omega1(a)*t*pi/180);
    omega1(a+1)=omega1(a)-6;
    omegakr(i)=omega1(a+1)
    tetakr(i+1)=tetakr(i)+omega1(a)*t;
    a=a+1;
end

figure('Name','Kretanje po trajektoriji kruznog oblika')
plot(xkr,ykr,'Marker','o','MarkerFaceColor','red')
title('Kretanje po trajektoriji kruznog oblika')
xlabel('x') 
ylabel('y')

A=transpose([1:60; V(211:270); omega1(211:270); xkr; ykr; tetakr]);
filename = 'kruzno realno kretanje.xlsx';
xlswrite(filename,A);
toc