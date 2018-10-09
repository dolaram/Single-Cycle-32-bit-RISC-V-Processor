
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

entity REG is
    port(
        clk,rwr: in std_logic;
        wr_dt: in std_logic_vector( 31 downto 0);
        wr: in std_logic_vector( 4 downto 0);
        rd1: in std_logic_vector( 4 downto 0);
        rd2: in std_logic_vector( 4 downto 0);
        dt1: out std_logic_vector( 31 downto 0);
        dt2: out std_logic_vector( 31 downto 0));
end REG;

architecture Behavioral of REG is
-- define the new type for Register 32x32
type REG_ARRAY is array (0 to 31) of std_logic_vector(31 downto 0);
-- initialize the array 
signal REG: REG_ARRAY := (
    x"00000000",x"00000000",x"00000000",x"00000000",
    x"00000000",x"00000000",x"00000000",x"00000000",
    x"00000000",x"00000000",x"00000000",x"00000000",
    x"00000000",x"00000000",x"00000000",x"00000000",
    x"00000000",x"00000000",x"00000000",x"00000000",
    x"00000000",x"00000000",x"00000000",x"00000000",
    x"00000000",x"00000000",x"00000000",x"00000000",
    x"00000000",x"00000000",x"00000000",x"00000000");
begin
--Asyncronous Read
dt1 <= REG(to_integer(unsigned(rd1)));
dt2 <= REG(to_integer(unsigned(rd2)));
process(clk)
begin
    if(rising_edge(clk)) then
        if(rwr = '1') then
            -- write input data into RAM at the provided address
            REG(to_integer(unsigned(wr))) <= wr_dt;
            -- The index of the RAM array type needs to be integer so
            -- converts RAM_ADDR from std_logic_vector -> Unsigned -> Interger using numeric_std library
        end if;
    end if;
end process;
end Behavioral;
