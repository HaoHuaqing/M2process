# M2process

1.每个人每个动作取总长为2*duration的数据，以peak velocity以中心点；
2.每个trial为3468点，对于运动时间较长的病人需要重采样。
3.7通道EMG；
4.FR任务取2个components（成分），LR任务取2个components，FR2（前向重负载）任务取2个components（成分）

文件说明：

HHQ1106为数据预处理，绘制平均速度，轨迹，平均肌电等。
HHQ1106syn为synergy计算

a_4_SynergySimilarity_Output_hhq.m:
先将3个task合并，输入为三个synergy结果，计算单个vector或time profile的接近度（closeness）矩阵，值最大的即配对，再输出经加权的综合相似度，其中还包含转存VAF、计算平均timeprofile以得到贡献度和下一步的画图。需要改变的变量包括comp（使用synergy个数），len_trial（实验组受试者3个task各做了几次），len_trial_standard（对照组受试者3个task各做了几次），EXP（受试者mat文件名字）

a_5_Plot.m:
画某病人某任务某次检测的synergy vector和time profile,并显示其对应的H01（Healthy control 1）哪个成分、标记成相应颜色、显示单个closeness(向量接近度);标记颜色时，可将对比对象如H01的几个成分分别赋予不同颜色，患者的某个成分继而标记成他对应的成分的颜色，这样画图更直观。


SynergySimilarity_Output_EXP1。mat：
所有病人干预前的synergy相似度结果，所有人可放在一起，并输出至excel。

Vel10perc_Pooled_LR_4_C_ave_9H_Syn_Sync.mat：
所有健康受试者的综合synergy(baseline pattern),将9个control数据放在一起视为一组EMG计算得到。


