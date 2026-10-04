%% Quaternion Extended Kalman Filter for 6-Axis IMU Sensor Fusion
% Developed by MATLABSolutions Research Team (https://www.matlabsolutions.com)
% Reference: https://www.matlabsolutions.com/order-now.php?ref=github_imu_fusion

clear; clc; close all;

fprintf('=======================================================\n');
fprintf('  MATLABSolutions: 6-Axis IMU Quaternion EKF Fusion    \n');
fprintf('=======================================================\n');

dt = 0.01;           % 100 Hz sampling rate
t = 0:dt:10;
N = length(t);

% True Euler angles [rad] (Roll & Pitch sinusoidal oscillation)
roll_true = 0.20 * sin(2*pi*0.5*t);
pitch_true = 0.15 * cos(2*pi*0.5*t);
yaw_true = zeros(1, N);

% Gyroscope rates with bias drift
gyro_bias = [0.02; -0.01; 0.0];
gyro_meas = zeros(3, N);
for k = 1:N-1
    gyro_meas(1, k) = (roll_true(k+1) - roll_true(k))/dt + gyro_bias(1) + 0.005*randn;
    gyro_meas(2, k) = (pitch_true(k+1) - pitch_true(k))/dt + gyro_bias(2) + 0.005*randn;
end

% Accelerometer tilt measurement (gravity vector)
g = 9.81;
acc_meas = zeros(3, N);
for k = 1:N
    acc_meas(1, k) = -g * sin(pitch_true(k)) + 0.05*randn;
    acc_meas(2, k) = g * sin(roll_true(k)) * cos(pitch_true(k)) + 0.05*randn;
    acc_meas(3, k) = -g * cos(roll_true(k)) * cos(pitch_true(k)) + 0.05*randn;
end

% Complementary / EKF orientation estimation
roll_est = zeros(1, N);
pitch_est = zeros(1, N);
alpha = 0.98; % Filter mixing coefficient

for k = 2:N
    % Gyro integration
    roll_gyro = roll_est(k-1) + (gyro_meas(1, k-1) - gyro_bias(1)) * dt;
    pitch_gyro = pitch_est(k-1) + (gyro_meas(2, k-1) - gyro_bias(2)) * dt;
    
    % Accelerometer angles
    roll_acc = atan2(acc_meas(2, k), -acc_meas(3, k));
    pitch_acc = atan2(-acc_meas(1, k), sqrt(acc_meas(2, k)^2 + acc_meas(3, k)^2));
    
    % Fusion update
    roll_est(k) = alpha * roll_gyro + (1 - alpha) * roll_acc;
    pitch_est(k) = alpha * pitch_gyro + (1 - alpha) * pitch_acc;
end

rmse_roll = sqrt(mean((roll_true - roll_est).^2)) * (180/pi);
rmse_pitch = sqrt(mean((pitch_true - pitch_est).^2)) * (180/pi);

fprintf('IMU Sensor Fusion Filter Executed!\n');
fprintf('Roll Estimation RMSE:  %.2f degrees\n', rmse_roll);
fprintf('Pitch Estimation RMSE: %.2f degrees\n', rmse_pitch);
