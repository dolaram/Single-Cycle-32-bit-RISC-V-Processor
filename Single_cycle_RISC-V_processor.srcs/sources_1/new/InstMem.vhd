
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

entity InstMem is
    port(
        clk: in std_logic;
        ad: in std_logic_vector(31 downto 0);
        int: out std_logic_vector(31 downto 0));
end InstMem;

architecture Behavioral of InstMem is
-- define new type 
type RAM_ARRAY is array (0 to 31) of std_logic_vector( 31 downto 0);
signal addr: std_logic_vector(31 downto 0);
-- initialize the array 
signal RAM: RAM_ARRAY :=(
    x"00013083",x"00103103",x"00303183",x"403080B3",
    x"00220233",x"00008263",x"FE000DE3",x"00000000",
    x"00000000",x"00000000",x"00000000",x"00000000",
    x"00000000",x"00000000",x"00000000",x"00000000",
    x"00000000",x"00000000",x"00000000",x"00000000",
    x"00000000",x"00000000",x"00000000",x"00000000",
    x"00000000",x"00000000",x"00000000",x"00000000",
    x"00000000",x"00000000",x"00000000",x"00000000");
begin
addr <= '0' & '0' & ad(31 downto 2);
--Asyncronous Read 
int <= RAM(to_integer(unsigned(addr)));
end Behavioral;
