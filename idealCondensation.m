function [] = idealCondensation()
%IDEALCONDENSATION Summary of this function goes here
%   Detailed explanation goes here

%% heat pump calculation
addpath('etc/coolPropWrapper');

superheat = 3;
temp_cooling = 30; Tout = 65;
delta_T_evaporator = 10;

% Saturated vapour enthalpy in
enthalpy_mid1 = PropsSI('H', 'T', 273.15+temp_cooling-superheat, 'Q', 1, 'R134a');
p_low         = PropsSI('P', 'T', 273.15+temp_cooling-superheat, 'Q', 1, 'R134a');
% Overheating the vapour
enthalpy_mid2 = PropsSI('H', 'T', 273.15+temp_cooling, 'P', p_low, 'R134a');
enthropy      = PropsSI('S', 'T', 273.15+temp_cooling, 'P', p_low, 'R134a');
% Compression and heating
enthalpy_high = PropsSI('H', 'T', 273.15+Tout, 'S', enthropy, 'R134a');
p_high        = PropsSI('P', 'T', 273.15+Tout, 'S', enthropy, 'R134a');
% evaporative cooling
enthalpy_low1 = PropsSI('H', 'P', p_high, 'Q', 0, 'R134a');
temp_drying   = PropsSI('T', 'P', p_high, 'Q', 0, 'R134a')-273.15;
% undercooling the liquid
enthalpy_low2 = PropsSI('H', 'P', p_high, 'T', 273.15+temp_drying-superheat, 'R134a');

% compression energy
input_Energy           = enthalpy_high-enthalpy_mid2;
enthalpy_drying        = enthalpy_high-enthalpy_low2;
enthalpy_cooling       = enthalpy_mid1-enthalpy_low2;
enthalpy_ratio_cooling = enthalpy_cooling/(enthalpy_cooling+enthalpy_drying);
%COP_heating = enthalpy_drying/input_Energy;
%COP_cooling = enthalpy_cooling/input_Energy;


%% psychrometrics calculation
%calculations are based on temperature in (Tdb), relative humidity of
%the air in % (phi) and absolut humidity of the air in kg/kg (w)
addpath('psychrometric');

%temp_drying; enthalpy_drying
%temp_cooling; enthalpy_cooling
%test data
m_hum_in = 80; m_hum_out = 20;

s_air_hum = 90; %muss ausprobiert werden

% intitial situation (Point 1)
[Tdb, w, phi, h, ~, ~, ~] = ...
    Psychrometricsnew('Tdb', temp_cooling, 'phi', s_air_hum);
processdata = [Tdb, w, h, phi];
% heating up the air (Point 2)
[Tdb, w, phi, h, ~, ~, ~] = ...
    Psychrometricsnew('Tdb', temp_drying, 'w', w);
processdata = [processdata; Tdb, w, h, phi];
% temp_midle calc (by phi ratio) (Point 3)
phi_ratio = processdata(2,4) - (processdata(2,4)-processdata(1,4))/2;
[Tdb, w, phi, h, ~, ~, Twb] = ...
    Psychrometricsnew('Tdb', temp_cooling+delta_T_evaporator, 'h', h);
processdata = [processdata; Tdb, w, h, phi];


clear('Tdb', 'phi', 'w', 'h'); %a little bit of garbage handling

% numeric calculations
enthalpy_air_difference = processdata(2,3) - processdata(1,3);
delta_air_water_content = processdata(3,2) - processdata(2,2);
delta_m_hum = (m_hum_in-m_hum_out)/100;

% wrong calculation!!!!!!!!
energy_per_kg_mango = ...
    (delta_m_hum/delta_air_water_content)*enthalpy_air_difference;

%% plotting psychrometric chart
%load('storage/psychplot_base_axhandle.mat');

openfig('storage/psychplot_base.fig');
hold('on');
plot(processdata(:,1),processdata(:,2)*1000,'-r+');
end