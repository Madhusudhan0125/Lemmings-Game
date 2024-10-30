# Lemmings Game on Zynq MPSoC with SystemVerilog

This project implements the classic Lemmings game using SystemVerilog. The core game logic is built in `top.sv`, with features like walking, jumping, digging, and bumping. It is tested through a `tb2.sv` testbench and integrated into a block design in Vivado, which includes a Zynq MPSoC processor, GPIO inputs, and custom slices for array slicing.

## Project Structure

- **`top.sv`**: The main SystemVerilog file containing the game logic.
- **`tb2.sv`**: Testbench to validate `top.sv`.
- **Block Design**: Created in Vivado, utilizing the Zynq MPSoC, GPIO ports for input, and custom slices for input array slicing.
- **`system_top.sv`**: Wrapper file for connecting the block design with `top.sv`.
- **`io_map.xdc`**: Constraints file defining IO delays, input specifications, and a PL clock.

## Game Features

The game includes the following features:

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

## Workflow

1. **Design Verification**: `top.sv` is tested and verified with `tb2.sv`.
2. **Vivado Block Design Setup**: 
   - Create a new block design.
   - Add the Zynq MPSoC processor and GPIO for inputs.
   - Use slice components for array input handling.
3. **Custom Wrapper**: Connect the block design with `top.sv` using the `system_top.sv` wrapper.
4. **Constraints**: Apply constraints using `io_map.xdc` to specify timing, delay, and clock requirements.
5. **Bitstream Generation**:
   - Generate the bitstream for the design.
   - Export the design and hardware with the bitstream for deployment on hardware.

## Running the Design on Hardware

1. Load the bitstream onto the Zynq MPSoC.
2. Configure GPIO inputs and ensure clock synchronization as per `io_map.xdc`.
3. Test the game functionality on the hardware platform.

## Files

- **`top.sv`**: Core game logic
- **`tb2.sv`**: Testbench for functional verification
- **`system_top.sv`**: System wrapper for block design
- **`io_map.xdc`**: IO constraints and delay settings

## Future Enhancements

- Add more complex game actions.
- Improve GPIO input handling for additional player controls.





