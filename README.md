
# 🔢 Multiplier — VHDL Digital Design

A modular hardware-design project implementing a multiplier architecture in **VHDL**, using a datapath and controller-based structure with reusable digital components.

## 📌 Overview

This project explores digital circuit design and computer architecture by organizing the multiplier into separate functional modules. The main `Multiplier` module brings together the controller, datapath, and counter, while the datapath contains the components required for the arithmetic and register operations.

## 🏗️ Architecture

The design is organized into the following main modules:

- **Multiplier:** Top-level module that integrates the main components.
- **Datapath:** Contains the data-processing components, including shift registers and an adder-subtractor.
- **Controller:** Handles the control logic of the architecture.
- **Counter:** Provides the counter component used by the design.

## 🧩 Hardware Components

The repository includes reusable VHDL components for:

- **Arithmetic operations:** Full adder, N-bit adder, and adder-subtractor functionality.
- **Registers:** Synchronous registers and parallel-in/parallel-out (PIPO) and parallel-in/serial-out (PISO) shift-register structures.
- **Control and sequencing:** Controller and counter modules.

## 🛠️ Technologies

![VHDL](https://img.shields.io/badge/Language-VHDL-543978?style=flat-square)
![Digital Logic](https://img.shields.io/badge/Domain-Digital%20Logic-0A7D91?style=flat-square)
![Computer Architecture](https://img.shields.io/badge/Domain-Computer%20Architecture-2E7D32?style=flat-square)

## 🎯 Learning Objectives

- Practice modular digital-system design using VHDL.
- Understand the separation of datapath and control logic.
- Build reusable arithmetic and register components.
- Explore the integration of digital components into a larger hardware design.

## 🚀 Getting Started

1. Clone the repository:

   ```bash
   git clone https://github.com/mbsoroush/Multiplier.git
   ```

2. Open the project files in a VHDL-compatible development environment.
3. Review `Multiplier.vhd` to understand the top-level architecture.
4. Explore the datapath, controller, and component files to understand how the design is organized.


---

<p align="center">
  <i>A digital design project focused on modular architecture and reusable VHDL components.</i>
</p>
