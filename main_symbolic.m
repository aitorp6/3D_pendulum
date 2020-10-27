clc
clear all
close all

%% https://www.youtube.com/watch?v=Qo0IW91tniw
syms l m g theta dtheta ddtheta phi dphi ddphi real

q= [theta;phi];
dq= [dtheta;dphi];
ddq= [ddtheta;ddphi];

% theta giro entorno a Z xyz->123
R1 = [cos(theta),-sin(theta),0; sin(theta),cos(theta),0;  0,0,1; ];

% phi giro en torno a y
R2 = [cos(-phi),0,sin(-phi);0,1,0;-sin(-phi),0,cos(-phi);];


r_OP = R1*R2*[0;0;-l];
x = r_OP(1);
y = r_OP(2);
z = r_OP(3);

dx = jacobian(x,q)*dq;
dy = jacobian(y,q)*dq;
dz = jacobian(z,q)*dq;


T= (1/2)*m*(dx^2+dy^2+dz^2);
V = m*g*(l-l*cos(phi));
L = simplify(T-V)

eq = sym(zeros(2,1));
for i=1:length(q)
    dL_dqi = jacobian(L,dq(i));
    eq(i) = jacobian(dL_dqi,dq(i))*ddq(i)  - jacobian(L,q(i));    
end

eq = simplify(eq);

s_M = jacobian(eq, ddq);
s_delta = subs(-eq,[ddtheta, ddphi], [0,0]);

matlabFunction(s_M,'File','M','Vars',[m,l,q']);
matlabFunction(s_delta,'File','delta','Vars',[m,l,g,q',dq']);

matlabFunction(r_OP,'File','r_OP','Vars',[l,q']);





















