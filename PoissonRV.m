t = 10 %time interval
lambda = 5/t; %rate
dt = 0.01; %subinterval of length dt
N = round(t/dt);
p = lambda*dt;
num_trial = 10000;%number of samples
poisson = zeros(1, num_trial);
for i = 1:num_trial
    poisson(i) = sum((rand(1,N))<p);
end

figure
histogram(poisson,0:20,'Normalization','Probability')
xlabel('No. 1s')%x-axis label
ylabel('PMF')%y-axis label
title('Poisson Distribution')
set(gca, "linewidth", 1, "fontsize", 9);
grid on