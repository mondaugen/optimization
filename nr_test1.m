% Fit a polynomial in one coefficient to some data

t=(-5:0.1:5);
x    = @(t_) 3*t_.^3 + 2*t_.^2 + 1;
D    = @(t_,a_) sum((x(t_) - a_.*t_.^2).^2);
D_d1 = @(t_,a_) sum(-2.*(t_.^2).*(x(t_) - a_.*t_.^2));
D_d2 = @(t_,a_) sum(2.*(t_.^4));
K=100;
a=zeros(K,1);
a(1)=100;
beta=0.001;
for k=(2:K)
    a(k)=a(k-1) - D_d1(t,a(k-1)) / D_d2(t,a(k-1));
end
x_   = @(t_) a(K).*t_.^2;
plot(t,x(t),t,x_(t));
