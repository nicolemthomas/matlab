function [val] = perm(x)
    y = eye(numel(x));
    val = det( y(:,x) );
end