
% Starter Code for Simulation Assignment #2
% Created by Michael Hayes 

% Note:  Some values below will need to be filled in.
% Assuming GaAs Diode

clear all;
close all;
%Constants
Ks = 12.9;                                     % Dialectric constant GaAs
Na = [1E19, 5E17, 1E16, 5E15];                 %p-side doping (in cm^-3)
Nd = [1E15, 1E16, 5E17, 1E18]; 				   %n-side doping (in cm^-3)
A = 2 * 1.5e-6;                                %Area (in cm2)   
T = 300;                                       %Temperature (K)
Tau = 15*10^-6;                                %Minority carrier lifetime (sec)
M = 0.5;                   
ni = 2e6;                                      %Intrinsic carrier conc (cm^-3)
e0 = 8.85*10^-14;                              %Permittivity of free space (F/cm)
q = 1.6*10^-19;                                % C
V_bias = -5;                                   %Bias voltage
k = 1.38*10^(-23);                             % Boltzmann constant
a = 10^26;

for i = 3 : 3
    %Silicon Parameters
    un = (88+1252./(1+6.95e-18*Nd(i))); % Electron mobility
    up = (54.3+407./(1+6.95e-18*Na(i))); % Hole mobility
    
    Dp = (.0259)*up;
    Lp = sqrt(Dp*Tau);
    Dn = (.0259)*un;
    Ln = sqrt(Dn*Tau);
    
    Io(i) = q*A*((Dn/(Ln*Na(i))) + (Dp/(Lp*Nd(i))))*ni^2;
end

Va = -1.5:.0005:1.5;

for i = 3 : 3
    I(i,:) = abs(Io(i)*(exp(Va./(.0259))-1));
end

Tau = 100*10^-6;                                %Minority carrier lifetime (sec)

for i = 3 : 3
    %Silicon Parameters
    un = (88+1252./(1+6.95e-18*Nd(i))); % Electron mobility
    up = (54.3+407./(1+6.95e-18*Na(i))); % Hole mobility
    
    Dp = (.0259)*up;
    Lp = sqrt(Dp*Tau);
    Dn = (.0259)*un;
    Ln = sqrt(Dn*Tau);
    
    Io1(i) = q*A*((Dn/(Ln*Na(i))) + (Dp/(Lp*Nd(i))))*ni^2;
end

for i = 3 :3
    I1(i,:) = abs(Io1(i)*(exp(Va./(.0259))-1));
end

figure(1);
semilogy(Va,I(3,:),Va,I1(3,:), "linewidth",2);
xlabel('Vbias(volts)')%x-axis label
ylabel('I(amps)')%y-axis label
legend('15 us Minority Carrier Lifetime','100 us Minority Carrier Lifetime');
title('I-V for GaAs Diode at T=300k')
set(gca, "linewidth", 1, "fontsize", 12);