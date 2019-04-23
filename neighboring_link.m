function []=neighboring_link(varargin)
global X;
global d;
global h2;
global h4;
global G;
if(nargin<1)
    %% value setting
    boundary=16;%cutoff value, 
    %where the first peak ends according to the pair function
    low=10;high=15;%restriction of bonding between neighboring pairs, 
    %the range of the first peak according to the pair function
    %% 
    
    h2=figure();
    imshow(d);hold on
    scatter(X(:,1),X(:,2),'r+');
    axis equal;
    
    [idx, dist] = rangesearch(X,X,boundary);
    num=length(idx);
    len=zeros(num,1);
    for i=1:num
        len(i)=length(idx{i})-1;
    end
    [count,num_near]=hist(len,unique(len));
    figure,hist(len,unique(len))

    
    pair=[];%ready to expand the list of neighboring pairs
    for i=1:num
        if(len(i)>=1)%&&len(i)<=3
            for j=2:(len(i)+1)
                pair=[pair;[i idx{i}(j) dist{i}(j)]];
            end
        end
    end
    figure,hist(pair(:,3),1000)
    
    same_pair=[];
    for i=1:length(pair)
        if((pair(i,3)>=low)&&(pair(i,3)<=high))%set the bond length criteria
            same_pair=[same_pair;pair(i,[1 2])];
        end
    end
    
    ind=same_pair;
    x1=ind(:,1);x2=ind(:,2);
    uniqueEdgeList = unique(sort([x1,x2],2),'rows');
    G=graph(uniqueEdgeList(:,1)',uniqueEdgeList(:,2)');
    link=adjacency(G);
    
    figure; imshow(zeros(size(d)));
    hold on,gplot(link,X,'r');
    
    
    figure(h2),hold on
    gplot(link,X,'r');
    assignin('base','h2',h2)
    assignin('base','X',X)
    assignin('base','G',G)
    
else
    S=varargin{1};
    boundary=varargin{2};%defaul values
    low=varargin{3};
    high=varargin{4};%restriction of formng links between neighboring pairs
    

    h4=figure();
    imshow(d); hold on
    scatter(S(:,1),S(:,2),'r+')
    axis equal;    
    [idx, dist] = rangesearch(S,S,boundary);
    num=length(idx);
    len=zeros(num,1);
    for i=1:num
        len(i)=length(idx{i})-1;
    end
    pair=[];%ready to expand the list of neighboring pairs
    for i=1:num
        if(len(i)>=1)%&&len(i)<=3
            for j=2:(len(i)+1)
                pair=[pair;[i idx{i}(j) dist{i}(j)]];
            end
        end
    end
    
    same_pair=[];
    for i=1:length(pair)
        if((pair(i,3)>=low)&&(pair(i,3)<=high))%set the bond length criteria
            same_pair=[same_pair;pair(i,[1 2])];
        end
    end
    
    ind=same_pair;
    total=length(S);
    flag=0;
    if(~find(ind==total))
        ind=[ind;total,total];
        flag=1;
    end%in case the maximum index in S is not included in ind,add a loop in the next graph H
    x1=ind(:,1);x2=ind(:,2);
    uniqueEdgeList = unique(sort([x1,x2],2),'rows');
    H=graph(uniqueEdgeList(:,1)',uniqueEdgeList(:,2)');
    if(flag==1)
        H=rmedge(H,total,total);%remove the loop generated in the previous step if it exist
    end
    link=adjacency(H);
    
    gplot(link,S,'r');

    assignin('base','h4',h4)
    assignin('base','H',H)
    assignin('base','ind',ind)
end
