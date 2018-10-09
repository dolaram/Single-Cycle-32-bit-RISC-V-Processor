
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity ImmGen is
    Port( 
        inst: in std_logic_vector(31 downto 0);
        imm: out std_logic_vector(31 downto 0));
end ImmGen;

architecture Behavioral of ImmGen is
signal sel: std_logic_vector(1 downto 0);
signal s:std_logic;

begin
sel <= inst(6 downto 5);

-- IMM(0)
imm(0) <= inst(20) when sel = "00" else
            inst(7) when sel = "01" else
            '0' when sel = "10" else
            '0' when sel = "11";
-- IMM(4:1)
imm(4 downto 1) <= inst(24 downto 21) when sel(0) = '0' else
                    inst(11 downto 8);

-- IMM(10:5)
imm(10 downto 5) <= inst(30 downto 25);

-- IMM(11)
 imm(11) <= inst(31) when sel(1) = '0' else
            inst(7);
            
-- IMM(30:12)    
imm(20 downto 12) <= (inst(31) & inst(31) & inst(31) & inst(31) & inst(31) & inst(31) & inst(31) & inst(31) & inst(31));
imm(30 downto 21) <= (inst(31) & inst(31) & inst(31) & inst(31) & inst(31) & inst(31) & inst(31) & inst(31) & inst(31) & inst(31));
     
-- IMM(31)
imm(31) <= inst(31);
end Behavioral;