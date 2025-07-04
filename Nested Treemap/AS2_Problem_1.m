clear; close all; clc;

% Data
regions = { ...
    'Region 1', 'Brighton & Hove', 'Books', 610.00; ...
    'Region 1', 'Brighton & Hove', 'Electronics', 855.00; ...
    'Region 1', 'Brighton & Hove', 'Hardware', 998.00; ...
    'Region 1', 'Brighton & Hove', 'Software', 2020.00; ...
    'Region 1', 'Chichester', 'Home & Garden', 396.00; ...
    'Region 1', 'Chichester', 'Health & Beauty', 580.00; ...
    'Region 1', 'Chichester', 'Sports', 613.00; ...
    'Region 1', 'Chichester', 'Software', 885.00; ...
    'Region 1', 'Chichester', 'Electronics', 891.00; ...
    'Region 1', 'Chichester', 'DIY', 1449.00; ...
    'Region 1', 'Portsmouth', 'Books', 268.00; ...
    'Region 1', 'Portsmouth', 'Home & Garden', 390.00; ...
    'Region 1', 'Portsmouth', 'Electronics', 690.00; ...
    'Region 1', 'Portsmouth', 'DIY', 834.00; ...
    'Region 1', 'Portsmouth', 'Sports', 1008.00; ...
    'Region 1', 'Portsmouth', 'Clothes', 1016.00; ...
    'Region 1', 'Portsmouth', 'Toys & Children', 1201.00; ...
    'Region 2', 'Southampton', 'DIY', 169.00; ...
    'Region 2', 'Southampton', 'Hardware', 604.00; ...
    'Region 2', 'Southampton', 'Electronics', 757.00; ...
    'Region 2', 'Southampton', 'Sports', 1567.00; ...
    'Region 2', 'Winchester', 'Hardware', 524.00; ...
    'Region 2', 'Winchester', 'Sports', 541.00; ...
    'Region 2', 'Winchester', 'Books', 806.00; ...
    'Region 2', 'Winchester', 'Software', 991.00; ...
    'Region 2', 'Winchester', 'Toys & Children', 1079.00; ...
    'Region 2', 'Winchester', 'Electronics', 1661.00 ...
};

% Extract unique regions and branches
unique_regions = unique(regions(:,1));
unique_branches = unique(regions(:,2));

% Assign colors
branch_colors = lines(length(unique_branches));

% Prepare figure
figure('Position', [100, 100, 1200, 900]);
hold on;

% Compute revenue per region
region_revenue = zeros(length(unique_regions), 1);
for i = 1:length(unique_regions)
    region_revenue(i) = sum(cell2mat(regions(strcmp(regions(:,1), unique_regions{i}), 4)));
end

% Compute treemap layout for regions
region_r = treemap(region_revenue / sum(region_revenue));
region_r(4,:) = region_r(4,:) * 0.8;

% Iterate over regions
for r = 1:length(unique_regions)
    current_region = unique_regions{r};
    region_branches = unique(regions(strcmp(regions(:,1), current_region), 2));
    
    % Compute revenue per branch
    branch_revenue = zeros(length(region_branches), 1);
    for b = 1:length(region_branches)
        branch_revenue(b) = sum(cell2mat(regions(strcmp(regions(:,2), region_branches{b}), 4)));
    end
    
    % Compute treemap layout for branches within the region
    branch_r = treemap(branch_revenue / sum(branch_revenue), region_r(3,r), region_r(4,r));
    branch_r(1,:) = branch_r(1,:) + region_r(1,r);
    branch_r(2,:) = branch_r(2,:) + region_r(2,r);
    
    % Draw region outline and label
    rectangle('Position', [region_r(1,r), region_r(2,r), region_r(3,r), region_r(4,r)], ...
              'EdgeColor', [0.5 0.5 0.5], 'LineWidth', 2, 'FaceColor', 'none');
    text(region_r(1,r) + region_r(3,r)/2, region_r(2,r) + region_r(4,r) + 0.02, current_region, ...
         'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 12, 'FontWeight', 'bold');
    
    % Iterate over branches
    for b = 1:length(region_branches)
        branch_idx = find(strcmp(unique_branches, region_branches{b}));
        branch_data = regions(strcmp(regions(:,2), region_branches{b}), :);
        products = unique(branch_data(:,3));
        product_revenue = zeros(length(products),1);
        
        for p = 1:length(products)
            product_revenue(p) = sum(cell2mat(branch_data(strcmp(branch_data(:,3), products{p}), 4)));
        end
        
        % Compute product layout
        product_r = treemap(product_revenue / branch_revenue(b), branch_r(3,b), branch_r(4,b));
        product_r(1,:) = product_r(1,:) + branch_r(1,b);
        product_r(2,:) = product_r(2,:) + branch_r(2,b);
        
        % Draw product rectangles with labels
        for p = 1:length(products)
            color = branch_colors(branch_idx,:) * (0.7 + 0.3*(p/length(products)));
            rectangle('Position', [product_r(1,p), product_r(2,p), product_r(3,p), product_r(4,p)], ...
                      'FaceColor', color, 'EdgeColor', 'w');
            
            if product_r(3,p) > 0.05 && product_r(4,p) > 0.03
                text(product_r(1,p) + product_r(3,p)/2, product_r(2,p) + product_r(4,p)/2, products{p}, ...
                     'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'FontSize', 8, 'FontWeight', 'bold', 'Color', 'k');
            end
        end
        
        % Add branch name
        text(branch_r(1,b) + branch_r(3,b)/2, branch_r(2,b) + branch_r(4,b) + 0.01, region_branches{b}, ...
             'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 9, 'FontWeight', 'bold', 'Color', branch_colors(branch_idx,:));
    end
end
hold off;