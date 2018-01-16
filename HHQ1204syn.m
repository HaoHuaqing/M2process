%% sham syn
clear
clc

load(['D:\Data\M2Data\hhq1204\EMG_lp\80-4000.mat'])
EMGsham = [];
EMGsham = cat(1, EMGsham, averageEMG);
for k = 1:1:7
    [Synergy_Syn(1,k)] = NNMF_Sync(abs(EMGsham),k);
end

subplot(2,2,1)
bar(Synergy_Syn(2).U(1,:),'y','Horizontal','on')
name = {'1', '2', '3', '4','5', '6', '7'};
set(gca, 'YTickLabel', name);
subplot(2,2,3)
bar(Synergy_Syn(2).U(end,:),'y','Horizontal','on')
set(gca, 'YTickLabel', name);
subplot(2,2,2)
plot(Synergy_Syn(2).C(:,1),'Color',[1 0 0], 'LineWidth',4)
subplot(2,2,4)
plot(Synergy_Syn(2).C(:,2),'Color',[1 0 0], 'LineWidth',4)
h = suptitle('80-4000');
set(h,'Fontsize',30);




