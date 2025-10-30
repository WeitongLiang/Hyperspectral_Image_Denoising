function[U,sigma,V]=QR_SVD(D)
[Q,R]=qr(D,0);
[U2,sigma,V]=svd(R,'econ');
U=Q*U2;
end