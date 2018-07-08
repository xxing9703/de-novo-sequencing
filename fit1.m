function score=fit1(x,output)
ch='AEDDPRIVTQ';
[~,ind]=sort(x);
str=ch(ind)
score=-match(output,str);
end


