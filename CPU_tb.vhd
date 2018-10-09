
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
entity CPU_tb is
--  Port ( );
end CPU_tb;

architecture Behavioral of CPU_tb is
component CPU is
    port(
        clk,rst,en: in std_logic;
        alu_out: out std_logic_vector(31 downto 0));
end component;

signal clk: std_logic :='0';
signal rst,en: std_logic;
signal alu_out: std_logic_vector(31 downto 0);
--signal period: time := 50ns;
--signal ts: time := 50ns;
begin
CPU1: CPU port map(clk,rst,en,alu_out);
clocking_pro:process
begin
    wait for 20ns;
        clk <= not clk;
    wait for 20ns;
        clk <= not clk;
end process;

sti: process
begin
    wait for 99.9ns;
    rst <='1';
    en <= '1';
    wait for 40ns;
    rst <='0';
    en <= '1';
    wait;
end process;
end Behavioral;
