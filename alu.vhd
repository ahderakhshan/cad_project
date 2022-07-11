
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;
--use IEEE.math_real.all;
--use ieee.std_logic_unsigned.all;
--use IEEE.std_logic_arith.ALL;

entity alu is
	port( input : in std_logic_vector(40 downto 0);
			output: out std_logic_vector(31 downto 0));
end alu;

architecture Behavioral of alu is

signal first_operator : std_logic_vector(2 downto 0);
signal second_operator : std_logic_vector(2 downto 0);
signal third_operator : std_logic_vector(2 downto 0);
signal first_num : std_logic_vector (7 downto 0);
signal second_num : std_logic_vector (7 downto 0);
signal third_num : std_logic_vector (7 downto 0);
signal forth_num : std_logic_vector (7 downto 0);
signal first_result: std_logic_vector (7 downto 0);
signal second_result: std_logic_vector (7 downto 0);
signal counter: std_logic_vector(7 downto 0):= "00000000";
signal power_result_1:std_logic_vector(31 downto 0);
signal power_result_2:std_logic_vector(45 downto 0);
signal one:std_logic_vector(8 downto 0):="000000001";
signal endd:std_logic_vector(8 downto 0):="010000000";
signal temp_result:std_logic_vector(7 downto 0);
signal temp_result_2:std_logic_vector(7 downto 0);
begin
process (input) begin
		first_operator <= input(40 downto 38);
		second_operator <= input(37 downto 35);
		third_operator <= input(34 downto 32);
		first_num <= input(31 downto 24);
		second_num <= input(23 downto 16);
		third_num <= input(15 downto 8);
		forth_num <= input(7 downto 0); 
--end process;
		----------------------------------------
--process (input) begin
		if (first_operator="000") then
			temp_result <= first_num + second_num;
			first_result <= "000000000000000000000000" & temp_result;
		elsif (first_operator="001") then
			temp_result <= first_num - second_num;
			first_result <= "000000000000000000000000" & temp_result;
		elsif (first_operator="010") then
			--temp_result <= first_num * second_num;
			--first_result <= "0000000000000000" & temp_result;
		elsif (first_operator="011") then
			--temp_result <= first_num / second_num;
			--first_result <= "000000000000000000000000" & temp_result;
			--only power of 2 should be check
		elsif (first_operator="100") then
			--tavan
			
		elsif (first_operator="101") then
			--logaritm
			if ( signed(second_num)<1) then
				first_result<=std_logic_vector(to_signed(-1,32));
			elsif ( signed(second_num)>=1 and signed(second_num)<2) then
				first_result<=std_logic_vector(to_signed(0,32));
			elsif ( signed(second_num)>=2 and signed(second_num) <4) then
				first_result<=std_logic_vector(to_signed(1,32));
			elsif ( signed(second_num) >=4 and signed(second_num) < 8) then
				first_result<=std_logic_vector(to_signed(2,32));
			elsif (signed(second_num)>=8 and signed(second_num) <16) then
				first_result<=std_logic_vector(to_signed(3,32));
			elsif (signed(second_num)>=16 and signed(second_num) <32) then
				first_result<=std_logic_vector(to_signed(4,32));
			elsif (signed(second_num)>=32 and signed(second_num) <64) then
				first_result<=std_logic_vector(to_signed(5,32));
			elsif (signed(second_num)>=64 and signed(second_num) <128) then
				first_result<=std_logic_vector(to_signed(6,32));
			elsif (signed(second_num)>=128 and signed(second_num) <256) then
				first_result<=std_logic_vector(to_signed(7,32));
			end if;
		elsif (first_operator="110") then
			--jazr
			for i in 1 to 100 loop
				if ( i*i <= (signed(second_num)/2)) then
					first_result<= std_logic_vector(to_signed(i,32));
				end if;
			end loop;
		end if;
--end process;
		-------------------------------------
--process (input) begin
		if (third_operator="000") then
			temp_result_2 <= third_num + forth_num;
			second_result <= "000000000000000000000000" & temp_result_2;
		elsif (third_operator="001") then
			temp_result_2 <= third_num - forth_num;
			second_result <= "000000000000000000000000" & temp_result_2;
		elsif (third_operator="010") then
			--temp_result_2 <= third_num * forth_num;
			--second_result <= "0000000000000000" & temp_result_2;
		elsif (third_operator="011") then
			--temp_result_2 <= third_num / forth_num;
			--second_result <= "000000000000000000000000" & temp_result_2;
			--only power of 2 should be check
		elsif (third_operator="100") then
			---power
			
		elsif (third_operator="101") then
			if ( signed(forth_num)<1) then
				second_result<=std_logic_vector(to_signed(-1,32));
			elsif ( signed(forth_num)>=1 and signed(forth_num)<2) then
				second_result<=std_logic_vector(to_signed(0,32));
			elsif ( signed(forth_num)>=2 and signed(forth_num) <4) then
				second_result<=std_logic_vector(to_signed(1,32));
			elsif ( signed(forth_num) >=4 and signed(forth_num) < 8) then
				second_result<=std_logic_vector(to_signed(2,32));
			elsif (signed(forth_num)>=8 and signed(forth_num) <16) then
				second_result<=std_logic_vector(to_signed(3,32));
			elsif (signed(forth_num)>=16 and signed(forth_num) <32) then
				second_result<=std_logic_vector(to_signed(4,32));
			elsif (signed(forth_num)>=32 and signed(forth_num) <64) then
				second_result<=std_logic_vector(to_signed(5,32));
			elsif (signed(forth_num)>=64 and signed(forth_num) <128) then
				second_result<=std_logic_vector(to_signed(6,32));
			elsif (signed(forth_num)>=128 and signed(forth_num) <256) then
				second_result<=std_logic_vector(to_signed(7,32));
			end if;
		elsif (third_operator="110") then
			--jazr
			for j in 1 to 100 loop
				if ( j*j <= (signed(forth_num)/2)) then
					second_result<= std_logic_vector(to_signed(j,32));
				end if;
			end loop;
		end if;
--end process;
		-------------------------------
--process (first_result,second_result) begin
		if (second_operator="000") then
			output <= first_result + second_result;
		
		elsif (second_operator="001") then
			output<= first_result - second_result;
		elsif (second_operator="010") then
			--output <=first_result * second_result;
		elsif (second_operator="011") then
			--output <= "00000000000000000000000000000000" & std_logic_vector(signed(first_result) / signed(second_result));
			--only power of 2 should be check
		elsif (second_operator="100") then
			--power
			
		elsif (second_operator="101") then
			--logaritm
			if ( signed(second_result)<1) then
				output <=std_logic_vector(to_signed(-1,32));
			elsif ( signed(second_result)>=1 and signed(second_result)<2) then
				output<=std_logic_vector(to_signed(0,32));
			elsif ( signed(second_result)>=2 and signed(second_result) <4) then
				output<=std_logic_vector(to_signed(1,32));
			elsif ( signed(second_result) >=4 and signed(second_result) < 8) then
				output<=std_logic_vector(to_signed(2,32));
			elsif (signed(second_result)>=8 and signed(second_result) <16) then
				output<=std_logic_vector(to_signed(3,32));
			elsif (signed(second_result)>=16 and signed(second_result) <32) then
				output<=std_logic_vector(to_signed(4,32));
			elsif (signed(second_result)>=32 and signed(second_result) <64) then
				output<=std_logic_vector(to_signed(5,32));
			elsif (signed(second_result)>=64 and signed(second_result) <128) then
				output<=std_logic_vector(to_signed(6,32));
			elsif (signed(second_result)>=128 and signed(second_result) <256) then
				output<=std_logic_vector(to_signed(7,32));
			end if;
		elsif (second_operator="110") then
			--jazr
			for z in 1 to 100 loop
				if ( z*z <= (signed(second_result)/2)) then
					output<= std_logic_vector(to_signed(z,32));
				end if;
			end loop;
		end if;
end process ;
end Behavioral;

