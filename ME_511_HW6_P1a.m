%%ME 511 Fatigue and Fracture
%Homework 5 
%Problem 1b
%Nicole Thomas
%
%%Performs the crack growth analysis using the Paris Crack Growth Model
%%(HW5 Q1a)


clear
clc
clear all

hole_dia = 2;           %(inches): Dia of hole w/ crack extending from it
a_i = 0.1;              %(inches): Initial crack length
sigma_min = 18750;      %(psi): Minimum stress
sigma_max = 25000;      %(psi): Maximum stress

stress_intesity_factor = sigma*sqrt(hole_dia + a) * sqrt(pi()/2);

%%For the Paris Law with an r squared value of 0.9944, c = 1.889e-09 and 
%m = 3.1, which was found in HW5 P1a
C = 0.1;                %(dimensionless): Paris law parameter, C
m = 0.1;                %(dimensionless): Paris law parameter, C
da/dN = C*(delta_k)^m;



