function [energySecondary, energyPrimary, energyElectricity, CO2weight] = specificIdealCondensation(app)
%SPECIFOCIDEALCONVECTIVE Returns output data for ideal condensation
%drying processes
%
%   energySecondary:    Secondary energy used to dry mangos
%   energyPrimary:      Primary energy used to dry mangos
%   energyElectricity:  Current needed in kWh
%   CO2weight:          emitted CO2 due to burning butane

    energySecondary   = round(app.energy_per_kg_mango/1000); % [kJ]
    energyPrimary     = round(energySecondary*app.def.prim_fac_electricity); % [kJ]
    energyElectricity = round(app.energy_per_kg_mango/3.6E6, 1); % [kWh]
    CO2weight         = round(app.energy_per_kg_mango*app.def.prim_fac_electricity*app.def.electricity_CO2_per_J, 2); % kg
end

