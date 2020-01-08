```
Author: Mario Huegi
Institution: FHNW - University of Applied Sciences Northwestern Switzerland
Course of studies: Energy and Environmental Technologies
Module: MATLAB-Workshob
Lecturer: Prof. Dr. Norbert Hofmann
```

### Features
* Graphical interface for mango drying simulation
* Data saving formats: CSV, TXT, DAT
* Plot saving formats: PDF, PNG, JPEG

### Third-party software
* Use of CoolProp in Matlab (see [CoolProp-Website](http://www.coolprop.org/ "CoolProp-Website"), openSource alternative to [refProp](https://www.nist.gov/srd/refprop "refProp"))
* MATLAB-Toolboxes used: X-Steam, SplashScreen
* MATLAB-Toolboxes used and modified: SI Psychrometric Chart

# Mango Drying Simulator

* [General Overview](#general-overview)
* [Function description](#function-description)
  * [mangoSimulator](#mangosimulator)
  * [specificIdealConvective](#specificidealconvective)


## General Overview
This script was created within the scope of an EUT project (EUT-P3-19HS-08). The project group investigated the behaviour of mangos in different ovens. With the help of this script the ideal behaviour of a convection oven can be simulated. For the creation of the graphics X-Steam is used. Furthermore, the script can also simulate a condensation dryer, which is operated with a heat pump. The program CoolProp was used to calculate the heat pump statically.

## Function description
### mangoSimulator
This function starts the software with a splashScreen wrapper.
### specificIdealConvective
Returns output data for ideal convective processes
###inputs:
app: GUI-data variable
###outputs:
energySecondary: Secondary energy used to dry mangos
energyPrimary:   Primary energy used to dry mangos
energyButane:    Amount of Butane needed
CO2weight:       emitted CO2 due to burning butane