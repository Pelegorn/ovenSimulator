function [energy_per_kg_mango, air_per_kg_mango, COP_heating] = ...
    idealCondensation(temp_cooling, temp_heating, superheat, ...
    m_hum_in, m_hum_out, air_hum, UIaxes)
%IDEALCONDENSATION calculates an ideal condensation dryer (heat pump)
%   This function uses coolProp, make sure to have coolProp installed in
%   an MATLAB compatible Phython version (in Phython use: pip install
%   coolProp)
%   For more information, see <a href="coolProp: 
%   web('http://www.coolprop.org/')">the coolProp Web site</a>.
%   
%   inputs:
%   temp_cooling:   low temperature of the heat pump
%   temp_heating:   high temperature of the heat pump
%   superheat:      amount of degrees to overheat (compressor protection)
%   m_hum_in:       humidity of raw-mango (in percent)
%   m_hum_out:      humidity of dry-mango (in percent)
%   air_hum:        humidity of air at the coldest point (in percent)
%   UIaxes:         GUI-Axes File to plot psychrometric chart
%   
%   outputs:
%   energy_per_kg_mango:    amount of energy used by ideal condesation
%                           dryer
%   air_per_kg_mango:       amount of air used, to transport the needed
%                           energy (can be used to calculate a fan)
%   COP_heating:            Coefficient of Power of the heating process in
%                           the heat pump

%% heat pump calculation
addpath('etc/coolPropWrapper');

%check User Input
if temp_heating-temp_cooling < 20
    logFileGenerator('Wrong User Input in idealCondensation');
    msgbox('Heating and cooling difference must be more than 20° Celsius!');
    energy_per_kg_mango = 0; 
    air_per_kg_mango    = 0;
    return
elseif m_hum_in <= m_hum_out
    logFileGenerator('Wrong User Input in idealCondensation');
    msgbox('Humidity_in must be higher than Humidity_out!');
    energy_per_kg_mango = 0; 
    air_per_kg_mango    = 0;
    return
end

% Saturated vapour enthalpy in
enthalpy_mid1 = PropsSI('H', 'T', 273.15+temp_cooling-superheat, 'Q', 1, 'R134a');
p_low         = PropsSI('P', 'T', 273.15+temp_cooling-superheat, 'Q', 1, 'R134a');
% Overheating the vapour
enthalpy_mid2 = PropsSI('H', 'T', 273.15+temp_cooling, 'P', p_low, 'R134a');
enthropy      = PropsSI('S', 'T', 273.15+temp_cooling, 'P', p_low, 'R134a');
% Compression and heating
enthalpy_high = PropsSI('H', 'T', 273.15+temp_heating, 'S', enthropy, 'R134a');
p_high        = PropsSI('P', 'T', 273.15+temp_heating, 'S', enthropy, 'R134a');
% evaporative cooling
enthalpy_low1 = PropsSI('H', 'P', p_high, 'Q', 0, 'R134a');
temp_drying   = PropsSI('T', 'P', p_high, 'Q', 0, 'R134a')-273.15;
% undercooling the liquid
enthalpy_low2 = PropsSI('H', 'P', p_high, 'T', 273.15+temp_drying-superheat, 'R134a');

% compression energy
input_Energy           = enthalpy_high-enthalpy_mid2;
enthalpy_drying        = enthalpy_high-enthalpy_low2;
enthalpy_cooling       = enthalpy_mid1-enthalpy_low2;
COP_heating = enthalpy_drying/input_Energy;
COP_cooling = enthalpy_cooling/input_Energy;


%% psychrometrics calculation
%calculations are based on temperature in (Tdb), relative humidity of
%the air in % (phi) and absolut humidity of the air in kg/kg (w)
addpath('psychrometric');

% intitial situation (Point 1)
[Tdb, w, phi, h, ~, ~, ~] = ...
    Psychrometricsnew('Tdb', temp_cooling, 'phi', air_hum);
processdata = [Tdb, w, h, phi];
% heating up the air (Point 2)
[Tdb, w, phi, h, ~, ~, ~] = ...
    Psychrometricsnew('Tdb', temp_drying, 'w', w);
processdata = [processdata; Tdb, w, h, phi];
% temp_midle calc (by phi ratio) (Point 3)
[Tdb, w, phi, h, ~, ~, Twb] = ...
    Psychrometricsnew('Tdb', temp_cooling+(temp_drying-temp_cooling)/2, 'h', h);
processdata = [processdata; Tdb, w, h, phi];

clear('Tdb', 'phi', 'w', 'h'); %a little bit of garbage handling


%% numeric calculations
enthalpy_air_difference = processdata(2,3) - processdata(1,3);
delta_air_water_content = processdata(3,2) - processdata(2,2);
delta_m_hum = (m_hum_in-m_hum_out)/100;

energy_per_kg_mango = ...
    (delta_m_hum/delta_air_water_content)*enthalpy_air_difference/ ...
    COP_heating;

air_per_kg_mango = ...
    ((1-processdata(3,2))/delta_air_water_content)*delta_m_hum;

%% generating plot
plot(UIaxes, [processdata(:,1); processdata(1,1)], ...
    [processdata(:,2); processdata(1,2)]*1000, '-r+');

%% plotting psychrometric chart (only for testing function!!!)
%load('storage/psychplot_base_axhandle.mat');

%openfig('storage/psychplot_base.fig');
%hold('on');
%plot(processdata(:,1),processdata(:,2)*1000,'-r+');
end