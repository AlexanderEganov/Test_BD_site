clc
%начало лабы 2
%—амолет:  Piper PA-34 Seneca 
%јйропорт: ѕариж Ўарль-де-голль
g=9.8;                                      % ускорение свободного падени€
Cyaotriva= 1.5;                             % константа подъемной силы
e2 = 6.69437999014*10^(-3);                 %  онстанта
A = 6378137;                                %  онстанта             м
u=0.0000729;                                % 15.041градусы в час = 0.00007292082577569 радиан в секунду
Ge = 9.7803253359;                          % m/(c^2)
Gp = 9.8321849378;                          % m/(c^2)
% начальные координаты 
lam0 =(2 + 34/60 + 0.15/3600)/180*pi;       % долгота
phi0 =(49 + 1/60 + 24.59/3600)/180*pi;      % широта
% psi0 = -94/180*pi;                          % направление(курс)
psi0 = 87/180*pi;                          % направление(курс)
H0 = 118;                                   % высота над уровнем мор€ 
                                            % вспомогательные характеристики самолета
S= 2*19.39;                                 % площадь 2 крыльев м^2
p= 1.2;                                     % сопративление воздуха kg/(m^3)
massa=1900;                                 % ћасса самолета + человек + груз
dT = 0.1;                                   % шаг
Votr =(sqrt((2*massa*g)/(S*p*Cyaotriva)));  % скорость отрыва от земли
Vbez = 1.3*Votr;                            % безопасна€ скорость
V0 = 0;                                     % начальна€ скорость
tyag=2*176*20;                              % т€га                                           
Lp = Votr^2/(2*g*(tyag/(massa*g)-0.2));     % расчет длинны разбега
teta0=0;
gamma0=0;
gamma=gamma0; 
H = H0;
Hbez = 10.7;                                % безопасна€ высота
kren = 0;
tangaj = 0;
kurs = psi0;
teta0 = 0;
tetaotr = pi/6;                             % угол отрыва
teta=teta0;
T1 = massa*2*Votr/(tyag);
T2 = 2*(Hbez)/(Votr*sin(tetaotr));          % расчет времени на подьем до безопасной высоты
T_razgona = [0:dT:T1]';
T_rejim_nabora = [0:dT:T2]';
T=[0:dT:(T1+T2)-dT]';
VRazg=(V0-Votr)/2*cos(pi*T/T1)+(V0+Votr)/2;
VRej_nabora=(Votr-Vbez)/2*cos(pi*T/T2)+(Votr+Vbez)/2;
  
lam = 0*T + lam0;                           % матрица дл€ л€мбды
teta=0*T+teta0;
H = 0*T + H0;                               % матрица дл€ высоты
kren = 0*T;                                 % матрица дл€ крена которого нету
tangaj = 0*T;                               % матрица дл€ тангажа
kurs = 0*T + psi0;                          % ћатрица дл€ курса
rez1=[];
rez2=[];
modznach=[];
phi = 0*T+phi0;

Vu=0*T; 
Vn=0*T;
Ve=0*T;
Rn = 0*T;
Re = 0*T;
teta(124,1)=0.0037;
for i = 2:size(T,1)
   if i<=T1/dT
       format long;
       Itetaciya=i;
  H(i)=H0;
  Vu(i,1) = VRazg(i-1,1)*sin(teta(i-1,1));
  Vn(i,1) = VRazg(i-1,1)*cos(psi0)*cos(teta(i-1,1));
  Ve(i,1) = VRazg(i-1,1)*sin(psi0)*cos(teta(i-1,1));
  teta(i,1) = teta0;
  Rn(i,1) = A*(1-e2)/((sqrt(1-e2*(sin(phi(i-1,1)))^2))^3);
  H(i,1) = H(i-1,1) + Vu(i,1)*dT;
  phi(i,1) = phi(i-1,1) + Vn(i,1)/(Rn(i,1)+H(i,1))*dT; 
  Re(i,1) = A/sqrt(1-e2*(sin(phi(i-1,1)))^2);
  lam(i,1) = lam(i-1,1) + Ve(i,1)/((Re(i,1)+H(i,1))*cos(phi(i,1)))*dT;
  
  
  
  
  
V_vektor = [Ve(i,1);Vn(i,1);Vu(i,1)];
  
V_tochka = [-sin(psi0)*pi/T1*(V0-Votr)/2*sin(pi/T1*T_razgona(i-1,1));
             -cos(psi0)*pi/T1*(V0-Votr)/2*sin(pi/T1*T_razgona(i-1,1));
                                        0                          ];
                                    
Spsi=[sin(psi0) cos(psi0) 0;
     -cos(psi0) sin(psi0) 0;
        0         0       1];
   
Steta=[  cos(teta(i,1))  0 sin(teta(i,1)) ;
             0       1      0     ; 
         -sin(teta(i,1)) 0 cos(teta(i,1))];
   
Sgamma= [1      0          0       ;
        0  -sin(gamma0)  cos(gamma0);
        0  -cos(gamma0) -sin(gamma0)];
     
 
    
    S=(Sgamma*Steta*Spsi);                               
                                                            
                                    
                                    
 U_krisha = [        0            u*sin(phi(i,1)) -u*cos(phi(i,1));
               -u*sin(phi(i,1))        0                0         ;
                u*cos(phi(i,1))        0                0        ];
                                                                     
  Omega_krisha = [              0               Ve(i)*tan(phi(i-1,1))/(Re(i)+H(i))      -Ve(i)/(Re(i)+H(i));
                  -Ve(i)*tan(phi(i-1,1))/(Re(i)+H(i))               0                  -Vn(i)/(Rn(i)+H(i));
                          Ve(i)/(Re(i)+H(i))                Vn(i)/(Rn(i)+H(i))                    0    ]  ;
                      
 Norm_G=((-Ge*cos(phi(i-1,1))*cos(phi(i-1,1))-Gp*sqrt(1-e2)*sin(phi(i-1,1))*sin(phi(i-1,1)))/sqrt(1-e2*sin(phi(i-1,1))*sin(phi(i-1,1))));
  
  Gx=[   0     ;
         0     ;
      Norm_G  ];
 
 Fx = V_tochka-((Omega_krisha+2*U_krisha)*V_vektor+Gx);         
            
 Fz=S*Fx;

  modznach1=[Fz(1) Fz(2) Fz(3)];
  modznach=[modznach;modznach1];
  flight1 = [T(i) lam(i,1)*180/pi phi(i,1)*180/pi H(i) kren(i) tangaj(i) kurs(i)];
  znacheniya1 = [T(i) Fz(1) Fz(2) Fz(3)];
  rez2=[rez2;znacheniya1];
  rez1=[rez1;flight1];


   else
  kren(i,1) = 0;
  kurs(i,1) = psi0;
  teta(i,1) = (teta0-tetaotr)/2*cos(pi*T_rejim_nabora(i-124,1)/T2) + (teta0+tetaotr)/2;  
  Vn(i,1) = VRej_nabora(i-124,1)*cos(psi0)*cos(teta(i,1));
  Rn(i,1) = A*(1-e2)/((sqrt(1-e2*(sin(phi(i-1,1)))^2))^3);
  Vu(i,1) = VRej_nabora(i-124,1)*sin(teta(i,1));
  H(i,1) = H(i-1,1) + Vu(i,1)*dT;
  phi(i,1) = phi(i-1,1) + (Vn(i,1)/(Rn(i,1)+H(i,1)))*dT;
  Re(i,1) = A/sqrt(1-e2*(sin(phi(i,1)))^2);
  Ve(i,1) = VRej_nabora(i-124,1)*sin(psi0)*cos(teta(i,1));
  lam(i,1) = lam(i-1,1) + Ve(i,1)/((Re(i,1)+H(i,1))*cos(phi(i,1)))*dT; 
  tangaj(i,1) = teta(i,1);
  
  V_ = [Ve(i,1);
        Vn(i,1);
        Vu(i,1)];
        
  V_tochka = [      -sin(psi0)*pi/T2*(Votr-Vbez)/2*sin(pi/T2*T_rejim_nabora(i-124,1));
                    -cos(psi0)*pi/T2*(Votr-Vbez)/2*sin(pi/T2*T_rejim_nabora(i-124,1));
                                             0                   ]; 

  S = [           cos(teta(i-1,1))*sin(psi0)                             cos(teta(i-1,1))*cos(psi0)                                    sin(teta(i-1,1));
      sin(gamma)*cos(psi0)-sin(teta(i-1,1))*cos(gamma)*sin(psi0) -sin(teta(i-1,1))*cos(gamma)*cos(psi0)-sin(gamma)*sin(psi0)        cos(teta(i-1,1))*cos(gamma);
      sin(gamma)*sin(teta(i-1,1))*sin(psi0)+cos(gamma)*cos(psi0)  sin(gamma)*sin(teta(i-1,1))*cos(psi0)-cos(gamma)*sin(psi0)      -sin(gamma)*cos(teta(i-1,1))];
  
  Omega_krisha = [           0                 Ve(i,1)*tan(phi(i,1))/(Re(i,1)+H(i,1))                 -Ve(i,1)/(Re(i,1)+H(i,1));
                 -Ve(i,1)*tan(phi(i,1))/(Re(i,1)+H(i,1))                 0                            -Vn(i,1)/(Rn(i,1)+H(i,1));
                       Ve(i,1)/(Re(i,1)+H(i,1))                   Vn(i,1)/(Rn(i,1)+H(i,1))                              0     ];
    
  U_krisha = [          0          u*sin(phi(i,1))       -u*cos(phi(i,1));
               -u*sin(phi(i,1))           0                       0      ;
                 u*cos(phi(i,1))          0                       0     ];
                 
                 

 Norm_g=(-Ge*cos(phi(i,1))*cos(phi(i,1))-Gp*sqrt(1-e2)*sin(phi(i,1))*sin(phi(i,1)))/sqrt(1-e2*sin(phi(i,1))*sin(phi(i,1)));
 
  gx = [   0;  0;   -Norm_g];
  
  fx = V_tochka - ( Omega_krisha + 2*U_krisha)*V_ + gx;

  fz = S*fx;

  
  yar=[T(i) fz(2) teta(i,1) psi0 gamma0 VRej_nabora(i-124,1)];
  
  modznach2=[fz(1) fz(2) fz(3)];
  modznach=[modznach;modznach2]; 
  
znacheniya2 = [T(i) fz(1) fz(2) fz(3)]; 
rez2=[rez2;znacheniya2];

flight2 = [T(i) lam(i,1)*180/pi phi(i,1)*180/pi H(i) kren(i) tangaj(i) kurs(i)];
rez1=[rez1;flight2];
   end
    
end
Vu;
  modznach;
% plot(rez2(:,1),rez2(:,3),'-.'); grid on;
rez2;
save rez2.txt rez2 -ascii
 flight=rez1;
 save flight.txt flight -ascii
tgeo2kml(flight)

modznach(i-1,:);
%------------------------- Ќачало лабораторной работы 3-------------------------
D=1
lam_mod =(2 + 34/60 + 0.15/3600)/180*pi;       % долгота
phi_mod =(49 + 1/60 + 24.59/3600)/180*pi;      % широта
psi_mod = 87/180*pi;                          % направление(курс)

H_mod=H0;

Vn_mod = 0;
Vu_mod = 0;
Ve_mod = 0;

V_vector_mod = [Ve_mod;
                Vn_mod;
                Vu_mod];
        
 Rn_mod = A*(1-e2)/((sqrt(1-e2*(sin(phi_mod ))^2))^3);
 Re_mod = A/sqrt(1-e2*(sin(phi_mod ))^2);
 
Spsi=[sin(psi_mod) cos(psi_mod) 0;
     -cos(psi_mod) sin(psi_mod) 0;
           0            0       1];
   
Steta=[  cos(teta0)  0 sin(teta0) ;
             0       1      0     ; 
         -sin(teta0) 0 cos(teta0)];
   
Sgamma= [1        0          0       ;
         0  -sin(gamma0)  cos(gamma0);
         0  -cos(gamma0) -sin(gamma0)];
        
S=(Sgamma*Steta*Spsi) ;

 
flight3=[]; 
   
U=(((360+360)/365.25)/24)*pi/(180*60*60);
   
for i = 2:size(T,1)
   if i<=T1/dT
 
 kren=0;
tangaj=0;
kurs=psi_mod;
Itetaciya=i;

  Omega_krisha_mod = [                   0                             V_vector_mod(1)*tan(phi_mod)/(Re_mod+H_mod)                 -V_vector_mod(1)/(Re_mod+H_mod);
                      -V_vector_mod(1)*tan(phi_mod)/(Re_mod+H_mod)                           0                                       -V_vector_mod(2)/(Rn_mod+H_mod);
                       V_vector_mod(1)/(Re_mod+H_mod)                        V_vector_mod(2)/(Rn_mod+H_mod)                                            0         ];
      
   U_krisha_mod = [         0           U*sin(phi_mod)        -U*cos(phi_mod);
                    -U*sin(phi_mod)           0                       0      ;
                     U*cos(phi_mod)           0                       0      ];     
 
 Norm_g=(-Ge*cos(phi_mod)*cos(phi_mod)-Gp*sqrt(1-e2)*sin(phi_mod)*sin(phi_mod))/sqrt(1-e2*sin(phi_mod)*sin(phi_mod));
 Gx_mod = [   0;  0;   Norm_g]; 
   
 
 job1 = (Omega_krisha_mod+2*U_krisha_mod)*V_vector_mod ;
 job2 = Gx_mod+S'*(modznach(i-1,:))';  
  
 V_vector_mod=(job1+job2)*dT+V_vector_mod;
V_vector_mod;

phi_mod= phi_mod + (V_vector_mod(2)/(Rn_mod+H_mod))*dT;
lam_mod = lam_mod + V_vector_mod(1)/((Re_mod+H_mod)*cos(phi_mod))*dT ;
H_mod=H_mod+V_vector_mod(3)*dT;

Rn_mod = A*(1-e2)/((sqrt(1-e2*(sin(phi_mod ))^2))^3);
Re_mod = A/sqrt(1-e2*(sin(phi_mod ))^2);

flight3 = [flight3;T(i) lam_mod*180/pi phi_mod*180/pi H_mod kren tangaj kurs];
   else
kren=0;
kurs=psi_mod;
Itetaciya=i;

teta(i,1) = (teta0-tetaotr)/2*cos(pi*T_rejim_nabora(i-124,1)/T2) + (teta0+tetaotr)/2

Spsi=[sin(psi_mod) cos(psi_mod) 0;
     -cos(psi_mod) sin(psi_mod) 0;
           0            0       1];

       
Steta=[  cos(teta(i-1,1))  0 sin(teta(i-1,1)) ;
             0       1      0     ; 
         -sin(teta(i-1,1)) 0 cos(teta(i-1,1))];
   
Sgamma= [1        0          0       ;
         0  -sin(gamma0)  cos(gamma0);
         0  -cos(gamma0) -sin(gamma0)];
        
S=(Sgamma*Steta*Spsi) ;




  Omega_krisha_mod = [                   0                             Ve(i-1,1)*tan(phi_mod)/(Re_mod+H_mod)              -Ve(i-1,1)/(Re_mod+H_mod);
                    -Ve(i-1,1)*tan(phi_mod)/(Re_mod+H_mod)                           0                                    -Vn(i-1,1)/(Rn_mod+H_mod);
                       Ve(i-1,1)/(Re_mod+H_mod)                        Vn(i-1,1)/(Rn_mod+H_mod)                                       0         ];
      
   U_krisha_mod = [         0           U*sin(phi_mod)        -U*cos(phi_mod);
                    -U*sin(phi_mod)           0                       0      ;
                     U*cos(phi_mod)           0                       0      ];     

 Norm_g=(-Ge*cos(phi_mod)*cos(phi_mod)-Gp*sqrt(1-e2)*sin(phi_mod)*sin(phi_mod))/sqrt(1-e2*sin(phi_mod)*sin(phi_mod));
 Gx_mod = [   0;  0;   -Norm_g]; 
   
 
 job1 = (Omega_krisha_mod+2*U_krisha_mod)*V_vector_mod ;
 job2 = Gx_mod+S'*(modznach(i-1,:))';  
  
 V_vector_mod=(job1+job2)*dT+V_vector_mod;
V_vector_mod;

phi_mod= phi_mod + (V_vector_mod(2)/(Rn_mod+H_mod))*dT;
lam_mod = lam_mod + V_vector_mod(1)/((Re_mod+H_mod)*cos(phi_mod))*dT ;
H_mod=H_mod+V_vector_mod(3)*dT;

Rn_mod = A*(1-e2)/((sqrt(1-e2*(sin(phi_mod ))^2))^3);
Re_mod = A/sqrt(1-e2*(sin(phi_mod ))^2);

tangaj=teta(i,1);
flight3 = [flight3;T(i) lam_mod*180/pi phi_mod*180/pi H_mod kren tangaj kurs];
   end
    
end
% plot(flight3(:,1),flight3(:,3),'-.'); grid on;
flight_=[];
flight_=flight3;

save flight_.txt flight_ -ascii
tgeo2kml(flight_)
hold on;
% plot(flight(:,1),flight(:,3),'-.'); grid on;
% plot(flight3(:,1),flight3(:,3),'-.'); grid on;




