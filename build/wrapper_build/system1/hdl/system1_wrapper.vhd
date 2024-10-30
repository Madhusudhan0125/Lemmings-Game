--Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
--Date        : Sat Oct 26 00:38:12 2024
--Host        : Madhu running 64-bit major release  (build 9200)
--Command     : generate_target system1_wrapper.bd
--Design      : system1_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity system1_wrapper is
  port (
    aah : out STD_LOGIC_VECTOR ( 0 to 0 );
    areset : in STD_LOGIC_VECTOR ( 0 to 0 );
    bump_left : in STD_LOGIC_VECTOR ( 0 to 0 );
    bump_right : in STD_LOGIC_VECTOR ( 0 to 0 );
    clk : out STD_LOGIC;
    dig : in STD_LOGIC_VECTOR ( 0 to 0 );
    digging : out STD_LOGIC_VECTOR ( 0 to 0 );
    ground : in STD_LOGIC_VECTOR ( 0 to 0 );
    jumping : out STD_LOGIC_VECTOR ( 0 to 0 );
    small_bump_left : in STD_LOGIC_VECTOR ( 0 to 0 );
    small_bump_right : in STD_LOGIC_VECTOR ( 0 to 0 );
    walk_left : out STD_LOGIC_VECTOR ( 0 to 0 );
    walk_right : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
end system1_wrapper;

architecture STRUCTURE of system1_wrapper is
  component system1 is
  port (
    jumping : out STD_LOGIC_VECTOR ( 0 to 0 );
    walk_left : out STD_LOGIC_VECTOR ( 0 to 0 );
    walk_right : out STD_LOGIC_VECTOR ( 0 to 0 );
    aah : out STD_LOGIC_VECTOR ( 0 to 0 );
    digging : out STD_LOGIC_VECTOR ( 0 to 0 );
    areset : in STD_LOGIC_VECTOR ( 0 to 0 );
    bump_left : in STD_LOGIC_VECTOR ( 0 to 0 );
    small_bump_left : in STD_LOGIC_VECTOR ( 0 to 0 );
    bump_right : in STD_LOGIC_VECTOR ( 0 to 0 );
    small_bump_right : in STD_LOGIC_VECTOR ( 0 to 0 );
    ground : in STD_LOGIC_VECTOR ( 0 to 0 );
    dig : in STD_LOGIC_VECTOR ( 0 to 0 );
    clk : out STD_LOGIC
  );
  end component system1;
begin
system1_i: component system1
     port map (
      aah(0) => aah(0),
      areset(0) => areset(0),
      bump_left(0) => bump_left(0),
      bump_right(0) => bump_right(0),
      clk => clk,
      dig(0) => dig(0),
      digging(0) => digging(0),
      ground(0) => ground(0),
      jumping(0) => jumping(0),
      small_bump_left(0) => small_bump_left(0),
      small_bump_right(0) => small_bump_right(0),
      walk_left(0) => walk_left(0),
      walk_right(0) => walk_right(0)
    );
end STRUCTURE;
