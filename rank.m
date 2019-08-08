function [r] = rank(A, tol)

s = svd(A);
if nargin==1
        tol = max(size(A)')*max(s)*esp;
end
r = sum(s > tol);
end