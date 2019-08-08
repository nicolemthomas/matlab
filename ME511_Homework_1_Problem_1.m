%%The Inglis Solution for the tangential stress surrounding an elliptical
%%hole in a plate under tension

% This code plots the distribution of the normalized stress
% sigma_betabeta/sigma_0 from beta=0 to beta=pi/2

clear all 
clc
a_over_b = [1.000000001 2 5 10];
normalized_stress(4,100) = zeros;
beta (:,1) = linspace(0,pi/2,100);   %beta = linspace(0,pi()/2,200);
for n=1:4
    alpha(:,n)= atanh(1./a_over_b(:,n)); 
    for i=1:100 
        normalized_stress(i,n) = exp(2*alpha(:,n))*(((1+exp(-2*alpha(:,n)))*sinh(2*alpha(:,n)))./(cosh(2*alpha(:,n))-cos(2*beta(i,:)))-1);
    end 
end
        
figure
plot (beta(:,1),normalized_stress(:,1),beta(:,1),normalized_stress(:,2),beta(:,1),normalized_stress(:,3),beta(:,1),normalized_stress(:,4),'LineWidth',2);
hold on
title('Normalized Stress at Various a/b Values');
xlabel('beta');
ylabel('normalized stress (N/m^2)');
legend('a/b = 1', 'a/b = 2', 'a/b = 5', 'a/b = 10');