x=1:10;
exp=mz;
rng(1);
for i=1:size(lbs,1)
%for i=75:79
ch=lbs{i};
fun=@(x)fit3a(x,exp,ch);
lb=ones(1,10)*0;
ub=ones(1,10)*1;

opts = gaoptimset(@ga);
%opts = gaoptimset(opts,'PlotFcns',{@gaplotbestf,@gaplotstopping});
opts = gaoptimset(opts,'Generations',30,'StallGenLimit', 100);
opts = gaoptimset(opts,'PopulationSize',500);
[x,score] = ga(fun,10,[],[],[],[],lb,ub,[],opts) ;
[i,score]
best(i,1)=score;
[~,ind]=sort(x);
str{i}=ch(ind);
end