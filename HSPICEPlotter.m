% Extract spice results from .sw0 (or .tr0) file into a structure "x"
x = loadsig('hspice_StarterCode_2022.sw0');

% Extract diode current 'i_d1' from structure 'x'
i = evalsig(x,'i_d1');
% Use lssig(x) to list possible signals

% Extract applied voltage at node n1 into variable "v"
v = evalsig(x,'v_n1');

plot(v,i);
figure;
semilogy(v,abs(i));
xlabel('Applied Voltage (V_A) [V]');
ylabel('Current [A]');
grid on