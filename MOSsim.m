%% ECE 417 Simulation Project 2
% Name: Benjamin Warren
% Class: ECE 417
% Winter 2023

clear, clc, close all

%% Calculate Constants and Material Parameters% pre-defined constants

kb = 8.62e-5;      % Boltzmann's constant (eV/K)
q  = 1.602e-19;    % Electron charge (C)
T  = 300;          % Room Temperature (K)
e_0 = 8.854e-14;   % Permittivity of vacuum (F/cm)
e_si = 11.8*e_0;   % Permittivity of Si (F/cm)
e_ox = 3.9*e_0;   % Permitivity of oxide layer (F/cm)
n_i = 1.0e10;      % Intrinsic carrier concentration of Si (cm^-3)
tau0 = 5e-7;    % s
N0 = 5e16;      % cm^-3
Len = 0.4e-6;   % Channel Length
Wid = 1e-6;     % Channel Width
Gox = 1.1e-6;      % (cm) gate oxide
x_j = .150e-6;  % S/D junction (meters)
N_g = 2e20;     % cm^-3 N Gate concentration
P_s = 2e17;     % cm^-3 P Substrate concentration
N_sd = 6e20;    % cm^-3 N S/D concentration
Qf = 1e-12;      % cm^-2 Fixed Charge
u_ci = 60;      % cm^2/V-s Channel inversion mobility
Eg = 1.12;      % eV Bandgap of silicon

% Calculate surface and bulk potential
Phi_b = (.0259)*log(P_s/n_i);
Phi_s = 2*Phi_b;

% Calculate Vox
Cox = e_ox/Gox; % Oxide thickness in meters
gamma = sqrt(2*q*e_si*P_s)/Cox; % Body-effect coefficient
Vox = gamma * sqrt(2*Phi_b); % Oxide potential

% Calculate Vfb
Psi_ms = -Eg/2 - Phi_b;
Vfb = Psi_ms - (Qf / Cox);

% Estimate Zero bias threshold voltage
Vt0 = Vfb + 2*Phi_b + gamma*sqrt(2*Phi_b);

% Create plot of Id-Vds output curves
Vds = (0:0.01:2);
Vgs = [0 1.4 1.8 2.2 2.6];

K = gamma/sqrt(2); % Body-effect constant
M = 1 + K/(sqrt(2*Phi_s)); % Body-effect constant 

figure(1)
for i = 1:length(Vgs)
    hold on
    Vdsat = (Vgs(i)-Vt0)/M;
    for j = 1:length(Vds)
        if Vgs(i)<Vt0
            Id(i,j) = 0;
        elseif Vgs(i)>=Vt0 && Vds(j)<Vdsat
            Id(i,j) = (Wid/Len)*u_ci*Cox*((Vgs(i)-Vt0)*Vds(j)-M*(Vds(j))^2/2);
        else
            Id(i,j) = (Wid/(2*M*Len))*u_ci*Cox*(Vgs(i)-Vt0)^2;
        end
    end
    plot(Vds,Id(i,:),"LineWidth",2)
end
hold off
title('NMOS Output Curves')
legend('V_{GS} = 0V','V_{GS} = 1.4V','V_{GS} = 1.8V','V_{GS} = 2.2V','V_{GS} = 2.6V')
xlabel('V_{DS} [V]')
ylabel('I_{D} [A]')
axis([0 2 -.5e-5 10e-5])

figure(2)
Vgs = (0:0.01:3);
Vds = [0.25 0.5 1];
for i = 1:length(Vds)
    hold on
    for j = 1:length(Vgs)
        Vdsat = (Vgs(j)-Vt0)/M;
        if Vgs(j)<Vt0
            Ids(i,j) = 0;
        elseif Vgs(j)>=Vt0 && Vds(i)<Vdsat
            Ids(i,j) = (Wid/Len)*u_ci*Cox*((Vgs(j)-Vt0)*Vds(i)-M*(Vds(i))^2/2);
        elseif Vgs(j)>=Vt0 && Vds(i)>=Vdsat
            Ids(i,j) = (Wid/(2*M*Len))*u_ci*Cox*(Vgs(j)-Vt0)^2;
        end
    end
    plot(Vgs,Ids(i,:),"LineWidth",2)
end
hold off
title('NMOS Transfer Curves')
legend('V_{DS} = 0.25V','V_{DS} = 0.5V','V_{DS} = 1.0V')
xlabel('V_{GS} [V]')
ylabel('I_{D} [A]')


figure(3)
Vgs = (0:0.01:3);
Vds = [0.25 0.5 1];
for i = 1:length(Vds)
    hold on
    for j = 1:length(Vgs)
        Vdsat = (Vgs(j)-Vt0)/M;
        if Vgs(j)<Vt0
            Ids(i,j) = 0;
        elseif Vgs(j)>=Vt0 && Vds(i)<Vdsat
            Ids(i,j) = (Wid/Len)*u_ci*Cox*((Vgs(j)-Vt0)*Vds(i)-M*(Vds(i))^2/2);
        elseif Vgs(j)>=Vt0 && Vds(i)>=Vdsat
            Ids(i,j) = (Wid/(2*M*Len))*u_ci*Cox*(Vgs(j)-Vt0)^2;
        end
    end
    semilogy(Vgs,Ids(i,:),"LineWidth",2)
end
hold off
set(gca, 'YScale', 'log')
title('NMOS Transfer Curves')
legend('V_{DS} = 0.25V','V_{DS} = 0.5V','V_{DS} = 1.0V')
xlabel('V_{GS} [V]')
ylabel('I_{D} [A]')

T=table(transpose(Phi_b),transpose(Cox),transpose(gamma),transpose(Vox),transpose(Psi_ms),transpose(Vfb),transpose(Vt0),transpose(K),transpose(M),'VariableNames',{'Phi_B','Cox','gamma','Vox','Psi_ms','Vfb','Vt0','K','M'});
display(T)