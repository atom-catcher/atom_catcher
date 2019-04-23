function []=atom_finder()
evalin('base','clear,clc');
evalin('base','addpath(''library'')');
[FileName,PathName]=uigetfile('.dat','Select the DAT-file');
prompt={'Enter image size sx:',...
        'sy: ',...
        ['Input Format No.:                                              ';...
         '1:  int8     3:  int16     5:  int32    7: float      9:  int64';...
         '2: uint8    4: uint16     6: uint32    8: double    10: uint64 ';] };
name='Input Image Info.';
numlines=1;
defaultanswer={'1024','1024','7'};
answer=inputdlg(prompt,name,numlines,defaultanswer);
sx=str2num(answer{1});sy=str2num(answer{2});imageformat=str2num(answer{3});
file=strcat(PathName,FileName);
fid=fopen(file,'r');
strformat=ImageFormatTransform(imageformat);
I=fread(fid,[sx,sy],strformat);
fclose(fid);
I=I';%original intensity
intensity=normalize(I);
low_in=0;high_in=1;
low_out=0;high_out=1;
gamma=1;
image=imadjust(intensity,[low_in,high_in],[low_out,high_out],gamma);

global h1;
S.intensity=intensity;
h1=figure('units','pixels',...
              'position',[20 50 600 600],...
              'name','atom_finder',...
              'numbertitle','off',...
              'resize','off');
pb = uicontrol('style','push',...
                 'units','pixels',...
                 'position',[50 530 100 30],...
                 'fontsize',14,...
                 'string','find atom',...
                 'callback',{@pb_call,S});
ax = axes('units','pixels',...
            'position',[10 10 512 512]);
figure(h1),imshow(image);
assignin('base','h1',h1);


function [] = pb_call(varargin)
global X;
global d;
prompt={'median filter size:',...
        'gaussian filter size: ','gaussian filter sigma',...
        'threshold','edge pixels'};
name='Set Filter Info.';
numlines=1;
defaultanswer={'3','9','2','0.03','10'};%default values of filter and threshold
answer=inputdlg(prompt,name,numlines,defaultanswer);
ms=str2num(answer{1});gs=str2num(answer{2});sigma=str2num(answer{3}); threshold=str2num(answer{4});edge=str2num(answer{5});

S = varargin{3}; 
d=S.intensity;
g=fspecial('gaussian',gs,sigma);%gaussian size and sigma%Gaussian_filter(9,2)
p=FastPeakFind(d,threshold,g,edge,1,ms);
figure();
imagesc(d); hold on
scatter(p(1:2:end),p(2:2:end),'r+');
axis equal;
X=[p(1:2:end),p(2:2:end)];
assignin('base','X',X);
assignin('base','d',d);
colormap(jet);
[corrfun r rw]=twopointcorr(X(:,1),X(:,2),1);
figure,plot(corrfun(1:50));%check the correlation function