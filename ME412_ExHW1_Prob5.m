%%MEGN 412 - Extended Homework 1 - Problem 5
% Nicole Thomas
% March 1, 2018
%
clear all
clear
clc

%% Initialize strain matrix
Strain = [200, 300, 200; 300, -100, 500; 200, 500, -400]; %MPa

%%Part A: Find the strain invariants
I_strain = Strain(1,1) + Strain(2,2) + Strain(3,3)
II_1strain = Strain(1,1)*Strain(2,2) + Strain(1,1)*Strain(3,3) + ...
    Strain(2,2)*Strain(3,3) - Strain(1,2)^2 - Strain(2,3)^2 - Strain(1,3)^2
III_strain = det(Strain)

principal_strains = eig(Strain)