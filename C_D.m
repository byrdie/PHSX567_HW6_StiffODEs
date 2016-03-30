% function for computing the Reynolds number
function result = C_D(v)

	% Global variable declaration
	global rho d eta;

	% Function definition
	Re = rho * v * d / eta;
	result = (24 / Re) * (1 + Re^(2/3) / 6);

endfunction
