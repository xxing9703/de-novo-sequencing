clear
ppm=1e-3;
A=importdata('Pep1Sec.xlsx');
dt=A.data.x572;
figure
[pks,locs]=findpeaks(dt(:,2),'MinPeakProminence',500);
plot(dt(:,1),dt(:,2),dt(locs,1),pks,'.k')
text(dt(locs,1),pks+1000,num2str(dt(locs,1),4),'rotation',90);
xlim([100,1200])
ylim([0,max(pks)*1.2])
pks=pks/max(pks);
mz=dt(locs,1);
sig=pks;
out=[mz,sig];

%------------dimer
[~,~,B]=xlsread('lookup.xlsx');
k=0;dimer=[];label=[];
for i=1:20
    for j=1:20
    k=k+1;
     dimer(k,1)=B{i,3}+B{j,3};
     label{k,1}=[B{i,2},B{j,2}];
    end
end
[dimer,b]=unique(dimer);
label=label(b);
[dimer,ind]=sort(dimer);
label=label(ind);



%------------------------trimer
k=0;trimer=[];label_3=[];
for i=1:20
    for j=1:20
        for h=1:20
    k=k+1;
     trimer(k,1)=B{i,3}+B{j,3}+B{h,3};
     label_3{k,1}=[B{i,2},B{j,2},B{h,2}];
        end
    end
end
[trimer,b]=unique(trimer);
label_3=label_3(b);
[trimer,ind]=sort(trimer);
label_3=label_3(ind);

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

%----------------------lookup

%ub=max(trimer)+1;
%lb=min(dimer)-1;
%diff=diff(find(diff<ub));
%diff=diff(find(diff>lb));
output=[];
k=0;
in_str='ATEDVQDPRI';
for i=1:size(diff,1)
    for j=1:size(dimer,1)
        cc=label{j};
        f1=find(in_str==cc(1));
        f2=find(in_str==cc(2));
                
       if abs(diff(i,1)-dimer(j,1))<0.5 && ~isempty(f1) && ~isempty(f2)
           k=k+1;
           output{k,1}=diff(i,1);
           output{k,2}=dimer(j,1);
           output{k,3}=label{j};  
           output{k,4}=diff(i,2);
           output{k,5}=diff(i,3);
       end      
    end  
    
     for j=1:size(trimer,1)
        cc=label_3{j};
        f1=find(in_str==cc(1));
        f2=find(in_str==cc(2));
        f3=find(in_str==cc(3));
                
       if abs(diff(i,1)-trimer(j,1))<0.5 && ~isempty(f1) && ~isempty(f2)&& ~isempty(f3)
           k=k+1;
           output{k,1}=diff(i,1);
           output{k,2}=trimer(j,1);
           output{k,3}=label_3{j};  
           output{k,4}=diff(i,2);
           output{k,5}=diff(i,3);
       end      
    end  
end

[~,ind]=unique(output(:,3));
output=output(ind,:);
[~,ind]=uniquetol(cell2mat(output(:,2)),1e-5);
output=output(ind,:);

ind=randperm(10);


%in_str='ATEDVQDPRI';
m_seq=[];
for i=1:7
   m_seq(i)=peptide_mz(in_str(end-i:end),1);
end
hold on
plot(m_seq,ones(7,1)*6e3,'or')
m_seq=[];
for i=1:8
   m_seq(i)=peptide_mz(in_str(1:i+1),0);
end
hold on
plot(m_seq,ones(8,1)*9e3,'dr')
m_seq=[];
for i=1:5
   m_seq(i)=peptide_mz(in_str(end-i-2:end-2),0);
end
hold on
plot(m_seq,ones(5,1)*6e3,'*r')
