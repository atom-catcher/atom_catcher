function []=alloy_degree()
global type_count

evalin('base','save(''Sub'',''Sub'')');
Sub=load('Sub.mat');
S=Sub.Sub;
%% value setting
neighboring_link(S,26,16,25);%restriction of formng links 
%between neighboring pairs, 
%boundary, low and high respectively
%to generate the network H for further processings
%% 
evalin('base','save(''H'',''H'')');
H=load('H.mat');
H=H.H;

for i=1:numnodes(H)
    nei{i}=neighbors(H,i);
end

nei_count=zeros(length(nei),type_count+1);%the first column is the type of the atom itself
for i=1:length(nei)
    if(isempty(nei(i)))
        nei_count(i,1)=S(i,3);
        nei_count(i,2)=6;
    else
        nei_count(i,1)=S(i,3);
        if(length(nei{i})>4&&length(nei{i})<7)%exclude edge sites and those with too many links && notice that if 
                                              %the row in nei_count are all
                                              %zero, it is invalid site;
                                              %however this error might be
                                              %large if the chosen area is
                                              %small!
                                             
            for j=1:length(nei{i})
                nei_count(i,S(nei{i}(j),3)+1)=nei_count(i,S(nei{i}(j),3)+1)+1;
            end
            nei_count(i,2)=nei_count(i,2)+6-length(nei{i});%if there is one missing link, assign it a vacancy
        end      
        
    end
end
temp=[];
for i=1:length(nei)
    if(sum(nei_count(i,2:end))~=0)
        temp=[temp;nei_count(i,:)];
    end
end
nei_count=temp;
index_type2=find(nei_count(:,1)==2);
index_type3=find(nei_count(:,1)==3);
J23=(sum(nei_count(index_type2,3+1))/(6*length(index_type2)))/(length(index_type3)/(length(index_type2)+length(index_type3)))%type3 around type2
J32=(sum(nei_count(index_type3,2+1))/(6*length(index_type3)))/(length(index_type2)/(length(index_type2)+length(index_type3)))
assignin('base','nei',nei)
assignin('base','nei_count',nei_count)

evalin('base','save(strcat(''data'',cell2mat(strsplit(datestr(datetime(''now'')),'':''))))');%save all varibles in the workspace


% for i=1:length(nei)
%     if(isempty(nei{i}))
%         i
%     end
% end