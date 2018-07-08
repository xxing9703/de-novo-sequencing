x0=1:10
fun=@(x)fit1(x,output)
lb=zeros(10,1);
ub=ones(10,1)*10;

opts = gaoptimset(@ga);
opts = gaoptimset(opts,'PlotFcns',{@gaplotbestf,@gaplotstopping});
opts = gaoptimset(opts,'Generations',100,'StallGenLimit', 50);
opts = gaoptimset(opts,'PopulationSize',500);
x = ga(fun,10,[],[],[],[],lb,ub,[],opts) ;