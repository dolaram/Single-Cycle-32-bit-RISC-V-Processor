
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ALU_tb is
--  Port ( );
end ALU_tb;

architecture Behavioral of ALU_tb is
component ALU is
    port(
    A,B,less:in std_logic_vector(31 downto 0);
    control: in std_logic_vector(3 downto 0);
    result: out std_logic_vector(31 downto 0);
    cout: out std_logic);
end component;
signal A,B,less:std_logic_vector(31 downto 0);
signal control: std_logic_vector(3 downto 0);
signal result:  std_logic_vector(31 downto 0);
signal cout:  std_logic;
begin
    ALU1: ALU port map (A=>A,B=>B,less=>less,control=>control,result=>result,cout=>cout);
process
begin
    wait for 100ns;
        control<="0010";
        A<=x"00000001";
        B<=x"00000003";
        less<=x"00000000";
    wait for 100ns;
        control<="0010";
        A<=x"00001524";
        B<=x"00001234";
        less<=x"00000000";
    wait for 100ns;
        control<="0110";
        A<=x"00000052";
        B<=x"00000042";
        less<=x"00000000";
    wait for 100ns;
        control<="0110";
        A<=x"00000005";
        B<=x"00000014";
        less<=x"00000000";
    wait;
end process;
end Behavioral;
