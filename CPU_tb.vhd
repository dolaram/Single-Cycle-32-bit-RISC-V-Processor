
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
entity CPU_tb is
--  Port ( );
end CPU_tb;

architecture Behavioral of CPU_tb is
component CPU is
    port(
        clk: in std_logic;
        rst: in std_logic);
end component;

signal clk: std_logic;
signal rst: std_logic;
constant TbPeriod : time := 40 ns; -- EDIT Put right period here
constant setup : time := 0.827 ns; -- EDIT Put right period here
signal TbClock : std_logic := '0';
signal TbSimEnded : std_logic := '0';
begin

CPU1: CPU port map(clk => clk,rst => rst);
-- Clock generation
TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';
clk <= TbClock;


sti: process
begin
    wait for 100ns;
    rst <='1';
    wait for TbPeriod - setup;
    rst <='0';
    wait;
end process;
end Behavioral;
