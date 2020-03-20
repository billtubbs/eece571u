
% Maryam Kamgarpour
% March 17, 2020
% estimate a linear model for COVID-19 growth in BC
% Data from: https://github.com/CSSEGISandData/COVID-19/blob/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Confirmed.csv


clear all; close all; clc;
load('BC_data.mat')
data = BCDATA(1:end)';

% approach 1 - fit a linear model to the log of data
N0 = 41;
M = data(N0:end-1);
y = data(N0+1:end);
N = length(y);
a = (M'*M)^(-1)*M'*y;
Np = 14;
x = zeros(1,N+Np);
x(1,1) = data(N0);
for k = 1:1:N+Np
    x(1,k+1) = a*x(1,k);
end

figure(1);
plot(y,'mx','LineWidth',1.5);
hold on;
plot(x(1,:), 'b','LineWidth',1.5);
xlabel('Days starting from March 2 to March 31', 'FontSize', 16);
ylabel('number of COVID-19', 'FontSize', 16);
lgd = legend('actual cases', 'predicted cases');
lgd.FontSize = 16;
grid on
title('Predicting COVID-19 Growth in BC', 'FontSize', 16);
saveas(gcf, 'covid_growth_bc.png')

