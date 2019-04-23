function [cc,cr] = centroid(cols,rows,intensity)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
len=length(cols);
I=0;cc=0;cr=0;
for i=1:len
    cc=cc+intensity(rows(i),cols(i))*cols(i);
    cr=cr+intensity(rows(i),cols(i))*rows(i);
    I=I+intensity(rows(i),cols(i));
end
cc=int32(cc/I);
cr=int32(cr/I);
end

