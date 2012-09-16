%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% The air dispersion model setting
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Uwind = 5;   % wind speed (m/s)
grav = 9.8; % gravitational acceleration (m/s^2)
mu = 1.8e-5;    % dynamic viscosity of air (kg/m.s)
rho = 7140; % density of zinc (kg/m^3)
R = 0.45e-6;    % diameter of zinc particles (m).   See Gatz (1975)
Wdep = 0.0062;   % Zn deposition velocity (m/s), in the range [5e-4, 1e-2]
Wset = 2 * rho * grav * R ^ 2 / (9 * mu);   % settling velocity (m/s): Stokes law
dia = 0.162;    % receptor diameter (m)
A = pi * (dia / 2) ^ 2; % receptor area (m ^ 2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% The communication model setting, quantize step size is on demand
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

G = (10^-13.11); % channel gain constant, 10^-13.11*di^-4.281 (km)
TxPower= 0.01;        % Watt, transmission power
Bw= 180;         % kHz, bandwidth
N0= 10^-12;      % W/kHz, noise power density

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Scensor scatter setting 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nx = 100;
ny = 100;
xlim = [-500, 500];
ylim = [-500, 500];
x0 = xlim(1) + [0 : nx] / nx * (xlim(2) - xlim(1));
y0 = ylim(1) + [0 : ny] / ny * (ylim(2) - ylim(1));
[xmesh, ymesh] = meshgrid(x0, y0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Source setting 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
source.expectQ = 0.0011;    % emission rate (kg/s)
source.x = 0;   % x location (m)
source.y = 0;   % y location (m)
source.z = 10;  % height (m)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Sensor information setting 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
recept.n = 100; % # of receptors
recept.x = (rand(recept.n, 1) - 0.5) * (xlim(2) - xlim(1)); % x location (m)
recept.y = (rand(recept.n, 1) - 0.5) * (ylim(2) - ylim(1)); % y location (m)
recept.z = zeros(recept.n, 1);  % height (m)
