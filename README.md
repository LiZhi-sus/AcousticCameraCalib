# Enhanced Extrinsic Calibration of Acoustic Cameras Using Closed-Form Initialization and Batch Optimization
This repository contains the official implementation of our paper:
"Enhanced Extrinsic Calibration of Acoustic Cameras Using Closed-Form Initialization and Batch Optimization".
It provides scripts, functions, and data to estimate, validate, and visualize calibration results of acoustic camera systems in both simulation and real-world experiments.


---

## 📁 Data Folder Details

The `data/` folder contains:
- **Raw measurement data**, named ‘my_measurement’, including TDOA measurements and corresponding calibration board images used in the experiments.
- **Saved `.mat` result files** from the experiments, used for plotting and analysis. The names correspond to the sections in the article, such as 'Sim_A'.

---

## 🚀 Usage

Make sure you have all dependencies in your MATLAB path (`func/` in particular), then run:

```matlab
% Run synthetic simulation using the sound source locations in 'location.mat':
run('Simulation_A.m')
run('Simulation_B.m')
run('Simulation_C.m')
% Run fixed real-data experiment
run('Experiment_B.m')
run('Experiment_C.m')
```
Then you will get the results corresponding to each subsection of the paper.

The generated .mat result files are saved in the **root directory** or `data/`, and can be used for plotting and reporting. Figures can be reproduced using the provided scripts `plot_Sim_A.m`, `plot_Exp_B.m`, etc.
