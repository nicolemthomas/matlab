function [t, tn, ts] = traction21 (s, n)

t = zeros(3,1);
% for jj=1:3
%     for kk=1:3
%         t(jj) = t(jj) + n(kk)*s(kk,jj); 
%     end
% end
t = dot12(n,s);
tn = dot(t, n);
ts = sqrt(dot(t,t)-tn^2);