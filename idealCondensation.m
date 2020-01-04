function [] = idealCondensation()
%IDEALCONDENSATION Summary of this function goes here
%   Detailed explanation goes here

addpath('etc/coolPropWrapper');

superheat = 3;
Tin = 30; Tout = 80;

% Saturated vapour enthalpy in
enthalpy_mid1 = PropsSI('H', 'T', 273.15+Tin-superheat, 'Q', 1, 'R134a');
p_low         = PropsSI('P', 'T', 273.15+Tin-superheat, 'Q', 1, 'R134a');
% Overheating the vapour
enthalpy_mid2 = PropsSI('H', 'T', 273.15+Tin, 'P', p_low, 'R134a');
enthropy      = PropsSI('S', 'T', 273.15+Tin, 'P', p_low, 'R134a');
% Compression and heating
enthalpy_high = PropsSI('H', 'T', 273.15+Tout, 'S', enthropy, 'R134a');
p_high        = PropsSI('P', 'T', 273.15+Tout, 'S', enthropy, 'R134a');
% evaporative cooling
enthalpy_low1 = PropsSI('H', 'P', p_high, 'Q', 0, 'R134a');
temp_low1     = PropsSI('T', 'P', p_high, 'Q', 0, 'R134a')-273.15;
% undercooling the liquid
enthalpy_low2 = PropsSI('H', 'P', p_high, 'T', 273.15+temp_low1-superheat, 'R134a');


% compression energy
input_Energy  = enthalpy_high-enthalpy_mid2;
drying_Energy = enthalpy_high-enthalpy_low2;
COP = drying_Energy/input_Energy
end

