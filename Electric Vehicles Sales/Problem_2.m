clear all;
close all;
clc;

data = readtable('electric_vehicle_sales.xlsx');


years = data.('CalendarYear');
ev_sales = data.('EVSales');
phev_sales = data.('PHEVSales');
total_pev_sales = data.('TotalPEVSales');


figure;
bar(years, [ev_sales, phev_sales], 'stacked');
xlabel('Calendar Year');
ylabel('Sales (Thousands)');
title('Electric Vehicle Sales by Calendar Year, 2011–2023');
legend('EV Sales', 'PHEV Sales','Location','northwest');
grid on;

yticks(0:200:1600);
ylim([0 1600]);