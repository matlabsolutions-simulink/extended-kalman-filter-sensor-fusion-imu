# 6-Axis IMU Sensor Fusion via Quaternion Extended Kalman Filter

[![MATLAB](https://img.shields.io/badge/MATLAB-R2023b%20%7C%20R2024b-0076A8?logo=mathworks&logoColor=white)](https://www.mathworks.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Domain](https://img.shields.io/badge/Domain-Inertial%20Navigation%20&%20State%20Estimation-lightgrey.svg)](#)

A standalone MATLAB implementation of 6-Axis IMU Sensor Fusion via Quaternion Extended Kalman Filter. Includes the governing dynamics, analytical formulations, and an executable script you can run directly without proprietary third-party dependencies.

## Overview

This repository provides a sensor fusion filter for 6-axis IMU modules (3-axis gyroscope + 3-axis accelerometer). It fuses high-rate gyro angular velocity integration with gravity vector tilt corrections to estimate roll and pitch without gimbal lock.

## Governing Equations & Mathematical Formulation

### Quaternion Kinematics Propagation

$$
\dot{q} = \frac{1}{2} q \otimes \begin{bmatrix} 0 \\ \vec{\omega} \end{bmatrix}
$$

### Accelerometer Gravity Measurement Innovation

$$
z_{\text{acc}} = C(q)^T \begin{bmatrix} 0 \\ 0 \\ -g \end{bmatrix} + v_{\text{acc}}
$$

where $q = [q_0, q_1, q_2, q_3]^T$ is the unit quaternion, $\vec{\omega}$ is the angular velocity from the gyroscope, and $C(q)$ is the direction cosine orientation matrix.

## Getting Started

### Prerequisites
- MATLAB (tested on R2022b through R2024b)
- Standard base MATLAB installation (no paid external toolboxes required for this starter script)

### Running the Code
1. Clone the repository:
   ```bash
   git clone https://github.com/matlabsolutions-simulink/extended-kalman-filter-sensor-fusion-imu.git
   cd extended-kalman-filter-sensor-fusion-imu
   ```
2. Open MATLAB, navigate to the cloned folder, and run:
   ```matlab
   run_imu_sensor_fusion_ekf
   ```

## Need the Complete Simulink or Simscape Model?

If you are working on a university capstone, thesis, or lab assignment and need the complete `.slx` model with Simscape physical networks, custom parameter lookup tables, or automated test harnesses, our team at [MATLABSolutions.com](https://www.matlabsolutions.com/order-now.php?ref=github_extended_kalman_filter_sensor_fusion_imu) provides custom academic simulation and consulting support.

## Technical Inquiries & Contact
- Website: [matlabsolutions.com](https://www.matlabsolutions.com)
- Custom Consulting Portal: [matlabsolutions.com/order-now.php](https://www.matlabsolutions.com/order-now.php)
- Email: info@matlabsolutions.com

## License
This project is open-source under the [MIT License](LICENSE).
