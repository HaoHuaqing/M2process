figure2;
for i = 1:2
    subplot(5,2,i)
    plot(Motionlen, ShamMotion(i,:), 'b', 'LineWidth',2)
end

for i = 3:9
    subplot(5,2,i)
    plot(EMGlen, ShamEMG(i,:), 'b', 'LineWidth',2)
end
hold on