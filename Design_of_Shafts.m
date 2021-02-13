% Given Quantities here are:
% D=3*x d=2*x r=0.5*x where x is a constant
% D/d=1.5 r/d=0.25
% Which gives Kt=1.4 Kts=1.21 q=0.58 qs=0.62  
Kt = 1.4; 
Kts = 1.21; 
q = 0.58; 
qs = 0.62;
Kf = 1+q*(Kt-1);
Kfs = 1+qs*(Kts-1);
Sut = input('Enter the Value of ultimate tensile strength'); %getting the value of Ultimate tensile strength
Sy = input('Enter the Value of Yield strength'); %getting the value of Yield strength
Ta = 0;
Mm = 0;
Ma = input('Enter the value of reverse bending load');
Tm = input('Enter the value of steady torque');
n = input('Enter the value of Factor of Safety');

Setest = 0.5*Sut;  %Se'=0.5*Sut as Sut<=200 kpsi
q = input('Enter the condition of Surface finish: 1-Ground  2-Machined or cold-rolled  3-Hot-rolled  4-As forged'); %getting the Surface condition
if q==1
    a = 1.58;
    b = -0.085;
elseif q==2
    a = 4.51;
    b = -0.265;
elseif q==3
    a = 57.7;
    b = -0.718;
else
    a = 272;
    b = -0.995;
end
Ka = a*power(Sut,b);  %getting the value of Surface_modification factor
%Let us assume the d = 51 mm
d_final = 0;
d = 51;
w = input('Enter the type of loading: 1-Bending and torsion  2-Axial Loading'); %getting the type of Loadingif w==1
    if d>=2.79&&d<=51
        Kb = 1.24*power(d,-0.107); %getting the value of Size Modification factor
    elseif d>51&&d<=254
        Kb = 1.51*power(d,-0.157); %getting the value of Size Modification factor
    else
        Kb = 1; %getting the value of size modification factor
    end
    we =input('Enter the type of Loading- 1:Bending 2:Axial 3:Torsion'); %Entering the type of Loading
    if we==1
        Kc = 1;  %getting the value of Load Modification factor
    elseif we==2
        Kc = 0.85;  %getting the Value of Load Modification factor
    else
        Kc = 0.59;  %getting the value of Load modification factor
    end
    Kd = 1; %The value of Temperature Modification factor
    Ke = 1; %The value of Reliability factor
    K_f = 1; %The value of miscellaneous modification factor
    Sereal = Ka*Kb*Kc*Kd*Ke*Setest; %real value of Endurance limit obtained using Marin Equation
    Se = Sereal;
    m = input('Enter the criterion to use 1.DE-Gerber 2.DE-ASME Elliptic 3.DE-Soderberg');
    if m == 1
        Al = (4*(Kf*Ma)+3*(Kfs*Ta))^0.5;
        Bl = (4*(Kf*Mm)+3*(Kfs*Tm))^0.5;
        d_final = ((8*n*Al)/(3.14*Se))*(1+(1+((2*Bl*Se)/(Al*Se))^2)^0.5)^(1/3);
    elseif m == 2
        d_final = (((16*n)/3.14)*(4*(Kf*Ma/Se)^2+3*(Kfs*Ta/Se)^2+4*(Kf*Mm/Se)^2+3*(Kfs*Tm/Se)^2)^0.5)^(1/3);
    elseif m == 3
        d_final = (((16*n)/3.14)*((4*(Kf*Ma/Se)^2+3*(Kfs*Ta/Se)^2)^0.5+(4*(Kf*Mm/Se)^2+3*(Kfs*Tm/Se)^2)^0.5))^(1/3);
    end
while d~=d_final
    d=d_final;
    if d>=2.79&&d<=51
        Kb = 1.24*power(d,-0.107); %getting the value of Size Modification factor
    elseif d>51&&d<=254
        Kb = 1.51*power(d,-0.157); %getting the value of Size Modification factor
    else
        Kb = 1; %getting the value of size modification factor
    end
    if we==1
        Kc = 1;  %getting the value of Load Modification factor
    elseif we==2
        Kc = 0.85;  %getting the Value of Load Modification factor
    else
        Kc = 0.59;  %getting the value of Load modification factor
    end
    Kd = 1; %The value of Temperature Modification factor
    Ke = 1; %The value of Reliability factor
    K_f = 1; %The value of miscellaneous modification factor
    Sereal = Ka*Kb*Kc*Kd*Ke*Setest; %real value of Endurance limit obtained using Marin Equation
    Se = Sereal;
    if m == 1
        Al = (4*(Kf*Ma)+3*(Kfs*Ta))^0.5;
        Bl = (4*(Kf*Mm)+3*(Kfs*Tm))^0.5;
        d_final = ((8*n*Al)/(3.14*Se))*(1+(1+((2*Bl*Se)/(Al*Se))^2)^0.5)^(1/3);
    elseif m == 2
        d_final = (((16*n)/3.14)*(4*(Kf*Ma/Se)^2+3*(Kfs*Ta/Se)^2+4*(Kf*Mm/Se)^2+3*(Kfs*Tm/Se)^2)^0.5)^(1/3);
    elseif m == 3
        d_final = (((16*n)/3.14)*((4*(Kf*Ma/Se)^2+3*(Kfs*Ta/Se)^2)^0.5+(4*(Kf*Mm/Se)^2+3*(Kfs*Tm/Se)^2)^0.5))^(1/3);
    end
end
D = d*1.5;
r = d*0.25;

fprintf('The value of d = %f',d);
fprintf('The value of D = %f',D);
fprintf('The value of r = %f',r);