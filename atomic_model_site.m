function []=atomic_model_site()
global X;
global d;
global h5;
global group;
global r;
global type_count
Sub=[];
%% value setting
j=2;%specify the site you're interested in, 
%switch between site 1 and 2;
seperation=[0 0.12 0.34 0.55 1];%specify the intensity range 
%for the different atoms on this site(including vacancy),
%here 4 types on this site;
%% 

low=seperation(1:end-1);
high=seperation(2:end);
type_count=length(seperation)-1;
style={'wo','yo','bo','po'};
atom_style=[1,2,3,4];
type=group{j};
x=X(type,1);y=X(type,2);
filter_av=filterM(r);
num=sum(filter_av(:));
avI=size(x);
for i=1:length(x)
    avI(i)=sum(sum(filter_av.*d(y(i)-r:y(i)+r,x(i)-r:x(i)+r)));
end
avI=avI/num;
atom=zeros(length(X),1);%initialize atom
for i=1:length(avI)
    atom(type(i))=find((avI(i)>=low).*(avI(i)<=high));%seperate atoms into several types,here 4 types
end
for i=1:length(X)
    if(atom(i)>0)%considering all types of atoms specified in the beginning of this function
        Sub=[Sub;X(i,:),atom(i)];%atom(i)=0 means the atom is not on the interested site, therefore not in consideration
    end
end
[corrfun rr rw]=twopointcorr(Sub(:,1),Sub(:,2),1);
figure,plot(corrfun(1:50));%check the correlation function

h5=figure();
imshow(d);hold on;
color={'w','y','g','b','p'};
for i=1:type_count
    index=find(Sub(:,3)==i);
    scatter(Sub(index,1),Sub(index,2),'o',color{i});
end


assignin('base','atom',atom);
assignin('base','Sub',Sub);
assignin('base','type_count',type_count);
assignin('base','h5',h5);

%evalin('base','save(strcat(''data'',cell2mat(strsplit(datestr(datetime(''now'')),'':''))))');
