%% MEGN 515 HW 1 Problem 1
%Nicole Thomas

L = 10;
x = linspace(-L,0);
EA = 40*10^6;
 
u_x = (1/(EA))*(2*x.^3 +300.*x + 5000);
P_x = -12*x - 300;

plot(x,u_x)
title('Axial Deflection')
xlabel('x')
ylabel('u_n(x)')

figure
plot(x,P_x)
title('Internal Axial Force')
xlabel('x')
ylabel('P_n(x)')
