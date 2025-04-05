# Enhanced Extrinsic Calibration of Acoustic Cameras Using Closed-Form Initialization and Batch Optimization
This is an open-source project aimed at calibrating the extrinsic parameters of an acoustic camera system. The repository contains scripts, functions, and data to estimate, validate, and visualize calibration results for acoustic cameras in both simulation and real-world experiments.

Table of Contents
	•	Overview
	•	Features
	•	Directory Structure
	•	Getting Started
	•	Prerequisites
	•	Installation
	•	Usage
	•	Data Description
	•	Contributing
	•	License
	•	Contact

⸻

Overview

Acoustic camera calibration involves determining the position and orientation of an acoustic sensor array relative to a visual camera or other reference coordinate system. Accurate extrinsic calibration is crucial for many applications, including:
	•	3D localization of sound sources
	•	Augmented reality overlays combining visual and acoustic information
	•	Robotics and UAV systems that rely on multimodal sensor fusion

This repository provides MATLAB scripts (and supporting data) for simulating and testing different calibration methods. It also offers tools to analyze the calibration’s convergence, accuracy, and robustness.

⸻

Features
	•	Simulation Scripts: Evaluate calibration methods in a controlled environment.
	•	Experiment Scripts: Real-world data collection and calibration routines.
	•	Visualization Tools: Plot and analyze calibration error, convergence curves, and final extrinsic parameters.
	•	Modular Functions: Easily adapt or extend for custom calibration workflows.

⸻

Directory Structure

AcousticCameraCalib/
├── Data/
│   ├── 111.txt
│   └── ...           # Contains raw or processed datasets
├── cameraParams/
│   └── ...           # Camera intrinsic parameters or related calibration files
├── func/
│   └── ...           # Core MATLAB functions used throughout the project
├── Experiment_Cm/
│   └── ...           # Scripts and data for real-world experiment calibrations
├── Simulation_Bm/
│   └── ...           # Scripts and data for one set of simulation-based calibrations
├── Simulation_Cm/
│   └── ...           # Scripts and data for another set of simulation-based calibrations
├── location.mat      # Contains location data for the acoustic/visual sensors
├── plot_Exp_Bm.m     # Visualization script for experimental results
├── plot_Sim_Am.m     # Visualization script for simulation results
├── plot_converg.m    # Script to plot convergence curves of calibration algorithms
├── results_range_ours1.mat
│                     # Example results from a calibration run
├── README.md         # Project README
└── ...

	•	Data/: Includes raw and/or processed data for simulations and experiments.
	•	cameraParams/: Holds camera intrinsic parameter files or calibration images.
	•	func/: Utility functions for data processing, calibration, and error evaluation.
	•	Experiment_Cm/, Simulation_Bm/, Simulation_Cm/: Organized sets of scripts and data for various experiments or simulations.
	•	plot_*.m: MATLAB plotting scripts to visualize calibration results and convergence.

⸻

Getting Started

Prerequisites
	•	MATLAB (recommended version: R2021b or later, though most versions should work)
	•	Basic knowledge of MATLAB scripting and data handling

Installation
	1.	Clone the repository:

git clone https://github.com/YourUsername/AcousticCameraCalib.git


	2.	Open the folder in MATLAB (or add it to your MATLAB path).

Usage
	1.	Navigate to the repository folder in MATLAB.
	2.	Run one of the main scripts (e.g., a script in Experiment_Cm or Simulation_Bm) to start the calibration process.

cd AcousticCameraCalib/Experiment_Cm
run main_experiment_calib.m


	3.	Modify parameters or data paths as needed:
	•	Check any .m files in the func/ directory for user-configurable settings.
	•	Update file paths to your own data in Data/ or cameraParams/.
	4.	Visualize the results:
	•	Use plot_Exp_Bm.m, plot_Sim_Am.m, or plot_converg.m to plot calibration accuracy, convergence, and other metrics.

⸻

Data Description
	•	Data/: Contains raw or preprocessed data files (e.g., acoustic signals, reference camera images, or ground-truth positions).
	•	location.mat: A MATLAB .mat file that typically includes sensor array geometry or known reference coordinates.
	•	results_range_ours1.mat: Example output from a calibration run, containing extrinsic parameters, error metrics, etc.

⸻

Contributing

Contributions are welcome! If you would like to:
	1.	Report a bug or request a feature, please open an issue.
	2.	Contribute code via pull requests:
	•	Fork this repository
	•	Create a new branch (git checkout -b feature-XYZ)
	•	Commit your changes
	•	Open a pull request describing your changes

Please ensure your code is well-documented and tested.

⸻

License

This project is licensed under the MIT License. You are free to use, modify, and distribute this software. See the LICENSE file for details.

⸻

Contact
	•	Author: [Your Name or Team Name]
	•	Email: [YourEmail@example.com]
	•	GitHub: YourUsername

Feel free to reach out with questions or suggestions!

⸻

Thank you for using AcousticCameraCalib. We hope it helps streamline your acoustic camera calibration workflow!
