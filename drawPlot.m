function [] = drawPlot(app, name, path, type)
%DRAWPLOT plots the input UIFigure to pdf, png or jpeg
%   The plotted pdf are usable as scalable vector graphics e.g. in latex
%   jpeg and png are not scalable and worse in quality

%temp figure with axes
fig = figure;
fig.Visible = 'off';
figAxes = axes(fig);
%copy all UIAxes children and properties            
allChildren = app.UIAxes.XAxis.Parent.Children;
copyobj(allChildren, figAxes)
figAxes.XLim = app.UIAxes.XLim;
figAxes.YLim = app.UIAxes.YLim;
figAxes.ZLim = app.UIAxes.ZLim;
figAxes.DataAspectRatio = app.UIAxes.DataAspectRatio;

%saving of pdf (+ cutting to size)
if type == "pdf"
    set(fig,'Units', 'centimeters');
    pos = get(fig,'Position');
    set(fig, 'PaperPositionMode','Auto','PaperUnits','centimeters','PaperSize', [pos(3), pos(4)])
    print(fig, fullfile(path, name),'-dpdf','-r0')
%saving as png or jpeg
else
    saveas(fig, fullfile(path, name), type);
end

delete(fig);
end