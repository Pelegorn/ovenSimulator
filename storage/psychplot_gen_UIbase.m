addpath('../psychrometric/');
%bla. = psychplotting(0,90,0,36); %TDB 10-40C and SH 6-30 g/kg
fig = openfig('psychplot_base.fig', 'invisible');
ax = findobj(fig,'Type','Axes');  % assuming 1 and only 1 handle is returned