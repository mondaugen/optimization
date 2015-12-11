%Fit a periodic function of one coefficient to some data
clear;
t=[-5:0.1:5];
nu=0.*randn(1,length(t));
x = @(t_) sin(4*t_) + nu;
D_d1= @(t_,a_) sum(-2.*t_.*cos(a_.*t_).*x(t_)+t_.*sin(2*a_.*t));
D_d2= @(t_,a_) sum(2.*t_.^2.*sin(a_.*t_).*x(t_)+2*t.^2.*cos(2*a_.*t_));
K=1000;
a=zeros(K,1);
a(1)=4.7;
c=1;
e=0.001;
for k=(2:K)
    a(k)=a(k-1) - c*D_d1(t,a(k-1)) / D_d2(t,a(k-1));
    if (abs(a(k) - a(k-1)) < e*c)
        break;
    end
end
x_= @(t_) sin(a(k)*t_);
plot(t,x(t),t,x_(t));
