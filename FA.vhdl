LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
entity FA is 
    port(
        ci: in std_logic;
        a: in std_logic;
        b: in std_logic;
        
        s: out std_logic;
        co: out std_logic

    );
end FA;

architecture rtl of FA is 
    signal ci_XOR_b: std_logic;
begin
    ci_XOR_b <= a XOR b;

    s <= ci XOR ci_XOR_b;

    co <= ci when ci_XOR_b = '1'  else b;
    

end rtl;

