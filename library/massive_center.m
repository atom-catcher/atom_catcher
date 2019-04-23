function [newx,newy]=massive_center(oldx,oldy,im,r)
limit=circle(r);
[av,cols,rows]=av_circle(oldx,oldy,limit,im);
[newx,newy] = centroid(cols,rows,im);