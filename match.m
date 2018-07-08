function count=match(input,str)
s=length(str);

for i=1:s-1
    c1=str(i);
    c2=str(i+1);    
    str2{i,1}=[c1,c2];
    str2{i,2}=[c2,c1];    
end

for i=1:s-2
    c1=str(i);
    c2=str(i+1);
    c3=str(i+2);    
    str3{i,1}=[c1,c2,c3];
    str3{i,2}=[c2,c1,c3];    
    str3{i,3}=[c1,c3,c2];
    str3{i,4}=[c3,c1,c2];    
    str3{i,5}=[c3,c2,c1];
    str3{i,6}=[c2,c3,c1];    
end
st=[str2(:);str3(:)];
count=0;
for i=1:size(input,1)
   for j=1:size(st,1)
       if strcmp(input{i,3},st{j})
           count=count+1;
       end
   end
end


