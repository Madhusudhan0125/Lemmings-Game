# Lemmings Game Simulation - top.v

## Overview

This project implements the core logic of the **Lemmings Game** in System Verilog. Lemmings are little characters that can walk, dig, fall, and sometimes splat based on the conditions in their environment. The code provided models a basic state machine that handles their movement and behavior, including walking, falling, digging, and splatting when falling from a height that is too great.

The game logic is organized into various states that manage how a lemming reacts to the environment, whether it's walking left or right, falling, digging, or reaching its demise by splatting.

## Design Details

### State Machine

The lemming's behavior is modeled using a finite state machine (FSM), where each state represents a particular action:

- **LEFT**: Lemming is walking to the left.
- **RIGHT**: Lemming is walking to the right.
- **FALLING_LEFT**: Lemming is falling while it was walking left.
- **FALLING_RIGHT**: Lemming is falling while it was walking right.
- **DIGGING_LEFT**: Lemming is digging while facing left.
- **DIGGING_RIGHT**: Lemming is digging while facing right.
- **SPLAT**: Lemming has fallen from too high and splatted.

### Parameters

The state machine uses parameters to encode the various states:

- `LEFT` = 0
- `RIGHT` = 1
- `FALLING_LEFT` = 2
- `FALLING_RIGHT` = 3
- `DIGGING_LEFT` = 4
- `DIGGING_RIGHT` = 5
- `SPLAT` = 6

### Inputs

- **clk**: The clock signal.
- **areset**: Asynchronous reset signal to reset the game state.
- **bump_left**: Indicates that the lemming has bumped into an obstacle while walking left.
- **bump_right**: Indicates that the lemming has bumped into an obstacle while walking right.
- **ground**: Indicates if the lemming is standing on solid ground or is in the air (falling).
- **dig**: Tells the lemming to start digging if it is on the ground.

### Outputs

- **walk_left**: High when the lemming is walking left.
- **walk_right**: High when the lemming is walking right.
- **aah**: High when the lemming is falling.
- **digging**: High when the lemming is digging.

### States and Transitions

- **Walking (LEFT/RIGHT)**: The lemming walks left or right until it hits an obstacle or the ground disappears beneath it. When `bump_left` or `bump_right` is encountered, the lemming reverses direction. If the ground disappears (`ground = 0`), the lemming transitions to a falling state.
  
- **Falling (FALLING_LEFT/FALLING_RIGHT)**: If the lemming falls for too long without hitting the ground, it will "splat." A `counter` is used to track how long the lemming has been falling. If the lemming lands on the ground (`ground = 1`), it either continues walking or splats depending on the height from which it fell.

- **Digging (DIGGING_LEFT/DIGGING_RIGHT)**: The lemming digs when the `dig` signal is high, and it is on the ground. If the ground disappears while digging, the lemming transitions into the falling state.

- **Splatting (SPLAT)**: If the lemming falls from too high, it will "splat," and its journey ends. Once in the `SPLAT` state, the lemming remains there permanently.

### Counters for Falling Duration

Two separate `counter` modules are instantiated: one for falling while facing left (`FALLING_LEFT`) and one for falling while facing right (`FALLING_RIGHT`). These counters measure the duration of the fall, and if the fall lasts too long, they set the `splat_left` or `splat_right` signals, leading the state machine into the `SPLAT` state.

### Default Outputs and State Control

In the `always_comb` block, the output values (`walk_left`, `walk_right`, `aah`, `digging`) are set based on the current state. For example:

- **walk_left** is set high only if the state is `LEFT`.
- **walk_right** is set high only if the state is `RIGHT`.
- **aah** is high during the falling states.
- **digging** is high during the digging states.

### Interface (top_if)

To simplify the wiring of signals in testbenches or other modules, a SystemVerilog interface `top_if` is defined. This interface bundles all the inputs and outputs required to interact with the `top` module.

### Interface Signals

- Inputs: `clk`, `areset`, `bump_left`, `bump_right`, `ground`, `dig`
- Outputs: `walk_left`, `walk_right`, `aaah`, `digging`

## Usage

1. **Simulation**: To simulate this design, you need to instantiate the `top` module in a testbench. You can apply various input signals to simulate walking, falling, digging, and splatting actions in a Lemmings game. Use the `top_if` interface to easily connect and manage signals.

2. **Synthesis**: This design is suitable for synthesis on FPGA platforms. Make sure your FPGA environment and constraints meet the clock requirements of the design.

3. **Counter Module**: Ensure that the counter modules are implemented or instantiated correctly. These counters play a key role in tracking fall duration and determining if the lemming splats.

## File Breakdown

- **top.v**: Contains the main module implementing the lemming state machine.
- **top_if.sv**: Interface file for bundling the inputs and outputs for testbench or higher-level module connection.

## Future Enhancements

- Add more complex actions such as jumping or building bridges.
- Optimize the design for performance in terms of speed and resource usage.
- Implement multiple lemmings and interactions between them to simulate more advanced gameplay.

## Conclusion

This System Verilog design provides a core FSM implementation for the Lemmings game, where lemmings can walk, dig, fall, and splat based on their environment. With a modular structure and interface definition, this design is scalable and can be extended with more complex game mechanics.
