function [A_hat E_hat iter] = inexact_rsvd_WNNMrpca(D,C,tol, maxIter)
tic
%临时的加权核范数的用来非精确RPCA的方法，没有迭代的reweighted情况
% Oct 2009
% This matlab code implements the inexact augmented Lagrange multiplier 
% method for Robust PCA.
%
% D - m x n matrix of observations/data (required input)
%
% lambda - weight on sparse error term in the cost function
%
% tol - tolerance for stopping criterion.
%     - DEFAULT 1e-7 if omitted or -1.
%
% maxIter - maximum number of iterations
%         - DEFAULT 1000, if omitted or -1.
% 
% Initialize A,E,Y,u
% while ~converged 
%   minimize (inexactly, update A and E only once)
%     L(A,E,Y,u) = |A|_* + lambda * |E|_1 + <Y,D-A-E> + mu/2 * |D-A-E|_F^2;
%   Y = Y + \mu * (D - A - E);
%   \mu = \rho * \mu;
% end
%
% Minming Chen, October 2009. Questions? v-minmch@microsoft.com ; 
% Arvind Ganesh (abalasu2@illinois.edu)
%
% Copyright: Perception and Decision Laboratory, University of Illinois, Urbana-Champaign
%            Microsoft Research Asia, Beijing

% addpath PROPACK;

% C=1,5*1e2;%WNNM里面的一个参数
[m n] = size(D);


if nargin < 4
    tol = 1e-7;
elseif tol == -1
    tol = 1e-7;
end

if nargin < 5
    maxIter = 1000;
elseif maxIter == -1
    maxIter = 1000;
end

% initialize
Y = D;
[~,sigma,~]=rSVD(Y);
sigma=sigma(:);
norm_two = max(sigma);
norm_inf = norm( Y(:), inf) ;
dual_norm = max(norm_two, norm_inf);
Y = Y / dual_norm;

A_hat = zeros( m, n);
E_hat = zeros( m, n);
mu = .5/norm_two*10*sqrt(m); % this one can be tuned
mu_bar = mu * 1e7;
rho = 1.3;          % this one can be tuned
d_norm = norm(D, 'fro');

iter = 0;
total_svd = 0;
converged = false;
stopCriterion = 1;
sv = 10;
while ~converged       
    iter = iter + 1;
    
    temp_T = D - A_hat + (1/mu)*Y;
    E_hat = max(temp_T - 1/mu, 0);
    E_hat = E_hat+min(temp_T + 1/mu, 0);

%%%%%%这里用wnnm改造过%%%%%
 
    [U S V] = rSVD(D - E_hat + (1/mu)*Y);


    
%     
%             %%%%%%%%%%%%%%%%%%
%         diagS = diag(S);
%         [tempDiagS,svp]=ClosedWNNM(diagS,C*sqrt(m*n)/mu,eps);
%         temp_A=U(:,1:svp)*diag(tempDiagS)*V(:,1:svp)';
%         %%%%%%%%%%%%%%%%%%
        
    
    
    %%%%%%%%%%%%%
    diagS = diag(S);
    [tempDiagS,svp]=ClosedWNNM(diagS,C*m*sqrt(n)/mu,eps); %myeps
    %[tempDiagS,svp]=ClosedWNNM(diagS,C*sqrt(m*n)/mu,eps); %myeps
    A_hat = U(:,1:svp)*diag(tempDiagS)*V(:,1:svp)';  
    %%%%%%%%%%%%
    if svp < sv
        sv = min(svp + 1, n);
    else
        sv = min(svp + round(0.05*n), n);
    end

%%%%%% 
    total_svd = total_svd + 1;
  
    Z = D - A_hat - E_hat;
    
    Y = Y + mu*Z;
    mu = min(mu*rho, mu_bar);
        
    %% stop Criterion    
    stopCriterion = norm(Z, 'fro') / d_norm;
    if stopCriterion < tol
        converged = true;
    end   
    if ~converged && iter >= maxIter
        disp('Maximum iterations reached') ;
        converged = 1 ;       
    end
end
toc
end