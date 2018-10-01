library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LSB_ALU_tb is
--  Port ( );
end LSB_ALU_tb;

architecture Behavioral of LSB_ALU_tb is
component LSB_ALU is
    port(
        a,b,cin,less:in std_logic;
        control: in std_logic_vector(3 downto 0);
        result,cout: out std_logic);

end component;
signal a,b,cin,less: std_logic;
signal control: std_logic_vector(3 downto 0);
signal result,cout: std_logic;
begin
    uut: LSB_ALU port map(a,b,cin,less,control,result,cout);
    process
    begin
        wait for 100ns;
            a<='1';
            b<='0';
            cin<='0';
            control<="0010";
            less<='0';
        wait for 30ns;
            a<='1';
            b<='1';
            cin<='0';
            control<="0010";
            less<='0';
        wait for 30ns;
            a<='1';
            b<='0';
            cin<='0';
            control<="0000";
            less<='0';
        wait for 30ns;
            a<='1';
            b<='0';
            cin<='0';
            control<="1101";
            less<='0'; 
        wait;
    end process;
end Behavioral;
