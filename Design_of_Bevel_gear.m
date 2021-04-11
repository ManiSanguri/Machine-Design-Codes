%% Design of Bevel Gear
%% Name- Mani Sanguri
%% References- PSG Design Data Book and Machine Design Shigley
%% Steps 1 to 14 are carried out to Design a Helical Gear

%% Step 1- Input Parameters
Ptrans= input('Enter the value of Power transmitted in KW');  %This is the value of Power transmitted through the Spur gear and Pinion
nP= input('Enter the Speed of Pinion or the Machine driving the Pinion'); %This is the RPM input
mg= input('Enter the gear ratio i.e. x in x:1'); % Reduction ratio
Temp= input('Enter the temperature of the environoment in Celsius'); % This is the temperature of the surrounding environment
nd= input('Enter the value of the design factor'); % Design Factor
Npmin= input('Enter the minimum number of teeth in the pinion'); % This is the value of the minimum number of teeth in the pinion
Ngmin= input('Enter the minimum number of teeth in the gear'); % This is the value of the minimum number of teeth in the gear
Np= input('Enter the number of teeth in the pinion'); % This is the value of the number of teeth in the pinion
sp= input('Select the tooth Profile from the Following Options: \nPress 1 for 20 degrees Full depth Involute \nPress 2 for 14.5 degrees full depth Involute, there are more Options available though'); %This is the value of Prssure Angle
R= input('Enter the value of reliability goal'); % This is the value of reliability goal to be achieved
Lp= input('Enter the value of pinion life');
pi= 3.1416;

%% Step 2-Selection of Gear tooth Profile

if sp==1
    phi= 20;
else
    phi= 14.5;
end

%% Step 3-Calculation of constants involved in Designing the Gear Profile

Kmb= 1.25; 
Clg= 3.4822*(Lp/mg)^(-0.0602);
Clp= 3.4822*(Lp)^(-0.0602);
Klg= 1.683*(Lp/mg)^(-0.0323);
Klp= 1.683*(Lp)^(-0.0323);
Kr= 0.50-0.25*(log10(1-R));
Cr= (Kr)^0.50;
Kt= (273 + Temp)/393; 
Ct= Kt;
Sf= nd;
Sh= (nd)^0.5;

% As we have been given a crowned and straight-bevel gears that has normal pressure angle 20 degrees

Kx= 1;
Cxc= 1.5;
Ng= Np*mg;
y= atand(Np/Ng);
f= atand(Ng/Np);

% From Figure 15–6 and 15–7, we get

I= 0.0825;
Jp= 0.248;
Jg= 0.202;

%% Step 4-Decision 1: Taking the guess value of diametral pitch, Pd

Pd= input('Enter the guess value of diametral pitch');
Ks= 0.4867+0.2132/Pd;
dP= Np/Pd;
dG= dP*mg;
vt= pi*dP*(nP*60)/12;
Wt= 33000*(Ptrans*1.37)/vt;
A0= dP/(2*sind(y));
F= min(0.3*A0,10/Pd)

%% Step 5-Decision 2: Taking the guess value of F

F= input('Enter the guess value of F');
Cs= 0.125*(F)+0.4375;
Km= F+0.0036*(F^2);

%% Step 6-Decision 3: Taking the guess value of transmission accuracy number, Tan

Tan= input('Enter the guess value of transmission accuracy number');
B= 0.25*((12-Tan)^(2/3));
A= 50+56*(1-B);
Kv= ((A+(vt)^0.5)/A)^B;

%% Step 7-Decision 4: For Pinion and gear material and treatment we carburize and case-harden grade ASTM 1320 to Core 21 HRC (HB is 229 Brinell) and Case 55-64 HRC (HB is 515 Brinell)

% From the table 15-4, sac= 200000 psi and from Table 15–6, sat= 30000 psi
sac= 200000;
sat= 30000;

%% Step 8-Calculating the safety factor involved in Gear Bending

% From the Equation (15–3), the bending stress will be given as
Ko= 1;
stg= (Wt/F)*Pd*Ko*Kv*((Ks*Km)/(Kx*Jg));
% From the Equation (15–4, the bending strength will be given as
swtg= (sat*Klg)/(Sf*Kt*Kr);
Sfg= 2*(swtg/stg) 

%% Step 9-Calculating the safety factor involved in Pinion Bending

% The bending stress can be calculated as 
stp= stg*(Jg/Jp);
% From the Equation (15–4, the bending strength can be calculated as
swtp= (sat*Klp)/(Sf*Kt*Kr);
Sfp= 2*(swtp/stp)

%% Step 10-Calculating the factor of safety involved in Gear Wear

Ch= 1;
Cp= 2290;
scg= Cp*((Wt/(F*dP*I))*Ko*Kv*Km*Cs*Cxc)^(1/2);
swcg= ((sac*Clg*Ch)/(Sh*Kt*Cr));
Shg2= 2*(swcg/scg)^2

%% Step 11-Calculating the factor of safety involved in Pinion Wear

swcp= ((sac*Clp*Ch)/(Sh*Kt*Cr));
Shp2= 2*(swcp/scg)^2

% The actual factors of safety are seen. 

%% Step 12- Comparing the four factor of safety 

% We need to make a direct comparison of the factors and from these in this case we see that the threat from gear bending and pinion wear is equal. 
% We see that the three of these are comparable with each other. 

%% Step 13- Adjusting the design variables by recalculating such that the factors are close to 2

% Here the goal should be to change in the design decisions that drive the factors closer to 2. 
% The next step here should be adjusting the design variables.  

%% Step 14- End