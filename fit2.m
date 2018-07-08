function score=fit2(x,exp)
str=n2p(x);

[~,mz]=bylist(str);

mz=reshape(mz,size(mz,1)*size(mz,2),1);
mz=unique(mz);
count=0;

for i=1:length(mz)
    for j=1:length(exp)
      if abs(mz(i)-exp(j))<0.5
          count=count+1;
      end
    end
end

score=-count;
