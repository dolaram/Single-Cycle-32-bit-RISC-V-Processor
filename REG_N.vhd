
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity REG_N is
    port(
    clk,rst,rwr: in std_logic;
    wr_dt: in std_logic_vector( 31 downto 0);
    wr: in std_logic_vector( 4 downto 0);
    rd1: in std_logic_vector( 4 downto 0);
    rd2: in std_logic_vector( 4 downto 0);
    dt1: out std_logic_vector( 31 downto 0);
    dt2: out std_logic_vector( 31 downto 0));
end REG_N;

architecture Behavioral of REG_N is
signal wr_en: std_logic_vector(4 downto 0);
signal do0: std_logic_vector( 31 downto 0);
signal do1: std_logic_vector( 31 downto 0);
signal do2: std_logic_vector( 31 downto 0);
signal do3: std_logic_vector( 31 downto 0);
signal do4: std_logic_vector( 31 downto 0);
begin
--- WRITE DECODER
wr_en <= "00001" when wr(2 downto 0) = "000" else
        "00010" when wr(2 downto 0) = "001" else
        "00100" when wr(2 downto 0) = "010" else
        "01000" when wr(2 downto 0) = "011" else
        "10000" when wr(2 downto 0) = "100";
process(clk)
begin
    if(rising_edge(clk)) then 
        if(rst = '1') then
            do0 <= x"00000000";
            do1 <= x"00000000";
            do2 <= x"00000000";
            do3 <= x"00000000";
            do4 <= x"00000000";
        elsif(rwr = '1') then
            --if(wr_en(0) ='1') then
            --    do0 <= wr_dt;
            --end if;
            
            if(wr_en(1) ='1') then
                do1 <= wr_dt;
            end if;
            
            if(wr_en(2) ='1') then
                do2 <= wr_dt;
                
            end if;
            if(wr_en(3) ='1') then
                do3 <= wr_dt;
            end if;
            if(wr_en(4) ='1') then
                do4 <= wr_dt;
            end if;
        end if;
    end if;
end process;

dt1 <= do0 when rd1(2 downto 0)="000" else
    do1 when rd1(2 downto 0)="001" else
    do2 when rd1(2 downto 0)="010" else
    do3 when rd1(2 downto 0)="011" else
    do4 when rd1(2 downto 0)="100";
dt2 <= do0 when rd2(2 downto 0)="000" else
    do1 when rd2(2 downto 0)="001" else
    do2 when rd2(2 downto 0)="010" else
    do3 when rd2(2 downto 0)="011" else
    do4 when rd2(2 downto 0)="100";
end Behavioral;
        
        
        
        
