%% Decision of the Parameters

% Music Wire, A228
% A = 201000 psi-in^m; m = 0.145 ; E = 28.5 Mpsi, G = 11.75 Mpsi (expecting d > 0.064 in)
% Ends squared and ground
% Safety: use design factor at solid height of (ns)d = 1.2
% Robust linearity = 0.15
% Using as-wound spring, Ssy = 0.45*Sut
% Decision variable: d = 0.080 in

Fmax = input('Enter the amount of load to be supported');
Fmax = Fmax*0.224809;
ymax = input('Enter the length to be compressed'); ymax = ymax*0.0393701;
ys = input('Enter the maximum value of solid length'); ys = ys*0.0393701;
yf = input('Enter the maximum value of free length'); yf = yf*0.0393701;
d = 0.080;
ns = 1.2;
rl = 0.15;
A = 201000;
m = 0.145;
E = 28.5;
G = 11.75;

%% Calculations Involved Ssy = (0.45*A)/d^m;

a = Ssy/ns;
b = (8*(1+rl)*Fmax)/(3.14*d^2);
C = (((2*a)-b)/(4*b))+((((2*a)-b)/(4*b))^2-((3*a)/(4*b)))^0.5; D = C*d;
Kb = (4*C+2)/(4*C-3);
ts = Kb*((8*(1+rl)*Fmax*D)/(3.14*(d)^3)); ns = Ssy/ts;
OD = D+d; ID = D-d;
Na = (G*10^6*(d^4)*ymax)/(8*Fmax*(D^3)); Nt = Na+2;
Ls = Nt*d;
Lo = Ls+(1+rl)*ymax; Lcr = 2.63*D/a;
fom = -2.6*(3.14^2)*(d^2)*Nt*D*0.25;

%% Criterions on which values will be segregated

% The constraint of spring index 4 <= C <= 12 rules out diameters larger than 0.088 in.
% The constraint 3 <= Na <= 15 rules out wire diameters less than and equal to 0.072 in.
% The Ls <= 1 constraint rules out diameters less than and equal to 0.076 in.
% The Lo <= 4 constraint rules out diameters less than 0.071 in.
% The buckling criterion rules out free lengths longer than Lcr, which rules out diameters less than equal to 0.072 in.
% The figure of merit decides and the decision is the design with 0.080 in wire diameter

%% Printing the final values

fprintf('\nWire Diameter= %f',d*25.4); fprintf('\nOuter Diameter= %f',OD*25.4); fprintf('\nInner Diameter= %f',ID*25.4); fprintf('\nFigure of merit= %f',fom); fprintf('\nTotal number of turns= %d',Nt);