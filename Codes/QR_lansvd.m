function [U,S,V,K] = QR_lansvd(D,k)
    [U,S,V]=QR_SVD(D);
    K=zeros(1,k);
    Temp=S(:);
    for i = 1:k
        [maxm,pos]=max(Temp);
        K(i)=maxm;
        Temp(pos)=-inf;
    end
end