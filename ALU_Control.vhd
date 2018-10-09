----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU_Control is
    port(
        inst:in std_logic_vector(31 downto 0);
        control: out std_logic_vector(3 downto 0));
end ALU_Control;

architecture Behavioral of ALU_Control is
signal opcode: std_logic_vector(6 downto 0);
signal ALUop: std_logic_vector(1 downto 0);
begin
opcode <= inst(6 downto 0);
ALUop <= "00" when opcode = "0000011" else
        "00" when opcode = "0100011" else
        "01" when opcode = "1100011" else
        "10" when opcode = "0110011";
----------------------------------------------------------------------------------
process(inst,ALUop)
begin 
    if(ALUop = "00") then
        control <= "0010";
    elsif(ALUop = "01") then
        control <= "0110";
    elsif(ALUop = "10") then
        if(inst(14 downto 12) = "000") then 
            if(inst(30) = '0') then
                control <= "0010";
            else
                control <= "0110";
            end if;
        elsif(inst(14 downto 12) = "111") then 
            control <= "0000";
        elsif(inst(14 downto 12) = "110") then 
            control <= "0001";    
        end if;
    end if;
end process;
end Behavioral;