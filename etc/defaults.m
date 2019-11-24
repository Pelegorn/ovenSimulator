clear; clc;

%mango conditions
man_w_c_in        = 0.8;
man_w_c_out       = 0.2;
delta_man_w_c     = man_w_c_in - man_w_c_out;

%surounding air conditions
s_air_t_cels      = 30;
s_air_t_kelv      = 273.15 + s_air_t_cels;
s_air_humidity    = 0.53;

%oven settings
air_flow          = 1; %m^3/s
air_in_t_cels     = 68;
air_in_t_kelv     = 273.15 + air_in_t_cels;
air_out_t_cels    = 55;
air_out_t_kelv    = 273.15 + air_out_t_cels;

save('defaults');