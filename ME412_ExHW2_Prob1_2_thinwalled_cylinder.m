%% MLGN 517 - Advanced Mech - Extended Homework 2 - Problem 1 - Part 2
% Nicole Thomas
% April 17, 2018
%
%% Determine the stresses and displacement in a steel cylinder that is subject to internal pressure, and zero external pressure. 
clear all
clear
clc
close all

%%Part 2
%% Compare the solution from basic Mechanics of Materials for the hoop stress of a thin-walled cylinder. 
%% Plot the solution as a function of the wall thickness.



%% Set geometry of the cylinder and the internal pressure
a = 1.5; %(inches): inside diameter of the cylinder
b = linspace(1.51,2.5); %(inches): outside diameter of the cylinder
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

%% Calculate the constants from the geometry and material properties
B = zeros(1,100);
C = zeros(1,100);
r = zeros(1,100);
u_r = zeros(1,100);
t = zeros(1,100);
U_prime_r = zeros(1,100);
sigma_rr = zeros(1,100);
sigma_thetatheta = zeros(1,100);
sigma_theta_mom = zeros(1,100);

for i = 1:100
    B(i) = (1/(2*(mu + lambda)))*(((a^2)*p_i - (b(i)^2).*p_o)/(b(i)^2 - a^2)); 
    C(i) = (((a^2)*(b(i)^2))/(2*mu))*(p_i - p_o)/(b(i)^2 - a^2); 

    r(i) = b(i);
    u_r(i) = B(i)*r(i) + C(i)/r(i);
    t(i) = b(i) - a;
    
    %%Develop a plot of sigma_rr (radial stress) and sigma_thetatheta
    %%(tangential stress) as a function of r
    %B_1 = linspace(B,B);
    U_prime_r(i) = B(i) - C(i)/(r(i)^2); %derivative of u_r

    sigma_rr(i) = (2*mu + lambda)*U_prime_r(i) + (lambda/r(i))*u_r(i); %radial stress
    sigma_thetatheta(i) = (1/r(i))*(2*mu + lambda)*u_r(i) + lambda*U_prime_r(i); %tangential stress 
    
    sigma_theta_mom(i) = p_i*r(i)/(b(i)-a); %Mechanics of materials hoop stress
    ratio(i) = sigma_thetatheta(i)/sigma_theta_mom(i);
end

figure
plot(t,sigma_rr, t, sigma_thetatheta, t, sigma_theta_mom)
legend('sigma_rr','sigma_thetatheta','sigma_theta_mom')
title('Stress as a function of wall thickness')
xlabel('wall thickness (in)')
ylabel('Stress (psi)')

figure
plot(t,ratio)
title('Ratio of Calculated Hoop Stress to Basic Mech of Mat Hoop Stress')
xlabel('wall thickness (in)')
ylabel('ratio')