
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;

entity LSB_ALU is
    port(
        a,b,cin,less:in std_logic;
        control: in std_logic_vector(3 downto 0);
        result,cout: out std_logic);

end LSB_ALU;

architecture Behavioral of LSB_ALU is
component FA is
    port(A,B,Cin:in std_logic;
    S,Cout: out std_logic);
end component;

signal a1,b1,an,bn: std_logic;
signal sum:std_logic;
signal op: std_logic_vector(1 downto 0);
begin
FA1: FA port map(A=>a1,B=>b1,Cin=>cin,S=>sum,Cout=>cout);
an<=control(3);
bn<=control(2);
op<=control(1 downto 0);
a1<= a when an = '0' else 
     (not a) when an = '1';
b1<= b when bn = '0' else 
          (not b) when bn = '1';
result<=(a1 and b1) when op ="00" else
        (a1 or b1) when op ="01" else
        sum when op ="10" else
        less when op ="11";

end Behavioral;