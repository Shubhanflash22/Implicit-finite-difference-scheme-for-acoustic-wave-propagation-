function [spDxL,spDxR]= sparce_der_D2_O6(nx)
% create simple derivative matrix
CD11 = -2*diag(ones(nx,1)) + diag(ones(nx-1,1),1) + diag(ones(nx-1,1),-1);
CD12= (2^(-2))*(-2*diag(ones(nx,1)) + diag(ones(nx-2,1),2) + diag(ones(nx-2,1),-2));

% Interior
alpha = 2/11;       a=12/11;       b=3/11;
DxL= diag(ones(nx,1)) + alpha*diag(ones(nx-1,1),1) + alpha*diag(ones(nx-1,1),-1);
DxR= a*CD11 + b*CD12 ;

% Boundary 1st node
alpha=126/11;   c=[2077/157, -2943/110, 573/44, 167/99, -18/11, 57/110, -9/136];
DxL(1,2) = alpha;
DxL(nx,nx-1) = alpha;

DxR(1,1:7)=c;
DxR(nx,nx-6:nx)= - fliplr(c);

% Boundary 2nd node
alpha=11/128;   c=[585/512, -141/64, 459/512, 9/32, -81/512, 3/64, -3/512];
DxL(2,2) = alpha;
DxL(nx-1,nx-1) = alpha;

DxR(2,1:7)=c;
DxR(nx-1,nx-6:nx)= - fliplr(c);

spDxL = sparse(DxL);
spDxR = sparse(DxR);
end