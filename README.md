# Lemmings Logic on Kria K26

This project implements the classic Lemmings game logic using SystemVerilog on a Kria K26 Robotics board. The game logic includes movement features, such as walking, bumping, jumping, digging, and falling, and is implemented in `top.sv`. The design is tested using `tb2.sv` and integrated into a block design in Vivado with a Zynq MPSoC, GPIO inputs, and array slicing components.

## Project Structure

- **`top.sv`**: SystemVerilog file containing the core game logic.
- **`tb2.sv`**: Testbench to validate `top.sv`.
- **Block Design**: Created in Vivado with a Zynq MPSoC, GPIO inputs, and custom slices.
- **`system_top.sv`**: Custom wrapper for connecting the block design with `top.sv`.
- **`io_map.xdc`**: Constraints file defining IO delays, input specifications, and a PL clock.

## Hardware Platform

- **Board**: Kria K26 Robotics SOM (System on Module)
- **Processor**: Zynq UltraScale+ MPSoC

## Game Features

The game logic supports the following actions:

- **Walk**: Move left or right.
- **Bump**: Detects collisions when moving left or right.
- **Jump**: Character jumps.
- **Dig**: Character digs downward.
- **Fall**: Character falls when unsupported.

### Outputs

The outputs for these actions include:
- **Walk Left**
- **Walk Right**
- **Jump**
- **Dig**
- **"Aah"** (triggered when falling)

## Block Design Overview

The block design created in Vivado includes the following components:

- **Zynq MPSoC**: Provides processing capability.
- **GPIO Ports**: Used for input handling.
- **Slices**: Slice components are used to separate specific inputs from the GPIO array.

Below is the block design diagram:
![Block Design](https://drive.google.com/file/d/1nFb5LIJLOup0f4hYctwPwXYZykjD-sUa/view?usp=sharing)

## Workflow

1. **Design Verification**: `top.sv` is tested with `tb2.sv`.
2. **Vivado Block Design**:
   - Add the Zynq MPSoC processor and GPIO for inputs.
   - Use slices for array input handling, such as `bump_left`, `bump_right`, etc.
3. **Custom Wrapper**: Connects the block design to `top.sv` using `system_top.sv`.
4. **Constraints**: IO settings are configured in `io_map.xdc` for timing and clock requirements.
5. **Bitstream Generation**:
   - Generate the bitstream and export the design.
   - Load the bitstream onto the Kria K26 for hardware deployment.

## Running on Hardware

1. Load the bitstream onto the Kria K26 board.
2. Configure GPIO inputs and ensure clock synchronization as specified in `io_map.xdc`.
3. Test the game logic on the hardware platform.

## Files

- **`top.sv`**: Core game logic.
- **`tb2.sv`**: Testbench for validation.
- **`system_top.sv`**: Wrapper for block design connection.
- **`io_map.xdc`**: IO constraints and delay settings.

## Future Enhancements

- Add more complex game behaviors.
- Enhance GPIO input handling.
- Optimize array slicing for efficiency.

