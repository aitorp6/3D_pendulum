
clear all; clc; close all;

%% Initial conditions
m = 1;
l = 3;
g = 9.8;
q_0 = [0.4;0.2];
dq_0 = [-1;0];


t_final = 100.0; 
delta_t = 0.01;

%% Integrate
data.l = l;
data.m = m;
data.g = g;


state_init = [q_0;dq_0]';
tspan = [0:delta_t:t_final];

options = odeset('RelTol',1e-7);
[tSeries, stateSeries] = ode45 (@deriv, tspan, state_init, options, data);


state_xyz=zeros(length(tspan),3);
for i=1:length(tspan)
    state_xyz(i,:) = r_OP(l,stateSeries(i,1),stateSeries(i,2)  );
    
end
%plot3(state_xyz(:,1),state_xyz(:,2),state_xyz(:,3))

h=figure(2)
hold on;axis equal;grid on; 
title('3D pendulum','interpreter','latex','Fontsize', 18) 
ball = scatter3(state_xyz(1,1),state_xyz(1,2),state_xyz(1,3),100,'filled'  );
bar  = plot3([0,state_xyz(1,1)],[0,state_xyz(1,2)],[0,state_xyz(1,3)] ,'k','LineWidth',2);
path = plot3(state_xyz(1,1),state_xyz(1,2),state_xyz(1,3),'r')
axis([-1,1,-1,1, -3,0])

view(72,10)
for i=1:length(tSeries)
    x = state_xyz(i,1);
    y = state_xyz(i,2);
    z = state_xyz(i,3);

    set(ball,'Xdata', x, 'YData',y,'ZData',z );
    set(bar ,'Xdata',[0, x], 'YData',[0,y],'ZData',[0,z] );
    set(path ,'Xdata',state_xyz(1:i,1), 'YData',state_xyz(1:i,2),'ZData',state_xyz(1:i,3) );   
    

    pause(delta_t)
end


