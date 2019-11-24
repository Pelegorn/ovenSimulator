clear; clc;
%% Input data
%mango conditions
mango_water_content_in = 0.8;
mango_water_content_out = 0.2;
delta_mango_water_content = mango_water_content_in - mango_water_content_out;

%surounding air conditions
surrounding_air_t_celsius = 30;
surrounding_air_t_kelvin  = 273.15 + surrounding_air_t_celsius;
surrounding_air_moisture_content = 0.53;
pressure = 1.013E5;

%oven settings
air_flow_oven = 1;
drying_air_in_t_celsius = 68;
drying_air_in_t_kelvin  = 273.15 + drying_air_in_t_celsius;
drying_air_out_t_celsius = 55;
drying_air_out_t_kelvin  = 273.15 + drying_air_in_t_celsius;

%% Calculation
%calculations are based on temperature in (Tdb), relative humidity of
%the air in % (phi) and absolut humidity of the air in kg/kg (w)
addpath('psychrometric');

% intitial situation
[Tdb, w, ~, h, ~, ~, ~] = ...
Psychrometricsnew('Tdb', surrounding_air_t_celsius, ...
                  'phi', surrounding_air_moisture_content*100);
processdata = [Tdb, w, h];

% heating up the air
[Tdb, w, ~, h, ~, ~, ~] = ...
Psychrometricsnew('Tdb', drying_air_in_t_celsius, ...
                  'w', w);
processdata = [processdata; Tdb, w, h];

% intake of water
[Tdb, w, ~, h, ~, ~, ~] = ...
Psychrometricsnew('Tdb', drying_air_out_t_celsius, ...
                  'h', h);
processdata = [processdata; Tdb, w, h];

clear('Tdb', 'w', 'h'); %a little bit of garbage handling

% numeric calculations
enthalpy_air_difference = processdata(2,3) - processdata(1,3);
delta_air_water_content = processdata(3,2) - processdata(2,2);


energy_per_kg_mango = ...
    (delta_mango_water_content/delta_air_water_content)*enthalpy_air_difference

% unsure and only for the evaporation process (maybe burning is important)
air_per_kg_mango = ...
    ((1-processdata(3,2))/delta_air_water_content)*delta_mango_water_content

%idealer Prozess mit realen Werten braucht ca. 100g Butan pro kg Mango
%ungefähr 100m^3 Luft zur Trocknung


%% plotting psychrometric chart
load('storage/psychplot_base_axhandle.mat');

openfig('storage/psychplot_base.fig');
hold('on');
plot(processdata(:,1),processdata(:,2)*1000,'-r+');