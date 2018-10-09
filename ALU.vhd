library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;


entity ALU is
    port(
    A,B,less:in std_logic_vector(31 downto 0);
    control: in std_logic_vector(3 downto 0);
    result: out std_logic_vector(31 downto 0);
    cout,zero: out std_logic);
end ALU;

architecture Behavioral of ALU is
component  LSB_ALU is
    port(
        a,b,cin,less:in std_logic;
        control: in std_logic_vector(3 downto 0);
        result,cout: out std_logic);

end component;
signal carry:std_logic_vector(32 downto 0);
signal zero_array:std_logic_vector(32 downto 0);
signal result_out:std_logic_vector(31 downto 0);
begin
    carry(0) <= control(2);
    G1 :for I in 0 to 31 generate
            ALU_LSB1: LSB_ALU port map(a=>A(I),b=>B(I),cin=>carry(I),less=>less(I),control=>control,result=>result_out(I),cout=>carry(I+1));
        end generate;
    result <= result_out;
    cout<= carry(32);
    
    zero_array(0)<= '0';
    G2: for I in 1 to 32 generate
            zero_array(I) <= zero_array(I-1) or result_out(I-1);
    end generate;
    zero <= not zero_array(32);
end Behavioral;
