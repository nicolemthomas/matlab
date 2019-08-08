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
delta_k_033 = [];
da_dN_033 = [];
delta_k_01 = [];
da_dN_01 = [];

for i = 1:length(fatigue_data)
    if fatigue_data(i,1) == 0.75
        delta_k_075 = [delta_k_075;fatigue_data(i,2)];
        da_dN_075 = [da_dN_075;fatigue_data(i,3)];
    end
    if fatigue_data(i,1) == 0.33
        delta_k_033 = [delta_k_033;fatigue_data(i,2)];
        da_dN_033 = [da_dN_033;fatigue_data(i,3)];
    end
    if fatigue_data(i,1) == 0.1
        delta_k_01 = [delta_k_01;fatigue_data(i,2)];
        da_dN_01 = [da_dN_01;fatigue_data(i,3)];
    end
end

% Finding the maximum of the delta_k arrays for each R value
K_c_075 = max(delta_k_075)/(1-0.75);
K_c_033 = max(delta_k_033)/(1-0.33);
K_c_01 = max(delta_k_01)/(1-0.1);

% Setting the z values for each R value. The Z value is equal to the
% denominator in the Forman Model equation. 
z_075 = (1-0.75)*K_c_075 - delta_k_075;
z_033 = (1-0.33)*K_c_033 - delta_k_033;
z_01 = (1-0.1)*K_c_01 - delta_k_01;

% Taking out specified # of data points in stage I and III for each R value
num_stage_I_075 = 5;
num__stage_III_075 = 0;  % Should be 0 for Forman Model 
x_forman_075 = delta_k_075(num_stage_I_075:length(delta_k_075)-num__stage_III_075);
y_forman_075 = da_dN_075(num_stage_I_075:length(da_dN_075)-num__stage_III_075);
z_forman_075 = z_075(num_stage_I_075:length(z_075)-num__stage_III_075);
%
num_stage_I_033 = 15;
num__stage_III_033 = 0;  % Should be 0 for Forman Model 
x_forman_033 = delta_k_033(num_stage_I_033:length(delta_k_033)-num__stage_III_033);
y_forman_033 = da_dN_033(num_stage_I_033:length(da_dN_033)-num__stage_III_033);
z_forman_033 = z_033(num_stage_I_033:length(z_033)-num__stage_III_033);
%
num_stage_I_01 = 30;
num__stage_III_01 = 0;  % Should be 0 for Forman Model 
x_forman_01 = delta_k_01(num_stage_I_01:length(delta_k_01)-num__stage_III_01);
y_forman_01 = da_dN_01(num_stage_I_01:length(da_dN_01)-num__stage_III_01);
z_forman_01 = z_01(num_stage_I_01:length(z_01)-num__stage_III_01);
%

% PLOTTTTTT!!!
figure
loglog(x_forman_075,y_forman_075,'+r',x_forman_033,y_forman_033,'ob',x_forman_01,y_forman_01,'.g')
%axis([-1 1 -1 1])
title('Forman Model - Separate Data')
legend('R = 0.75','R = 0.33','R = 0.1')
xlabel('Delta K') % x-axis label
ylabel('da/dN') % y-axis label

% figure
% loglog(x_paris, y_paris,'+b')
% %axis([-1 1 -1 1])
% title('Paris Model - Stage II Data')
% legend('R = 0.75')
% xlabel('Delta K') % x-axis label
% ylabel('da/dN') % y-axis label


cftool
