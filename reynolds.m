% function for computing the Reynolds number
function C_D = reynolds(v)

	% Global variable declaration
	global rho, d, eta;

	% Function definition
	Re = rho * v * d / eta;
	C_D = (24/Re)(1 + Re^(2/3) / 6);

endfunction
