function M=filterM(radius)
%atom filter
limit=circle(radius);
len=length(limit);
M=zeros(len*2-1);
count=0;row=len;col=len;
for i=-limit(1):limit(1)
    M(row+i,col)=1;
    count=count+1;
end
for j=2:len
    for i=-limit(j):limit(j)
        M(row+i,col+j-1)=1;
        M(row+i,col-j+1)=1;
        count=count+2;
    end
end
M=M/count;
end