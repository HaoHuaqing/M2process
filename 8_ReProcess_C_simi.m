%% load and average (each subject)
clear;
% cd ('X:\Synergy_Analysis\ReProcess_Vel10perc\LR_4COMPONENT');

%    group = 'Control';  
    group = 'Subject'; 

for sub = 7
        exp = '04';              % 01 首评     %　02 尾评     % 3 二次入组首评    %  4 二次入组尾评
        savefolder = ['Exp',exp,'_',group];
        cd ('X:\Synergy_Analysis\ReProcess_Vel10perc');
        cd (savefolder);

            if sub >= 10
            vel10perc_synmat = ['Vel10perc_Syn_Peak_Sync_',group,'_',num2str(sub), '.mat'];
            else vel10perc_synmat = ['Vel10perc_Syn_Peak_Sync_',group,'_0',num2str(sub), '.mat'];
            end
            load (vel10perc_synmat);


%%% average and save
k(1) = 3;
k(2) = 4;
for task = 1:2
    point = 1000;
    tranum = len_trial(task);
    for column = 1:1:k(task)
        for chan = 1:1:point
            for tra = 1:1:tranum
                C_chan(chan,tra) = Synergy_Sync(task,k(task)).C((tra-1)*point+chan,column);
            end
            C_ave(chan,column) = mean(C_chan(chan,:));
        end
    end
        Synergy_Sync(task,k(task)).C_ave = C_ave;
end
% if k(1) == 3
save(['Vel10perc_Syn_Peak_Sync_',group,'_',num2str(subnum), '.mat'], 'type', 'subnum','dt_1','dt_2','FS_M','FS_E','Syn','Synergy_Sync','len_trial','trial');
% else save(['Vel10perc_Syn_Peak_Sync_',group,'_',num2str(subnum), '_N_'  num2str(k(1)) '_N_'  num2str(k(2)) '.mat'], 'type', 'subnum','dt_1','dt_2','FS_M','FS_E','Syn','Synergy_Sync','len_trial','trial');
% end
end
 %% load and average (9H)
% clc;
% close all;
% clear;
%     cd ('X:\Synergy_Analysis\ReProcess_Vel10perc');
%     cd Pooled_Control;
%     total  = 9;
%     poolmat = ['Vel10perc_Pooled_' num2str(total) 'H_Syn_Sync.mat'];
%     load (poolmat);
%     
% k(1) = 3;
% k(2) = 3;
% len_trial(1) = 88;
% len_trial(2) = 94;
% 
% for task = 1:2
%     point = 1000;
%     tranum = len_trial(task);
%     for column = 1:1:k(task)
%         for chan = 1:1:point
%             for tra = 1:1:tranum
%                 C_chan(chan,tra) = Pooled_Synergy(task,k(task)).C((tra-1)*point+chan,column);
%             end
%             C_ave(chan,column) = mean(C_chan(chan,:));
%         end
%     end
%         Pooled_Synergy(task,k(task)).C_ave = C_ave;
% end
% % if k(1) == 3
% % save(['Vel10perc_Pooled_' num2str(total) 'H_Syn_Sync.mat'], 'type','dt_1','dt_2','FS_M','FS_E','Pooled_Synergy','len_trial');
% % else save(['Vel10perc_Pooled_' num2str(total) 'H_Syn_Sync_N_'  num2str(k(1)) '_N_'  num2str(k(2)) '.mat'], 'type','dt_1','dt_2','FS_M','FS_E','Pooled_Synergy','len_trial');
% % end

%% get similarity of C
% cd folder 
clc;
close all;
clear;
    cd ('X:\Synergy_Analysis\ReProcess_Vel10perc');
    cd LR_4COMPONENT;
    total  = 9;
    poolmat = ['Vel10perc_Pooled_LR_4_C_ave_' num2str(total) 'H_Syn_Sync.mat'];
    load (poolmat);
    cd .. 
Syn_9H = Pooled_Synergy;
%% cd synergy of each people
cd ('X:\Synergy_Analysis\ReProcess_Vel10perc');
% group = 'Control';
group = 'Subject';
for sub = 7
    exp = '04';         % 01 首评     %　02 尾评     % 3 二次入组首评    %  4 二次入组尾评
    savefolder = ['Exp',exp,'_',group];
    cd (savefolder);
    if sub >= 10
    synmat = (['Vel10perc_Syn_Peak_Sync_' group '_' num2str(sub) '.mat']);
    else synmat = (['Vel10perc_Syn_Peak_Sync_' group '_0' num2str(sub) '.mat']);
    end
    load (synmat);
    Syn_Each = Synergy_Sync;
    cd ..
    cd Pooled_Control;
    load(['Similar_to_9H_Comp_3_4_' group '_' num2str(subnum) '_3_4_exp_' exp '.mat']);
    
    for task = 1:1:2
            switch task 
                case 1
                    k_9H = 3;% component of pool synergy
                    k_Each = 3;  
                case 2
                    k_9H = 4;
                    k_Each = 4;      
            end

        for k1 = 1:1:k_9H
            for k2 = 1:1:k_Each
            Similar(task).Pool_Each_C(k1,k2) = sum(Syn_9H(task, k_9H).C_ave(:,k1).* Syn_Each(task, k_Each).C_ave(:,k2))/(norm(Syn_9H(task, k_9H).C_ave(:,k1))*norm(Syn_Each(task, k_Each).C_ave(:,k2)));
            end
        end
    end

save(['Similar_to_9H_Comp_3_4_' group '_' num2str(subnum) '_3_4_exp_' exp '.mat'],'Similar');
cd .. 
end

%% get similarity of C (SIMI TO H01)
% cd folder 
clc;
close all;
clear;
    cd ('X:\Synergy_Analysis\ReProcess_Vel10perc');
    cd LR_4COMPONENT;
    load('Vel10perc_Syn_LR_4_C_ave_Control_01.mat');
    Syn_H01 = Synergy_Sync;
    clear Synergy_Sync;
    cd ..
% cd synergy of each people

% group = 'Control';
group = 'Subject';
for sub = [7]
    exp = '04';         % 01 首评     %　02 尾评     % 3 二次入组首评    %  4 二次入组尾评
    savefolder = ['Exp',exp,'_',group];        
    %     cd (savefolder);
    if exp =='01'
        cd LR_4COMPONENT;
        if sub >= 10
        synmat = (['Vel10perc_Syn_LR_4_C_ave_' group '_' num2str(sub) '.mat']);
        else synmat = (['Vel10perc_Syn_LR_4_C_ave_' group '_0' num2str(sub) '.mat']);
        end
    else 
        cd (savefolder);
        if sub >= 10
        synmat = (['Vel10perc_Syn_Peak_Sync_' group '_' num2str(sub) '.mat']);
        else synmat = (['Vel10perc_Syn_Peak_Sync_' group '_0' num2str(sub) '.mat']);
        end
    end
        load (synmat);
        Syn_Each = Synergy_Sync;
    cd ..
    cd Pooled_Control;
    load(['Similar_to_H01_Comp_3_4_' group '_' num2str(subnum) '_3_4_exp_' exp '.mat']);
    
    for task = 1:1:2
            switch task 
                case 1
                    k_H01 = 3;% component of pool synergy
                    k_Each = 3;  
                case 2
                    k_H01 = 4;
                    k_Each = 4;      
            end

        for k1 = 1:1:k_H01
            for k2 = 1:1:k_Each
            Similar(task).H01_Each_C(k1,k2) = sum(Syn_H01(task, k_H01).C_ave(:,k1).* Syn_Each(task, k_Each).C_ave(:,k2))/(norm(Syn_H01(task, k_H01).C_ave(:,k1))*norm(Syn_Each(task, k_Each).C_ave(:,k2)));
            end
        end
    end

save(['Similar_to_H01_Comp_3_4_' group '_' num2str(subnum) '_3_4_exp_' exp '.mat'],'Similar');
cd .. 
end