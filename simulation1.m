clear; clc;
%% Input data
d = load('defaults.mat');

%% Calculation
%calculations are based on temperature in (Tdb), relative humidity of
%the air in % (phi) and absolut humidity of the air in kg/kg (w)
addpath('psychrometric');

% intitial situation
[Tdb, w, ~, h, ~, ~, ~] = ...
Psychrometricsnew('Tdb', d.s_air_t_cels, ...
                  'phi', d.s_air_humidity*100);
processdata = [Tdb, w, h];

% heating up the air
[Tdb, w, ~, h, ~, ~, ~] = ...
Psychrometricsnew('Tdb', d.air_in_t_cels, ...
                  'w', w);
processdata = [processdata; Tdb, w, h];

% intake of water
[Tdb, w, ~, h, ~, ~, ~] = ...
Psychrometricsnew('Tdb', d.air_out_t_cels, ...
                  'h', h);
processdata = [processdata; Tdb, w, h];

clear('Tdb', 'w', 'h'); %a little bit of garbage handling

% numeric calculations
enthalpy_air_difference = processdata(2,3) - processdata(1,3);
delta_air_water_content = processdata(3,2) - processdata(2,2);


energy_per_kg_mango = ...
    (d.delta_man_w_c/delta_air_water_content)*enthalpy_air_difference

% unsure and only for the evaporation process (maybe burning is important)
air_per_kg_mango = ...
    ((1-processdata(3,2))/delta_air_water_content)*d.delta_man_w_c

%idealer Prozess mit realen Werten braucht ca. 100g Butan pro kg Mango
%ungefähr 100m^3 Luft zur Trocknung


%% plotting psychrometric chart
load('storage/psychplot_base_axhandle.mat');

openfig('storage/psychplot_base.fig');
hold('on');
plot(processdata(:,1),processdata(:,2)*1000,'-r+');