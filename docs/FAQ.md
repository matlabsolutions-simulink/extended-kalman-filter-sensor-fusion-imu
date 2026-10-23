# Extended Kalman Filter Sensor Fusion Imu — Engineering FAQ & Troubleshooting

> Verified solutions to real student and researcher laboratory inquiries.

### Q: How to tune measurement noise covariance R for accelerometer and magnetometer fusion during dynamic acceleration?

**Verified Technical Solution:**

In 6-axis or 9-axis Attitude and Heading Reference Systems (AHRS), accelerometer readings $a_m$ are assumed to reflect gravity $g$. During rapid dynamic maneuvers, linear acceleration corrupts the tilt estimate:

1. **Dynamic Measurement Covariance Inflation:**
   Compute the norm of the measured acceleration $\|a_m\|$. If $\|a_m\| \ne g$, the vehicle is undergoing dynamic acceleration. Inflate measurement noise covariance $R_{\text{acc}}$:
   $$R_{\text{acc,k}} = R_0 \cdot \left( 1 + \gamma \left| \|a_m\| - g \right| \right)$$
   where $\gamma$ is a scaling sensitivity factor.

2. **Quaternion State Propagation:**
   State vector $x = [q_0, q_1, q_2, q_3, b_{gx}, b_{gy}, b_{gz}]^T$ includes quaternion orientation and gyroscope bias. Propagate using gyro rates $\omega_m - b_g$:
   $$q_{k|k-1} = \left( I + \frac{\Delta t}{2} \Omega(\omega) \right) q_{k-1}$$

3. **Convergence Safeguard:**
   Force quaternion normalization ($q = q / \|q\|$) after every measurement update to maintain orthogonal rotation matrix properties.

Explore sensor fusion and aerospace navigation projects at https://www.matlabsolutions.com/projects/sensor-fusion-matlab.php.

---

