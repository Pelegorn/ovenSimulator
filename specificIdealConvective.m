function [energySecondary, energyPrimary, energyButane, CO2weight] = specificIdealConvective(app)
%SPECIFOCIDEALCONVECTIVE Returns output data for ideal convective processes
%
%   energySecondary:Secondary energy used to dry mangos
%   energyPrimary:  Primary energy used to dry mangos
%   energyButane:   Amount of Butane needed
%   CO2weight:      emitted CO2 due to burning butane

    energySecondary = round(app.energy_per_kg_mango/1000); % [kJ]
    energyPrimary   = round(energySecondary*app.def.prim_fac_butane); % [kJ]
    energyButane    = round(app.energy_per_kg_mango/app.def.butane_J_per_kg, 1); % [kg]
    CO2weight       = round(app.energy_per_kg_mango/app.def.butane_J_per_kg*app.def.butane_CO2_per_kg, 2); % kg
end