function exportCSV(app)
%EXPORTCSV exports all input and output data to csv, txt or dat
%   User can choose path and filename in a opening prompt

% user input
filter = {'*.csv'; '*.txt'; '*.dat'};
[name, path] = uiputfile(filter, 'save_csv', 'mango_drying_data');

%0 = action cancelled by user
if name == 0
    logFileGenerator('csv export aborted');
    msgbox('Operation cancelled');
    return
end

% saving of data to choosen format
type = 'idealConvective';
switch type
    case 'idealConvective'
        ovenType                            = "ideal_Convective";
        mangoHumidityIn_percent             = app.humidity_inSpinner.Value;
        mangoHumidityOut_percent            = app.humidity_outSpinner.Value;
        surroundingAirTemperature_celsius   = app.temperature_airCSpinner.Value; 
        surroundingAirHumidity_percent      = app.humidity_airSpinner.Value;
        temperatureIn_celsius               = app.temperature_inCSpinner.Value;
        temperatureOut_celsius              = app.temperature_outCSpinner.Value;
        
        [energySecondary, energyPrimary, energyButane, CO2weight] = specificIdealConvective(app);
        secondaryEnergy_kJ                  = energySecondary;
        primaryEnergy_kJ                    = energyPrimary;
        Butane_kg                           = energyButane;
        CO2emissions_kg                     = CO2weight;
        airTotal_m3                         = round(app.air_per_kg_mango);        
        
        T = table(ovenType, mangoHumidityIn_percent, mangoHumidityOut_percent, ...
            surroundingAirTemperature_celsius, surroundingAirHumidity_percent, ...
            temperatureIn_celsius, temperatureOut_celsius, secondaryEnergy_kJ, ...
            primaryEnergy_kJ, Butane_kg, CO2emissions_kg, airTotal_m3);
        writetable(T, fullfile(path, name));
    case 'idealCondensation'
        ovenType                            = "ideal_Condensation";
        mangoHumidityIn_percent             = app.humidity_inSpinner.Value;
        mangoHumidityOut_percent            = app.humidity_outSpinner.Value; 
        surroundingAirHumidity_percent      = app.humidity_airSpinner.Value;
        temperatureHeating_celsius          = app.temperature_inCSpinner.Value;
        temperatureCooling_celsius          = app.temperature_outCSpinner.Value;
        temperatureSuperheating_Kelvin      = app.superheatingCSpinner.Value;
        
        [energySecondary, energyPrimary, energyButane, CO2weight] = specificIdealConvective(app);
        secondaryEnergy_kJ                  = energySecondary;
        primaryEnergy_kJ                    = energyPrimary;
        Electricity_kWh                      = energyButane;
        CO2emissions_kg                     = CO2weight;
        airTotal_m3                         = round(app.air_per_kg_mango);        
        
        T = table(ovenType, mangoHumidityIn_percent, mangoHumidityOut_percent, ...
            surroundingAirHumidity_percent, temperatureHeating_celsius, ...
            temperatureCooling_celsius, temperatureSuperheating_Kelvin, ...
            secondaryEnergy_kJ, primaryEnergy_kJ, Electricity_kWh, CO2emissions_kg, airTotal_m3);
        writetable(T, fullfile(path, name));
end

% confirmation of success
logFileGenerator('successful csv export');
msgbox('Saving completed');
end