function []=position_relax()
global X;
global d;
global r;
%% value setting
selection=2%selection:1 method massive center;
           %selection:2 method gaussian fitting.
%% 
tic
xx=X(:,1);yy=X(:,2);dd=d;rr=r;
parfor m=1:length(xx)
    oldx=int32(xx(m));
    oldy=int32(yy(m));
    mag=1.2%magnify the range of fitting area(compared to the atom size)
    range=int32(rr*mag)
    [Xm,Ym] = meshgrid(-range+oldx:range+oldx,-range+oldy:range+oldy);
    xdata = zeros(size(Xm,1),size(Ym,2),2);
    xdata(:,:,1) = Xm;
    xdata(:,:,2) = Ym;
    Z=dd(-range+oldy:range+oldy,-range+oldx:range+oldx);
    x0 = [0.5,oldx,range/2,oldy,range/2,0]; %Inital guess parameters %[Amp,xo,wx,yo,wy,fi]
    lb = [0,-range+oldx,0,-range+oldy,0,-pi/4];
    ub = [1,range+oldx,range^2,range+oldy,range^2,pi/4];
    x0=double(x0);lb=double(lb);ub=double(ub);
    [x,resnorm,residual,exitflag] = lsqcurvefit(@D2GaussFunctionRot,x0,xdata,Z,lb,ub);
        oldx=x(2);oldy=x(4);
    xx(m)=oldx;
    yy(m)=oldy;
end
for m=1:length(xx)
    X(m,1)=xx(m);
    X(m,2)=yy(m);
end
toc