%%ME 511 Midterm Problem 4, part b
%Nicole Thomas

clear all 
clear
clc
%
%%Specify geometry of the specimen:
B = 0.25; %(in) overall thickness of the TDCB Specimen
B_n = 0.2; %(in) groove thickness of the TDCB Specimen
a = 2; %(in) initial crack length
h = 0.25; %(in) height of each arm
L_tot = 3; %(in) total length of specimen
sigma_ys = 5800; %(psi) Yield strength of ABS
%
B_eff = sqrt(B*B_n); %(in) effective thickness of the TDCB Specimen
K_C = 10000; %(psi(in)^.5) Anticipated fracture toughness

L = 0.4; %(in) Length of non-tapered part of specimen
w = 2*((a-L)*tan(pi()/6)+h); %(in) total height of the specimen at the crack tip
I_moment_inertia = B_eff*(w^3)/12; %(in^4) Area moment of inertia
P = (sigma_ys*I_moment_inertia)/(a*w); %(lb) applied load
A = K_C/P ;

a_over_w_32_1 = (K_C*B_eff)/(P*2*sqrt(3))
w_calc1 = (a/ a_over_w_32_1)^(2/3)

n_max = 2*L_tot*tan(pi()/6)/h
n_min = 2
a_min = h*n_min*(K_C*B_eff/(P*2*sqrt(3)))^(2/3)
a_over_w_32_min = a_min/((2*h)^(3/2))
a_over_w_32_max = L_tot/((2*h)^(3/2))





