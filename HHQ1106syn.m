%% sham syn
clear
clc

load(['D:\Data\M2Data\hhq1106\MAT\LREMG_S.mat'])
EMGsham = [];
EMGsham = cat(1, EMGsham, EMGMatrix);
for k = 1:1:7
    [Synergy_Syn(1,k)] = NNMF_Sync(abs(EMGsham),k);
end

% subplot(1,2,1)
% bar(Synergy_Syn(2).U(1,:),'Horizontal','on','FaceColor',[250/255 200/255 20/255])
% name = {'PC', 'DP', 'DA', 'Bi','Tlt', 'Tlh', 'BR'};
% % set(gca, 'YTickLabel', name);
% xlim([0 1])
% subplot(1,2,2)
% bar(Synergy_Syn(2).U(end,:),'Horizontal','on','FaceColor',[217/255 113/255 110/255])
% % set(gca, 'YTickLabel', name);
% xlim([0 1])
% 
% figure(2);
% subplot(2,1,1)
% plot(Synergy_Syn(2).C(:,1),'Color',[250/255 200/255 20/255], 'LineWidth',4)
% subplot(2,1,2)
% plot(Synergy_Syn(2).C(:,2),'Color',[217/255 113/255 110/255], 'LineWidth',4)
% % h = suptitle('LR(Low Load)');
% % set(h,'Fontsize',30);




