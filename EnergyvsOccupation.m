x = [-0.3:0.00001:0.3];

Temp1 = 1./(1 + exp(x./(8.617*10^-5*0.000000000000000001)))
Temp2 = 1./(1 + exp(x./(8.617*10^-5*150)))
Temp3 = 1./(1 + exp(x./(8.617*10^-5*250)))
Temp4 = 1./(1 + exp(x./(8.617*10^-5*350)))
Temp5 = 1./(1 + exp(x./(8.617*10^-5*450)))

figure
plot(x,Temp1,x,Temp2,x,Temp3,x,Temp4,x,Temp5,"linewidth",3)
axis([-0.3 0.3 0 1])
xlabel('E-Ef (eV)')%x-axis label
ylabel('f(E)')%y-axis label
title('Energy vs Occupation with Temperature')
set(gca, "linewidth", 1, "fontsize", 12);
legend('T=0K','T=150K','T=250K','T=350K','T=450K')
grid on