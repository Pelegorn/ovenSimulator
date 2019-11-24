function [] = drawPdf()
%DRAWPDF Summary of this function goes here
%   Detailed explanation goes here
fig = gcf;
set(fig,'Units','Inches');
pos = get(fig,'Position');
set(fig, 'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize', [pos(3), pos(4)])
print(fig, 'filename','-dpdf','-r0')
end

