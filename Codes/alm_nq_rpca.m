function [A,E,iter] = alm_nq_rpca(D, lambda, tol, Iter)
%D：数据矩阵
%lambda：平衡一范数和核范数的权重
%tol：迭代中止条件
%Iter：最大迭代次数
D=im2double(D);
[m,n]=size(D);
%如果没有指定参数值,设置默认值
if nargin < 2
    lambda = 1 / sqrt(m);
end
if nargin < 3
    tol = 1e-7;
end
if nargin < 4
    Iter = 1000;
end
Y=D;
%计算最大的奇异值和模最大的元素，对矩阵做归一化
norm1 = svds(Y,1);
norm2 = norm( Y(:), inf) / lambda;
dual = max(norm1, norm2);
Y = Y / dual;
%初始化
A = zeros( m, n);
E = zeros( m, n);
mu = 1.25/norm1;
mu_bar = mu * 1e7;
rho = 1.5;
d_norm = norm(D, 'fro');
%记录迭代次数
iter = 0;
total_svd = 0;
converged = false;
tic
while ~converged       
    iter = iter + 1;
    temp_T = D - A + (1/mu)*Y;
    %迭代求解E
    E = max(temp_T - lambda/mu, 0);
    E = E+min(temp_T + lambda/mu, 0);
    %迭代求解A
    [U,S,V]=ieee_know_r(D - E + (1/mu)*Y,11);
    diagS = diag(S);
    svp = length(find(diagS > 1/mu));
    A = U(:, 1:svp) * diag(diagS(1:svp) - 1/mu) * V(:, 1:svp)';
    total_svd = total_svd + 1;
    Z = D - A - E;
    %更新拉格朗日因子
    Y = Y + mu*Z;
    mu = min(mu*rho, mu_bar);
    %判断是否继续迭代
    stopjudgement= norm(Z, 'fro') / d_norm;
    if stopjudgement < tol
        converged = true;
    end    
    if ~converged && iter >= Iter
        disp('达到最大迭代次数') ;
        converged = 1 ;       
    end
end
toc
end
