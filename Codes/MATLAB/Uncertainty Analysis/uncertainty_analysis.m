clc;clear;

%% Fast fluids %%
%Define Constants and Data
A = 0.244765622;
B = 0.061530348;

ref_viscosity_water = 0.89; % cSt for water
% First 5 readings are for water (original data)
time_water = [3.73; 4.28; 4.28; 3.75; 3.54]; 
% Last 5 readings are for milk (original data)
time_milk = [8.35; 8.03; 7.7; 7.28; 8.24];

%%Functions for Uncertainty Calculation%%
% Function to calculate viscosity from time
calculate_viscosity = @(t) A * t - B ./ t;
% Function to calculate sensitivity coefficient (dv/dt)
calculate_dv_dt = @(t_avg) A + B / (t_avg^2);

%% UNCERTAINTY ANALYSIS FOR WATER %%
fprintf('--- Analysing Water Measurements ---\n');

viscosity_measured_water = calculate_viscosity(time_water);
avg_viscosity_measured_water = mean(viscosity_measured_water);
fprintf('Average Measured Viscosity for Water: %.4f cSt\n', avg_viscosity_measured_water);
fprintf('Reference Viscosity for Water: %.2f cSt\n', ref_viscosity_water);

n_water = length(time_water);
std_dev_t_water = std(time_water);
u_t_water = std_dev_t_water / sqrt(n_water);
fprintf('Standard Uncertainty for Water Time (u_t_water): %.4f seconds\n', u_t_water);

avg_time_water = mean(time_water);
dv_dt_water = calculate_dv_dt(avg_time_water);
fprintf('Sensitivity Coefficient (dv/dt) for Water at average time %.2f s: %.4f cSt/s\n', avg_time_water, dv_dt_water);

u_v_temperature_water = 0; % Set to 0 if temperature effect is negligible
fprintf('Uncertainty in Viscosity due to Temperature for Water (u_v_temperature_water): %.4f cSt (Assumed negligible)\n', u_v_temperature_water);

uc_v_water = sqrt( (dv_dt_water * u_t_water)^2 + (u_v_temperature_water)^2 ); 
fprintf('Combined Standard Uncertainty for Water (uc_v_water): %.4f cSt\n', uc_v_water);

k_water = 2; % Coverage factor for 95% confidence
U_water = k_water * uc_v_water;
fprintf('Expanded Uncertainty for Water (U_water) at 95%% confidence (k=2): %.4f cSt\n', U_water);
fprintf('Water Viscosity: %.4f +/- %.4f cSt (at 95%% confidence)\n\n', avg_viscosity_measured_water, U_water);

%% UNCERTAINTY ANALYSIS FOR MILK %%
fprintf('--- Analysing Milk Measurements ---\n');

viscosity_measured_milk = calculate_viscosity(time_milk);
avg_viscosity_measured_milk = mean(viscosity_measured_milk);
fprintf('Average Measured Viscosity for Milk: %.4f cSt\n', avg_viscosity_measured_milk);

n_milk = length(time_milk);
std_dev_t_milk = std(time_milk);
u_t_milk = std_dev_t_milk / sqrt(n_milk); % Standard uncertainty of the mean time for milk
fprintf('Standard Uncertainty for Milk Time (u_t_milk): %.4f seconds\n', u_t_milk);

avg_time_milk = mean(time_milk);
dv_dt_milk = calculate_dv_dt(avg_time_milk);
fprintf('Sensitivity Coefficient (dv/dt) for Milk at average time %.2f s: %.4f cSt/s\n', avg_time_milk, dv_dt_milk);

u_v_temperature_milk = 0;
fprintf('Uncertainty in Viscosity due to Temperature for Milk (u_v_temperature_milk): %.4f cSt (Assumed negligible)\n', u_v_temperature_milk);

uc_v_milk = sqrt( (dv_dt_milk * u_t_milk)^2 + (u_v_temperature_milk)^2 );
fprintf('Combined Standard Uncertainty for Milk (uc_v_milk): %.4f cSt\n', uc_v_milk);

k_milk = 2; % Coverage factor for 95% confidence
U_milk = k_milk * uc_v_milk;
fprintf('Expanded Uncertainty for Milk (U_milk) at 95%% confidence (k=2): %.4f cSt\n', U_milk);
fprintf('Milk Viscosity: %.4f +/- %.4f cSt (at 95%% confidence)\n', avg_viscosity_measured_milk, U_milk);

%% plotting Water and Milk data points %%

figure; % Create a new figure window

min_overall_time = min([min(time_water), min(time_milk)]); % Smallest time across both
max_overall_time = max([max(time_water), max(time_milk)]); % Largest time across both

t_range = linspace(min_overall_time - 1, max_overall_time + 1, 100);

A_old = 0.244765622; 
B_old = 0.061530348;
v_calculated = A_old * t_range - B_old ./ t_range;

plot(t_range, v_calculated, 'b-', 'LineWidth', 2, 'DisplayName', 'v = A*t - B/t');
hold on;

% Plot average time for Water
avg_t_water = mean(time_water); % Make sure time_water is defined
avg_v_water = A_old * avg_t_water - B_old / avg_t_water;
plot(avg_t_water, avg_v_water, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r', 'DisplayName', 'Avg. Water Measurement');

% Plot average time for Milk 
avg_t_milk = mean(time_milk);
avg_v_milk = A_old * avg_t_milk - B_old / avg_t_milk;
plot(avg_t_milk, avg_v_milk, 'gs', 'MarkerSize', 8, 'MarkerFaceColor', 'g', 'DisplayName', 'Avg. Milk Measurement');

xlabel('Flow Time (seconds)');
ylabel('Kinematic Viscosity (cSt)');
title('Viscometer Equation: Viscosity vs. Flow Time (Water & Milk)');
legend('show', 'Location', 'best');
grid on;
hold off;

%% Slow Fluid %%
% Define Constants and Data
fprintf('\n\n'); 
A = 1.297738228;
B = -235.6160549;

ref_viscosity_corn_oil = 35; % cSt for Corn Oil

% Time measurements (seconds)
time_corn_oil = [13.95; 14.13; 18.94; 16.8; 17.34]; 
% Data for Sesame Oil (seconds)
time_sesame_oil = [20.5; 22.82; 21.06; 19.86; 19.25]; 

%% Functions for Uncertainty Calculation %%

% Function to calculate viscosity from time
calculate_viscosity = @(t) A * t - B ./ t;
% Function to calculate sensitivity coefficient (dv/dt)
calculate_dv_dt = @(t_avg) A + B / (t_avg^2);

%% UNCERTAINTY ANALYSIS FOR CORN OIL %%
fprintf('--- Analysing Corn Oil Measurements ---\n');

viscosity_measured_corn_oil = calculate_viscosity(time_corn_oil);
avg_viscosity_measured_corn_oil = mean(viscosity_measured_corn_oil);
fprintf('Average Measured Viscosity for Corn Oil: %.4f cSt\n', avg_viscosity_measured_corn_oil);
fprintf('Reference Viscosity for Corn Oil: %.2f cSt\n', ref_viscosity_corn_oil);

n_corn_oil = length(time_corn_oil);
std_dev_t_corn_oil = std(time_corn_oil);
u_t_corn_oil = std_dev_t_corn_oil / sqrt(n_corn_oil); % Standard uncertainty of the mean time for corn oil
fprintf('Standard Uncertainty for Corn Oil Time (u_t_corn_oil): %.4f seconds\n', u_t_corn_oil);

avg_time_corn_oil = mean(time_corn_oil);
dv_dt_corn_oil = calculate_dv_dt(avg_time_corn_oil);
fprintf('Sensitivity Coefficient (dv/dt) for Corn Oil at average time %.2f s: %.4f cSt/s\n', avg_time_corn_oil, dv_dt_corn_oil);

u_v_temperature_corn_oil = 0;
fprintf('Uncertainty in Viscosity due to Temperature for Corn Oil (u_v_temperature_corn_oil): %.4f cSt (Assumed negligible)\n', u_v_temperature_corn_oil);

uc_v_corn_oil = sqrt( (dv_dt_corn_oil * u_t_corn_oil)^2 + (u_v_temperature_corn_oil)^2 ); 
fprintf('Combined Standard Uncertainty for Corn Oil (uc_v_corn_oil): %.4f cSt\n', uc_v_corn_oil);

k_corn_oil = 2; % Coverage factor for 95% confidence
U_corn_oil = k_corn_oil * uc_v_corn_oil;
fprintf('Expanded Uncertainty for Corn Oil (U_corn_oil) at 95%% confidence (k=2): %.4f cSt\n', U_corn_oil);
fprintf('Corn Oil Viscosity: %.4f +/- %.4f cSt (at 95%% confidence)\n\n', avg_viscosity_measured_corn_oil, U_corn_oil);


%% UNCERTAINTY ANALYSIS FOR SESAME OIL %%
fprintf('--- Analysing Semsem Oil Measurements ---\n');

viscosity_measured_sesame_oil = calculate_viscosity(time_sesame_oil);
avg_viscosity_measured_sesame_oil = mean(viscosity_measured_sesame_oil);
fprintf('Average Measured Viscosity for Semsem Oil: %.4f cSt\n', avg_viscosity_measured_sesame_oil);

n_sesame_oil = length(time_sesame_oil);
std_dev_t_sesame_oil = std(time_sesame_oil);
u_t_sesame_oil = std_dev_t_sesame_oil / sqrt(n_sesame_oil); % Standard uncertainty of the mean time for sesame oil
fprintf('Standard Uncertainty for Semsem Oil Time (u_t_Semsem_oil): %.4f seconds\n', u_t_sesame_oil);

avg_time_sesame_oil = mean(time_sesame_oil);
dv_dt_sesame_oil = calculate_dv_dt(avg_time_sesame_oil);
fprintf('Sensitivity Coefficient (dv/dt) for Semsem Oil at average time %.2f s: %.4f cSt/s\n', avg_time_sesame_oil, dv_dt_sesame_oil);

u_v_temperature_sesame_oil = 0;
fprintf('Uncertainty in Viscosity due to Temperature for Semsem Oil (u_v_temperature_sesame_oil): %.4f cSt (Assumed negligible)\n', u_v_temperature_sesame_oil);

uc_v_sesame_oil = sqrt( (dv_dt_sesame_oil * u_t_sesame_oil)^2 + (u_v_temperature_sesame_oil)^2 );
fprintf('Combined Standard Uncertainty for Sesame Oil (uc_v_Semsem_oil): %.4f cSt\n', uc_v_sesame_oil);

k_sesame_oil = 2; % Coverage factor for 95% confidence
U_sesame_oil = k_sesame_oil * uc_v_sesame_oil;
fprintf('Expanded Uncertainty for Semsem Oil (U_Semsem_oil) at 95%% confidence (k=2): %.4f cSt\n', U_sesame_oil);
fprintf('Semsem Oil Viscosity: %.4f +/- %.4f cSt (at 95%% confidence)\n', avg_viscosity_measured_sesame_oil, U_sesame_oil);

%% plotting OILS data points %%
figure;
t_range = linspace(min([time_corn_oil; time_sesame_oil]) - 2, max([time_corn_oil; time_sesame_oil]) + 2, 100);
v_calculated = A * t_range - B ./ t_range;
plot(t_range, v_calculated, 'b-', 'LineWidth', 2, 'DisplayName', 'v = A*t - B/t');
hold on;

% Plot average time for Corn Oil
avg_t_corn_oil = mean(time_corn_oil);
avg_v_corn_oil = A * avg_t_corn_oil - B / avg_t_corn_oil;
plot(avg_t_corn_oil, avg_v_corn_oil, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r', 'DisplayName', 'Avg. Corn Oil Measurement');

% Plot average time for Sesame Oil
avg_t_sesame_oil = mean(time_sesame_oil);
avg_v_sesame_oil = A * avg_t_sesame_oil - B / avg_t_sesame_oil;
plot(avg_t_sesame_oil, avg_v_sesame_oil, 'gs', 'MarkerSize', 8, 'MarkerFaceColor', 'g', 'DisplayName', 'Avg. Sesame Oil Measurement');

xlabel('Flow Time (seconds)');
ylabel('Kinematic Viscosity (cSt)');
title('Viscometer Equation: Viscosity vs. Flow Time');
legend('show', 'Location', 'best');
grid on;
hold off;