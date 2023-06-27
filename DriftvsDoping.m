x = logspace(14,20);

eDrift= 88 + 1252./(1 + (6.95*10^-18*x))
hDrift= 54.3 + 407./(1 + (3.75*10^-18*x))

figure
loglog(x,eDrift,x,hDrift,"linewidth",3)
axis([10^14 10^20 10^1 3*10^3])
xlabel('N_A or N_D (cm^{-3})')%x-axis label
ylabel('\mu_n or \mu_p (^{cm^{2}}/_{V-sec})')%y-axis label
title('Electron/Hole Drift Mobility vs Doping Concentration')
set(gca, "linewidth", 1, "fontsize", 12);
legend('Electrons','Holes');
grid on