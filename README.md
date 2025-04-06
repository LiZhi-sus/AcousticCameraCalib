# Enhanced Extrinsic Calibration of Acoustic Cameras Using Closed-Form Initialization and Batch Optimization
This is an open-source project aimed at calibrating the extrinsic parameters of an acoustic camera system. The repository contains scripts, functions, and data to estimate, validate, and visualize calibration results for acoustic cameras in both simulation and real-world experiments.

## 🔬 Experiment Overview

### ✅ `Simulation_A.m`  `Simulation_B.m` `Simulation_C.m`
- Simulates microphone array calibration in 3D space using synthetic measurements.
- Compares different initialization strategies:
  - **Ground truth**
  - **Proposed closed-form linear solver**
  - **Random initialization** (L = 0.1m, 0.5m, 1.0m, 2.0m)
- Output:
  - `Error_Contribution_Sim_A_*.mat`: RMSE on x/y/z/total
  - `Error_Mean_Sim_A_*.mat`: Averaged RMSE results

---

### 📊 `Experiment_B.m`
- Uses real-world data from `data/my_measurement_3/`.
- Evaluates:
  - Ground truth initialization
  - Proposed method with closed-form initial guess
  - Random initializations with L = 0.1m / 0.5m / 1.0m
- Optionally supports noise robustness tests (commented in code).
- Output:
  - `Error_Contribution_Sim_E_*.mat` and `Error_Mean_Sim_E_*.mat`

---

### 📈 `Experiment_C.m`
- Benchmarks 4 calibration methods:
  - `calib_func_00`, `calib_func_01`, `calib_func_02`, `calib_func_03`
- Varies dataset size by number of checkerboard positions: from 3 to 69 (step 3)
- Runs 10 iterations for each configuration to compute average RMSE
- Supports three datasets:
  - `my_measurement_1/`, `my_measurement_2/`, `my_measurement_3/`
- Plots and saves results:
  - `Error_0.mat`, `Error_1.mat`, `Error_2.mat`, `Error_3.mat`

---

## 📁 Data Folder Details

The `data/` folder contains:
- **Raw measurement data** used in the experiments.
- **Saved `.mat` result files** from the experiments, used for plotting and analysis.
- **Exp_C/** folder includes pre-computed error metrics for additional comparisons:
  - `Error_snsr.mat`, `Error_add.mat`, `Error_multi.mat`, `Error_sig.mat`

---

## 🚀 Usage

Make sure you have all dependencies in your MATLAB path (`func/` in particular), then run:

```matlab
% Run synthetic simulation
run('Simulation_A.m')

% Run fixed real-data experiment
run('Experiment_B.m')

% Run benchmark across dataset scales
run('Experiment_C.m')

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
You can get the calibration result after run `plot_Sim_A` and `plot_Exp_B`:

