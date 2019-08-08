%% MLGN 517 - Advanced Mech - Extended Homework 2 - Problem 2
% Nicole Thomas
% April 17, 2018
%
%% Given a stress tensor, calculate the following:
%% (a) mean stress (dilational) tensor and the deviatoric (distortional) stress tensors.
%% (b) Compute the Volume change associated w/ each of these stress tensors. 
clear all
clear
clc
close all

%% Set stress tensor and material properties
stress_tensor = [80,100,-100;...
                100, 50, -90;...
                -100,-90,-100]*10^6; %(Pa): given stress tensor
E = 200*10^9; %(Pa): Modulus of elasticity
v = 0.3; %(dimensionless): Poisson's ratio
V_o = 1*(0.01^3); %(m^3): Initial volume

%% (a)
dilational_tensor = (1/3)*trace(stress_tensor)*eye(3)
deviatoric_tensor = stress_tensor - dilational_tensor

%% (b) 
%First, calculate the lame constants from the material properties:
mu = E/(2*(1+v)); 
lambda = E*v/((1+v)*(1-2*v));

%Set the compliance matrix for an isotropic material: 
stress_voight = [stress_tensor(1,1); stress_tensor(2,2); stress_tensor(3,3);...
                stress_tensor(2,3); stress_tensor(1,3); stress_tensor(1,2)];
compliance_tensor = [1/E, -v/E, -v/E, 0, 0, 0;
                    -v/E, 1/E, -v/E, 0, 0, 0;
                    -v/E, -v/E, 1/E, 0, 0, 0;
                    0, 0, 0, 2*(1+v)/E, 0, 0;
                    0, 0, 0, 0, 2*(1+v)/E, 0;
                    0, 0, 0, 0, 0, 2*(1+v)/E];
                
strain_voight = compliance_tensor*stress_voight;
strain_tensor = [strain_voight(1), strain_voight(6), strain_voight(5);
                 strain_voight(6), strain_voight(2), strain_voight(4);
                 strain_voight(5), strain_voight(4), strain_voight(3)];
             
dilation_e = trace(strain_tensor);
Volume_Change = dilation_e*V_o

%% Just for kicks, here's the code for the stiffness matrix should I need it one day...
%% Given strains, compute the stress matrix
%Given strains - just replace the strain tensor input
strain_tensor_in = strain_tensor;
strain_tensor_in_voight = [strain_tensor_in(1,1); 
                           strain_tensor_in(2,2); 
                           strain_tensor_in(3,3);
                           strain_tensor_in(2,3); 
                           strain_tensor_in(1,3);
                           strain_tensor_in(1,2)];

stiffness_tensor = [2*mu+lambda, lambda, lambda, 0, 0, 0;
                    lambda, 2*mu+lambda, lambda, 0, 0, 0;
                    lambda, lambda, 2*mu+lambda, 0, 0, 0;
                    0, 0, 0, mu, 0, 0;
                    0, 0, 0, 0, mu, 0;
                    0, 0, 0, 0, 0, mu];
                
stress_out_voight = stiffness_tensor*strain_tensor_in_voight;
stress_tensor_out = [stress_out_voight(1), stress_out_voight(6), stress_out_voight(5);
                 stress_out_voight(6), stress_out_voight(2), stress_out_voight(4);
                 stress_out_voight(5), stress_out_voight(4), stress_out_voight(3)];
%For this problem, the output stress tensor should be identical to our given
%stress tensor...
             