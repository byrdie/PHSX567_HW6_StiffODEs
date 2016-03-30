% Roy Smart
% PHSX567 Mathematical Physics II
% Homework 6
% Octave script for determining the smallest particle that can become trapped in
% the atmosphere's convective currents

clear all

% Provided quantities
global part_rho = 1000;		% Particle density
global rho = 1;				% Atmosphere density
global w_0 = 10;			% Vortex speed
global a = 1000;			% Vortex radius
global eta = 2e-5;			% Air Viscosity
global g = 10;				% Gravitational acceleration

% Variable quanties
global d = 1000e-6;					% Particle diameter

% Derived quantities
global r = d / 2;				% Particle radius
global V = (4/3) * pi * r^3;	% Particle volume
global m = part_rho * V;		% Particle mass
global A = pi * r^2;		% Particle cross-sectional area
tau = 2 * pi * a / w_0;			% Convective turnover time

% Initial conditions (x0, dxdt0, y0, dydt0)
initial = [0, 0, 1.5e3, 0];
times = 0:10*tau;

% Find the trajectory of the particle by solving the system of ODEs
trajectory = lsode("advect", initial, times);

X = trajectory(:,1);
Y = trajectory(:,3);

figure(1)
plot(X(Y > 0),Y(Y > 0));
title(sprintf("Particle Trajectory, %1.0f um Diameter", d * 1e6));
xlabel("Horizontal position, x (m)");
ylabel("Vertical position, y (m)")


% Try to find the maximum particle that can be held aloft
ub = 1000e-6;	% upper bound on particle size
lb = 1e-6;		% lower bound on particle size
t = 0:10*tau;

for i = 1:10

	d = (ub - lb) / 2 + lb

	r = d / 2;				% Particle radius
	V = (4/3) * pi * r^3;	% Particle volume
	m = part_rho * V;		% Particle mass
	A = pi * r^2;		% Particle cross-sectional area
	tau = 2 * pi * a / w_0;			% Convective turnover time

	% Evaluate the next trajectory
	traject = lsode("advect", initial, t);
	y = traject(:,3);

	% Detect if it hit the ground
	len = length(y(y < 150.32));
	if(len > 76)	% Particle hit the ground
		ub = d;
	else
		lb = d;
	endif

endfor


% Plot the upper and lower bound
figure(2)
d = ub
traject_ub = lsode("advect", initial, t);
X = traject_ub(:,1);
Y = traject_ub(:,3);
plot(X(Y > 0),Y(Y > 0));
title(sprintf("Upper Bound Trajectory, %1.2f um Diameter", d * 1e6));
xlabel("Horizontal position, x (m)");
ylabel("Vertical position, y (m)");

hold on

d = lb
traject_lb = lsode("advect", initial, t);
X = traject_lb(:,1);
Y = traject_lb(:,3);
plot(X(Y > 0),Y(Y > 0), 'r');
title(sprintf("Lower Bound Trajectory, %1.2f um Diameter", d * 1e6));
xlabel("Horizontal position, x (m)");
ylabel("Vertical position, y (m)");

hold off





















