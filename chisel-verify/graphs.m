%% Coverpoint bcd
bcd = [3 2 1 1 2 0 3 3 2 3 0];
Xbcd = categorical({'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'others'});
bar(Xbcd, bcd);

%% Coverpoint val
val = [10, 0, 6 4];
Xval = categorical({'low', 'bad', 'high',  'others'});
Xval = reordercats(Xval, {'low', 'bad', 'high',  'others'});
bar(Xval, val);

%% Coverpoint a
a = [0, 4, 4, 4, 3, 1, 0, 0, 1, 0, 1, 1, 0, 1, 0, 0];
Xa = 0:15;
bar(Xa, a)
xticks(Xa);


%% Plot ém
close all;
figure('Position', [0 0 500 500]);
subplot(3,1,1);
bar(Xbcd, bcd);
title("Coverpoint BCD");
xlabel("Bins");
ylabel("Hits");
yticks(0:3);
ylim([0 3.3]);
subplot(3,1,2);
bar(Xval, val);
title("Coverpoint VAL");
xlabel("Bins");
ylabel("Hits");
ylim([0 11]);
subplot(3,1,3);
bar(Xa,a);
xticks(Xa);
yticks(0:4);
title("Coverpoint A");
xlabel("Bins");
ylabel("Hits");
ylim([0 4.4]);
exportgraphics(gcf, "coverage.pdf");