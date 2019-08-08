%%ME 511 Midterm Problem 4
%Nicole Thomas

clear all 
clear
clc
%
%%Specify geometry of the specimen:
B = 0.25; %(in) overall thickness of the TDCB Specimen
B_n = 0.2; %(in) groove thickness of the TDCB Specimen
%a = 0.5; %(in) initial crack length
h = 0.25; %(in) height of each arm
sigma_ys = 5800; %(psi) Yield strength of ABS
%
B_eff = sqrt(B*B_n); %(in) effective thickness of the TDCB Specimen
%
K_C = 10000; %(psi(in)^.5) Anticipated fracture toughness

L = 0.4; %(in) Length of non-tapered part of specimen
w = 2*((a-L)*tan(pi()/6)+h); %(in) total height of the specimen at the crack tip
I_moment_inertia = B_eff*(w^3)/12; %(in^4) Area moment of inertia
P = (sigma_ys*I_moment_inertia)/(a*w); %(lb) applied load
A = K_C/P

c_1 = a/(w^(3/2));
K_I = (2*sqrt(3)/B_eff)*c_1;

a = linspace(0,2); %(in) initial crack length 
w = linspace(0,2); %(in) specimen height
P_w = (sigma_ys*I_moment_inertia)/(a*w); %(lb) applied load
a_over_h_32 = K_C/((2*sqrt(3)*P)/B_eff)
h_32 = (a/ a_over_h_32)^(2/3)
%A = (2*sqrt(3)*c_1)/B_eff; 


