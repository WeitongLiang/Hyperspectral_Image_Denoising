function [U,s1,V]=method1_r(A,r)
[m,n]=size(A);
Y1=A*randn(n,r);
[Q,R] = qr(Y1,0);
B =Q'*A;
[P,R1]=qr(B',0);
[u,s1,v]=svd(R1,0);
U=Q*v;
V=P*u;
end
% A=U*s1'*V';
% r可以设为秩的界