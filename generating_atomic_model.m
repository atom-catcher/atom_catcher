function []=generating_atomic_model()
global G;
global X;
global d;
global h3
global group;

%% value setting
initial=10;%specify the initial point,
%check cluster in the workspace;default is 1
%% 

h3=figure;imshow(zeros(size(d)));
link=adjacency(G);
hold on,gplot(link,X,'b');

figure,plot(G)

c = conncomp(G,'Type','weak');
numberOfComponents = max(c);
cluster={};
for i=1:numberOfComponents
    cluster{i} = find(c == i);
end
assignin('base','cluster',cluster);

[dis dt pred] = bfs(adjacency(G),initial);%specify the initial point,check cluster in the workspace
A=find(dis>=0&mod(dis,2)==0);
B=find(dis>=0&mod(dis,2)~=0);
group={A,B};
figure(h3)
hold on;
style={'bo','wo','rs','kh','cs'};
for i=1:2
    for j=1:length(group{i})
        index=group{i}(j);
        plot(X(index,1),X(index,2),style{i},'MarkerSize',2);
    end
end
assignin('base','group',group);
assignin('base','h3',h3);