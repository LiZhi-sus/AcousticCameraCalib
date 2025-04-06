# Enhanced Extrinsic Calibration of Acoustic Cameras Using Closed-Form Initialization and Batch Optimization
This is an open-source project aimed at calibrating the extrinsic parameters of an acoustic camera system. The repository contains scripts, functions, and data to estimate, validate, and visualize calibration results for acoustic cameras in both simulation and real-world experiments.
## 📁 Data Folder Details

The `data/` folder contains:
- **Raw measurement data** used in the experiments.
- **Saved `.mat` result files** from the experiments, used for plotting and analysis.
- **Exp_C/** folder includes pre-computed error metrics for additional comparisons:
  - `Error_snsr.mat`, `Error_add.mat`, `Error_multi.mat`, `Error_sig.mat`

## 🚀 Usage

Make sure you have all dependencies in your MATLAB path (`func/` in particular), then run:

```matlab
% Run synthetic simulation
run('Simulation_A.m')
run('Simulation_B.m')
run('Simulation_C.m')
% Run fixed real-data experiment
run('Experiment_B.m')
run('Experiment_C.m')
```
You can get the calibration result after run `plot_B` and `plot_E`:

