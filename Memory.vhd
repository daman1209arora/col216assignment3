library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Memory is
  PORT (
    clka : IN STD_LOGIC;
    wea1 : IN STD_LOGIC;
    addra1 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    dina1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    
    wea2 : IN STD_LOGIC;
    addra2 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    dina2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    
    clkb : IN STD_LOGIC;
    enb : IN STD_LOGIC;
    addrb1: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    doutb1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) := (others => '0');
    addrb2: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    doutb2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) := (others => '0');
    reset: IN std_logic := '0'
  );
end Memory;

architecture Behavioral of Memory is

	type Memory_type is array (0 to 4095) of std_logic_vector (31 downto 0);
	signal Memory_array : Memory_type := (  0 => "00000000000000000000010101000000",
                                            1 => "10001100000001000000000001101000",
                                            2 => "00000000001000100000100000100000",
                                            3 => "00000000011000110001100000100000",
                                            4 => "10101100000000000000000001100011",
                                            5 => "00000000000000110001100011000010",
                                            100 => "00000000000000000000000001110000",
                                            102 => "00000000000000000000000000101101",
                                            103 => "00000000000000000000000000000110",
                                            104 => "00000000000000001111111111111110",
                                            others => (others => '0')) ;
	signal address1, address2 : unsigned (15 downto 0);
begin
	process (clkb)
	begin
    if rising_edge(clkb) then    
        if (enb = '1') then
            address1 <= unsigned(addrb1);    
            address2 <= unsigned(addrb2);
        end if;
    end if;
    end process;
	doutb1 <= Memory_array (to_integer(address1));
	doutb2 <= Memory_array (to_integer(address2));
	
	process (clka)
	begin
		if rising_edge(clka) then	
			if(reset = '1') then Memory_array(0)<= (others => '0');
			else
			if (wea1 = '1') then
				Memory_array (to_integer(unsigned(addra1))) <= dina1;
				Memory_array (to_integer(unsigned(addra2))) <= dina2;	
			end if;
		    end if;
		end if;
	end process;
end Behavioral;
