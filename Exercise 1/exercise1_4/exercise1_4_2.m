% Pattern Recognition 2022
% Exercise 1.4 | Bayes Classification
% Part 2
%

clc;
clear all;
close all;

DT = 0.01;

m1 = [3 3];
m2 = [6 6];

S1 = [1.2 0.4; 0.4 1.2];
S2 = [1.2 0.4; 0.4 1.2];


% Contouring the two classes
x1 = [-3:DT:12];
x2 = [-3:DT:12];
[X1,X2] = meshgrid(x1,x2);

Y1 = mvnpdf([X1(:) X2(:)], m1, S1);
Y1R = reshape(Y1,length(x2),length(x1));

Y2 = mvnpdf([X1(:) X2(:)], m2, S2);
Y2R = reshape(Y2,length(x2),length(x1));

% S1 != S2
figure(1);
hold on;
contour(x1,x2,Y1R,[.0001 .001 .01 .05:.1:.95 .99 .999 .9999],'LineColor','b');
contour(x1,x2,Y2R,[.0001 .001 .01 .05:.1:.95 .99 .999 .9999],'LineColor','r');

P1 = [0.1 0.25 0.5 0.75 0.9];
P2 = 1 - P1;
syms x y

hold on;

for i = 1:length(P1)
    y = (67.7 - 2*log(P2(i)/P1(i)) - 7.6*x)/(7.6);
    fplot(y,'--');
    axis([-3 12 -3 12]);
end

title('The 2 data classes and the decision limits when S1 = S2');
legend('1st Class', '2nd Class', 'P(\omega_1)=0.1', 'P(\omega_1)=0.25', 'P(\omega_1)=0.5','P(\omega_1)=0.75', 'P(\omega_1)=0.9')
hold off;
grid on;


