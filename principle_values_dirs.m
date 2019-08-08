function [I1, I2, I3] = principle_values_dirs(F)

% v = [1 2 3];
% u = [2 3 4];

I1 = trace(F);

I2 = scalar22(F, F) / 2;

I3 = det(F);

[1 -I1 -I2 -I3]

rts = sort(roots([1 -I1 -I2 -I3]), 'ascend')
% for ii=1:length(rts)
%     F_m = F;
%     F_m(1,1) = F(1,1) - rts(ii);
%     F_m(2,2) = F(2,2) - rts(ii);
%     F_m(3,3) = F(3,3) - rts(ii);
%     F_m
% end