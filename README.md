# Matrix Multiplication in Verilog

This repository contains a Verilog implementation of **Matrix Multiplication**, structured into a modular design for clarity and efficiency. The design includes a **Datapath**, **Control Unit**, and a **Top Module**, along with a **Testbench** to verify functionality.

## Overview
Matrix multiplication is a fundamental operation in various computational applications, including digital signal processing, machine learning, and scientific computing. This project demonstrates how matrix multiplication can be efficiently implemented using **Hardware Description Language (HDL)** for FPGA or ASIC applications.

## Files in This Repository

1. **`control.v`** - Implements the **control unit** to manage the sequencing and operations of matrix multiplication.
2. **`datapath.v`** - Implements the **datapath**, which includes registers, multipliers, and adders required for matrix computation.
3. **`top_module.v`** - Integrates the control unit and datapath to form the complete matrix multiplication system.
4. **`tb_matrix_multiplication.v`** - Testbench to verify the correctness and functionality of the design.

## Design Details
The matrix multiplication design follows a **FSM-based (Finite State Machine) control** to efficiently handle computation. Below is a high-level breakdown of the operation:

- The **datapath** consists of:
  - Registers to store input matrices.
  - Multipliers and adders to perform matrix element-wise computations.
  - Accumulators to store the sum of product values.
  
- The **control unit** manages:
  - Input fetching.
  - Sequential operations for computing the product of rows and columns.
  - Output storage and final computation completion signal.

## Simulation and Verification
The testbench (**`tb_matrix_multiplication.v`**) is used for simulation. It:
- Provides stimulus (test cases) to the design.
- Checks intermediate results.
- Verifies the correctness of the output matrix.

To simulate the design, use a Verilog simulator such as **ModelSim, VCS, or Xilinx Vivado**:

```sh
# Compile the design and testbench
vlog control.v datapath.v top_module.v tb_matrix_multiplication.v

# Run the simulation
vsim tb_matrix_multiplication

# View the waveform (optional)
add wave *
run -all
