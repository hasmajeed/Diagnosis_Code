figure;
plot3(feature_tr12(1:length(feature1_tr12_benign),1),feature_tr12(1:length(feature1_tr12_benign),2),feature_tr12(1:length(feature1_tr12_benign),3),'b*');
hold on;
plot3(feature_tr12(length(feature1_tr12_benign)+1:end,1),feature_tr12(length(feature1_tr12_benign)+1:end,2),feature_tr12(length(feature1_tr12_benign)+1:end,3),'r*');

xlim([0 10]);
ylim([0 0.1]);
zlim([-2000 2000]);

figure;
plot3(feature_val1(1:length(feature1_val1_benign),1),feature_val1(1:length(feature1_val1_benign),2),feature_val1(1:length(feature1_val1_benign),3),'b*');
hold on;
plot3(feature_val1(length(feature1_val1_benign)+1:end,1),feature_val1(length(feature1_val1_benign)+1:end,2),feature_val1(length(feature1_val1_benign)+1:end,3),'r*');
title('stained');
xlim([0 10]);
ylim([0 0.1]);
zlim([-2000 2000]);
