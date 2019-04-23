function []=reload_data()
evalin('base','global group;global X;global d;global d;global G;global r;global type_count;global h1;global h2;global h3;global h4;global h5');
evalin('base','addpath(''library'')');
end
% copy and paste %% command to export data in the current figure
% h = gcf; %current figure handle
% axesObjs = get(h, 'Children');  %axes handles
% dataObjs = get(axesObjs, 'Children'); %handles to low-level graphics objects in axes
% objTypes = get(dataObjs, 'Type');  %type of low-level graphics object
% xdata = get(dataObjs, 'XData');  %data from low-level grahics objects
% ydata = get(dataObjs, 'YData');