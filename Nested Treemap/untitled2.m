data = readtable('area.xlsx');
cities = data.CITIES;
tempData = data{:, 2:end};

% Latitude
lat = [41.0814, 41.4993, 39.9612, 39.7589, 40.7584, 41.6639, 41.0998, ...
       37.5556, 38.0406, 38.2527, 37.0834, 37.9716, 41.0793, 39.7684, 41.6764];

% Longitude
lon = [-81.5190, -81.6944, -82.9988, -84.1916, -82.5154, -83.5552, -80.6495, ...
       -83.3839, -84.5037, -85.7585, -88.6001, -87.5711, -85.1394, -86.1581, -86.2520];

latLim = [37.0, 42.5];
lonLim = [-89.5, -80.5];

figure;
axesm('mercator', 'MapLatLimit', latLim, 'MapLonLimit', lonLim);

% Load and display state boundaries
states = shaperead('usastatelo', 'UseGeoCoords', true);
geoshow(states, 'FaceColor', [0.9 0.9 0.9], 'EdgeColor', 'black');
title('Greater Cincinnati Tri-State Area');

% State names and centroids
stateNames = {'Ohio', 'Kentucky', 'Indiana'};
stateCentroids = [
    40.4173, -82.9071;
    37.8393, -84.2700;
    40.2672, -86.1349
];

% Add state labels
for i = 1:length(stateNames)
    textm(stateCentroids(i, 1), stateCentroids(i, 2), stateNames{i}, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', ...
        'FontSize', 12, ...
        'Color', 'blue');
end

hold on;
colorbar;
scatterm(lat, lon, 100, mean(tempData, 2), 'filled');
title('Mean Temperature Heatmap (^{\circ}F)');
hold off;