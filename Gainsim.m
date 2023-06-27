clear, clc, close all

p1 = 1e4;
beta = 1;

a0 = 1E2;
s = tf('s');

i = 0;

for p2 = 1E5.*[2.34 2.93 3.57 4.27 5 5.78 6.58 7.41 8.27]
    Av = a0/((1+s/p1)*(1+s/p2));
    H = Av/(1+Av*beta);
    hold on
    step(H)
    S = stepinfo(H);
    i = i+1;
    overshoots(1,i) = S.Overshoot;
    overshoots(2,i) = p2;
    p(i) = p2/a0;
end

for p2 = 1E5.*[2.34 2.93 3.57 4.27 5 5.78 6.58 7.41 8.27]
    Av = a0/((1+s/p1)*(1+s/p2));
    H = Av/(1+Av*beta);
    i = i + 1;
    peaks(1,i) = getPeakGain(H);
    peaks(2,i) = p2;
end
hold off

DB = [6.57
5.66
4.88
4.19
3.59
3.06
2.6
2.19
1.83];

PM = [40 45 50 55 60 65 70 75 80];
T=table(transpose(PM), transpose(p),transpose(overshoots(1,:)),'VariableNames',{'PM (deg)','p2/(p1*a0)','% Overshoot'});
display(T)
figure(2)
plot(PM,DB,'b-',"LineWidth",2)
hold on
plot(PM,overshoots(1,:),'r-',"LineWidth",2)
xlabel('Phase Margin[degrees]');
legend('Magnitude Peaking (dB)', 'Overshoot %')
grid on
hold off