
% Starter Code for Simulation Assignment #2
% Created by Michael Hayes 

% Note:  Some values below will need to be filled in.
% Assuming GaAs Diode

clear all;
close all;
%Constants
Ks = 12.9;                                          % Dialectric constant GaAs
Na = [1E19, 5E17, 1E16, 5E15];                 %p-side doping (in cm^-3)
Nd = [1E15, 1E16, 5E17, 1E18]; 				   %n-side doping (in cm^-3)
A = 2 * 1.5e-6;                                 %Area (in cm2)   
T = 300;                                       %Temperature (K)
Tau = 15*10^-6;                                %Minority carrier lifetime (sec)
M = 0.5;                   
ni = 2e6;                                    %Intrinsic carrier conc (cm^-3)
e0 = 8.85*10^-14;                              %Permittivity of free space (F/cm)
q = 1.6*10^-19;                                % C
V_bias = -5;                                   %Bias voltage
k = 1.38*10^(-23);                                    % Boltzmann constant
a = 10^26;

for i = 1 : 4
     %Silicon Parameters
    un = (88+1252./(1+6.95e-18*Nd(i))); % Electron mobility
    up = (54.3+407./(1+6.95e-18*Na(i))); % Hole mobility
    
    Dp = (.0259)*up;
    Lp = sqrt(Dp*Tau);
    Dn = (.0259)*un;
    Ln = sqrt(Dn*Tau);
        
    Io(i) = q*A*((Dn/(Ln*Na(i))) + (Dp/(Lp*Nd(i))))*ni^2;
    
    Vbi(i) = (.0259)*log(Na(i)*Nd(i)/(ni)^2);
    
    xn(i) = sqrt((2*Ks*e0*Na(i)*Vbi(i))*(1./(q*Na(i)*(Na(i)+Nd(i)))));
    
    xp(i) = Nd(i)*xn(i)/Na(i);
    
    Wo(i) = xn(i) + xp(i);
    Cjo(i) = (Ks*e0*A)/Wo(i);
    
    Cj(i) = Cjo(i)/sqrt(1-V_bias./Vbi(i));
    qNa(i) = q * Na(i);
    qNd(i) = q * Nd(i);
    Emax(i) = 2 * Vbi(i) * Wo(i);
end

Va = -1.5:.0005:1.5;

for i = 1 : 4
    I(i,:) = abs(Io(i)*(exp(Va./(.0259))-1));
end


T=table(transpose(Wo),transpose(xn),transpose(xp),transpose(qNa),transpose(qNd),transpose(Vbi),transpose(Emax),'VariableNames',{'Wo[cm]','xn[cm]','xp[cm]','qNa[1/cm3]','qNd[1/cm3]','Vbi[V]','Emax[V/cm]'})