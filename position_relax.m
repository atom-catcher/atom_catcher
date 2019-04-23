function []=position_relax()
global X;
global d;
global r;
%% value setting
selection=2%selection:1 method massive center;
           %selection:2 method gaussian fitting.
%% 
for m=1:length(X)
    oldx=int32(X(m,1));
    oldy=int32(X(m,2));
    if selection==1
        iteration=10%iteration time of finding massive center
        for n=1:iteration
        [newx,newy]=massive_center(oldx,oldy,d,r);
        oldx=newx;oldy=newy;
        end
    elseif selection==2
        mag=1.2%magnify the range of fitting area(compared to the atom size)
        range=int32(r*mag)
        [Xm,Ym] = meshgrid(-range+oldx:range+oldx,-range+oldy:range+oldy);
        xdata = zeros(size(Xm,1),size(Ym,2),2);
        xdata(:,:,1) = Xm;
        xdata(:,:,2) = Ym;
        Z=d(-range+oldy:range+oldy,-range+oldx:range+oldx);
        x0 = [0.5,oldx,range/2,oldy,range/2,0]; %Inital guess parameters %[Amp,xo,wx,yo,wy,fi]
        lb = [0,-range+oldx,0,-range+oldy,0,-pi/4];
        ub = [1,range+oldx,range^2,range+oldy,range^2,pi/4];
        x0=double(x0);lb=double(lb);ub=double(ub);
        [x,resnorm,residual,exitflag] = lsqcurvefit(@D2GaussFunctionRot,x0,xdata,Z,lb,ub);
        oldx=x(2);oldy=x(4);
    end
    X(m,1)=oldx;
    X(m,2)=oldy;
end