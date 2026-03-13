# Single-Cycle-RISCV-V-Processor
A Single Cycle RISCV-V Processor implemented in Verilog
This project was the final lab for my Digital Logic Laboratory course at the University of California, Irvine. 
The Verilog implementation reflects the knowledge and skills I developed throughout the course.


Project Description:
The top-level processor consists of three modules:
  Controller – generates the main control signals for the processor based on the instruction opcode, determining how data flows through the Datapath.
  ALUController – determines the specific ALU operation to perform using signals from the Controller and Datapath.
  Datapath – contains the hardware components that execute instructions.
  
The Datapath module contains several submodules that implement the core functionality of the processor:
  Program Counter (FlipFlop) – stores the address of the current instruction.
  Instruction Memory – outputs the instruction located at the PC address.
  Register File – stores register values and allows reading and writing of registers.
  Immediate Generator – extracts and sign-extends immediate values from instructions.
  ALU Source Multiplexer – selects the second operand for the ALU.
  ALU – performs arithmetic and logical operations.
  Data Memory – reads or writes data for load and store instructions.
  Mem2Reg Multiplexer – selects the value written back to the register file.
  
The processor functionality can be tested using the tb_processor testbench.
