LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity C4M1P4 is port (                 	
   SW: 	in std_logic_vector(8 downto 0); 	

   LEDR:   out std_logic_vector(9 downto 0);
   HEX0:   out std_logic_vector(7 downto 0);
   HEX1:   out std_logic_vector(7 downto 0);
   HEX5:   out std_logic_vector(7 downto 0);
   HEX3:   out std_logic_vector(7 downto 0)              			
);            		
end C4M1P4;


architecture rtl of C4M1P4 is

    --signal V: std_logic_vector(3 downto 0);
    signal A : std_logic_vector(3 downto 0); 
    signal z : std_logic_vector(3 downto 0);
    signal D0 : std_logic_vector(3 downto 0); 
    signal D1 : std_logic_vector(3 downto 0); 

    signal c1: std_logic := '0';
    signal c2: std_logic := '0';
    signal c3: std_logic := '0';
    signal sum: std_logic_vector(4 downto 0);
    signal int_sum: integer;


    component FA 
        port(
            ci: in std_logic;
            a: in std_logic;
            b: in std_logic;
            
            s: out std_logic;
            co: out std_logic
        );
    end component;


begin

    A0: FA port map(SW(8),SW(0),SW(4),sum(0),c1);
    A1: FA port map(c1,SW(1),SW(5),sum(1),c2);
    A2: FA port map(c2,SW(2),SW(6),sum(2),c3);
    A3: FA port map(c3,SW(3),SW(7),sum(3),sum(4));

    --assignments
    LEDR(0) <= sum(0);
    LEDR(1) <= sum(1);
    LEDR(2) <= sum(2);
    LEDR(3) <= sum(3);
    LEDR(4) <= sum(4);

   
    int_sum <= to_integer(unsigned(sum)) - 10;
    A <= std_logic_vector(to_unsigned(int_sum,A'length)) when (int_sum < 10) else "0000";
    z <= "0001" when (sum > "01001") else "0000";
    D0 <= A when (z = "0001") else sum(3 downto 0);
    --D1 <= A when (z = "0001") else V;
    HEX1 <= "11111001" when (z = "0001") else "11000000";
    
    LEDR(9) <= '1' when (SW(3 downto 0)> "1001" or SW(7 downto 4)> "1001" ) else '0';

   

    digit0 : process(D0) is
    
    begin

        case D0 is
            when "0000" => HEX0 <= "11000000";
            when "0001" => HEX0 <= "11111001";
            when "0010" => HEX0 <= "10100100";
            when "0011" => HEX0 <= "10110000";
            when "0100" => HEX0 <= "10011001";
            when "0101" => HEX0 <= "10010010";
            when "0110" => HEX0 <= "10000010";
            when "0111" => HEX0 <= "11111000";
            when "1000" => HEX0 <= "10000000";
            when "1001" => HEX0 <= "10011000";
            when others => HEX0 <= (others => '1');

        end case;
    end process digit0;

    digit5 : process(SW) is 
    
    begin

        case SW(7 downto 4) is
            when "0000" => HEX5 <= "11000000";
            when "0001" => HEX5 <= "11111001";
            when "0010" => HEX5 <= "10100100";
            when "0011" => HEX5 <= "10110000";
            when "0100" => HEX5 <= "10011001";
            when "0101" => HEX5 <= "10010010";
            when "0110" => HEX5 <= "10000010";
            when "0111" => HEX5 <= "11111000";
            when "1000" => HEX5 <= "10000000";
            when "1001" => HEX5 <= "10011000";
            when others => HEX5 <= (others => '1');

        end case;
    end process digit5;

    digit3 : process(SW) is
    
    begin

        case SW(3 downto 0) is
            when "0000" => HEX3 <= "11000000";
            when "0001" => HEX3 <= "11111001";
            when "0010" => HEX3 <= "10100100";
            when "0011" => HEX3 <= "10110000";
            when "0100" => HEX3 <= "10011001";
            when "0101" => HEX3 <= "10010010";
            when "0110" => HEX3 <= "10000010";
            when "0111" => HEX3 <= "11111000";
            when "1000" => HEX3 <= "10000000";
            when "1001" => HEX3 <= "10011000";
            when others => HEX3 <= (others => '1');

        end case;
    end process digit3;


    

  
end rtl;
    