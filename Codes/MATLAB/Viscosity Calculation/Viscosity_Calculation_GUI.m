clc,clear

A_FAST = 0.2447656223;  % Coefficient for t < 10s
B_FAST = 0.06153034765; % Coefficient for t < 10s
A_SLOW = 1.297738228;   % Coefficient for t >= 10s
B_SLOW = -235.6160549;  % Coefficient for t >= 10s
TIME_THRESHOLD = 10.0;  % Time threshold in seconds

% Get time input from user
t = input('Enter the time (in seconds): ');

% Validate input
if t <= 0
    fprintf('Error: Time must be positive!\n');
else
    % Calculate viscosity based on time
    if t < TIME_THRESHOLD
        % Fast flow equation: ? = A_FAST * t - B_FAST / t
        viscosity = A_FAST * t - B_FAST / t;
        fprintf('Using fast flow equation (t < 10s)\n');
    else
        % Slow flow equation: ? = A_SLOW * t - B_SLOW / t
        viscosity = A_SLOW * t - B_SLOW / t;
        fprintf('Using slow flow equation (t >= 10s)\n');
    end
    
    % Display result
    fprintf('Time: %.2f seconds\n', t);
    fprintf('Viscosity: %.4f cSt\n', viscosity); % Added unit (cSt)
end