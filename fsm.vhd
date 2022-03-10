-- fsm.vhd: INC projekt
-- Author(s): Kozhevnikov Dmitrii (xkozhe00)
--
library ieee;
use ieee.std_logic_1164.all;
-- ----------------------------------------------------------------------------
--                        Entity declaration
-- ----------------------------------------------------------------------------
entity fsm is
port(
   CLK         : in  std_logic;
   RESET       : in  std_logic;

   -- Input signals
   KEY         : in  std_logic_vector(15 downto 0);
   CNT_OF      : in  std_logic;

   -- Output signals
   FSM_CNT_CE  : out std_logic;
   FSM_MX_MEM  : out std_logic;
   FSM_MX_LCD  : out std_logic;
   FSM_LCD_WR  : out std_logic;
   FSM_LCD_CLR : out std_logic
);
end entity fsm;
-- ----------------------------------------------------------------------------
--                      Architecture declaration
-- ----------------------------------------------------------------------------
architecture begavioral of fsm is
    type t_state is (START, TEST1, TEST2, TEST3, TEST4, TEST5, TEST6, TEST7_0, TEST7_1, TEST8_0, TEST8_1, TEST9_0, TEST9_1, GOOD_PASSWORD, BAD_PASSWORD, PRINT_BAD_MESSAGE, PRINT_GOOD_MESSAGE, FINISH);
    signal present_state, next_state : t_state;

begin
-- -------------------------------------------------------
sync_logic : process(RESET, CLK)
begin
    if (RESET = '1') then
        present_state <= START;
    elsif (CLK 'event AND CLK = '1') then 
        present_state <= next_state;
    end if;
    end process sync_logic;
-- -------------------------------------------------------	 
-- kod1 = 1254860001 	 kod2 = 1254862003
-- -------------------------------------------------------
next_state_logic : process(present_state, KEY, CNT_OF)
begin
   case (present_state) is
   -- - - - - - - - - - - - - - - - - - - - - - -
   when START =>
       next_state <= START;
       if (KEY(1) = '1') then
         next_state <= TEST1;
       elsif (KEY(15) = '1') then
         next_state <= PRINT_BAD_MESSAGE; 
       elsif (KEY(15 downto 0) /= "0000000000000000") then
         next_state <= BAD_PASSWORD;
       end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when TEST1 =>
       next_state <= TEST1;
       if (KEY(2) = '1') then
          next_state <= TEST2;
       elsif (KEY(15) = '1') then
          next_state <= PRINT_BAD_MESSAGE; 
       elsif (KEY(15 downto 0) /= "0000000000000000") then
          next_state <= BAD_PASSWORD;
       end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when TEST2 =>
       next_state <= TEST2;
       if (KEY(5) = '1') then
          next_state <= TEST3;
       elsif (KEY(15) = '1') then
          next_state <= PRINT_BAD_MESSAGE; 
       elsif (KEY(15 downto 0) /= "0000000000000000") then
          next_state <= BAD_PASSWORD;
       end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
	when TEST3 =>
       next_state <= TEST3;
       if (KEY(4) = '1') then
          next_state <= TEST4;
       elsif (KEY(15) = '1') then
          next_state <= PRINT_BAD_MESSAGE; 
       elsif (KEY(15 downto 0) /= "0000000000000000") then
          next_state <= BAD_PASSWORD;
       end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
	when TEST4 =>
       next_state <= TEST4;
       if (KEY(8) = '1') then
          next_state <= TEST5;
       elsif (KEY(15) = '1') then
          next_state <= PRINT_BAD_MESSAGE; 
       elsif (KEY(15 downto 0) /= "0000000000000000") then
          next_state <= BAD_PASSWORD;
       end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
	 when TEST5 =>
       next_state <= TEST5;
       if (KEY(6) = '1') then
          next_state <= TEST6;
       elsif (KEY(15) = '1') then
          next_state <= PRINT_BAD_MESSAGE; 
       elsif (KEY(15 downto 0) /= "0000000000000000") then
          next_state <= BAD_PASSWORD;
       end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
	 when TEST6 =>
       next_state <= TEST6;
       -- kod1
       if (KEY(0) = '1') then 
          next_state <= TEST7_0;
       -- kod2
       elsif (KEY(2) = '1') then
          next_state <= TEST7_1;
       elsif (KEY(15) = '1') then
          next_state <= PRINT_BAD_MESSAGE; 
       elsif (KEY(15 downto 0) /= "0000000000000000") then
          next_state <= BAD_PASSWORD;
       end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
	 when TEST7_0 =>
       next_state <= TEST7_0;
       if (KEY(0) = '1') then
          next_state <= TEST8_0;
       elsif (KEY(15) = '1') then
          next_state <= PRINT_BAD_MESSAGE; 
       elsif (KEY(15 downto 0) /= "0000000000000000") then
          next_state <= BAD_PASSWORD;
       end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
	 when TEST7_1 =>
       next_state <= TEST7_1;
       if (KEY(0) = '1') then
          next_state <= TEST8_1;
       elsif (KEY(15) = '1') then
          next_state <= PRINT_BAD_MESSAGE; 
       elsif (KEY(15 downto 0) /= "0000000000000000") then
          next_state <= BAD_PASSWORD;
       end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
	 when TEST8_0 =>
       next_state <= TEST8_0;
       if (KEY(0) = '1') then
          next_state <= TEST9_0;
       elsif (KEY(15) = '1') then
          next_state <= PRINT_BAD_MESSAGE; 
       elsif (KEY(15 downto 0) /= "0000000000000000") then
          next_state <= BAD_PASSWORD;
       end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
	 when TEST8_1 =>
       next_state <= TEST8_1;
       if (KEY(0) = '1') then
          next_state <= TEST9_1;
       elsif (KEY(15) = '1') then
          next_state <= PRINT_BAD_MESSAGE; 
       elsif (KEY(15 downto 0) /= "0000000000000000") then
          next_state <= BAD_PASSWORD;
       end if;
	-- - - - - - - - - - - - - - - - - - - - - - -		 
	 when TEST9_0 =>
       next_state <= TEST9_0;
       if (KEY(1) = '1') then
          next_state <= GOOD_PASSWORD;
       elsif (KEY(15) = '1') then
          next_state <= PRINT_BAD_MESSAGE; 
       elsif (KEY(15 downto 0) /= "0000000000000000") then
          next_state <= BAD_PASSWORD;
       end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when TEST9_1 =>
       next_state <= TEST9_1;
       if (KEY(3) = '1') then
          next_state <= GOOD_PASSWORD;
       elsif (KEY(15) = '1') then
          next_state <= PRINT_BAD_MESSAGE; 
       elsif (KEY(15 downto 0) /= "0000000000000000") then
          next_state <= BAD_PASSWORD;
       end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	--            Messaging
   -- - - - - - - - - - - - - - - - - - - - - - -
	when PRINT_BAD_MESSAGE =>
       next_state <= PRINT_BAD_MESSAGE;
       if (CNT_OF = '1') then
          next_state <= FINISH;
       end if;	
	-- - - - - - - - - - - - - - - - - - - - - - -
	when GOOD_PASSWORD =>
       next_state <= GOOD_PASSWORD;
       if (KEY(15) = '1') then
          next_state <= PRINT_GOOD_MESSAGE;
       elsif (KEY(15 downto 0) /= "0000000000000000") then
          next_state <= BAD_PASSWORD;
       end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
	when BAD_PASSWORD =>
       next_state <= BAD_PASSWORD;
       if (KEY(15) = '1') then
          next_state <= PRINT_BAD_MESSAGE;
       end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
	when PRINT_GOOD_MESSAGE =>
       next_state <= PRINT_GOOD_MESSAGE;
       if (CNT_OF = '1') then
           next_state <= FINISH;
       end if;
	-- - - - - - - - - - - - - - - - - - - - - - -		 
   when FINISH =>
      next_state <= FINISH;
      if (KEY(15) = '1') then
         next_state <= START; 
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when others =>
      next_state <= START;
   end case;
end process next_state_logic;

-- -------------------------------------------------------
output_logic : process(present_state, KEY)
begin
   FSM_CNT_CE     <= '0';
   FSM_MX_MEM     <= '0';
   FSM_MX_LCD     <= '0';
   FSM_LCD_WR     <= '0';
   FSM_LCD_CLR    <= '0';

   case (present_state) is
   -- - - - - - - - - - - - - - - - - - - - - - -
   when PRINT_BAD_MESSAGE =>
        FSM_CNT_CE <= '1';
        FSM_MX_LCD <= '1';
        FSM_LCD_WR <= '1';
   -- - - - - - - - - - - - - - - - - - - - - - -
    when PRINT_GOOD_MESSAGE =>
        FSM_CNT_CE <= '1';
        FSM_MX_LCD <= '1';
        FSM_MX_MEM <= '1';
        FSM_LCD_WR <= '1';
   -- - - - - - - - - - - - - - - - - - - - - - -
    when FINISH =>
        if (KEY(15) = '1') then
            FSM_LCD_CLR <= '1'; 
        end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
    when others =>
        if (KEY(14 downto 0) /= "000000000000000") then
            FSM_LCD_WR <= '1';
        end if;
        if (KEY(15) = '1') then
            FSM_LCD_CLR <= '1';
        end if;
    end case;
end process output_logic;

end architecture begavioral;

