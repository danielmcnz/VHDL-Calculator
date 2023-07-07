# FPGA Calculator

A calculator was designed and programmed on an FPGA custom board using VHDL.
Figure 1 shows a setup of the board in a remote lab. 
The sources folder contains the code, the constraints folder contains predefined values for hardware I/O, and the simulation folder contains two test benches.
One testbench checks the ALU and ensures the ALU works as intended. The other test bench checks that the two's compliment logic works correctly.

<p align="center">
  <img src="https://github.com/danielmcnz/VHDL-Calculator/assets/24379868/6f54d693-e2b8-4ae5-871d-3e4a62a48e6a" />

  <p align="center">Figure 1: FPGA Board used for programming the calculator</p>
</p>

## Controls
The board comprises of 16 switches at the bottom of Figure 1, as well as five buttons to the top right of the seven segment display.
The 16 switches are used for entering numerical values into the registers that stored the inputted numbers and the desired operator, 
while the five buttons are used for moving between operators (i.e. move to entering the operand once the first number has been entered).

## Sequence of Operations
- The calculator first expects a binary number, using the switches to input a value, which is shown on the seven segment display.
- The middle of the five buttons can be pressed to move to the next stage, where a binary number from 0 to 4 is entered to determine the type of operator used for the calcuation.
(00 = addition, 01 = subtraction, 10 = multiplication, 11 = squared)
- The second binary number can then be inputted.
- The middle button again needds to be pressed to now show the result of the operation on the seven segment display.
- The left and right buttons can be used to move left and right throughout the whole calculation.
This helps to view which numbers were entered and/or the operator used.
