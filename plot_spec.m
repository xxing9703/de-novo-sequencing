A=importdata('Pep1Sec.xlsx');
%dt=A.data.parent;
dt=A.data.x572;
%dt=A.data.x583;
%dt=A.data.x594;
figure
[pks,locs]=findpeaks(dt(:,2),'MinPeakProminence',1000);
plot(dt(:,1),dt(:,2),dt(locs,1),pks,'.k')
set(gca,'xtick',[])
%plot(dt(:,1),dt(:,2))

%set(gca,'xtick',[])
offset=zeros(length(pks),1);
offset(2)=offset(2)+20000;
offset(10)=offset(11)+14000;

text(dt(locs,1),pks+max(pks)*0.02+offset,num2str(dt(locs,1),5),'rotation',90);
xlabel('m/z')
xlim([100,1200])
ylim([0,max(pks)*1.2])