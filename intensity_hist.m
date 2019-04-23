function []=intensity_hist()
global group;
global d;
global X;
global r;

%% value setting
r=4;%radius of the area averaged specified/pixel
%% 

name={'A','B'};
for j=1:length(group)
    type=group{j};
    x=X(type,1);y=X(type,2);
    len=length(x);

    filter_av=filterM(r);
    num=sum(filter_av(:));
    avI=size(x);
    for i=1:len
        avI(i)=sum(sum(filter_av.*d(y(i)-r:y(i)+r,x(i)-r:x(i)+r)));
    end
    avI=avI/num;
    figure;
    [f,xx]=hist(avI(:),100);
    bar(xx,f/trapz(xx,f))
    xlim([0 1])

    
    BIC = zeros(1,5);
    GMModels = cell(1,5);
    options = statset('Display','final','MaxIter',500);
    for k = 1:5
        GMModels{k} = gmdistribution.fit(avI',k,'Replicates',10,'Options',options,'Regularize',1e-6);
        BIC(k)= GMModels{k}.BIC;
    end
    
    [minBIC,numComponents] = min(BIC);
    
    BestModel = GMModels{numComponents};
    
    xx=[0:0.01:1]';Y=pdf(BestModel,xx);
    figure,plot(xx,Y,'r','Linewidth',2);
    hold on;
    obj=BestModel;
    for i=1:obj.NComponents
        yy=obj.PComponents(i)*normpdf(xx,obj.mu(i),sqrt(obj.Sigma(i)));
        plot(xx,yy,'g','Linewidth',2);
    end
    assignin('base',name{j},obj)
end
evalin('base','A,B');
    