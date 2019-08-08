clearvars; close all; clc;

X = 150;
Xp = 100;
Y = 6;
Yp = 17;
S = 10;

%% Calculate Strength Tensors (non zero elements)

Fi = zeros(6,1);

Fi(1,1) = X^-1 - Xp^-1;
Fi(2,1) = Y^-1 - Yp^-1;

Fij = zeros(6,6);

Fij(1,1) = (X*Xp)^-1;
Fij(2,2) = (Y*Yp)^-1;
Fij(6,6) = (S)^-2;

Fij(1,2) = sqrt(Fij(1,1)*Fij(2,2));
Fij(2,1) = Fij(1,2);

%% Figure 3


T(1,1) = (Fi(1)+Fi(2))/2;
T(2,1) = (Fi(1)-Fi(2))/2;
T(3,1) = 0;

theta = linspace(-pi/2,pi/2,100);
theta_plot = theta * 180/pi;

F1p = T(1) + T(2)*cos(2*theta);
F2p = T(1) - T(2)*cos(2*theta);
F6p = 2*T(2)*sin(2*theta);

fig3 = figure; grid; hold on;
plot(theta_plot,F1p,'LineWidth',2)
plot(theta_plot,F2p,'LineWidth',2)
plot(theta_plot,F6p,'LineWidth',2);

title('Sigma One vs. Angle', 'FontSize', 14);
xlabel('Sigma One [ksi]', 'FontSize', 14);
ylabel('Angle [deg]', 'FontSize', 14);
lgd = legend('F1''','F2''','F6''');
lgd.FontSize = 10;

axis([-90 90 -0.15 0.15])

saveplots(fig3,'Figure3_Replot');


%% Figure 4


theta = linspace(-pi/2,pi,100);
theta_plot = theta * 180/pi;

F12 = [1;-1] * Fij(1,2);

U1 = (3*Fij(1,1) + 3*Fij(2,2) + 2*F12 + Fij(6,6))/8;
U2 = (Fij(1,1) - Fij(2,2))/2;
U3 = (Fij(1,1)+ Fij(2,2)-2*F12-Fij(6,6))/8;
U4 = (Fij(1,1)+ Fij(2,2)+ 6*F12-Fij(6,6))/8;
U5 = (Fij(1,1)+Fij(2,2)-2*F12+ Fij(6,6))/8;

U1_ub = (3*Fij(1,1) + 3*Fij(2,2) + 2*Fij(1,2) + Fij(6,6))/8;
U2_ub = (Fij(1,1) - Fij(2,2))/2;
U3_ub = (Fij(1,1)+ Fij(2,2)-2*Fij(1,2)-Fij(6,6))/8;
U4_ub = (Fij(1,1)+ Fij(2,2)+ 6*Fij(1,2)-Fij(6,6))/8;
U5_ub = (Fij(1,1)+Fij(2,2)-2*Fij(1,2)+ Fij(6,6))/8;

F11p_ub = (U1_ub + U2_ub*cos(2*theta) + U3_ub*cos(4*theta));
F12p_ub = U4_ub-U3_ub*cos(4*theta);
F16p_ub = -U2_ub * sin(2*theta) - (U2_ub+U5_ub)*sin(4*theta);
F66p_ub = (5*U5_ub - 4*U3_ub*cos(4*theta));

Fij(1,2) = -Fij(1,2);
U1_lb = (3*Fij(1,1) + 3*Fij(2,2) + 2*Fij(1,2) + Fij(6,6))/8;
U2_lb = (Fij(1,1) - Fij(2,2))/2;
U3_lb = (Fij(1,1)+ Fij(2,2)-2*Fij(1,2)-Fij(6,6))/8;
U4_lb = (Fij(1,1)+ Fij(2,2)+ 6*Fij(1,2)-Fij(6,6))/8;
U5_lb = (Fij(1,1)+Fij(2,2)-2*Fij(1,2)+ Fij(6,6))/8;

F11p_lb = (U1_lb + U2_lb*cos(2*theta) + U3_lb*cos(4*theta));
F12p_lb = U4_lb-U3_lb*cos(4*theta);
F16p_lb = -U2_lb * sin(2*theta) - (U2_lb+U5_lb)*sin(4*theta);
F66p_lb = (5*U5_lb - 4*U3_lb*cos(4*theta));


fig4 = figure
subplot(2,1,1);
hold on; grid
plot(theta_plot,F11p_ub,'LineWidth',2); 
plot(theta_plot,F11p_lb,'LineWidth',2); 
axis([-90 180 0 0.012]);
title('F11''', 'FontSize', 14);
xlabel('Sigma One [ksi]', 'FontSize', 14);
ylabel('Angle [deg]', 'FontSize', 14);
lgd = legend('Upper Bound', 'Lower Bound');
lgd.FontSize = 10;

subplot(2,1,2)
hold on;grid; 
plot(theta_plot,F16p_ub,'LineWidth',2); 
plot(theta_plot,F16p_lb,'LineWidth',2);

title('F16''', 'FontSize', 14);
xlabel('Sigma One [ksi]', 'FontSize', 14);
ylabel('Angle [deg]', 'FontSize', 14);
lgd = legend('Upper Bound', 'Lower Bound');
lgd.FontSize = 10;

axis([-90 180 -0.01 0.01]);

saveplots(fig4,'Figure4_Replot');


%% Plot 6

theta = linspace(0,pi/2,100);
theta_plot = theta * 180/pi;

F1p = 0.0523 - 0.0556*cos(2*theta);
F11p = (U1 + U2*cos(2*theta) + U3*cos(4*theta));
F11p_ub = (U1_ub + U2_ub*cos(2*theta) + U3_ub*cos(4*theta));
F11p_lb = (U1_lb + U2_lb*cos(2*theta) + U3_lb*cos(4*theta));

for ii=1:length(theta)
    s1_p_ub(ii) = (-F1p(ii) + sqrt(F1p(ii)^2 + 4*F11p_ub(ii))) / (2*F11p_ub(ii));
    s1_p_lb(ii) = (-F1p(ii) + sqrt(F1p(ii)^2 + 4*F11p_lb(ii))) / (2*F11p_lb(ii));
    s1_m_ub(:,ii) = (-F1p(ii) - sqrt(F1p(ii)^2 + 4*F11p_ub(ii))) / (2*F11p_ub(ii));
    s1_m_lb(:,ii) = (-F1p(ii) - sqrt(F1p(ii)^2 + 4*F11p_lb(ii))) / (2*F11p_lb(ii));
end

fig6 = figure; grid;
hold on;
plot(theta_plot,s1_p_ub,'LineWidth',2)
plot(theta_plot,s1_p_lb,'LineWidth',2)
plot(theta_plot,s1_m_ub,'LineWidth',2)
plot(theta_plot,s1_m_lb,'LineWidth',2)

title('Sigma One vs. Angle', 'FontSize', 14);
xlabel('Sigma One [ksi]', 'FontSize', 14);
ylabel('Angle [deg]', 'FontSize', 14);
lgd = legend('Pos. Upper Bound', 'Pos. Lower Bound', 'Neg. Upper Bound', 'Neg. Lower Bound');
lgd.FontSize = 10;

saveplots(fig6,'Figure6_Replot');


%% Plot 7

theta = linspace(0,pi/2,100);
theta_plot = theta * 180/pi;

F6p = 2*T(2)*sin(2*theta);
F66p_ub = (4*U5_ub - 4*U3_ub*cos(4*theta));
F66p_lb = (4*U5_lb - 4*U3_lb*cos(4*theta));

for ii=1:length(theta)
    s6_p_ub(ii) = (-F6p(ii) + sqrt(F6p(ii)^2 + 4*F66p_ub(ii))) / (2*F66p_ub(ii));
    s6_p_lb(ii) = (-F6p(ii) + sqrt(F6p(ii)^2 + 4*F66p_lb(ii))) / (2*F66p_lb(ii));
    s6_m_ub(ii) = (-F6p(ii) - sqrt(F6p(ii)^2 + 4*F66p_ub(ii))) / (2*F66p_ub(ii));
    s6_m_lb(ii) = (-F6p(ii) - sqrt(F6p(ii)^2 + 4*F66p_lb(ii))) / (2*F66p_lb(ii));
end

fig7 = figure
grid
hold on;
plot(theta_plot,s6_p_ub,'LineWidth',2)
plot(theta_plot,s6_p_lb,'LineWidth',2)
plot(theta_plot,s6_m_ub,'LineWidth',2)
plot(theta_plot,s6_m_lb,'LineWidth',2)
axis([0 90 -15 25])

title('Sigma Six vs. Angle', 'FontSize', 14);
xlabel('Sigma Six [ksi]', 'FontSize', 14);
ylabel('Angle [deg]', 'FontSize', 14);
lgd = legend('Pos. Upper Bound', 'Pos. Lower Bound', 'Neg. Upper Bound', 'Neg. Lower Bound');
lgd.FontSize = 10;

saveplots(fig7,'Figure7_Replot');
