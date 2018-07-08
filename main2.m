x=1:10;
exp=out(:,1);
fun=@(x)fit2(x,exp);
lb=ones(1,10)*1;
ub=ones(1,10)*20;

opts = gaoptimset(@ga);
opts = gaoptimset(opts,'PlotFcns',{@gaplotbestf,@gaplotstopping});
opts = gaoptimset(opts,'Generations',1000,'StallGenLimit', 100);
opts = gaoptimset(opts,'PopulationSize',3000);
x = ga(fun,10,[],[],[],[],lb,ub,[],1:10,opts) ;