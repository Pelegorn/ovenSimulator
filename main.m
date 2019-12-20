s = SplashScreen('SplashScreen', 'img/mango.png');
s.addText( 30, 50, 'Mango Drying Simulator', 'FontSize', 40, 'Color', [0 0 0.6] )
s.addText( 30, 80, 'v1.0 (nightly)', 'FontSize', 20, 'Color', [0.2 0.2 0.5] )
s.addText( 30, 380, 'Loading...', 'FontSize', 20, 'Color', 'white' )
GUI;
delete(s);