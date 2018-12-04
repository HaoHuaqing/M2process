%% initial load
clear ;
clc;
close all;
type = 'Subject'; 
cd  (['D:\Data\HaoHQ_1203\result1203']);

EXP = '_PA1011';  
comp(1,1) = 2;
comp(1,2) = 2;
comp(1,3) = 2;
emgnum = 7;
load (['SynergySimilarity_Output_EXP' EXP '.mat']);
cd (['D:\Data\HaoHQ_1203\M2data']);
for sub = 2
                    % 1 Ê×ÆÀ     %¡¡2 Î²ÆÀ     % 3 ¶þ´ÎÈë×éÊ×ÆÀ    %  4 ¶þ´ÎÈë×éÎ²ÆÀ

      load ('Syn_Peak_Sync_PA1011');

             
       %%%%%%%%
       for task = 1:3

          
          switch task 
              case 1
                        colo = [226/255 175/255 45/255;
                                119/255 181/255 53/255;
                                217/255 113/255 110/255];
         
                        input = figure;

                        xSize_i  = 4;   % Í¼Æ¬¿í,Ó¢´ç
                        ySize_i  = 7; % ¸ß,Ó¢´ç
                        xLeft_i  = 1;
                        yTop_i   = 0;
                        set(input, 'Units', 'inches');  %  'centimeters'
                        set(input, 'Position', [xLeft_i yTop_i xSize_i ySize_i]);
                        set(input, 'PaperUnits', 'inches');  %  'centimeters'
                        set(input, 'PaperPosition', [xLeft_i yTop_i xSize_i ySize_i]);

                        Position(1:2*comp(1,task),1:4) = [0.1 0.4  0.35 0.5;
                                                          0.55 0.4  0.35 0.5;
                                                          0.1 0.22  0.8 0.15;
                                                          0.1 0.05  0.8 0.15;];
                            
              case 2
                       colo = [226/255 175/255 45/255;
                                119/255 181/255 53/255;
                                217/255 113/255 110/255]; % colo of template (H01)
                        input = figure;
                        xSize_i  = 4;   % Í¼Æ¬¿í,Ó¢´ç
                        ySize_i  = 7; % ¸ß,Ó¢´ç
                        xLeft_i  = 1;
                        yTop_i   = 0;
                        set(input, 'Units', 'inches');  %  'centimeters'
                        set(input, 'Position', [xLeft_i yTop_i xSize_i ySize_i]);
                        set(input, 'PaperUnits', 'inches');  %  'centimeters'
                        set(input, 'PaperPosition', [xLeft_i yTop_i xSize_i ySize_i]);
                         
                        Position(1:2*comp(1,task),1:4) = [0.1 0.4  0.35 0.5;
                                                          0.55 0.4  0.35 0.5;
                                                          0.1 0.22  0.8 0.15;
                                                          0.1 0.05  0.8 0.15;];
               case 3
                       colo = [226/255 175/255 45/255;
                                119/255 181/255 53/255;
                                217/255 113/255 110/255]; % colo of template (H01)
                        input = figure;
                        xSize_i  = 4;   % Í¼Æ¬¿í,Ó¢´ç
                        ySize_i  = 7; % ¸ß,Ó¢´ç
                        xLeft_i  = 1;
                        yTop_i   = 0;
                        set(input, 'Units', 'inches');  %  'centimeters'
                        set(input, 'Position', [xLeft_i yTop_i xSize_i ySize_i]);
                        set(input, 'PaperUnits', 'inches');  %  'centimeters'
                        set(input, 'PaperPosition', [xLeft_i yTop_i xSize_i ySize_i]);
                         
                        Position(1:2*comp(1,task),1:4) = [0.1 0.4  0.35 0.5;
                                                          0.55 0.4  0.35 0.5;
                                                          0.1 0.22  0.8 0.15;
                                                          0.1 0.05  0.8 0.15;];

          end
                        for row = 1:comp(1,task)
                             subplot('position',Position(row,:));
                             h1 = barh(Synergy_Sync(task,comp(1,task)).U(row,emgnum:-1:1),'FaceColor',colo(Syne_Subj{sub,task}.MatchNum(1,row),:),'EdgeColor',colo(Syne_Subj{sub,task}.MatchNum(1,row),:),'LineWidth',1);
                             set(get(h1(1),'BaseLine'),'Visible','off');
                             set(gca, 'YTick',[],'XTick',[0 1]);     
                             xlim([0 1]);
                             ylim([0.5 emgnum+0.41]);
                             titlestr = [num2str(round(Syne_Subj{sub,task}.MatchSimi_V(1,row)*100)/100) ' (' num2str(Syne_Subj{sub,task}.MatchNum(1,row)) ')'];
                             title(titlestr);
                        end
                        
                        for column = 1:comp(1,task)
                             subplot('position',Position(column+comp(1,task),:));
                             C_xlim = max(max(Syne_Subj{sub,task}.C_ave));
                             area(Syne_Subj{sub,task}.C_ave(:,column),'FaceColor',colo(Syne_Subj{sub,task}.MatchNum(1,column),:),'EdgeColor',colo(Syne_Subj{sub,task}.MatchNum(1,column),:),'LineWidth',1);
                             set(gca, 'YTick',[],'XTick',[0 1000]);  
                             ylim([0 C_xlim*1.1]);
                             titlestr = [num2str(round(Syne_Subj{sub,task}.MatchSimi_T(1,column)*100)/100) ' (' num2str(Syne_Subj{sub,task}.MatchNum(1,column)) ')'];
                             title(titlestr);
                        end
                        
%                           annotation('textbox',...
%                           [0.40 0.88 0.10 0.10],...
%                           'String',{['Subj ' num2str(sub) ' Task ' num2str(task) ' EXP ' num2str(EXP)]}','LineStyle','none');

           
       end
end

       