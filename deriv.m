function dxdt = deriv(t,state,data)
    m = data.m;
    l = data.l;
    g = data.g;

    n = size(state,1)/2;
    x   = state(1:n);
    dx  = state(n+1:end);
    
    n_M = M(m,l,x(1),x(2)); 
    n_delta = delta(m,l,g, x(1),x(2),dx(1),dx(2));
    ddx = inv(n_M)*n_delta;
    
   
    dxdt = zeros (2*n,1);
    dxdt(1:n,1) = dx;
    dxdt(n+1:end,1) = ddx;  

end