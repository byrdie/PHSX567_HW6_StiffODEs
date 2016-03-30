% Equations of motion for a particle in the atmosphere
function dxdt = advect(x,t) 

	% Constant parameters of the ODE
	global g m A rho w_0 a;

	% Convective velocity field
	w_x = -(pi * w_0 / 2) * cos(pi * x(1) / (2 * a)) .* cos(pi * x(3) / (2 * a));
	w_y = -(pi * w_0 / 2) * sin(pi * x(1) / (2 * a)) .* sin(pi * x(3) / (2 * a));
	mag = sqrt( (w_x - x(2))^2 + (w_y - x(4))^2 );

	% ODE statement
	dxdt(1) = x(2);
	dxdt(2) = (1 / (2 * m)) * C_D( mag ) * A .* rho .* mag .* (w_x - x(2));
	dxdt(3) = x(4);
	dxdt(4) = -g + (1 / (2 * m)) * C_D( mag ) * A .* rho .* mag .* (w_y - x(4));

endfunction
