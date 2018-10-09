
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Control_Unit is
    port(
        opcode: in std_logic_vector(6 downto 0);
        dmw,dmr,memreg,rwr,ALUsrc,branch:out std_logic);
end Control_Unit;

architecture Behavioral of Control_Unit is

begin
process(opcode)
begin
    if(opcode = "0110011") then     --- R_type
        branch <= '0';
        ALUsrc <= '0';
        memreg <= '0';
        rwr <= '1';
        dmr <='0';
        dmw <= '0';
    elsif(opcode = "0000011") then  --- load dword
        branch <= '0';
        ALUsrc <= '1';
        memreg <= '1';
        rwr <= '1';
        dmr <='1';
        dmw <= '0';
    elsif(opcode = "0100011") then  ----store dword
        branch <= '0';
        ALUsrc <= '1';
        memreg <= '0'; --X
        rwr <= '0';
        dmr <='0';
        dmw <= '1';
    elsif(opcode = "1100011") then  --- branch eqaul
        branch <= '1';
        ALUsrc <= '0';
        memreg <= '0'; --X
        rwr <= '0';
        dmr <='0';
        dmw <= '0';
    end if;
end process;
end Behavioral;
