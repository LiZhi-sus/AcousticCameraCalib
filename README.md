# Enhanced Extrinsic Calibration of Acoustic Cameras Using Closed-Form Initialization and Batch Optimization
This is an open-source project aimed at calibrating the extrinsic parameters of an acoustic camera system. The repository contains scripts, functions, and data to estimate, validate, and visualize calibration results for acoustic cameras in both simulation and real-world experiments.

---

## 📁 Data Folder Details

The `data/` folder contains:
- **Raw measurement data** used in the experiments.
- **Saved `.mat` result files** from the experiments, used for plotting and analysis.

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
