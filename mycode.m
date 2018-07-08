dt=importdata('MS_all.xlsx');
dt=dt.data.all;
figure
plot(dt(:,1),dt(:,2));

[a,b]=findpeaks(dt(:,2),sort(dt(:,1)+rand(size(dt,1),1)/1e5),'MinPeakProminence',1e3,'MinPeakWidth',0.03); 
%[a,b]=findpeaks(dt(:,2),dt(:,1)); 

hold on
plot(b,a,'.r')