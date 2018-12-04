velx = Motion.trial20(:,3);
vely = Motion.trial20(:,4);
vel = sqrt((velx.^2 + vely.^2));
starter = find(vel>0.1*max(vel));
plot(vel)
hold on
disp(starter(1))
plot(starter(1),0,'o')