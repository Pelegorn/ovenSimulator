function [] = drawPlot(app)
%DRAWPLOT plots the input UIFigure to pdf, png or jpeg
%   The plotted pdf are usable as scalable vector graphics e.g. in latex
%   jpeg and png are not scalable and worse in quality

% user input
filter = {'*.pdf';'*.png';'*.jpeg'};
[name, path, typeRaw] = uiputfile(filter, 'save_plot', 'mango_drying_plot');

%0 = action cancelled by user
if name == 0
    logFileGenerator('plot creation aborted');
    msgbox('Operation cancelled');
    return
end

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
            
switch typeRaw
    case 1 % == '.pdf'
        drawPdf(fig, path, name);
    case 2 % == '.png'
        saveas(fig, fullfile(path, name), 'png');
    case 3 % == '.jpeg'
        saveas(fig, fullfile(path, name), 'jpeg');
    otherwise % == '.pdf'
        drawPdf(fig, path, name);
end
delete(fig);

% confirmation of success
logFileGenerator('successful plot export');
msgbox('Saving completed');
end