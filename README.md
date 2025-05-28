# Saybolt Viscometer Project

**Ahmed M. Bsher**<br>
ahmedbsher999@gmail.com<br>
**Alexandria University – Faculty of Engineering** – Mechanical Engineering

---

## Project Overview

This project is a Semi-Automated Saybolt Viscometer designed to measure the kinematic viscosity of Newtonian fluids. It combines mechanical design, sensor technology, microcontroller programming, and data analysis to provide a low-cost, modern alternative to traditional viscometers.

The viscometer measures the time taken for a fixed volume (60 ml) of fluid to flow through a standard orifice. This flow time is then used to calculate the fluid's viscosity using calibrated equations.

---

## Key Features

-   **Semi-Automated Measurement:** Uses an ESP32 microcontroller and an HC-SR04 ultrasonic sensor to automate fluid level measurement and time calculation.
-   **Real-Time Display:** LCD screen provides live viscosity readings.
-   **Dual Calibration:** Separate equations for fast-flowing and slow-flowing fluids to ensure accuracy.
-   **Python GUI Calculator:** A Tkinter-based application for easy viscosity calculation.
-   **Uncertainty Analysis:** Detailed MATLAB-based analysis to evaluate measurement accuracy and error sources.
-   **SolidWorks Design:** Precisely designed mechanical enclosure using SolidWorks23.

---

## Technologies and Tools Used

-   **ESP32 Microcontroller:** Main control unit for sensor data processing and output.
-   **HC-SR04 Ultrasonic Sensor:** For measuring fluid levels in the beaker.
-   **16x2 LCD Screen:** To display real-time viscosity readings.
-   **SolidWorks23:** For designing the mechanical enclosure.
-   **Python (Tkinter):** For developing the viscosity calculation GUI.
-   **MATLAB:** For uncertainty analysis.

---

## Project Components

### Mechanical Design

-   Designed in SolidWorks23 with a rectangular box enclosure, LCD screen cutout, and funnel opening.
-   Tab-and-slot construction for easy assembly and stability.
-   Internal support columns for the ultrasonic sensor.

### Sensor and Control System

-   HC-SR04 ultrasonic sensor for fluid level measurement.
-   ESP32 microcontroller for processing sensor data and displaying results.
-   16x2 LCD screen for displaying viscosity readings.

### Software

-   **ESP32 Firmware:** Code to read sensor data, calculate flow time, and display viscosity.
-   **Python GUI (`viscosity_calculation_gui.py`):**
    -   Tkinter application for viscosity calculation based on input time.
    -   Separate calibration equations for fast and slow flows.
-   **MATLAB Scripts:** For uncertainty analysis and error quantification.

---

## Calibration

-   Two sets of calibration equations:
    -   Fast-flowing fluids (water, milk): `v = 0.2447656223 * t - (0.06153034765 / t)`
    -   Slow-flowing fluids (oil): `v = 1.297738228 * t - (-235.6160549 / t)`
-   Calibration constants derived from tests with reference fluids.

---

## Uncertainty Analysis

-   Conducted using MATLAB to evaluate measurement accuracy.
-   Identified sources of uncertainty:
    -   Sensor resolution
    -   Wave reflection
    -   Power supply fluctuations
    -   Fluid properties
    -   Temperature errors
-   Calculated combined and expanded uncertainties to provide a confidence interval.

---

## Getting Started

1.  Clone the repository to your local machine.
2.  Review the `SAYBOLT Viscometer Project Report.pdf` for detailed information.
3.  Explore the `Software` folder for the Python GUI.
4.  Check the `Codes` folder for the ESP32 firmware.
5.  Refer to the `Gallery` for project images.

### Running the Python GUI

1.  Ensure Python and Tkinter are installed.
2.  Navigate to the `Software` folder.
3.  Run `python viscosity_calculation_gui.py`.

---

## Contact

**Ahmed M. Bsher**<br>
ahmedbsher999@gmail.com<br>
[LinkedIn](https://www.linkedin.com/in/ahmed-bsher-921242232/)<br>
[Portfolio Website](https://ahmedbsher.github.io/My-Portfolio/)

---

## Tags

`#Engineering` `#Electronics` `#EmbeddedSystems` `#Viscosity` `#SayboltViscometer` `#ESP32` `#Arduino` `#Python` `#Tkinter` `#SolidWorks` `#Sensors` `#Measurement` `#FluidMechanics` `#Project`

---

