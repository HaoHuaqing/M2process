%% Read Data
clear
clc
Motionfs = 100;
Files = dir(strcat('D:\Data\M2Data\hhq1204\HHQMotion1204\'));
LengthFiles = length(Files);
for i = 4:LengthFiles
   trialname = strcat('D:\Data\M2Data\hhq1204\HHQMotion1204\',Files(i).name);
   disp(trialname)
   eval(['Motion.trial',num2str(i - 3),'=','csvread(trialname,1,0);']);
end

Files = dir(strcat('D:\Data\M2Data\hhq1204\HHQEMG1204\'));
LengthFiles = length(Files);
for i = 4:LengthFiles
   trialname = strcat('D:\Data\M2Data\hhq1204\HHQEMG1204\',Files(i).name);
   disp(trialname)
   eval(['EMG.trial',num2str(i - 3),'=','csvread(trialname,1,0);']);
end

disp('Read data completed')

%% Plot sham
FrontTime = -0.5;
BackTime = 1.3;
TotalTime = 1.8;
Motionfs = 100;
EMGfs = 1926;
Motionlen = (1:1:181)/100;
EMGlen = (1:1:3468)/1926;
velstarter(1) = 79;
velstarter(2) = 77;
velstarter(3) = 93;
velstarter(4) = 79;
velstarter(5) = 52;

EMGstarter(1) = 3757;
EMGender(1) = 13370;
EMGstarter(2) = 2363;
EMGender(2) = 13970;
EMGstarter(3) = 2891;
EMGender(3) = 10860;
EMGstarter(4) = 2710;
EMGender(4) = 10620;
EMGstarter(5) = 2981;
EMGender(5) = 9303;

for i = 1:2
    figure(1);
    subplot(5,2,i)
    averageMotion = zeros(181,1);    
    for j = 1:5  
        eval(['posX = Motion.trial', num2str(j), '(:,', num2str(i*2-1), ');'])
        eval(['posY = Motion.trial', num2str(j), '(:,', num2str(i*2), ');'])
        pos = sqrt((posX.^2 + posY.^2));
        pos = pos(velstarter(j) + FrontTime * Motionfs: velstarter(j) + BackTime * Motionfs);
        averageMotion = averageMotion + pos;
        plot(Motionlen,pos, 'k')
        hold on   
    end
    plot(Motionlen, averageMotion/5, 'r', 'LineWidth',2)
    figure(2);
    subplot(5,2,i)
    plot(Motionlen, averageMotion/5, 'r', 'LineWidth',2)
    hold on  
end

averageEMG = zeros(3468,7);
for i = 3:9
   figure(1);
   subplot(5,2,i)
   for j = 1:5    
      eval(['[EMG_bp,EMG_rt,EMG_lp_20,EMG_lp_6] = EMG_Process(1000*EMG.trial', num2str(j), '(:,', num2str((i-3)*8+2), '),100, 1926, 2);'])
      EMGtemp = EMG_lp_20(EMGstarter(j):EMGender(j));
      EMGstartpos = round(velstarter(j)/100 * EMGfs + FrontTime * EMGfs);
      EMGtemp = EMGtemp(EMGstartpos: round(EMGstartpos + TotalTime * EMGfs));
      averageEMG(:,i-2) = averageEMG(:,i-2) + EMGtemp;
      plot(EMGlen, EMGtemp, 'k')
      hold on  
   end
    plot(EMGlen, averageEMG(:,i-2)/5, 'r', 'LineWidth',2)
    figure(2);
    subplot(5,2,i)
    plot(EMGlen, averageEMG(:,i-2)/5, 'r', 'LineWidth',2)
    hold on  
end


%% plot 80-2000
FrontTime = -0.5;
BackTime = 1.3;
TotalTime = 1.8;
Motionfs = 100;
EMGfs = 1926;
Motionlen = (1:1:181)/100;
EMGlen = (1:1:3468)/1926;
velstarter(6) = 110;
velstarter(7) = 67;
velstarter(8) = 90;
velstarter(9) = 82;
velstarter(10) = 104;

EMGstarter(6) = 3868;
EMGender(6) = 15380;
EMGstarter(7) = 3227;
EMGender(7) = 12850;
EMGstarter(8) = 2773;
EMGender(8) = 12870;
EMGstarter(9) = 3158;
EMGender(9) = 11370;
EMGstarter(10) = 2427;
EMGender(10) = 9606;

for i = 1:2
    figure(1);
    subplot(5,2,i)
    averageMotion = zeros(181,1);
    for j = 6:10  
        eval(['posX = Motion.trial', num2str(j), '(:,', num2str(i*2-1), ');'])
        eval(['posY = Motion.trial', num2str(j), '(:,', num2str(i*2), ');'])
        pos = sqrt((posX.^2 + posY.^2));
        pos = pos(velstarter(j) + FrontTime * Motionfs: velstarter(j) + BackTime * Motionfs);
        averageMotion = averageMotion + pos;
        plot(Motionlen,pos, 'k')
        hold on   
    end
    plot(Motionlen,averageMotion/5, 'r', 'LineWidth',2)
    figure(2);
    subplot(5,2,i)
    plot(Motionlen, averageMotion/5, 'g', 'LineWidth',2)
    hold on  
end

averageEMG = zeros(3468, 7);
for i = 3:9
    figure(1);
   subplot(5,2,i)
   for j = 6:10     
      eval(['[EMG_bp,EMG_rt,EMG_lp_20,EMG_lp_6] = EMG_Process(1000*EMG.trial', num2str(j), '(:,', num2str((i-3)*8+2), '),100, 1926, 2);'])
      EMGtemp = EMG_lp_20(EMGstarter(j):EMGender(j));
      EMGstartpos = round(velstarter(j)/100 * EMGfs + FrontTime * EMGfs);
      EMGtemp = EMGtemp(EMGstartpos: round(EMGstartpos + TotalTime * EMGfs));
      averageEMG(:,i-2) = averageEMG(:,i-2) + EMGtemp;
      plot(EMGlen, EMGtemp, 'k')
      hold on  
   end
   plot(EMGlen, averageEMG(:,i-2)/5, 'r', 'LineWidth',2)
   figure(2);
    subplot(5,2,i)
    plot(EMGlen, averageEMG(:,i-2)/5, 'g', 'LineWidth',2)
    hold on  
end


%% plot 70-2000
FrontTime = -0.5;
BackTime = 1.3;
TotalTime = 1.8;
Motionfs = 100;
EMGfs = 1926;
Motionlen = (1:1:181)/100;
EMGlen = (1:1:3468)/1926;
velstarter(11) = 104;
velstarter(12) = 96;
velstarter(13) = 77;
velstarter(14) = 79;
velstarter(15) = 76;

EMGstarter(11) = 3296;
EMGender(11) = 11130;
EMGstarter(12) = 2638;
EMGender(12) = 8986;
EMGstarter(13) = 7078;
EMGender(13) = 17160;
EMGstarter(14) = 3718;
EMGender(14) = 10510;
EMGstarter(15) = 3209;
EMGender(15) = 10140;
for i = 11:15
   disp((EMGender(i)-EMGstarter(i))/1926)
   eval(['MotionSize = size(Motion.trial', num2str(i), ');'])
   disp(MotionSize(1))
end

for i = 1:2
    figure(1);
    subplot(5,2,i)
    averageMotion = zeros(181, 1);
    for j = 11:15  
        eval(['posX = Motion.trial', num2str(j), '(:,', num2str(i*2-1), ');'])
        eval(['posY = Motion.trial', num2str(j), '(:,', num2str(i*2), ');'])
        pos = sqrt((posX.^2 + posY.^2));
        pos = pos(velstarter(j) + FrontTime * Motionfs: velstarter(j) + BackTime * Motionfs);
        averageMotion = averageMotion + pos;
        plot(Motionlen,pos, 'k')
        hold on   
    end
    plot(Motionlen,averageMotion/5, 'r', 'LineWidth',2)
    figure(2);
    subplot(5,2,i)
    plot(Motionlen, averageMotion/5, 'b', 'LineWidth',2)
    hold on 
end

averageEMG = zeros(3468,7);
for i = 3:9
    figure(1);
   subplot(5,2,i)
   for j = 11:15     
      eval(['[EMG_bp,EMG_rt,EMG_lp_20,EMG_lp_6] = EMG_Process(1000*EMG.trial', num2str(j), '(:,', num2str((i-3)*8+2), '),100, 1926, 2);'])
      EMGtemp = EMG_lp_20(EMGstarter(j):EMGender(j));
      EMGstartpos = round(velstarter(j)/100 * EMGfs + FrontTime * EMGfs);
      EMGtemp = EMGtemp(EMGstartpos: round(EMGstartpos + TotalTime * EMGfs));
      averageEMG(:,i-2) = averageEMG(:,i-2) + EMGtemp;
      plot(EMGlen, EMGtemp, 'k')
      hold on  
   end
   plot(EMGlen, averageEMG(:,i-2)/5, 'r', 'LineWidth',2)
    figure(2);
    subplot(5,2,i)
    plot(EMGlen, averageEMG(:,i-2)/5, 'b', 'LineWidth',2)
    hold on  
end

%% plot 60-2000
FrontTime = -0.5;
BackTime = 1.3;
TotalTime = 1.8;
Motionfs = 100;
EMGfs = 1926;
Motionlen = (1:1:181)/100;
EMGlen = (1:1:3468)/1926;
velstarter(16) = 79;
velstarter(17) = 93;
velstarter(18) = 107;
velstarter(19) = 92;
velstarter(20) = 111;

EMGstarter(16) = 3001;
EMGender(16) = 9273;
EMGstarter(17) = 5194;
EMGender(17) = 11810;
EMGstarter(18) = 3857;
EMGender(18) = 10050;
EMGstarter(19) = 4451;
EMGender(19) = 12620;
EMGstarter(20) = 3452;
EMGender(20) = 10080;
for i = 16:20
   disp((EMGender(i)-EMGstarter(i))/1926)
   eval(['MotionSize = size(Motion.trial', num2str(i), ');'])
   disp(MotionSize(1))
end

for i = 1:2
    figure(1);
    subplot(5,2,i)
    averageMotion = zeros(181,1);
    for j = 16:20  
        eval(['posX = Motion.trial', num2str(j), '(:,', num2str(i*2-1), ');'])
        eval(['posY = Motion.trial', num2str(j), '(:,', num2str(i*2), ');'])
        pos = sqrt((posX.^2 + posY.^2));
        pos = pos(velstarter(j) + FrontTime * Motionfs: velstarter(j) + BackTime * Motionfs);
        averageMotion = averageMotion + pos;
        plot(Motionlen,pos, 'k')
        hold on   
    end
    plot(Motionlen,averageMotion/5, 'r', 'LineWidth',2)
    figure(2);
    subplot(5,2,i)
    plot(Motionlen, averageMotion/5, 'k', 'LineWidth',2)
    hold on 
end

averageEMG = zeros(3468,7);
for i = 3:9
   figure(1);
   subplot(5,2,i)
   for j = 16:20     
      eval(['[EMG_bp,EMG_rt,EMG_lp_20,EMG_lp_6] = EMG_Process(1000*EMG.trial', num2str(j), '(:,', num2str((i-3)*8+2), '),100, 1926, 2);'])
      EMGtemp = EMG_lp_20(EMGstarter(j):EMGender(j));
      EMGstartpos = round(velstarter(j)/100 * EMGfs + FrontTime * EMGfs);
      EMGtemp = EMGtemp(EMGstartpos: round(EMGstartpos + TotalTime * EMGfs));
      averageEMG(:,i-2) = averageEMG(:,i-2) + EMGtemp;
      plot(EMGlen, EMGtemp, 'k')
      hold on  
   end
    plot(EMGlen, averageEMG(:,i-2)/5, 'r', 'LineWidth',2)
    figure(2);
    subplot(5,2,i)
    plot(EMGlen, averageEMG(:,i-2)/5, 'k', 'LineWidth',2)
    hold on  
end



%% plot 80-3000
FrontTime = -0.5;
BackTime = 1.3;
TotalTime = 1.8;
Motionfs = 100;
EMGfs = 1926;
Motionlen = (1:1:181)/100;
EMGlen = (1:1:3468)/1926;
velstarter(21) = 97;
velstarter(22) = 80;
velstarter(23) = 91;
velstarter(24) = 72;
velstarter(25) = 98;

EMGstarter(21) = 2280;
EMGender(21) = 11990;
EMGstarter(22) = 5916;
EMGender(22) = 12440;
EMGstarter(23) = 4309;
EMGender(23) = 11910;
EMGstarter(24) = 2788;
EMGender(24) = 12030;
EMGstarter(25) = 2796;
EMGender(25) = 10610;
for i = 21:25
   disp((EMGender(i)-EMGstarter(i))/1926)
   eval(['MotionSize = size(Motion.trial', num2str(i), ');'])
   disp(MotionSize(1))
end

for i = 1:2
    figure(1);
    subplot(5,2,i)
    averageMotion = zeros(181,1);
    for j = 21:25  
        eval(['posX = Motion.trial', num2str(j), '(:,', num2str(i*2-1), ');'])
        eval(['posY = Motion.trial', num2str(j), '(:,', num2str(i*2), ');'])
        pos = sqrt((posX.^2 + posY.^2));
        pos = pos(velstarter(j) + FrontTime * Motionfs: velstarter(j) + BackTime * Motionfs);
        averageMotion = averageMotion + pos;
        plot(Motionlen,pos, 'k')
        hold on   
    end
    plot(Motionlen,averageMotion/5, 'r', 'LineWidth',2)
    figure(2);
    subplot(5,2,i)
    plot(Motionlen, averageMotion/5, 'b', 'LineWidth',2)
    hold on 
end

averageEMG = zeros(3468,7);
for i = 3:9
   figure(1);
   subplot(5,2,i)
   for j = 21:25   
      eval(['[EMG_bp,EMG_rt,EMG_lp_20,EMG_lp_6] = EMG_Process(1000*EMG.trial', num2str(j), '(:,', num2str((i-3)*8+2), '),100, 1926, 2);'])
      EMGtemp = EMG_lp_20(EMGstarter(j):EMGender(j));
      EMGstartpos = round(velstarter(j)/100 * EMGfs + FrontTime * EMGfs);
      EMGtemp = EMGtemp(EMGstartpos: round(EMGstartpos + TotalTime * EMGfs));
      averageEMG(:,i-2) = averageEMG(:,i-2) + EMGtemp;
      plot(EMGlen, EMGtemp, 'k')
      hold on  
   end
    plot(EMGlen, averageEMG(:,i-2)/5, 'r', 'LineWidth',2)
    figure(2);
    subplot(5,2,i)
    plot(EMGlen, averageEMG(:,i-2)/5, 'b', 'LineWidth',2)
    hold on  
end


%% plot 80-4000
FrontTime = -0.5;
BackTime = 1.3;
TotalTime = 1.8;
Motionfs = 100;
EMGfs = 1926;
Motionlen = (1:1:181)/100;
EMGlen = (1:1:3468)/1926;
velstarter(26) = 78;
velstarter(27) = 0;
velstarter(28) = 86;
velstarter(29) = 66;
velstarter(30) = 94;

EMGstarter(26) = 2506;
EMGender(26) = 9834;
EMGstarter(27) = 0;
EMGender(27) = 0;
EMGstarter(28) = 4027;
EMGender(28) = 10470;
EMGstarter(29) = 3793;
EMGender(29) = 11090;
EMGstarter(30) = 4139;
EMGender(30) = 13580;
for i = 26:30
   disp((EMGender(i)-EMGstarter(i))/1926)
   eval(['MotionSize = size(Motion.trial', num2str(i), ');'])
   disp(MotionSize(1))
end

for i = 1:2
    figure(1);
    subplot(5,2,i)
    averageMotion = zeros(181,1);
    for j = 26:30 
        if velstarter(j)>50
            eval(['posX = Motion.trial', num2str(j), '(:,', num2str(i*2-1), ');'])
            eval(['posY = Motion.trial', num2str(j), '(:,', num2str(i*2), ');'])
            pos = sqrt((posX.^2 + posY.^2));
            pos = pos(velstarter(j) + FrontTime * Motionfs: velstarter(j) + BackTime * Motionfs);
            averageMotion = averageMotion + pos;
            plot(Motionlen,pos, 'k')
            hold on
        end   
    end
    plot(Motionlen,averageMotion/4, 'r', 'LineWidth',2)
    figure(2);
    subplot(5,2,i)
    plot(Motionlen, averageMotion/4, 'k', 'LineWidth',2)
    hold on 
end

averageEMG = zeros(3468,7);
for i = 3:9
   figure(1);
   subplot(5,2,i)
   for j = 26:30
      if velstarter(j)>50
          eval(['[EMG_bp,EMG_rt,EMG_lp_20,EMG_lp_6] = EMG_Process(1000*EMG.trial', num2str(j), '(:,', num2str((i-3)*8+2), '),100, 1926, 2);'])
          EMGtemp = EMG_lp_20(EMGstarter(j):EMGender(j));
          EMGstartpos = round(velstarter(j)/100 * EMGfs + FrontTime * EMGfs);
          EMGtemp = EMGtemp(EMGstartpos: round(EMGstartpos + TotalTime * EMGfs));
          averageEMG(:,i-2) = averageEMG(:,i-2) + EMGtemp;
          plot(EMGlen, EMGtemp, 'k')
          hold on 
      end
   end
    plot(EMGlen, averageEMG(:,i-2)/4, 'r', 'LineWidth',2)
    figure(2);
    subplot(5,2,i)
    plot(EMGlen, averageEMG(:,i-2)/4, 'k', 'LineWidth',2)
    hold on 
end










