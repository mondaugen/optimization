% Find the chebychev centre of a polyhedron using linear programming
clear;
% vertices of polyhedron (x y)
% Must be specified in counter-clockwise order going around the polygon (if
% dimension 2)
P=[ 0 2;
    1 0;
    3 1;
    2 3; ];
P_=circshift(P,[-1 0]);
% Normal vectors describing lines
A=ones(2,2,size(P,1));
B=ones(2,1,size(P,1));
A(1,1,:)=P(:,1);
A(2,1,:)=P_(:,1);
B(1,1,:)=P(:,2);
B(2,1,:)=P_(:,2);
x=zeros(2,1,size(P,1));
t=(0:0.1:3);
hold on;
for n=1:size(x,3)
    x(:,1,n)=linsolve(A(:,:,n),B(:,:,n));
    plot(t,x(:,1,n)'*[t; ones(1,length(t))]);
end
hold off;
% Constraints
x_=reshape(x,[size(x,3) size(x,1)]);
a=ones(size(x_,1),size(x_,2)+1);
b=ones(size(x_,1),1);
a(:,1)=-x_(:,1);
b(:,1)=x_(:,2);
% ignore above
% the half-spaces have to be specified, so we do it manually
a=[ -2 -1;
    3 1;
    .5 -1;
    -1 1; ];
b=[ -2;
    10;
    .5;
    2 ];
% augment a with norms
a(:,3)=norm(a(:,(1:2)),2,"rows");
[xopt,fopt,status,extra]=glpk([0 0 1]',a,b,[0 0 0]', ...
    [Inf Inf Inf]',"UUUU",["C";"C";"C"],-1);
