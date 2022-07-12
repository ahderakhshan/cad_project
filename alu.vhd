
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
--use IEEE.math_real.all;
--use ieee.std_logic_unsigned.all;
--use IEEE.std_logic_arith.ALL;

entity alu is
	port( input : in std_logic_vector(40 downto 0);
			output: out std_logic_vector(63 downto 0));
end alu;

architecture Behavioral of alu is

signal first_operator : std_logic_vector(2 downto 0);
signal second_operator : std_logic_vector(2 downto 0);
signal third_operator : std_logic_vector(2 downto 0);
signal first_num : std_logic_vector (7 downto 0);
signal second_num : std_logic_vector (7 downto 0);
signal third_num : std_logic_vector (7 downto 0);
signal forth_num : std_logic_vector (7 downto 0);
signal first_result: std_logic_vector (31 downto 0);
signal second_result: std_logic_vector (31 downto 0);
signal counter: std_logic_vector(7 downto 0):= "00000000";
signal power_result_1:std_logic_vector(31 downto 0);
signal power_result_2:std_logic_vector(45 downto 0);
signal one:std_logic_vector(8 downto 0):="000000001";
signal endd:std_logic_vector(8 downto 0):="010000000";
signal temp: std_logic_vector(31 downto 0);
begin
process (input) begin
		first_operator <= input(40 downto 38);
		second_operator <= input(37 downto 35);
		third_operator <= input(34 downto 32);
		first_num <= input(31 downto 24);
		second_num <= input(23 downto 16);
		third_num <= input(15 downto 8);
		forth_num <= input(7 downto 0);
		----------------------------------------
		if (first_operator="000") then
			first_result(7 downto 0) <= std_logic_vector(signed(first_num) + signed(second_num));
		elsif (first_operator="001") then
			first_result(7 downto 0) <= std_logic_vector(signed(first_num) - signed(second_num));
		elsif (first_operator="010") then
			first_result(15 downto 0) <= std_logic_vector(signed(first_num) * signed(second_num));
		elsif (first_operator="011") then
			first_result(7 downto 0) <= std_logic_vector(signed(first_num) / signed(second_num));
			--only power of 2 should be check
		elsif (first_operator="100") then
			--tavan
			if (signed(second_num) = "00000000") then
				temp <= "00000000000000000000000000000001";
			else
				temp(7 downto 0) <= std_logic_vector(signed(first_num));
				for i in 2 to to_integer(signed(second_num)) loop
					temp <= std_logic_vector(signed(temp(7 downto 0)) * signed(first_num));
				end loop;
			end if;
			first_result <= temp;
		elsif (first_operator="101") then
			--logaritm
		elsif (first_operator="110") then
			--jazr
			for i in 1 to 100 loop
				if ( i*i <= (signed(second_num)/2)) then
					first_result<= std_logic_vector(to_signed(i,32));
				end if;
			end loop;
		end if;
		-------------------------------------
		if (third_operator="000") then
			second_result(7 downto 0) <= std_logic_vector(signed(third_num) + signed(forth_num));
		elsif (third_operator="001") then
			second_result(7 downto 0) <= std_logic_vector(signed(third_num) - signed(forth_num));
		elsif (third_operator="010") then
			second_result(15 downto 0) <= std_logic_vector(signed(third_num) * signed(forth_num));
		elsif (third_operator="011") then
			second_result(7 downto 0) <= std_logic_vector(signed(third_num) / signed(forth_num));
			--only power of 2 should be check
		elsif (third_operator="100") then
			--power
			if (signed(forth_num) = "00000000") then
				temp <= "00000000000000000000000000000001";
			else
				temp(7 downto 0) <= std_logic_vector(signed(third_num));
				for i in 2 to to_integer(signed(forth_num)) loop
					temp <= std_logic_vector(signed(temp(7 downto 0)) * signed(third_num));
				end loop;
			end if;
			second_result <= temp;
		elsif (third_operator="101") then
			--logaritm
		elsif (third_operator="110") then
			--jazr
			for j in 1 to 100 loop
				if ( j*j <= (signed(forth_num)/2)) then
					second_result<= std_logic_vector(to_signed(j,32));
				end if;
			end loop;
		end if;
		-------------------------------
		if (second_operator="000") then
			output(31 downto 0) <= std_logic_vector(signed(first_result) + signed(second_result));
		elsif (second_operator="001") then
			output(31 downto 0) <= std_logic_vector(signed(first_result) - signed(second_result));
		elsif (second_operator="010") then
			output <= std_logic_vector(signed(first_result) * signed(second_result));
		elsif (second_operator="011") then
			output(31 downto 0) <= std_logic_vector(signed(first_result) / signed(second_result));
			--only power of 2 should be check
		elsif (second_operator="100") then
			--power
			if (signed(second_result) = "00000000") then
				temp <= "00000000000000000000000000000001";
			else
				temp(7 downto 0) <= std_logic_vector(signed(first_result));
				for i in 2 to to_integer(signed(second_result)) loop
					temp <= std_logic_vector(signed(temp(7 downto 0)) * signed(first_result));
				end loop;
			end if;
			output(31 downto 0) <= temp;
		elsif (second_operator="101") then
			--logaritm
		elsif (second_operator="110") then
			--jazr
			for z in 1 to 100 loop
				if ( z*z <= (signed(second_result)/2)) then
					output(31 downto 0)<= std_logic_vector(to_signed(z,32));
				end if;
			end loop;
		end if;
end process;
end Behavioral;

