function []=add_delete()
global h2;
global X
figure(h2),hold on;
while(1)% used to guarantine repeative measurements
    [x(1),y(1),key]=ginput(1);%x(1) and y(1) is used to record the position of single mouse click event, key record whether it is left,center and right for 1, 2 and 3 respectively
    if(key==2)
        break;
    end
    if(key==1)
        plot(x(1),y(1),'+','MarkerSize',10,'Color','r');
        X=[X;[x(1),y(1)]];
    end
    if(key==3)
        del_id=knnsearch(X,[x(1),y(1)],'K',1);
        plot(X(del_id,1),X(del_id,2),'o','MarkerSize',10,'Color','w');
        X(del_id,:)=[];
        
    end
end
assignin('base','X',X)
assignin('base','h2',h2)