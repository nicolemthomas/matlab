%% MLGN 517 - Advanced Mech - Extended Homework 2 - Problem 1
% Nicole Thomas
% April 17, 2018
%
%% Determine the stresses and displacement in a steel cylinder that is subject to internal pressure, and zero external pressure. 
clear all
clear
clc
close all

%% Set geometry of the cylinder and the internal pressure
a = 1.5; %(inches): inside diameter of the cylinder
b = 2.5; %(inches): outside diameter of the cylinder
p_i = 3000; %(psi): internal pressure
p_o = 0; %(psi): external pressure (not used here, but may be useful later)
%In this problem, we are assuming that the ends of the cylinder are fixed.

%% Set Material Properties:
E = 30*10^6; %(psi): Modulus of elasticity
v = 0.3; %(dimensionless): Poisson's ratio

%% Develop a plot of u_r (radial displacement) as a fxn of r
%First, calculate the lame constants from the material properties:
mu = E/(2*(1+v)); 
lambda = E*v/((1+v)*(1-2*v));

%Then, we calculate the constants from the geometry and material properties
B = (1/(2*(mu + lambda)))*(((a^2)*p_i - (b^2)*p_o)/(b^2 - a^2)); 
C = (((a^2)*(b^2))/(2*mu))*(p_i - p_o)/(b^2 - a^2); 

r = linspace(a,b);
u_r = B.*r + C./r;

figure
plot(r,u_r)
legend('u_r')
title('Radial displacement as a function of cylinder wall radius')
xlabel('r')
ylabel('u_r (inches of displacement)')




%% Develop a plot of sigma_rr (radial stress) and sigma_thetatheta(tangential stress) as a function of r
B_1 = linspace(B,B);
U_prime_r = B_1 - C./(r.^2); %derivative of u_r

sigma_rr = (2*mu + lambda).*U_prime_r + (lambda./r).*u_r; %radial stress
sigma_thetatheta = (1./r).*(2*mu + lambda).*u_r + lambda.*U_prime_r; %tangential stress

figure
plot(r,sigma_rr, r, sigma_thetatheta)
legend('sigma_rr','sigma_thetatheta')
title('Stress as a function of radius')
xlabel('r')
ylabel('Stress(psi)')
