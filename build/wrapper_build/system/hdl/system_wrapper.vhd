--Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
--Date        : Sat Oct 26 13:23:24 2024
--Host        : Madhu running 64-bit major release  (build 9200)
--Command     : generate_target system_wrapper.bd
--Design      : system_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity system_wrapper is
  port (
    areset : out STD_LOGIC_VECTOR ( 0 to 0 );
    bump_left : out STD_LOGIC_VECTOR ( 0 to 0 );
    bump_right : out STD_LOGIC_VECTOR ( 0 to 0 );
    clk : out STD_LOGIC;
    dig : out STD_LOGIC_VECTOR ( 0 to 0 );
    ground : out STD_LOGIC_VECTOR ( 0 to 0 );
    small_bump_left : out STD_LOGIC_VECTOR ( 0 to 0 );
    small_bump_right : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
end system_wrapper;

architecture STRUCTURE of system_wrapper is
  component system is
  port (
    areset : out STD_LOGIC_VECTOR ( 0 to 0 );
    bump_left : out STD_LOGIC_VECTOR ( 0 to 0 );
    bump_right : out STD_LOGIC_VECTOR ( 0 to 0 );
    small_bump_right : out STD_LOGIC_VECTOR ( 0 to 0 );
    small_bump_left : out STD_LOGIC_VECTOR ( 0 to 0 );
    ground : out STD_LOGIC_VECTOR ( 0 to 0 );
    dig : out STD_LOGIC_VECTOR ( 0 to 0 );
    clk : out STD_LOGIC
  );
  end component system;
begin
system_i: component system
     port map (
      areset(0) => areset(0),
      bump_left(0) => bump_left(0),
      bump_right(0) => bump_right(0),
      clk => clk,
      dig(0) => dig(0),
      ground(0) => ground(0),
      small_bump_left(0) => small_bump_left(0),
      small_bump_right(0) => small_bump_right(0)
    );
end STRUCTURE;
