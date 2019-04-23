function limit=circle(r)%Midpoint circle algorithm
%CIRCLE Summary of this function goes here
%   Detailed explanation goes here
[xc,yc]=getmidpointcircle(0,0,r);
l=length(xc)/4;
for i=l:-1:1
    limit(xc(i)+1)=yc(i);
end
end 