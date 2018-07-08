x=1:10;
exp=out(:,1);
ch='ATEDVQDPRI';
fun=@(x)fit3a(x,exp,ch);
lb=ones(1,10)*0;
ub=ones(1,10)*1;

opts = gaoptimset(@ga);
opts = gaoptimset(opts,'PlotFcns',{@gaplotbestf,@gaplotstopping});
opts = gaoptimset(opts,'Generations',50,'StallGenLimit', 100);
opts = gaoptimset(opts,'PopulationSize',400);
[x,best] = ga(fun,10,[],[],[],[],lb,ub,[],opts) ;

[~,ind]=sort(x);
str=ch(ind)