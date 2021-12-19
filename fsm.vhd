----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Seguini Giorgio
-- 
-- Create Date: 01.01.2021 00:00:01
-- Design Name: 
-- Module Name: FSM - Behavioral
-- Project Name: Prova Finale Reti Logiche 2020/21
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 1.01 - Final Version
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;


entity project_reti_logiche is
    port (
    i_clk : in std_logic;
    i_rst : in std_logic;
    i_start : in std_logic;
    i_data : in std_logic_vector(7 downto 0);
    o_address : out std_logic_vector(15 downto 0);
    o_done : out std_logic;
    o_en : out std_logic;
    o_we : out std_logic;
    o_data : out std_logic_vector (7 downto 0)
    );
 end project_reti_logiche;
 
 
architecture Behavioral of project_reti_logiche is
    type state_type is (IDLE, FINISH, VALIDATE_DATA,
                        READ, START,
                        READ_COL, 
                        READ_RIG, 
                        READ_FINAL,
                        WRITE,                  
                        COMPUTE_SHIFT);
                        
                        
    signal state : state_type;
    signal next_state : state_type;
    
    signal size: unsigned(15 downto 0);
    signal size_temp : unsigned(15 downto 0);
    signal count: unsigned(15 downto 0);
    signal count_temp: unsigned(15 downto 0);
    
    signal max_val : unsigned(7 downto 0);
    signal max_val_temp : unsigned(7 downto 0);
    signal min_val : unsigned(7 downto 0);
    signal min_val_temp :  unsigned(7 downto 0);
        
    signal shift_level : unsigned(3 downto 0);
    signal shift_level_temp : unsigned(3 downto 0);
    signal max_admissable : unsigned(8 downto 0);
    signal max_admissable_temp : unsigned(8 downto 0);
    
    signal o_address_temp: std_logic_vector(15 downto 0);
    signal o_en_temp: std_logic;
    signal o_we_temp: std_logic;
    signal o_data_temp: std_logic_vector(7 downto 0);
    signal o_done_temp: std_logic;
        
    begin
        state_reg: process(i_clk, i_rst)
        begin
            if i_rst='1' then
                state <= IDLE;
            elsif rising_edge(i_clk) then
                size <= size_temp;
                count <= count_temp;
            
                max_val <= max_val_temp;
                min_val <= min_val_temp;
                
                shift_level <= shift_level_temp;
                max_admissable <= max_admissable_temp;
                
                
                state <= next_state;
            end if;
        end process;
        
        
        delta: process(state, i_start, i_data, size, count, max_val, min_val, shift_level, max_admissable)
        begin
            
            size_temp <= size;
            count_temp <= count;
            
            max_val_temp <= max_val;
            min_val_temp <= min_val;
          
            shift_level_temp <= shift_level;
            max_admissable_temp <= max_admissable;
            
           
            case state is
                when IDLE =>
                    max_val_temp <= (others => '0');
                    min_val_temp <= (others => '1');
                    count_temp <= (others => '0');
                    if i_start ='1' then
                        next_state <= START;
                    elsif i_start = '0' then
                        next_state <= IDLE;
                    end if;
                    
                when START =>
                    next_state <= READ_COL;
                    
                when READ_COL =>
                    size_temp <= unsigned("00000000" & i_data);
                    next_state <= READ_RIG;
                                                                
                when READ_RIG =>
                    size_temp <= unsigned(size(7 downto 0)) * unsigned(i_data);
                    next_state <= VALIDATE_DATA;
                    
                when VALIDATE_DATA =>
                    if count < size then
                         count_temp <= count + 1;
                         next_state <= READ;
                    else
                        next_state <= FINISH;
                    end if;
                    
                when READ =>
                    if(unsigned(i_data) > unsigned(max_val)) then
                        max_val_temp <= unsigned(i_data);
                    end if;
                    if(unsigned(i_data) < unsigned(min_val)) then
                        min_val_temp <= unsigned(i_data);
                    end if;
                    if(count < size) then
                         count_temp <= count + 1;
                         next_state <= READ;
                    else
                        next_state <= COMPUTE_SHIFT;
                    end if;
               
                when COMPUTE_SHIFT =>
                    if max_val - min_val < 1 then
                        shift_level_temp <= "1000";
                        max_admissable_temp <= "000000001";
                    elsif max_val - min_val < 3 then
                        shift_level_temp <= "0111";
                        max_admissable_temp <= "000000010";
                    elsif max_val - min_val < 7 then
                        shift_level_temp <= "0110";
                        max_admissable_temp <= "000000100";
                    elsif max_val - min_val < 15 then
                        shift_level_temp <= "0101";
                        max_admissable_temp <= "000001000";
                    elsif max_val - min_val < 31 then
                        shift_level_temp <= "0100";
                        max_admissable_temp <= "000010000";
                    elsif max_val - min_val < 63 then
                        shift_level_temp <= "0011";
                        max_admissable_temp <= "000100000";
                    elsif max_val - min_val < 127 then
                        shift_level_temp <= "0010";
                        max_admissable_temp <= "001000000";
                    elsif max_val - min_val < 255 then
                        shift_level_temp <= "0001";
                        max_admissable_temp <= "010000000";
                    else
                        shift_level_temp <= "0000";
                        max_admissable_temp <= "100000000";
                    end if;
                    count_temp <= ( others => '0');
                    next_state <= READ_FINAL;
                                                      
                when READ_FINAL =>
                    next_state <= WRITE;
                                       
                when WRITE =>        
                    if count < (size -1) then
                        count_temp <= count +1;
                        next_state <= READ_FINAL;
                    else
                        next_state <= FINISH;
                    end if;

                    
               when FINISH =>
                    if i_start = '0' then
                        next_state <= IDLE;
                    else
                        next_state <= FINISH;
                    end if;
                    
        end case;
end process;


        lambda: process(state, i_start, i_data, size, count, max_val, min_val, shift_level, max_admissable)
        begin
            if (state = START) or (state = READ_COL) or (state = VALIDATE_DATA ) or ((state = READ) or (state = READ_FINAL)) or state = WRITE then
                o_en_temp <= '1';
            else
                o_en_temp <= '0';
            end if;
            
            if state = WRITE then
                o_we_temp <= '1';
            else
                o_we_temp <= '0';
            end if;
            
            if state = FINISH then
                o_done_temp <= '1';
            else
                o_done_temp <= '0';
            end if;
            
            if state = WRITE then
                if(unsigned(i_data) - min_val >= max_admissable) then
                    o_data_temp <= (others => '1');
                else
                    o_data_temp <= std_logic_vector(shift_left( (unsigned(i_data) - min_val),   to_integer(unsigned(shift_level))));                               
                end if;
            else
                o_data_temp <= (others => '0');
            end if;
            
            if (state = START) then
                o_address_temp <= (others => '0');
            elsif (state = READ_COL ) then
                o_address_temp <= (0 => '1', others => '0');
            elsif (state = VALIDATE_DATA ) then
                o_address_temp <= (1 => '1', others => '0');
            elsif ((state = READ) or (state = READ_FINAL)) then
                o_address_temp <= std_logic_vector(count + 2);
            elsif state = WRITE then
                o_address_temp <= std_logic_vector(count + 2 + size);
            else
                o_address_temp <= (others => '0');
            end if;
            
        end process;
    
    
        output_reg: process(i_clk, i_rst)
        begin
            if i_rst='1' then
                o_address <= (others => '0');
                o_en <= '0';
                o_we <= '0';
                o_data <= (others => '0');
                o_done <= '0';
            elsif falling_edge(i_clk) then
                o_address <= o_address_temp;
                o_en <= o_en_temp;
                o_we <= o_we_temp;
                o_data <= o_data_temp;
                o_done <= o_done_temp;
            end if;
        end process;
    
    
end behavioral;