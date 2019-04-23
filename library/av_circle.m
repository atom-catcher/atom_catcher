function [av,cols,rows]=av_circle(col,row,limit,intensity)%注意行列与实际的x，y轴的关系,x是row
len=length(limit);
count=0;I=0;
for i=-limit(1):limit(1)
    I=I+intensity(row+i,col);
    cols(count+1)=col;
    rows(count+1)=row+i;
    count=count+1;
end
for j=2:len
    for i=-limit(j):limit(j)
        I=I+intensity(row+i,col+j-1)+intensity(row+i,col-j+1);
        cols(count+1)=col+j-1;
        rows(count+1)=row+i;
        cols(count+2)=col-j+1;
        rows(count+2)=row+i;
        count=count+2;
    end
end
av=I/count;
end

       

% void drawcircle(int x0, int y0, int radius)%Midpoint circle algorithm
% {
%     int x = radius;
%     int y = 0;
%     int err = 0;
% 
%     while (x >= y)
%     {
%         putpixel(x0 + x, y0 + y);
%         putpixel(x0 + y, y0 + x);
%         putpixel(x0 - y, y0 + x);
%         putpixel(x0 - x, y0 + y);
%         putpixel(x0 - x, y0 - y);
%         putpixel(x0 - y, y0 - x);
%         putpixel(x0 + y, y0 - x);
%         putpixel(x0 + x, y0 - y);
% 
%         y += 1;
%         err += 1 + 2*y;
%         if (2*(err-x) + 1 > 0)
%         {
%             x -= 1;
%             err += 1 - 2*x;
%         }
%     }
% }