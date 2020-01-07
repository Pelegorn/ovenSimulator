function drawPdf(fig, path, name)
%DRAWPDF generates cutted pdf out of a MATLAB figure

set(fig,'Units', 'centimeters');
pos = get(fig,'Position');
set(fig, 'PaperPositionMode','Auto','PaperUnits','centimeters','PaperSize', [pos(3), pos(4)])
print(fig, fullfile(path, name),'-dpdf','-r0')
end

