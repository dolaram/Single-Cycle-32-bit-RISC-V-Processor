
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CPU is
    port(
        clk,rst,en: in std_logic;
        alu_out: out std_logic_vector(31 downto 0));
    
end CPU;

architecture Behavioral of CPU is
-- ________________ PROGRAM COUNTER _____________________
component PC is
    port(
        clk,rst: in std_logic;
        PC_in : in std_logic_vector(31 downto 0);
        PC_out : out std_logic_vector(31 downto 0));
end component;
-- ________________ INSTRUCTION MEMORY _____________________
component InstMem is
    port(
        clk: in std_logic;
        ad: in std_logic_vector(31 downto 0);
        int: out std_logic_vector(31 downto 0));
end component;
-- ________________ IMMEDIATE GENERATION _____________________
component ImmGen is
    Port( 
        inst: in std_logic_vector(31 downto 0);
        imm: out std_logic_vector(31 downto 0));
end component;
-- ________________ REGISTER FILE _____________________
component REG_N is
    port(
        clk,rst,rwr: in std_logic;
        wr_dt: in std_logic_vector( 31 downto 0);
        wr: in std_logic_vector( 4 downto 0);
        rd1: in std_logic_vector( 4 downto 0);
        rd2: in std_logic_vector( 4 downto 0);
        dt1: out std_logic_vector( 31 downto 0);
        dt2: out std_logic_vector( 31 downto 0));
end component;
-- ________________ ALU CONTROL _____________________
component ALU_Control is
    port(
        inst:in std_logic_vector(31 downto 0);
        control: out std_logic_vector(3 downto 0));
end component;
-- ________________ ALU  _____________________
component ALU is
    port(
    A,B,less:in std_logic_vector(31 downto 0);
    control: in std_logic_vector(3 downto 0);
    result: out std_logic_vector(31 downto 0);
    cout,zero: out std_logic);
end component;
-- ________________ DATA MEMORY  _____________________
component DMem is
    port(
        clk,dmw,dmr: in std_logic;
        ad: in std_logic_vector( 31 downto 0);
        wr_dt: in std_logic_vector( 31 downto 0);
        do: out std_logic_vector( 31 downto 0));
end component;
-- ________________ CONTROL_UNIT _______________________
component Control_Unit is
    port(
        opcode: in std_logic_vector(6 downto 0);
        dmw,dmr,memreg,rwr,ALUsrc,branch:out std_logic);
end component;
-- _________________ SIGNALS __________________________
signal PC_in : std_logic_vector(31 downto 0);
signal PC_out: std_logic_vector(31 downto 0);
signal inst: std_logic_vector(31 downto 0);
signal imm: std_logic_vector(31 downto 0);
signal control: std_logic_vector(3 downto 0);

--- _________________ALU inputs _________________________
signal dt1: std_logic_vector( 31 downto 0);
signal dt2: std_logic_vector( 31 downto 0);
signal B: std_logic_vector( 31 downto 0);
signal ALU_result: std_logic_vector( 31 downto 0);
signal wr: std_logic_vector( 4 downto 0);
signal wr_dt: std_logic_vector( 31 downto 0);
signal rd1: std_logic_vector( 4 downto 0);
signal rd2: std_logic_vector( 4 downto 0);

-- _________________ DATA MEM __________________________
signal do: std_logic_vector( 31 downto 0);

--_____________Control Signals ______________________
signal ALUsrc: std_logic;
signal cout: std_logic;
signal zero: std_logic;
signal rwr: std_logic;
signal memreg: std_logic;
-- data memory
signal dmw: std_logic;
signal dmr: std_logic;

-- branch 
signal PCsrc: std_logic;
signal branch: std_logic;
--_____________________________________________________

signal PC_add: std_logic_vector(31 downto 0);
begin

PC1: PC port map(clk=>clk,rst=>rst,PC_in=>PC_in,PC_out=>PC_out);
InstMem1:InstMem port map(clk=>clk,ad=>PC_out,int=>inst);
ImmGen1:ImmGen port map(inst=>inst,imm=>imm);

CU: Control_Unit port map(opcode=>inst(6 downto 0),dmw=>dmw,dmr=>dmr,memreg=>memreg,rwr=>rwr,ALUsrc=>ALUsrc,branch=>branch);

REG1: REG_N port map(clk=>clk,rst=>rst,rwr=>rwr,wr_dt=>wr_dt,wr=>wr,rd1=>rd1,rd2=>rd2,dt1=>dt1,dt2=>dt2);

ALU_Control1: ALU_Control port map(inst=>inst,control=>control);
ALU1: ALU port map(A=>dt1,B=>B,less=>B,control=>control,result=>ALU_result,cout=>cout,zero=>zero);

DMem1: DMem port map(clk=>clk,dmw=>dmw,dmr=>dmr,ad=>ALU_result,wr_dt=>dt2,do=>do);

-- ____________________ CONCURENT LOGIC _______________________
PCsrc <= (branch and zero);
PC_add <= x"00000004" when PCsrc = '0' else
            (imm(30 downto 0) & '0');
PC_in <= PC_out + PC_add;

--___________ Input to ALU _____________________________
B <= dt2 when ALUsrc = '0' else
        imm;
--___________Input to Registers ___________________________
rd1 <= inst(19 downto 15);
rd2 <= inst(24 downto 20);
wr  <= inst(11 downto 7);
wr_dt <= ALU_result when memreg = '0' else
            do;


alu_out <= ALU_result;
end Behavioral;
