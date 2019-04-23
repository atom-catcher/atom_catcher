function y=normalize(x)
xmin=min(x(:));xmax=max(x(:));
y=(x-xmin)./(xmax-xmin);