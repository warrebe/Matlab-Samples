% Constants
q = 1.6*10^-19; % Electron charge

L = 1; % Length of silicon structure in cm
H = 0.75; % Hieght of silicon structure in cm
W = 1; % Width of silicon structure in cm
SA = H*W; % Surface Area of silicon structure in cm

ni = 10^10; % Intirinsic carrier concentration of silicon @T=300k
Na = [0,10^14,10^16,10^19]; % Acceptor doping concentrations
Nd = [0,10^14,10^16,10^19]; % Donor doping concentrations

%Silicon Parameters
un = 88+1252./(1+6.95e-18*Nd); % Electron mobility
up = 54.3+407./(1+6.95e-18*Na); % Hole mobility

V = 0:0.0001:1;

for i = 1 : 4
    if(Na(i) == 0) % Equillibrium
        n = ni;
        p = ni;
    else
        p = Na(i);
        n = (ni^2)/p
    end
    
    sigma = q*(un(i)*n+up(i)*p); % Conductivity
    rho(i) = 1./sigma % Resistivity
    R = L / (sigma * SA) % Resistance
    I(i,:) = V./R % Current
end

for j = 1 : 4
    if(Nd(j) == 0) % Equillibrium
        n = ni;
        p = ni;
    else
        n = Nd(j);
        p = (ni^2)/n
    end
    
    sigma = q*(un(j)*n+up(j)*p); % Conductivity
    rho(i+j) = 1./sigma % Resistivity
    R = L / (sigma * SA) % Resistance
    I(i+j,:) = V./R % Current
end
 
fprintf('%.16e\n', I(1));
disp(['value of resistivity = ',num2str(rho)]);

figure(1);
loglog(V,I(1,:),V,I(2,:),V,I(3,:),V,I(4,:),V,I(5,:),V,I(6,:),V,I(7,:),V,I(8,:), "linewidth",3);
axis([10^-4 10^0 10^-10 10^3])
axis ij
xlabel('V(volts)')%x-axis label
ylabel('I(amps)')%y-axis label
title('I-V for silicon at T=300k w/doping')
set(gca, "linewidth", 1, "fontsize", 12);
legend('NA=0 (Intrinsic)','NA=10^{14} (P-Type)','NA=10^{16} (P-Type)','NA=10^{19} (P-Type)','ND=0 (Intrinsic)','ND=10^{14} (N-Type)','ND=10^{16} (N-Type)','ND=10^{19} (N-Type)');
grid on