%% Read Data
clear
clc
Motionfs = 100;
Files = dir(strcat('D:\Data\M2Data\hhq1106\Motion\'));
LengthFiles = length(Files);
for i = 3:LengthFiles
   trialname = strcat('D:\Data\M2Data\hhq1106\Motion\',Files(i).name);
   disp(trialname)
   eval(['Motion.trial',num2str(i - 2),'=','csvread(trialname,1,0);']);
end

Files = dir(strcat('D:\Data\M2Data\hhq1106\EMG\'));
LengthFiles = length(Files);
for i = 3:LengthFiles
   trialname = strcat('D:\Data\M2Data\hhq1106\EMG\',Files(i).name);
   disp(trialname)
   eval(['EMG.trial',num2str(i - 2),'=','csvread(trialname,1,0);']);
end

disp('Read data completed')

%% Plot FR
FrontTime = -0.5;
BackTime = 1.3;
TotalTime = 1.8;
Motionfs = 100;
EMGfs = 1926;
Motionlen = (1:1:181)/100;
EMGlen = (1:1:3468)/1926;
%velstarter(1) = 131;
velstarter(1) = 171;
velstarter(2) = 145;
velstarter(3) = 123;
velstarter(4) = 94;
velstarter(5) = 108;
velstarter(6) = 114;
velstarter(7) = 105;
velstarter(8)=93;
velstarter(9)=88;
velstarter(10) = 79;


EMGstarter(1) = 3818;
EMGender(1) = 16930;
EMGstarter(2) = 3771;
EMGender(2) = 10680;
EMGstarter(3) = 4208;
EMGender(3) = 11290;
EMGstarter(4) = 4384;
EMGender(4) = 10120;
EMGstarter(5) = 4542;
EMGender(5) = 10840;
EMGstarter(6) = 4618;
EMGender(6) = 10920;
EMGstarter(7) = 3933;
EMGender(7) = 9784;
EMGstarter(8) = 3551;
EMGender(8) = 9524;
EMGstarter(9)=2636;
EMGender(9)=8228;
EMGstarter(10)=3117;
EMGender(10) =9008;

%前向速度Vy>0为正，Vy<0为负
for i = 1:2
    figure(1);
    subplot(5,2,i)
    averageMotion = zeros(181,1);    
    for j = 1:10
        eval(['posX = Motion.trial', num2str(j), '(:,', num2str(i*2-1), ');'])
        eval(['posY = Motion.trial', num2str(j), '(:,', num2str(i*2), ');'])
        pos = sqrt((posX.^2 + posY.^2));
        pos = pos(velstarter(j) + FrontTime * Motionfs: velstarter(j) + BackTime * Motionfs);
        posY = posY(velstarter(j) + FrontTime * Motionfs: velstarter(j) + BackTime * Motionfs);
        if i==1
            averageMotion = averageMotion + pos;
            plot(Motionlen,pos, 'k')
        else
            averageMotion = averageMotion + posY;
            plot(Motionlen,posY, 'k')
        end       
        hold on   
    end
    plot(Motionlen, averageMotion/10, 'r', 'LineWidth',2)
    figure(2);
    subplot(5,2,i)
    plot(Motionlen, averageMotion/10, 'r', 'LineWidth',2)
    hold on  
end

EMGMatrix = [];
averageEMG = zeros(3468,7);
for i = 3:9
   figure(1);
   subplot(5,2,i)
   totalEMG = [];
   for j = 1:10
      eval(['[EMG_bp,EMG_rt,EMG_lp_20,EMG_lp_6] = EMG_Process(1000*EMG.trial', num2str(j), '(:,', num2str((i-3)*8+2), '),100, 1926, 2);'])
      EMGtemp = EMG_lp_20(EMGstarter(j):EMGender(j));
      EMGstartpos = round(velstarter(j)/100 * EMGfs + FrontTime * EMGfs);
      EMGtemp = EMGtemp(EMGstartpos: round(EMGstartpos + TotalTime * EMGfs));
      totalEMG = cat(1, totalEMG, EMGtemp);
      averageEMG(:,i-2) = averageEMG(:,i-2) + EMGtemp;
      plot(EMGlen, EMGtemp, 'k')
      hold on  
   end
   EMGMatrix = cat(2, EMGMatrix, totalEMG);
    plot(EMGlen, averageEMG(:,i-2)/10, 'r', 'LineWidth',2)
    figure(2);
    subplot(5,2,i)
    plot(EMGlen, averageEMG(:,i-2)/10, 'r', 'LineWidth',2)
    hold on  
end


%% Plot LR
FrontTime = -0.5;
BackTime = 1.3;
TotalTime = 1.8;
Motionfs = 100;
EMGfs = 1926;
Motionlen = (1:1:181)/100;
EMGlen = (1:1:3468)/1926;

velstarter(11) = 65;
velstarter(12) = 71;
velstarter(13) = 73;
velstarter(14) = 59;
velstarter(15) = 61;
velstarter(16) = 66;
velstarter(17) = 65;
velstarter(18) = 73;
velstarter(19) = 75;
velstarter(20) = 51;


EMGstarter(11) = 3257;
EMGender(11) = 8162;
EMGstarter(12) = 2946;
EMGender(12) = 7933;
EMGstarter(13) = 3558;
EMGender(13) = 8535;
EMGstarter(14) = 3017;
EMGender(14) = 8281;
EMGstarter(15) = 3410;
EMGender(15) = 8447;
EMGstarter(16) = 4831;
EMGender(16) = 10160;
EMGstarter(17) = 2954;
EMGender(17) = 7655;
EMGstarter(18) = 3068;
EMGender(18) = 7653;
EMGstarter(19) = 3285;
EMGender(19) = 7832;
EMGstarter(20) = 1607;
EMGender(20) = 5643;

for i = 1:2
    figure(1);
    subplot(5,2,i)
    averageMotion = zeros(181,1);    
    tanV = zeros(181,1); 
    for j = 11:20
        eval(['posX = Motion.trial', num2str(j), '(:,', num2str(i*2-1), ');'])
        eval(['posY = Motion.trial', num2str(j), '(:,', num2str(i*2), ');'])
        pos = sqrt((posX.^2 + posY.^2));
        pos = pos(velstarter(j) + FrontTime * Motionfs: velstarter(j) + BackTime * Motionfs);
        posX = posX(velstarter(j) + FrontTime * Motionfs: velstarter(j) + BackTime * Motionfs);
        posY = posY(velstarter(j) + FrontTime * Motionfs: velstarter(j) + BackTime * Motionfs);
        if i ==1
            averageMotion = averageMotion + pos;
            plot(Motionlen,pos, 'k')
        else
            for k = 1:181
                if posX(k)==0
                    tanV(k) = posY(k)*cos(51*pi/180);
                elseif posY(k)==0
                    tanV(k) = posX(k)*cos(39*pi/180);
                elseif posX(k)>0
                    ang = atand(posY(k)/posX(k)) - 39;
                    tanV(k) = pos(k)*cos(ang*pi/180);
                else
                    ang = atand(posY(k)/posX(k)) +180 - 39;
                    tanV(k) = pos(k)*cos(ang*pi/180);
                end
            end   
            averageMotion = averageMotion + tanV;
            plot(Motionlen,tanV, 'k')
        end
                
        hold on   
    end
    plot(Motionlen, averageMotion/10, 'r', 'LineWidth',2)
    figure(2);
    subplot(5,2,i)
    plot(Motionlen, averageMotion/10, 'r', 'LineWidth',2)
    hold on  
end

EMGMatrix = [];
averageEMG = zeros(3468,7);
for i = 3:9
   figure(1);
   subplot(5,2,i)
   totalEMG = [];
   for j = 11:20
      eval(['[EMG_bp,EMG_rt,EMG_lp_20,EMG_lp_6] = EMG_Process(1000*EMG.trial', num2str(j), '(:,', num2str((i-3)*8+2), '),100, 1926, 2);'])
      EMGtemp = EMG_lp_20(EMGstarter(j):EMGender(j));
      EMGstartpos = round(velstarter(j)/100 * EMGfs + FrontTime * EMGfs);
      EMGtemp = EMGtemp(EMGstartpos: round(EMGstartpos + TotalTime * EMGfs));
      averageEMG(:,i-2) = averageEMG(:,i-2) + EMGtemp;
      totalEMG = cat(1, totalEMG, EMGtemp);
      plot(EMGlen, EMGtemp, 'k')
      hold on  
   end
   EMGMatrix = cat(2, EMGMatrix, totalEMG);
    plot(EMGlen, averageEMG(:,i-2)/10, 'r', 'LineWidth',2)
    figure(2);
    subplot(5,2,i)
    plot(EMGlen, averageEMG(:,i-2)/10, 'r', 'LineWidth',2)
    hold on  
end

%% Plot FR2
FrontTime = -0.5;
BackTime = 1.3;
TotalTime = 1.8;
Motionfs = 100;
EMGfs = 1926;
Motionlen = (1:1:181)/100;
EMGlen = (1:1:3468)/1926;


velstarter(21) = 85;
velstarter(22) = 99;
velstarter(23) = 96;
velstarter(24) = 312;
velstarter(25) = 84;
velstarter(26) = 123;
velstarter(27) = 83;
velstarter(28) = 110;
velstarter(29) = 90;
velstarter(30) = 94;

EMGstarter(21) = 2822;
EMGender(21) = 8026;
EMGstarter(22) = 2134;
EMGender(22) = 7691;
EMGstarter(23) = 2853;
EMGender(23) = 8120;
EMGstarter(24) = 2666;
EMGender(24) = 13130;
EMGstarter(25) = 3263;
EMGender(25) = 13710;
EMGstarter(26) = 4887;
EMGender(26) = 18920;
EMGstarter(27) = 2465;
EMGender(27) = 12030;
EMGstarter(28) = 4972;
EMGender(28) = 13630;
EMGstarter(29) = 3435;
EMGender(29) = 15220;
EMGstarter(30) = 3396;
EMGender(30) = 14960;

for i = 1:2
    figure(1);
    subplot(5,2,i)
    averageMotion = zeros(181,1);    
    for j = 21:30 
        eval(['posX = Motion.trial', num2str(j), '(:,', num2str(i*2-1), ');'])
        eval(['posY = Motion.trial', num2str(j), '(:,', num2str(i*2), ');'])
        pos = sqrt((posX.^2 + posY.^2));
        pos = pos(velstarter(j) + FrontTime * Motionfs: velstarter(j) + BackTime * Motionfs);
        posY = posY(velstarter(j) + FrontTime * Motionfs: velstarter(j) + BackTime * Motionfs);
        if i==1
            averageMotion = averageMotion + pos;
            plot(Motionlen,pos, 'k')
        else
            averageMotion = averageMotion + posY;
            plot(Motionlen,posY, 'k')
        end       
        hold on   

    end
    plot(Motionlen, averageMotion/10, 'r', 'LineWidth',2)
    figure(2);
    subplot(5,2,i)
    plot(Motionlen, averageMotion/10, 'r', 'LineWidth',2)
    hold on  
end

EMGMatrix = [];
averageEMG = zeros(3468,7);
for i = 3:9
   figure(1);
   subplot(5,2,i)
   totalEMG = [];
   for j = 21:30 
      eval(['[EMG_bp,EMG_rt,EMG_lp_20,EMG_lp_6] = EMG_Process(1000*EMG.trial', num2str(j), '(:,', num2str((i-3)*8+2), '),100, 1926, 2);'])
      EMGtemp = EMG_lp_20(EMGstarter(j):EMGender(j));
      EMGstartpos = round(velstarter(j)/100 * EMGfs + FrontTime * EMGfs);
      EMGtemp = EMGtemp(EMGstartpos: round(EMGstartpos + TotalTime * EMGfs));
      averageEMG(:,i-2) = averageEMG(:,i-2) + EMGtemp;
      totalEMG = cat(1, totalEMG, EMGtemp);
      plot(EMGlen, EMGtemp, 'k')
      hold on  
   end
   EMGMatrix = cat(2, EMGMatrix, totalEMG);
    plot(EMGlen, averageEMG(:,i-2)/10, 'r', 'LineWidth',2)
    figure(2);
    subplot(5,2,i)
    plot(EMGlen, averageEMG(:,i-2)/10, 'r', 'LineWidth',2)
    hold on  
end

%% 轨迹图FR 
averageMotionX = zeros(181,1);
averageMotionY = zeros(181,1);
FRMotionX = zeros(181,1);
FRMotionY = zeros(181,1);
for j = 1:10
    eval(['posX = Motion.trial', num2str(j), '(:,1);'])
    eval(['posY = Motion.trial', num2str(j), '(:,2);'])
    posX = posX(velstarter(j) + FrontTime * Motionfs: velstarter(j) + BackTime * Motionfs);
    posY = posY(velstarter(j) + FrontTime * Motionfs: velstarter(j) + BackTime * Motionfs);
    FRMotionX = [FRMotionX posX];
    FRMotionY = [FRMotionY posY];
    averageMotionX = averageMotionX + posX;
    averageMotionY = averageMotionY + posY;
    plot(posX,posY,'Color',[230/255 200/255 230/255])
    xlim([10000 150000])
    ylim([0 110000])
    hold on
end
plot(averageMotionX/10,averageMotionY/10,'Color',[181/255 43/255 200/255],'linewidth',2)
hold on
plot(80000,5000,'*','Color',[181/255 43/255 200/255],'linewidth',4)
hold on
plot(80000,80000,'*','Color',[181/255 43/255 200/255],'linewidth',4)
hold on

averageMotionX = zeros(181,1);
averageMotionY = zeros(181,1);
LRMotionX = zeros(181,1);
LRMotionY = zeros(181,1);
for j = 11:20
    eval(['posX = Motion.trial', num2str(j), '(:,1);'])
    eval(['posY = Motion.trial', num2str(j), '(:,2);'])
    posX = posX(velstarter(j) + FrontTime * Motionfs: velstarter(j) + BackTime * Motionfs);
    posY = posY(velstarter(j) + FrontTime * Motionfs: velstarter(j) + BackTime * Motionfs);
    LRMotionX = [LRMotionX posX];
    LRMotionY = [LRMotionY posY];
    averageMotionX = averageMotionX + posX;
    averageMotionY = averageMotionY + posY;
    plot(posX,posY,'Color',[190/255 240/255 190/255])
    xlim([10000 150000])
    ylim([0 110000])
    hold on
end
plot(averageMotionX/10,averageMotionY/10,'Color',[0/255 162/255 61/255],'linewidth',2)
hold on
plot(30000,10000,'*','Color',[0/255 162/255 61/255],'linewidth',4)
hold on
plot(103750,70000,'*','Color',[0/255 162/255 61/255],'linewidth',4)
hold on

averageMotionX = zeros(181,1);
averageMotionY = zeros(181,1);
FRMotionX = zeros(181,1);
FRMotionY = zeros(181,1);
for j = 21:30
    eval(['posX = Motion.trial', num2str(j), '(:,1);'])
    eval(['posY = Motion.trial', num2str(j), '(:,2);'])
    posX = posX(velstarter(j) + FrontTime * Motionfs: velstarter(j) + BackTime * Motionfs);
    posY = posY(velstarter(j) + FrontTime * Motionfs: velstarter(j) + BackTime * Motionfs);
    FRMotionX = [FRMotionX posX];
    FRMotionY = [FRMotionY posY];
    averageMotionX = averageMotionX + posX;
    averageMotionY = averageMotionY + posY;
    plot(posX,posY,'Color',[200/255 200/255 200/255])
    xlim([10000 150000])
    ylim([0 110000])
    hold on
end
plot(averageMotionX/10,averageMotionY/10,'Color',[100/255 100/255 100/255],'linewidth',2)
hold on
plot(80000,10000,'*','Color',[100/255 100/255 100/255],'linewidth',4)
hold on
plot(80000,60000,'*','Color',[100/255 100/255 100/255],'linewidth',4)
hold on