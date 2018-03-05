-------------------------------------------------------------------------------
--  Odsek za racunarsku tehniku i medjuracunarske komunikacije
--  Autor: LPRS2  <lprs2@rt-rk.com>                                           
--                                                                             
--  Ime modula: timer_counter                                                           
--                                                                             
--  Opis:                                                               
--                                                                             
--    Modul broji sekunde i prikazuje na LED diodama                                         
--                                                                             
-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY timer_counter IS PORT (
                               clk_i     : IN STD_LOGIC; -- ulazni takt
                               rst_i     : IN STD_LOGIC; -- reset signal 
                               one_sec_i : IN STD_LOGIC; -- signal koji predstavlja proteklu jednu sekundu vremena 
                               cnt_en_i  : IN STD_LOGIC; -- signal dozvole brojanja                              
                               cnt_rst_i : IN STD_LOGIC; -- signal resetovanja brojaca (clear signal)
                               led_o     : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) -- izlaz ka led diodama
                             );
END timer_counter;

ARCHITECTURE rtl OF timer_counter IS

SIGNAL counter_value_r : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL counter_value_r_next : STD_LOGIC_VECTOR(7 DOWNTO 0);

component reg is
						generic(
										WIDTH    : positive := 8;
										RST_INIT : integer := 0
	);

						port(
                               i_clk     : IN STD_LOGIC; -- ulazni takt
                               in_rst    : IN STD_LOGIC; -- reset signal 
                               i_d       : IN STD_LOGIC_VECTOR(WIDTH -1 downto 0);
										 o_q		  : OUT STD_LOGIC_VECTOR(WIDTH -1 downto 0)
                             );
END component reg;

BEGIN

-- DODATI :
-- brojac koji na osnovu izbrojanih sekundi pravi izlaz na LE diode

REG2 : reg port map(
	i_clk => clk_i,
	in_rst => cnt_rst_i,
	i_d => counter_value_r_next,
	o_q => counter_value_r
);

counter_value_r_next <= (others=>'0') when (cnt_rst_i = '1') else 
						 counter_value_r + 1 when (cnt_en_i  ='1' and one_sec_i = '1') else 
						 counter_value_r ;


led_o <= counter_value_r;

END rtl;