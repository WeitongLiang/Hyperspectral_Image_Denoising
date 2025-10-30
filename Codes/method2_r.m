function [U3,s,V3]=method2_r(A,r)
[m,n]=size(A);
Y1=A*randn(n,r);
[Q,~]=qr(Y1,0);
B=Q'*A;
C=B*B';
[u1,s1,~]=svd(C,0);
U3=Q*u1;
s11=diag(s1);
V3=diag(sqrt(1./s11))*u1'*B;
s=diag(sqrt(s11));
V3=V3';
end
%  A=U3*s*V3;