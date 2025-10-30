function [U, S, V] = rSVD(A,k)
[m, n] = size(A);
if nargin<2
    k=round(min(size(A))/10);
end
B = randn(n, k);
[Q, ~] = qr(A*B, 0);
for j = 1:3
    [Q, ~] = qr((A'*Q), 0);
    [Q, ~] = qr((A*Q), 0);
end
B = Q'*A;
[U, S, V] = svd(B, 'econ');
U = Q*U;
end