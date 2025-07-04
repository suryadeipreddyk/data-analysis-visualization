clear all;
close all;
clc;

data = readtable('comparison_of_Big_Titles.xlsx');

category = data.('Category');
carlosAlcaraz = data.('CarlosAlcaraz');
jannikSinner = data.('JannikSinner');

figure;
barh([carlosAlcaraz, jannikSinner], 'grouped');

set(gca, 'YTick', 1:length(category), 'YTickLabel', category);

xlabel('Number of Titles'); 
ylabel('Title Categories'); 
legend({'Carlos Alcaraz', 'Jannik Sinner'}, 'Location', 'SouthEast');
title('Comparison of Big Titles: Alcaraz vs Sinner');
grid on;
