function score=fit3a(x,exp,ch)
%ch='AEDDIPQRTV';
%{
for i=1:length(x)
    cc(i)=ch(x(i));
    ch(x(i))=[];
end
str=[cc,ch];
%}

[~,ind]=sort(x);
str=ch(ind);

%set(handles.edit1,'string',str);
drawnow();
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
%set(handles.text_score,'string',num2str(count));
