A=importdata('Pep1Sec.xlsx');
dt=A.data.x572;
[pks,locs]=findpeaks(dt(:,2),'MinPeakProminence',1000);
mz=dt(locs,1);

%-----------------------diff
k=0;diff=[];
sz=size(mz,1);
for i=1:sz-1
    for j=i:sz
    k=k+1;
     diff(k,1)=abs(mz(i)-mz(j));
     diff(k,2)=mz(i);
     diff(k,3)=mz(j);
     
    end
end
diff=unique(diff(:,1));
diff=sort(diff);
exist=zeros(size(BB,1),1);
for i=1:size(BB,1)
    mass=BB{i,2};
    for j=1:size(diff,1)
        if abs(mass-diff(j))<0.1
            exist(i)=1;
        end
    end
end
%%
BB={'G',57.0214640000000;'A',71.0371140000000;'S',87.0320290000000;'P',97.0527640000000;'V',99.0684140000000;'T',101.047680000000;'C',103.009190000000;'L',113.084060000000;'N',114.042930000000;'D',115.026940000000;'Q',128.058580000000;'E',129.042590000000;'M',131.040480000000;'H',137.058910000000;'F',147.068410000000;'R',156.101110000000;'Y',163.063330000000;'W',186.079310000000};
combo=get_mass_combos(BB, 18, 1124.4,1124.6,1124.5);
cb=combo(find(combo(:,4)>0),:);
cb=cb(find(cb(:,5)>0),:);
cb=cb(find(cb(:,10)>0),:);
cb=cb(find(cb(:,11)>0),:);
cb=cb(find(cb(:,12)>0),:);
cbb=cb(find(sum(cb,2)==10),:);

for n=1:size(cbb,1)
numbers=cbb(n,:);lb=[];
for i=1:length(numbers)
  if numbers(i)>0
    lb=[lb,repmat(BB{i,1},1,numbers(i))];
  end
end
lbs{n,1}=lb;
end


