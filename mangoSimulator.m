function mangoSimulator()
%MANGOSIMULATOR this function starts the software with splashScreen wrapper
%   Descritption:   GUI for simulation of drying mangos
%   Author:         Mario Hügi
%   Date:           05. January 2020

% splash screen startup and configuration
s = SplashScreen('SplashScreen', 'img/mango.png');
s.addText( 30, 50, 'Mango Drying Simulator', 'FontSize', 40, 'Color', [0 0 0.6] )
s.addText( 30, 80, 'v1.1', 'FontSize', 20, 'Color', [0.2 0.2 0.5] )
s.addText( 30, 380, 'Loading...', 'FontSize', 20, 'Color', 'white' )

% starting GUI
GUI;

% garbage handling
delete(s);
end