%%
clc;
clear;
cd  (['D:\Data\HaoHQ_1203\M2data']);
S1 = load('HHQ1016FR_S_2.mat'); 
S2 = load('HHQ1016LR_S_2.mat'); 
S3 = load('HHQ1016FR2_S_2.mat'); 
Synergy_Sync = cat(1, S1.Synergy_Syn, S2.Synergy_Syn,S3.Synergy_Syn);
save(['Syn_Peak_Sync_HHQ1016.mat'],'Synergy_Sync'); 
cd .. 

%% output VAF
clear ;
clc;
type = 'Subject';
load(['D:\Data\HaoHQ_1203\M2data\Syn_Peak_Sync_PA1011.mat'])
sub = 2; 
for task = 1:3
    if type == 'Control'
        for comp = 1:1:7
            Syne_Cont{sub,task}.VAF(1,comp) = Synergy_Sync(task, comp).VAF;
        end

        else
            for comp = 1:1:7
                Syne_Subj{sub,task}.VAF(1,comp) = Synergy_Sync(task, comp).VAF;
        end

    end


end
EXP = '_PA1011';
cd  (['D:\Data\HaoHQ_1203\M2data']);
 save(['SynergySimilarity_Output_EXP' EXP '.mat'],'Syne_Subj'); 
 cd .. 
%% calculate similarity
clc;
cd  (['D:\Data\HaoHQ_1203\M2data']);
 
load('Syn_Peak_Sync_HHQ1016.mat'); % 与H01对比
Syn_H01 = Synergy_Sync;
clear Synergy_Syn;
len_trial_standard = [8,8,10]; %FR,LR,FR2
len_trial = [9,9,10];
comp (1,1) = 2; %两个task的synergy个数
comp (1,2) = 2;
comp (1,3) = 2;

point = 3468;   % synergy序列一个trial的点个数

type = 'Subject';
load(['D:\Data\HaoHQ_1203\M2data\Syn_Peak_Sync_PA1011.mat'])
Syn_Each = Synergy_Sync;
sub =2;
for task = 1:1:3
            k_H01 = comp(1,task);
            k_Each = comp(1,task);  
    
     %%%%%%%%%% simi of vector (before weighted by lamda)
            
            for k1 = 1:1:k_H01
                for k2 = 1:1:k_Each
                    Matrix_V(k1,k2) = sum(Syn_H01(task, k_H01).U(k1,:).* Syn_Each(task, k_Each).U(k2,:))/(norm(Syn_H01(task, k_H01).U(k1,:))*norm(Syn_Each(task, k_Each).U(k2,:)));
                end
            end
                    for nn = 1:1:k_Each
                        [simi num] = max(Matrix_V(:,nn));
                        Syne_Subj{sub,task}.MatchNum(1,nn) = num;
                        Syne_Subj{sub,task}.MatchSimi_V(1,nn) = simi;
                    end

    %%%%%%%%%% simi of time profile (before weighted by lamda)  
            % step 1:get the average of time profile from all trials
            %standard
            tranum = len_trial_standard(task);
                        for column = 1:1:comp(1,task)
                            for chan = 1:1:point
                                for tra = 1:1:tranum
                                    C_chan(chan,tra) = Syn_H01(task,comp(1,task)).C((tra-1)*point+chan,column);
                                end
                                C_ave(chan,column) = mean(C_chan(chan,:));
                            end
                        end
                            Syn_H01(task, k_H01).C_ave = C_ave;
                        clear C_ave;
                            
                        %subject
                        tranum = len_trial(task);
                        for column = 1:1:comp(1,task)
                            for chan = 1:1:point
                                for tra = 1:1:tranum
                                    C_chan(chan,tra) = Synergy_Sync(task,comp(1,task)).C((tra-1)*point+chan,column);
                                end
                                C_ave(chan,column) = mean(C_chan(chan,:));
                            end
                        end
                            Syne_Subj{sub,task}.C_ave = C_ave;

             %%step 2:calculate simi of averaged similarity    
            for k1 = 1:1:k_H01
                for k2 = 1:1:k_Each
                    Matrix_T(k1,k2) = sum(Syn_H01(task, k_H01).C_ave(:,k1).* Syne_Subj{sub,task}.C_ave(:,k2))/(norm(Syn_H01(task, k_H01).C_ave(:,k1))*norm(Syne_Subj{sub,task}.C_ave(:,k2)));
%                     Matrix_T(k1,k2) = sum(Syn_H01(task, k_H01).C(k1,:).* Syn_Each(task, k_Each).C(k2,:))/(norm(Syn_H01(task, k_H01).C(k1,:))*norm(Syn_Each(task, k_Each).C(k2,:)));                  
                end
            end
                    for nn = 1:1:k_Each
                       Syne_Subj{sub,task}.MatchSimi_T(1,nn) =  Matrix_T(Syne_Subj{sub,task}.MatchNum(1,nn),nn);   % Matchnumber decided by V
                    end
      
   %%%%%%%%%%%%%%%%%%%%%%%% get contribution of time profile form C_ave
     % contribution of eigen value
            Eigen   = zeros(1,comp(1,task));
            Contrib = zeros(1,comp(1,task));
            X       = Syne_Subj{sub,task}.C_ave;
            [coeff,score,latent]    = pca(X);
            Eigen(1,1:comp(1,task)) = latent;
            SUM     = sum(Eigen(1,1:comp(1,task)));
            for nn  = 1:comp(1,task)
                Syne_Subj{sub,task}.Contrib(1,nn) = Eigen(1,nn)/SUM;
            end
      % weighted similarity (= simi of Li et al., 2017)
            Syne_Subj{sub,task}.SV = sum(Syne_Subj{sub,task}.MatchSimi_V .* Syne_Subj{sub,task}.Contrib);
            Syne_Subj{sub,task}.ST = sum(Syne_Subj{sub,task}.MatchSimi_T .* Syne_Subj{sub,task}.Contrib);
            Syne_Subj{sub,task}.SCOM = 0.5 * (Syne_Subj{sub,task}.SV + Syne_Subj{sub,task}.ST);
end

%%
EXP = '_PA1011';
cd  (['D:\Data\HaoHQ_1203\result1203']);
save(['SynergySimilarity_Output_EXP' EXP '.mat'],'Syne_Subj'); 
cd ..
%% save to excel
clc; close all;clear all;
EXP = '_PA1011';
cd  (['D:\Data\HaoHQ_1203\result1203']);
load(['SynergySimilarity_Output_EXP' EXP '.mat']);
filename = (['SynergySimilarity_Output_EXP_1_' EXP '.xlsx']);
% group = 'Control';
  group = 'Subject';
comp (1,1) = 2; %两个task的synergy个数
comp (1,2) = 2;
comp (1,3) = 2;

  for sub = 2     
      for task = 1:3
        % export
        sheet = ['Task' num2str(task)'];
        SUBlist = ['BCDEFGHIJKLMNOPQRSTUVWXYZ'];
        xlRange = [SUBlist(sub)];
        data=[sub';task';comp(1,task)';Syne_Subj{sub,task}.VAF(1,comp(1,task))';Syne_Subj{sub,task}.SV';Syne_Subj{sub,task}.ST'';Syne_Subj{sub,task}.SCOM'';];
        [m,n]=size(data);
        data_cell = mat2cell(data, ones(m,1), ones(n,1));    
        title = {'sub';'task';'COMP';'VAF';'SV';'ST';'SCOM'};     
%         result= [title, data_cell];    % 第一次输出时需要titile,后面无需
        result= [data_cell];   
        xlswrite(filename,result,sheet,xlRange);
      end
    end