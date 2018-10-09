
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

entity DMem is
    port(
        clk,dmw,dmr: in std_logic;
        ad: in std_logic_vector( 31 downto 0);
        wr_dt: in std_logic_vector( 31 downto 0);
        do: out std_logic_vector( 31 downto 0));
end DMem;

architecture Behavioral of DMem is
-- define the new type for the RAM 40x32
type RAM_ARRAY is array (0 to 39) of std_logic_vector(31 downto 0);
-- initiakize the array 
signal RAM: RAM_ARRAY := (
    x"00000005",x"00000003",x"00000002",x"00000001",
    x"00000004",x"00000005",x"00000006",x"00000007",
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
do <= RAM(to_integer(unsigned(ad))) when dmr = '1' else
        (others => 'Z') when dmr = '0';
        
process(clk)
begin
    --Syncronous Write
    if(rising_edge(clk)) then
    -- when write dmw= 1, 
        if(dmw = '1') then
            -- write input data into RAM at the provided address
            RAM(to_integer(unsigned(ad))) <= wr_dt;
            -- The index of the RAM array type needs to be integer so
            -- converts RAM_ADDR from std_logic_vector -> Unsigned -> Interger using numeric_std library
        end if;
    end if;
end process;
end Behavioral;