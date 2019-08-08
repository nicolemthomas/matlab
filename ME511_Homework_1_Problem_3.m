function [] = Fracture_and_Fatigue_HW1
    clear all
    clc
    close all
    
    alpha(:,1) = linspace(pi/2,pi,100);
    for i=1:100 
        eqn = @(lambda) lambda*sin(2*alpha(i,1))+sin(2*lambda*alpha(i,1));
        lambda(i,1) = fzero(eqn, 0.75);
    end
    min_lambda = min(lambda)
    figure
    plot (alpha, lambda,'LineWidth',2)
    title('Lambda as a Function of Wedge Angle, alpha')
    axis([1.5 3.2 0 1.1])
    xlabel('Wedge Angle, alpha (radians)');
    ylabel('Lambda');
    legend('lambda*sin(2*alpha) + sin(2*lambda*alpha) = 0')
    
end