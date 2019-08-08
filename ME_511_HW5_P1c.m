%%ME 511 Fatigue and Fracture
%Homework 5 
%Problem 1b
%Nicole Thomas
%
%%Import fatigue data into their respective R Values
clear
clc
clear all

fatigue_data = xlsread('fatigue_data.xls','Sheet1');

delta_k_075 = [];
da_dN_075 = [];
R_075 = [];
delta_k_033 = [];
da_dN_033 = [];
R_033 = [];
delta_k_01 = [];
da_dN_01 = [];
R_01 = [];

for i = 1:length(fatigue_data)
    if fatigue_data(i,1) == 0.75
        delta_k_075 = [delta_k_075;fatigue_data(i,2)];
        da_dN_075 = [da_dN_075;fatigue_data(i,3)];
        R_075 = [R_075; fatigue_data(i,3)];
    end
    if fatigue_data(i,1) == 0.33
        delta_k_033 = [delta_k_033;fatigue_data(i,2)];
        da_dN_033 = [da_dN_033;fatigue_data(i,3)];
        R_033 = [R_033; fatigue_data(i,3)];
    end
    if fatigue_data(i,1) == 0.1
        delta_k_01 = [delta_k_01;fatigue_data(i,2)];
        da_dN_01 = [da_dN_01;fatigue_data(i,3)];
        R_01 = [R_01; fatigue_data(i,3)];
    end
end

% all_delta_k = [delta_k_075; delta_k_033; delta_k_01];
% all_da_dN = [da_dN_075; da_dN_033; da_dN_01];
% all_R = [R_075; R_033; R_01];
% 
% % Finding the maximum of the delta_k array
% K_c = max(all_delta_k)/(1-all_R);
% 
% % Setting the z values for each R value. The Z value is equal to the
% % denominator in the Forman Model equation. 
% z_all = (1-all_R)*K_c- all_delta_k;

% z_075 = (1-0.75)*K_c_075 - delta_k_075;
% z_033 = (1-0.33)*K_c_033 - delta_k_033;
% z_01 = (1-0.1)*K_c_01 - delta_k_01;

% % Taking out specified # of data points in stage I and III for each R value
% num_stage_I = 5;
% num__stage_III = 0;  % Should be 0 for Forman Model 
% x_forman = all_delta_k(num_stage_I:length(all_delta_k)-num__stage_III);
% y_forman = all_da_dN(num_stage_I:length(all_da_dN)-num__stage_III);
% z_forman = z_all(num_stage_I:length(z_all)-num__stage_III);
% %
% 
% Setting the z values for each R value. The Z value is equal to the
% denominator in the Forman Model equation. 
% z_075 = (1-0.75)*K_c_075 - delta_k_075;
% z_033 = (1-0.33)*K_c_033 - delta_k_033;
% z_01 = (1-0.1)*K_c_01 - delta_k_01;
K_c_033 = max(delta_k_033)/(1-0.33);

% Taking out specified # of data points in stage I and III for each R value
num_stage_I_075 = 5;
num__stage_III_075 = 0;  % Should be 0 for Forman Model 
x_forman_075 = delta_k_075(num_stage_I_075:length(delta_k_075)-num__stage_III_075);
y_forman_075 = da_dN_075(num_stage_I_075:length(da_dN_075)-num__stage_III_075);
R_forman_075 = R_075(num_stage_I_075:length(R_075)-num__stage_III_075);
% z_forman_075 = z_075(num_stage_I_075:length(z_075)-num__stage_III_075);
%
num_stage_I_033 = 15;
num__stage_III_033 = 0;  % Should be 0 for Forman Model 
x_forman_033 = delta_k_033(num_stage_I_033:length(delta_k_033)-num__stage_III_033);
y_forman_033 = da_dN_033(num_stage_I_033:length(da_dN_033)-num__stage_III_033);
R_forman_033 = R_033(num_stage_I_033:length(R_033)-num__stage_III_033);
% z_forman_033 = z_033(num_stage_I_033:length(z_033)-num__stage_III_033);
%
num_stage_I_01 = 30;
num__stage_III_01 = 0;  % Should be 0 for Forman Model 
x_forman_01 = delta_k_01(num_stage_I_01:length(delta_k_01)-num__stage_III_01);
y_forman_01 = da_dN_01(num_stage_I_01:length(da_dN_01)-num__stage_III_01);
R_forman_01 = R_01(num_stage_I_01:length(R_01)-num__stage_III_01);
% z_forman_01 = z_01(num_stage_I_01:length(z_01)-num__stage_III_01);


%%
all_delta_k = [x_forman_075; x_forman_033; x_forman_01];
all_da_dN = [y_forman_075; y_forman_033; y_forman_01];
all_R = [R_forman_075; R_forman_033; R_forman_01];

% Finding the maximum of the delta_k array
% K_c = max(all_delta_k)/(1-all_R);

% Setting the z values for each R value. The Z value is equal to the
% denominator in the Forman Model equation. 
z_all = (1-all_R)*K_c_033- all_delta_k;
% z_all = [z_forman_075; z_forman_075; z_forman_075];

% PLOTTTTTT!!!
figure
loglog(all_delta_k, all_da_dN,'+r')
%axis([-1 1 -1 1])
title('Forman Model - All Data')
legend('All Data at R = 0.75,0.33,0.1')
xlabel('Delta K') % x-axis label
ylabel('da/dN') % y-axis label


cftool

% Using the cftool, an R squared value of 0.483 is achievable with 
% c = 1.955e-7 and m = 2.586