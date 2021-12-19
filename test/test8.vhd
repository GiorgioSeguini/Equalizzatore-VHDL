library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
entity project_tb is
end project_tb;
architecture projecttb of project_tb is
constant c_CLOCK_PERIOD         : time := 15 ns;
signal   tb_done                : std_logic;
signal   mem_address            : std_logic_vector (15 downto 0) := (others => '0');
signal   tb_rst                 : std_logic := '0';
signal   tb_start               : std_logic := '0';
signal   tb_clk                 : std_logic := '0';
signal   mem_o_data,mem_i_data  : std_logic_vector (7 downto 0);
signal   enable_wire            : std_logic;
signal   mem_we                 : std_logic;
type ram_type is array (65535 downto 0) of std_logic_vector(7 downto 0);
signal RAM: ram_type := (
			0 => std_logic_vector(to_unsigned(11, 8)),
			1 => std_logic_vector(to_unsigned(17, 8)),
			2 => std_logic_vector(to_unsigned(35, 8)),
			3 => std_logic_vector(to_unsigned(199, 8)),
			4 => std_logic_vector(to_unsigned(68, 8)),
			5 => std_logic_vector(to_unsigned(74, 8)),
			6 => std_logic_vector(to_unsigned(169, 8)),
			7 => std_logic_vector(to_unsigned(196, 8)),
			8 => std_logic_vector(to_unsigned(89, 8)),
			9 => std_logic_vector(to_unsigned(202, 8)),
			10 => std_logic_vector(to_unsigned(241, 8)),
			11 => std_logic_vector(to_unsigned(64, 8)),
			12 => std_logic_vector(to_unsigned(221, 8)),
			13 => std_logic_vector(to_unsigned(248, 8)),
			14 => std_logic_vector(to_unsigned(83, 8)),
			15 => std_logic_vector(to_unsigned(198, 8)),
			16 => std_logic_vector(to_unsigned(109, 8)),
			17 => std_logic_vector(to_unsigned(240, 8)),
			18 => std_logic_vector(to_unsigned(145, 8)),
			19 => std_logic_vector(to_unsigned(129, 8)),
			20 => std_logic_vector(to_unsigned(190, 8)),
			21 => std_logic_vector(to_unsigned(38, 8)),
			22 => std_logic_vector(to_unsigned(214, 8)),
			23 => std_logic_vector(to_unsigned(157, 8)),
			24 => std_logic_vector(to_unsigned(207, 8)),
			25 => std_logic_vector(to_unsigned(73, 8)),
			26 => std_logic_vector(to_unsigned(177, 8)),
			27 => std_logic_vector(to_unsigned(166, 8)),
			28 => std_logic_vector(to_unsigned(213, 8)),
			29 => std_logic_vector(to_unsigned(4, 8)),
			30 => std_logic_vector(to_unsigned(169, 8)),
			31 => std_logic_vector(to_unsigned(8, 8)),
			32 => std_logic_vector(to_unsigned(85, 8)),
			33 => std_logic_vector(to_unsigned(247, 8)),
			34 => std_logic_vector(to_unsigned(129, 8)),
			35 => std_logic_vector(to_unsigned(102, 8)),
			36 => std_logic_vector(to_unsigned(148, 8)),
			37 => std_logic_vector(to_unsigned(231, 8)),
			38 => std_logic_vector(to_unsigned(252, 8)),
			39 => std_logic_vector(to_unsigned(110, 8)),
			40 => std_logic_vector(to_unsigned(127, 8)),
			41 => std_logic_vector(to_unsigned(55, 8)),
			42 => std_logic_vector(to_unsigned(96, 8)),
			43 => std_logic_vector(to_unsigned(200, 8)),
			44 => std_logic_vector(to_unsigned(34, 8)),
			45 => std_logic_vector(to_unsigned(44, 8)),
			46 => std_logic_vector(to_unsigned(170, 8)),
			47 => std_logic_vector(to_unsigned(135, 8)),
			48 => std_logic_vector(to_unsigned(208, 8)),
			49 => std_logic_vector(to_unsigned(60, 8)),
			50 => std_logic_vector(to_unsigned(254, 8)),
			51 => std_logic_vector(to_unsigned(56, 8)),
			52 => std_logic_vector(to_unsigned(82, 8)),
			53 => std_logic_vector(to_unsigned(205, 8)),
			54 => std_logic_vector(to_unsigned(24, 8)),
			55 => std_logic_vector(to_unsigned(178, 8)),
			56 => std_logic_vector(to_unsigned(247, 8)),
			57 => std_logic_vector(to_unsigned(246, 8)),
			58 => std_logic_vector(to_unsigned(80, 8)),
			59 => std_logic_vector(to_unsigned(82, 8)),
			60 => std_logic_vector(to_unsigned(9, 8)),
			61 => std_logic_vector(to_unsigned(88, 8)),
			62 => std_logic_vector(to_unsigned(50, 8)),
			63 => std_logic_vector(to_unsigned(112, 8)),
			64 => std_logic_vector(to_unsigned(118, 8)),
			65 => std_logic_vector(to_unsigned(2, 8)),
			66 => std_logic_vector(to_unsigned(54, 8)),
			67 => std_logic_vector(to_unsigned(36, 8)),
			68 => std_logic_vector(to_unsigned(55, 8)),
			69 => std_logic_vector(to_unsigned(105, 8)),
			70 => std_logic_vector(to_unsigned(128, 8)),
			71 => std_logic_vector(to_unsigned(238, 8)),
			72 => std_logic_vector(to_unsigned(156, 8)),
			73 => std_logic_vector(to_unsigned(123, 8)),
			74 => std_logic_vector(to_unsigned(255, 8)),
			75 => std_logic_vector(to_unsigned(96, 8)),
			76 => std_logic_vector(to_unsigned(147, 8)),
			77 => std_logic_vector(to_unsigned(50, 8)),
			78 => std_logic_vector(to_unsigned(234, 8)),
			79 => std_logic_vector(to_unsigned(86, 8)),
			80 => std_logic_vector(to_unsigned(127, 8)),
			81 => std_logic_vector(to_unsigned(61, 8)),
			82 => std_logic_vector(to_unsigned(178, 8)),
			83 => std_logic_vector(to_unsigned(255, 8)),
			84 => std_logic_vector(to_unsigned(87, 8)),
			85 => std_logic_vector(to_unsigned(246, 8)),
			86 => std_logic_vector(to_unsigned(122, 8)),
			87 => std_logic_vector(to_unsigned(253, 8)),
			88 => std_logic_vector(to_unsigned(13, 8)),
			89 => std_logic_vector(to_unsigned(44, 8)),
			90 => std_logic_vector(to_unsigned(203, 8)),
			91 => std_logic_vector(to_unsigned(211, 8)),
			92 => std_logic_vector(to_unsigned(116, 8)),
			93 => std_logic_vector(to_unsigned(61, 8)),
			94 => std_logic_vector(to_unsigned(244, 8)),
			95 => std_logic_vector(to_unsigned(244, 8)),
			96 => std_logic_vector(to_unsigned(158, 8)),
			97 => std_logic_vector(to_unsigned(183, 8)),
			98 => std_logic_vector(to_unsigned(115, 8)),
			99 => std_logic_vector(to_unsigned(229, 8)),
			100 => std_logic_vector(to_unsigned(171, 8)),
			101 => std_logic_vector(to_unsigned(199, 8)),
			102 => std_logic_vector(to_unsigned(195, 8)),
			103 => std_logic_vector(to_unsigned(60, 8)),
			104 => std_logic_vector(to_unsigned(164, 8)),
			105 => std_logic_vector(to_unsigned(211, 8)),
			106 => std_logic_vector(to_unsigned(239, 8)),
			107 => std_logic_vector(to_unsigned(0, 8)),
			108 => std_logic_vector(to_unsigned(148, 8)),
			109 => std_logic_vector(to_unsigned(188, 8)),
			110 => std_logic_vector(to_unsigned(75, 8)),
			111 => std_logic_vector(to_unsigned(99, 8)),
			112 => std_logic_vector(to_unsigned(12, 8)),
			113 => std_logic_vector(to_unsigned(3, 8)),
			114 => std_logic_vector(to_unsigned(94, 8)),
			115 => std_logic_vector(to_unsigned(134, 8)),
			116 => std_logic_vector(to_unsigned(96, 8)),
			117 => std_logic_vector(to_unsigned(120, 8)),
			118 => std_logic_vector(to_unsigned(138, 8)),
			119 => std_logic_vector(to_unsigned(116, 8)),
			120 => std_logic_vector(to_unsigned(72, 8)),
			121 => std_logic_vector(to_unsigned(195, 8)),
			122 => std_logic_vector(to_unsigned(211, 8)),
			123 => std_logic_vector(to_unsigned(105, 8)),
			124 => std_logic_vector(to_unsigned(72, 8)),
			125 => std_logic_vector(to_unsigned(152, 8)),
			126 => std_logic_vector(to_unsigned(218, 8)),
			127 => std_logic_vector(to_unsigned(212, 8)),
			128 => std_logic_vector(to_unsigned(216, 8)),
			129 => std_logic_vector(to_unsigned(241, 8)),
			130 => std_logic_vector(to_unsigned(152, 8)),
			131 => std_logic_vector(to_unsigned(54, 8)),
			132 => std_logic_vector(to_unsigned(30, 8)),
			133 => std_logic_vector(to_unsigned(196, 8)),
			134 => std_logic_vector(to_unsigned(53, 8)),
			135 => std_logic_vector(to_unsigned(135, 8)),
			136 => std_logic_vector(to_unsigned(99, 8)),
			137 => std_logic_vector(to_unsigned(16, 8)),
			138 => std_logic_vector(to_unsigned(12, 8)),
			139 => std_logic_vector(to_unsigned(132, 8)),
			140 => std_logic_vector(to_unsigned(244, 8)),
			141 => std_logic_vector(to_unsigned(121, 8)),
			142 => std_logic_vector(to_unsigned(36, 8)),
			143 => std_logic_vector(to_unsigned(154, 8)),
			144 => std_logic_vector(to_unsigned(4, 8)),
			145 => std_logic_vector(to_unsigned(199, 8)),
			146 => std_logic_vector(to_unsigned(167, 8)),
			147 => std_logic_vector(to_unsigned(203, 8)),
			148 => std_logic_vector(to_unsigned(66, 8)),
			149 => std_logic_vector(to_unsigned(40, 8)),
			150 => std_logic_vector(to_unsigned(59, 8)),
			151 => std_logic_vector(to_unsigned(19, 8)),
			152 => std_logic_vector(to_unsigned(143, 8)),
			153 => std_logic_vector(to_unsigned(231, 8)),
			154 => std_logic_vector(to_unsigned(65, 8)),
			155 => std_logic_vector(to_unsigned(43, 8)),
			156 => std_logic_vector(to_unsigned(171, 8)),
			157 => std_logic_vector(to_unsigned(8, 8)),
			158 => std_logic_vector(to_unsigned(157, 8)),
			159 => std_logic_vector(to_unsigned(254, 8)),
			160 => std_logic_vector(to_unsigned(58, 8)),
			161 => std_logic_vector(to_unsigned(254, 8)),
			162 => std_logic_vector(to_unsigned(2, 8)),
			163 => std_logic_vector(to_unsigned(225, 8)),
			164 => std_logic_vector(to_unsigned(16, 8)),
			165 => std_logic_vector(to_unsigned(37, 8)),
			166 => std_logic_vector(to_unsigned(57, 8)),
			167 => std_logic_vector(to_unsigned(150, 8)),
			168 => std_logic_vector(to_unsigned(225, 8)),
			169 => std_logic_vector(to_unsigned(16, 8)),
			170 => std_logic_vector(to_unsigned(185, 8)),
			171 => std_logic_vector(to_unsigned(35, 8)),
			172 => std_logic_vector(to_unsigned(45, 8)),
			173 => std_logic_vector(to_unsigned(75, 8)),
			174 => std_logic_vector(to_unsigned(146, 8)),
			175 => std_logic_vector(to_unsigned(8, 8)),
			176 => std_logic_vector(to_unsigned(85, 8)),
			177 => std_logic_vector(to_unsigned(136, 8)),
			178 => std_logic_vector(to_unsigned(246, 8)),
			179 => std_logic_vector(to_unsigned(175, 8)),
			180 => std_logic_vector(to_unsigned(184, 8)),
			181 => std_logic_vector(to_unsigned(126, 8)),
			182 => std_logic_vector(to_unsigned(143, 8)),
			183 => std_logic_vector(to_unsigned(94, 8)),
			184 => std_logic_vector(to_unsigned(194, 8)),
			185 => std_logic_vector(to_unsigned(218, 8)),
			186 => std_logic_vector(to_unsigned(99, 8)),
			187 => std_logic_vector(to_unsigned(250, 8)),
			188 => std_logic_vector(to_unsigned(188, 8)),
			others => (others => '0'));
component project_reti_logiche is
port (
      i_clk         : in  std_logic;
      i_rst         : in  std_logic;
      i_start       : in  std_logic;
      i_data        : in  std_logic_vector(7 downto 0);
      o_address     : out std_logic_vector(15 downto 0);
      o_done        : out std_logic;
      o_en          : out std_logic;
      o_we          : out std_logic;
      o_data        : out std_logic_vector (7 downto 0)
      );
end component project_reti_logiche;
begin
UUT: project_reti_logiche
port map (
          i_clk      	=> tb_clk,
          i_rst      	=> tb_rst,
          i_start       => tb_start,
          i_data    	=> mem_o_data,
          o_address  	=> mem_address,
          o_done      	=> tb_done,
          o_en   	=> enable_wire,
          o_we 		=> mem_we,
          o_data    	=> mem_i_data
          );

p_CLK_GEN : process is
begin
    wait for c_CLOCK_PERIOD/2;
    tb_clk <= not tb_clk;
end process p_CLK_GEN;
MEM : process(tb_clk)
begin
    if tb_clk'event and tb_clk = '1' then
        if enable_wire = '1' then
            if mem_we = '1' then
                RAM(conv_integer(mem_address))  <= mem_i_data;
                mem_o_data                      <= mem_i_data after 1 ns;
            else
                mem_o_data <= RAM(conv_integer(mem_address)) after 1 ns;
            end if;
        end if;
    end if;
end process;
test : process is
begin 
    wait for 100 ns;
    wait for c_CLOCK_PERIOD;
    tb_rst <= '1';
    wait for c_CLOCK_PERIOD;
    wait for 100 ns;
    tb_rst <= '0';
    wait for c_CLOCK_PERIOD;
    wait for 100 ns;
    tb_start <= '1';
    wait for c_CLOCK_PERIOD;
    wait until tb_done = '1';
    wait for c_CLOCK_PERIOD;
    tb_start <= '0';
    wait until tb_done = '0';
    wait for 100 ns;
	assert RAM(189) = std_logic_vector(to_unsigned(35, 8)) report "TEST FALLITO (WORKING ZONE). Expected  35  found " & integer'image(to_integer(unsigned(RAM(189))))  severity failure;
	assert RAM(190) = std_logic_vector(to_unsigned(199, 8)) report "TEST FALLITO (WORKING ZONE). Expected  199  found " & integer'image(to_integer(unsigned(RAM(190))))  severity failure;
	assert RAM(191) = std_logic_vector(to_unsigned(68, 8)) report "TEST FALLITO (WORKING ZONE). Expected  68  found " & integer'image(to_integer(unsigned(RAM(191))))  severity failure;
	assert RAM(192) = std_logic_vector(to_unsigned(74, 8)) report "TEST FALLITO (WORKING ZONE). Expected  74  found " & integer'image(to_integer(unsigned(RAM(192))))  severity failure;
	assert RAM(193) = std_logic_vector(to_unsigned(169, 8)) report "TEST FALLITO (WORKING ZONE). Expected  169  found " & integer'image(to_integer(unsigned(RAM(193))))  severity failure;
	assert RAM(194) = std_logic_vector(to_unsigned(196, 8)) report "TEST FALLITO (WORKING ZONE). Expected  196  found " & integer'image(to_integer(unsigned(RAM(194))))  severity failure;
	assert RAM(195) = std_logic_vector(to_unsigned(89, 8)) report "TEST FALLITO (WORKING ZONE). Expected  89  found " & integer'image(to_integer(unsigned(RAM(195))))  severity failure;
	assert RAM(196) = std_logic_vector(to_unsigned(202, 8)) report "TEST FALLITO (WORKING ZONE). Expected  202  found " & integer'image(to_integer(unsigned(RAM(196))))  severity failure;
	assert RAM(197) = std_logic_vector(to_unsigned(241, 8)) report "TEST FALLITO (WORKING ZONE). Expected  241  found " & integer'image(to_integer(unsigned(RAM(197))))  severity failure;
	assert RAM(198) = std_logic_vector(to_unsigned(64, 8)) report "TEST FALLITO (WORKING ZONE). Expected  64  found " & integer'image(to_integer(unsigned(RAM(198))))  severity failure;
	assert RAM(199) = std_logic_vector(to_unsigned(221, 8)) report "TEST FALLITO (WORKING ZONE). Expected  221  found " & integer'image(to_integer(unsigned(RAM(199))))  severity failure;
	assert RAM(200) = std_logic_vector(to_unsigned(248, 8)) report "TEST FALLITO (WORKING ZONE). Expected  248  found " & integer'image(to_integer(unsigned(RAM(200))))  severity failure;
	assert RAM(201) = std_logic_vector(to_unsigned(83, 8)) report "TEST FALLITO (WORKING ZONE). Expected  83  found " & integer'image(to_integer(unsigned(RAM(201))))  severity failure;
	assert RAM(202) = std_logic_vector(to_unsigned(198, 8)) report "TEST FALLITO (WORKING ZONE). Expected  198  found " & integer'image(to_integer(unsigned(RAM(202))))  severity failure;
	assert RAM(203) = std_logic_vector(to_unsigned(109, 8)) report "TEST FALLITO (WORKING ZONE). Expected  109  found " & integer'image(to_integer(unsigned(RAM(203))))  severity failure;
	assert RAM(204) = std_logic_vector(to_unsigned(240, 8)) report "TEST FALLITO (WORKING ZONE). Expected  240  found " & integer'image(to_integer(unsigned(RAM(204))))  severity failure;
	assert RAM(205) = std_logic_vector(to_unsigned(145, 8)) report "TEST FALLITO (WORKING ZONE). Expected  145  found " & integer'image(to_integer(unsigned(RAM(205))))  severity failure;
	assert RAM(206) = std_logic_vector(to_unsigned(129, 8)) report "TEST FALLITO (WORKING ZONE). Expected  129  found " & integer'image(to_integer(unsigned(RAM(206))))  severity failure;
	assert RAM(207) = std_logic_vector(to_unsigned(190, 8)) report "TEST FALLITO (WORKING ZONE). Expected  190  found " & integer'image(to_integer(unsigned(RAM(207))))  severity failure;
	assert RAM(208) = std_logic_vector(to_unsigned(38, 8)) report "TEST FALLITO (WORKING ZONE). Expected  38  found " & integer'image(to_integer(unsigned(RAM(208))))  severity failure;
	assert RAM(209) = std_logic_vector(to_unsigned(214, 8)) report "TEST FALLITO (WORKING ZONE). Expected  214  found " & integer'image(to_integer(unsigned(RAM(209))))  severity failure;
	assert RAM(210) = std_logic_vector(to_unsigned(157, 8)) report "TEST FALLITO (WORKING ZONE). Expected  157  found " & integer'image(to_integer(unsigned(RAM(210))))  severity failure;
	assert RAM(211) = std_logic_vector(to_unsigned(207, 8)) report "TEST FALLITO (WORKING ZONE). Expected  207  found " & integer'image(to_integer(unsigned(RAM(211))))  severity failure;
	assert RAM(212) = std_logic_vector(to_unsigned(73, 8)) report "TEST FALLITO (WORKING ZONE). Expected  73  found " & integer'image(to_integer(unsigned(RAM(212))))  severity failure;
	assert RAM(213) = std_logic_vector(to_unsigned(177, 8)) report "TEST FALLITO (WORKING ZONE). Expected  177  found " & integer'image(to_integer(unsigned(RAM(213))))  severity failure;
	assert RAM(214) = std_logic_vector(to_unsigned(166, 8)) report "TEST FALLITO (WORKING ZONE). Expected  166  found " & integer'image(to_integer(unsigned(RAM(214))))  severity failure;
	assert RAM(215) = std_logic_vector(to_unsigned(213, 8)) report "TEST FALLITO (WORKING ZONE). Expected  213  found " & integer'image(to_integer(unsigned(RAM(215))))  severity failure;
	assert RAM(216) = std_logic_vector(to_unsigned(4, 8)) report "TEST FALLITO (WORKING ZONE). Expected  4  found " & integer'image(to_integer(unsigned(RAM(216))))  severity failure;
	assert RAM(217) = std_logic_vector(to_unsigned(169, 8)) report "TEST FALLITO (WORKING ZONE). Expected  169  found " & integer'image(to_integer(unsigned(RAM(217))))  severity failure;
	assert RAM(218) = std_logic_vector(to_unsigned(8, 8)) report "TEST FALLITO (WORKING ZONE). Expected  8  found " & integer'image(to_integer(unsigned(RAM(218))))  severity failure;
	assert RAM(219) = std_logic_vector(to_unsigned(85, 8)) report "TEST FALLITO (WORKING ZONE). Expected  85  found " & integer'image(to_integer(unsigned(RAM(219))))  severity failure;
	assert RAM(220) = std_logic_vector(to_unsigned(247, 8)) report "TEST FALLITO (WORKING ZONE). Expected  247  found " & integer'image(to_integer(unsigned(RAM(220))))  severity failure;
	assert RAM(221) = std_logic_vector(to_unsigned(129, 8)) report "TEST FALLITO (WORKING ZONE). Expected  129  found " & integer'image(to_integer(unsigned(RAM(221))))  severity failure;
	assert RAM(222) = std_logic_vector(to_unsigned(102, 8)) report "TEST FALLITO (WORKING ZONE). Expected  102  found " & integer'image(to_integer(unsigned(RAM(222))))  severity failure;
	assert RAM(223) = std_logic_vector(to_unsigned(148, 8)) report "TEST FALLITO (WORKING ZONE). Expected  148  found " & integer'image(to_integer(unsigned(RAM(223))))  severity failure;
	assert RAM(224) = std_logic_vector(to_unsigned(231, 8)) report "TEST FALLITO (WORKING ZONE). Expected  231  found " & integer'image(to_integer(unsigned(RAM(224))))  severity failure;
	assert RAM(225) = std_logic_vector(to_unsigned(252, 8)) report "TEST FALLITO (WORKING ZONE). Expected  252  found " & integer'image(to_integer(unsigned(RAM(225))))  severity failure;
	assert RAM(226) = std_logic_vector(to_unsigned(110, 8)) report "TEST FALLITO (WORKING ZONE). Expected  110  found " & integer'image(to_integer(unsigned(RAM(226))))  severity failure;
	assert RAM(227) = std_logic_vector(to_unsigned(127, 8)) report "TEST FALLITO (WORKING ZONE). Expected  127  found " & integer'image(to_integer(unsigned(RAM(227))))  severity failure;
	assert RAM(228) = std_logic_vector(to_unsigned(55, 8)) report "TEST FALLITO (WORKING ZONE). Expected  55  found " & integer'image(to_integer(unsigned(RAM(228))))  severity failure;
	assert RAM(229) = std_logic_vector(to_unsigned(96, 8)) report "TEST FALLITO (WORKING ZONE). Expected  96  found " & integer'image(to_integer(unsigned(RAM(229))))  severity failure;
	assert RAM(230) = std_logic_vector(to_unsigned(200, 8)) report "TEST FALLITO (WORKING ZONE). Expected  200  found " & integer'image(to_integer(unsigned(RAM(230))))  severity failure;
	assert RAM(231) = std_logic_vector(to_unsigned(34, 8)) report "TEST FALLITO (WORKING ZONE). Expected  34  found " & integer'image(to_integer(unsigned(RAM(231))))  severity failure;
	assert RAM(232) = std_logic_vector(to_unsigned(44, 8)) report "TEST FALLITO (WORKING ZONE). Expected  44  found " & integer'image(to_integer(unsigned(RAM(232))))  severity failure;
	assert RAM(233) = std_logic_vector(to_unsigned(170, 8)) report "TEST FALLITO (WORKING ZONE). Expected  170  found " & integer'image(to_integer(unsigned(RAM(233))))  severity failure;
	assert RAM(234) = std_logic_vector(to_unsigned(135, 8)) report "TEST FALLITO (WORKING ZONE). Expected  135  found " & integer'image(to_integer(unsigned(RAM(234))))  severity failure;
	assert RAM(235) = std_logic_vector(to_unsigned(208, 8)) report "TEST FALLITO (WORKING ZONE). Expected  208  found " & integer'image(to_integer(unsigned(RAM(235))))  severity failure;
	assert RAM(236) = std_logic_vector(to_unsigned(60, 8)) report "TEST FALLITO (WORKING ZONE). Expected  60  found " & integer'image(to_integer(unsigned(RAM(236))))  severity failure;
	assert RAM(237) = std_logic_vector(to_unsigned(254, 8)) report "TEST FALLITO (WORKING ZONE). Expected  254  found " & integer'image(to_integer(unsigned(RAM(237))))  severity failure;
	assert RAM(238) = std_logic_vector(to_unsigned(56, 8)) report "TEST FALLITO (WORKING ZONE). Expected  56  found " & integer'image(to_integer(unsigned(RAM(238))))  severity failure;
	assert RAM(239) = std_logic_vector(to_unsigned(82, 8)) report "TEST FALLITO (WORKING ZONE). Expected  82  found " & integer'image(to_integer(unsigned(RAM(239))))  severity failure;
	assert RAM(240) = std_logic_vector(to_unsigned(205, 8)) report "TEST FALLITO (WORKING ZONE). Expected  205  found " & integer'image(to_integer(unsigned(RAM(240))))  severity failure;
	assert RAM(241) = std_logic_vector(to_unsigned(24, 8)) report "TEST FALLITO (WORKING ZONE). Expected  24  found " & integer'image(to_integer(unsigned(RAM(241))))  severity failure;
	assert RAM(242) = std_logic_vector(to_unsigned(178, 8)) report "TEST FALLITO (WORKING ZONE). Expected  178  found " & integer'image(to_integer(unsigned(RAM(242))))  severity failure;
	assert RAM(243) = std_logic_vector(to_unsigned(247, 8)) report "TEST FALLITO (WORKING ZONE). Expected  247  found " & integer'image(to_integer(unsigned(RAM(243))))  severity failure;
	assert RAM(244) = std_logic_vector(to_unsigned(246, 8)) report "TEST FALLITO (WORKING ZONE). Expected  246  found " & integer'image(to_integer(unsigned(RAM(244))))  severity failure;
	assert RAM(245) = std_logic_vector(to_unsigned(80, 8)) report "TEST FALLITO (WORKING ZONE). Expected  80  found " & integer'image(to_integer(unsigned(RAM(245))))  severity failure;
	assert RAM(246) = std_logic_vector(to_unsigned(82, 8)) report "TEST FALLITO (WORKING ZONE). Expected  82  found " & integer'image(to_integer(unsigned(RAM(246))))  severity failure;
	assert RAM(247) = std_logic_vector(to_unsigned(9, 8)) report "TEST FALLITO (WORKING ZONE). Expected  9  found " & integer'image(to_integer(unsigned(RAM(247))))  severity failure;
	assert RAM(248) = std_logic_vector(to_unsigned(88, 8)) report "TEST FALLITO (WORKING ZONE). Expected  88  found " & integer'image(to_integer(unsigned(RAM(248))))  severity failure;
	assert RAM(249) = std_logic_vector(to_unsigned(50, 8)) report "TEST FALLITO (WORKING ZONE). Expected  50  found " & integer'image(to_integer(unsigned(RAM(249))))  severity failure;
	assert RAM(250) = std_logic_vector(to_unsigned(112, 8)) report "TEST FALLITO (WORKING ZONE). Expected  112  found " & integer'image(to_integer(unsigned(RAM(250))))  severity failure;
	assert RAM(251) = std_logic_vector(to_unsigned(118, 8)) report "TEST FALLITO (WORKING ZONE). Expected  118  found " & integer'image(to_integer(unsigned(RAM(251))))  severity failure;
	assert RAM(252) = std_logic_vector(to_unsigned(2, 8)) report "TEST FALLITO (WORKING ZONE). Expected  2  found " & integer'image(to_integer(unsigned(RAM(252))))  severity failure;
	assert RAM(253) = std_logic_vector(to_unsigned(54, 8)) report "TEST FALLITO (WORKING ZONE). Expected  54  found " & integer'image(to_integer(unsigned(RAM(253))))  severity failure;
	assert RAM(254) = std_logic_vector(to_unsigned(36, 8)) report "TEST FALLITO (WORKING ZONE). Expected  36  found " & integer'image(to_integer(unsigned(RAM(254))))  severity failure;
	assert RAM(255) = std_logic_vector(to_unsigned(55, 8)) report "TEST FALLITO (WORKING ZONE). Expected  55  found " & integer'image(to_integer(unsigned(RAM(255))))  severity failure;
	assert RAM(256) = std_logic_vector(to_unsigned(105, 8)) report "TEST FALLITO (WORKING ZONE). Expected  105  found " & integer'image(to_integer(unsigned(RAM(256))))  severity failure;
	assert RAM(257) = std_logic_vector(to_unsigned(128, 8)) report "TEST FALLITO (WORKING ZONE). Expected  128  found " & integer'image(to_integer(unsigned(RAM(257))))  severity failure;
	assert RAM(258) = std_logic_vector(to_unsigned(238, 8)) report "TEST FALLITO (WORKING ZONE). Expected  238  found " & integer'image(to_integer(unsigned(RAM(258))))  severity failure;
	assert RAM(259) = std_logic_vector(to_unsigned(156, 8)) report "TEST FALLITO (WORKING ZONE). Expected  156  found " & integer'image(to_integer(unsigned(RAM(259))))  severity failure;
	assert RAM(260) = std_logic_vector(to_unsigned(123, 8)) report "TEST FALLITO (WORKING ZONE). Expected  123  found " & integer'image(to_integer(unsigned(RAM(260))))  severity failure;
	assert RAM(261) = std_logic_vector(to_unsigned(255, 8)) report "TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM(261))))  severity failure;
	assert RAM(262) = std_logic_vector(to_unsigned(96, 8)) report "TEST FALLITO (WORKING ZONE). Expected  96  found " & integer'image(to_integer(unsigned(RAM(262))))  severity failure;
	assert RAM(263) = std_logic_vector(to_unsigned(147, 8)) report "TEST FALLITO (WORKING ZONE). Expected  147  found " & integer'image(to_integer(unsigned(RAM(263))))  severity failure;
	assert RAM(264) = std_logic_vector(to_unsigned(50, 8)) report "TEST FALLITO (WORKING ZONE). Expected  50  found " & integer'image(to_integer(unsigned(RAM(264))))  severity failure;
	assert RAM(265) = std_logic_vector(to_unsigned(234, 8)) report "TEST FALLITO (WORKING ZONE). Expected  234  found " & integer'image(to_integer(unsigned(RAM(265))))  severity failure;
	assert RAM(266) = std_logic_vector(to_unsigned(86, 8)) report "TEST FALLITO (WORKING ZONE). Expected  86  found " & integer'image(to_integer(unsigned(RAM(266))))  severity failure;
	assert RAM(267) = std_logic_vector(to_unsigned(127, 8)) report "TEST FALLITO (WORKING ZONE). Expected  127  found " & integer'image(to_integer(unsigned(RAM(267))))  severity failure;
	assert RAM(268) = std_logic_vector(to_unsigned(61, 8)) report "TEST FALLITO (WORKING ZONE). Expected  61  found " & integer'image(to_integer(unsigned(RAM(268))))  severity failure;
	assert RAM(269) = std_logic_vector(to_unsigned(178, 8)) report "TEST FALLITO (WORKING ZONE). Expected  178  found " & integer'image(to_integer(unsigned(RAM(269))))  severity failure;
	assert RAM(270) = std_logic_vector(to_unsigned(255, 8)) report "TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM(270))))  severity failure;
	assert RAM(271) = std_logic_vector(to_unsigned(87, 8)) report "TEST FALLITO (WORKING ZONE). Expected  87  found " & integer'image(to_integer(unsigned(RAM(271))))  severity failure;
	assert RAM(272) = std_logic_vector(to_unsigned(246, 8)) report "TEST FALLITO (WORKING ZONE). Expected  246  found " & integer'image(to_integer(unsigned(RAM(272))))  severity failure;
	assert RAM(273) = std_logic_vector(to_unsigned(122, 8)) report "TEST FALLITO (WORKING ZONE). Expected  122  found " & integer'image(to_integer(unsigned(RAM(273))))  severity failure;
	assert RAM(274) = std_logic_vector(to_unsigned(253, 8)) report "TEST FALLITO (WORKING ZONE). Expected  253  found " & integer'image(to_integer(unsigned(RAM(274))))  severity failure;
	assert RAM(275) = std_logic_vector(to_unsigned(13, 8)) report "TEST FALLITO (WORKING ZONE). Expected  13  found " & integer'image(to_integer(unsigned(RAM(275))))  severity failure;
	assert RAM(276) = std_logic_vector(to_unsigned(44, 8)) report "TEST FALLITO (WORKING ZONE). Expected  44  found " & integer'image(to_integer(unsigned(RAM(276))))  severity failure;
	assert RAM(277) = std_logic_vector(to_unsigned(203, 8)) report "TEST FALLITO (WORKING ZONE). Expected  203  found " & integer'image(to_integer(unsigned(RAM(277))))  severity failure;
	assert RAM(278) = std_logic_vector(to_unsigned(211, 8)) report "TEST FALLITO (WORKING ZONE). Expected  211  found " & integer'image(to_integer(unsigned(RAM(278))))  severity failure;
	assert RAM(279) = std_logic_vector(to_unsigned(116, 8)) report "TEST FALLITO (WORKING ZONE). Expected  116  found " & integer'image(to_integer(unsigned(RAM(279))))  severity failure;
	assert RAM(280) = std_logic_vector(to_unsigned(61, 8)) report "TEST FALLITO (WORKING ZONE). Expected  61  found " & integer'image(to_integer(unsigned(RAM(280))))  severity failure;
	assert RAM(281) = std_logic_vector(to_unsigned(244, 8)) report "TEST FALLITO (WORKING ZONE). Expected  244  found " & integer'image(to_integer(unsigned(RAM(281))))  severity failure;
	assert RAM(282) = std_logic_vector(to_unsigned(244, 8)) report "TEST FALLITO (WORKING ZONE). Expected  244  found " & integer'image(to_integer(unsigned(RAM(282))))  severity failure;
	assert RAM(283) = std_logic_vector(to_unsigned(158, 8)) report "TEST FALLITO (WORKING ZONE). Expected  158  found " & integer'image(to_integer(unsigned(RAM(283))))  severity failure;
	assert RAM(284) = std_logic_vector(to_unsigned(183, 8)) report "TEST FALLITO (WORKING ZONE). Expected  183  found " & integer'image(to_integer(unsigned(RAM(284))))  severity failure;
	assert RAM(285) = std_logic_vector(to_unsigned(115, 8)) report "TEST FALLITO (WORKING ZONE). Expected  115  found " & integer'image(to_integer(unsigned(RAM(285))))  severity failure;
	assert RAM(286) = std_logic_vector(to_unsigned(229, 8)) report "TEST FALLITO (WORKING ZONE). Expected  229  found " & integer'image(to_integer(unsigned(RAM(286))))  severity failure;
	assert RAM(287) = std_logic_vector(to_unsigned(171, 8)) report "TEST FALLITO (WORKING ZONE). Expected  171  found " & integer'image(to_integer(unsigned(RAM(287))))  severity failure;
	assert RAM(288) = std_logic_vector(to_unsigned(199, 8)) report "TEST FALLITO (WORKING ZONE). Expected  199  found " & integer'image(to_integer(unsigned(RAM(288))))  severity failure;
	assert RAM(289) = std_logic_vector(to_unsigned(195, 8)) report "TEST FALLITO (WORKING ZONE). Expected  195  found " & integer'image(to_integer(unsigned(RAM(289))))  severity failure;
	assert RAM(290) = std_logic_vector(to_unsigned(60, 8)) report "TEST FALLITO (WORKING ZONE). Expected  60  found " & integer'image(to_integer(unsigned(RAM(290))))  severity failure;
	assert RAM(291) = std_logic_vector(to_unsigned(164, 8)) report "TEST FALLITO (WORKING ZONE). Expected  164  found " & integer'image(to_integer(unsigned(RAM(291))))  severity failure;
	assert RAM(292) = std_logic_vector(to_unsigned(211, 8)) report "TEST FALLITO (WORKING ZONE). Expected  211  found " & integer'image(to_integer(unsigned(RAM(292))))  severity failure;
	assert RAM(293) = std_logic_vector(to_unsigned(239, 8)) report "TEST FALLITO (WORKING ZONE). Expected  239  found " & integer'image(to_integer(unsigned(RAM(293))))  severity failure;
	assert RAM(294) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM(294))))  severity failure;
	assert RAM(295) = std_logic_vector(to_unsigned(148, 8)) report "TEST FALLITO (WORKING ZONE). Expected  148  found " & integer'image(to_integer(unsigned(RAM(295))))  severity failure;
	assert RAM(296) = std_logic_vector(to_unsigned(188, 8)) report "TEST FALLITO (WORKING ZONE). Expected  188  found " & integer'image(to_integer(unsigned(RAM(296))))  severity failure;
	assert RAM(297) = std_logic_vector(to_unsigned(75, 8)) report "TEST FALLITO (WORKING ZONE). Expected  75  found " & integer'image(to_integer(unsigned(RAM(297))))  severity failure;
	assert RAM(298) = std_logic_vector(to_unsigned(99, 8)) report "TEST FALLITO (WORKING ZONE). Expected  99  found " & integer'image(to_integer(unsigned(RAM(298))))  severity failure;
	assert RAM(299) = std_logic_vector(to_unsigned(12, 8)) report "TEST FALLITO (WORKING ZONE). Expected  12  found " & integer'image(to_integer(unsigned(RAM(299))))  severity failure;
	assert RAM(300) = std_logic_vector(to_unsigned(3, 8)) report "TEST FALLITO (WORKING ZONE). Expected  3  found " & integer'image(to_integer(unsigned(RAM(300))))  severity failure;
	assert RAM(301) = std_logic_vector(to_unsigned(94, 8)) report "TEST FALLITO (WORKING ZONE). Expected  94  found " & integer'image(to_integer(unsigned(RAM(301))))  severity failure;
	assert RAM(302) = std_logic_vector(to_unsigned(134, 8)) report "TEST FALLITO (WORKING ZONE). Expected  134  found " & integer'image(to_integer(unsigned(RAM(302))))  severity failure;
	assert RAM(303) = std_logic_vector(to_unsigned(96, 8)) report "TEST FALLITO (WORKING ZONE). Expected  96  found " & integer'image(to_integer(unsigned(RAM(303))))  severity failure;
	assert RAM(304) = std_logic_vector(to_unsigned(120, 8)) report "TEST FALLITO (WORKING ZONE). Expected  120  found " & integer'image(to_integer(unsigned(RAM(304))))  severity failure;
	assert RAM(305) = std_logic_vector(to_unsigned(138, 8)) report "TEST FALLITO (WORKING ZONE). Expected  138  found " & integer'image(to_integer(unsigned(RAM(305))))  severity failure;
	assert RAM(306) = std_logic_vector(to_unsigned(116, 8)) report "TEST FALLITO (WORKING ZONE). Expected  116  found " & integer'image(to_integer(unsigned(RAM(306))))  severity failure;
	assert RAM(307) = std_logic_vector(to_unsigned(72, 8)) report "TEST FALLITO (WORKING ZONE). Expected  72  found " & integer'image(to_integer(unsigned(RAM(307))))  severity failure;
	assert RAM(308) = std_logic_vector(to_unsigned(195, 8)) report "TEST FALLITO (WORKING ZONE). Expected  195  found " & integer'image(to_integer(unsigned(RAM(308))))  severity failure;
	assert RAM(309) = std_logic_vector(to_unsigned(211, 8)) report "TEST FALLITO (WORKING ZONE). Expected  211  found " & integer'image(to_integer(unsigned(RAM(309))))  severity failure;
	assert RAM(310) = std_logic_vector(to_unsigned(105, 8)) report "TEST FALLITO (WORKING ZONE). Expected  105  found " & integer'image(to_integer(unsigned(RAM(310))))  severity failure;
	assert RAM(311) = std_logic_vector(to_unsigned(72, 8)) report "TEST FALLITO (WORKING ZONE). Expected  72  found " & integer'image(to_integer(unsigned(RAM(311))))  severity failure;
	assert RAM(312) = std_logic_vector(to_unsigned(152, 8)) report "TEST FALLITO (WORKING ZONE). Expected  152  found " & integer'image(to_integer(unsigned(RAM(312))))  severity failure;
	assert RAM(313) = std_logic_vector(to_unsigned(218, 8)) report "TEST FALLITO (WORKING ZONE). Expected  218  found " & integer'image(to_integer(unsigned(RAM(313))))  severity failure;
	assert RAM(314) = std_logic_vector(to_unsigned(212, 8)) report "TEST FALLITO (WORKING ZONE). Expected  212  found " & integer'image(to_integer(unsigned(RAM(314))))  severity failure;
	assert RAM(315) = std_logic_vector(to_unsigned(216, 8)) report "TEST FALLITO (WORKING ZONE). Expected  216  found " & integer'image(to_integer(unsigned(RAM(315))))  severity failure;
	assert RAM(316) = std_logic_vector(to_unsigned(241, 8)) report "TEST FALLITO (WORKING ZONE). Expected  241  found " & integer'image(to_integer(unsigned(RAM(316))))  severity failure;
	assert RAM(317) = std_logic_vector(to_unsigned(152, 8)) report "TEST FALLITO (WORKING ZONE). Expected  152  found " & integer'image(to_integer(unsigned(RAM(317))))  severity failure;
	assert RAM(318) = std_logic_vector(to_unsigned(54, 8)) report "TEST FALLITO (WORKING ZONE). Expected  54  found " & integer'image(to_integer(unsigned(RAM(318))))  severity failure;
	assert RAM(319) = std_logic_vector(to_unsigned(30, 8)) report "TEST FALLITO (WORKING ZONE). Expected  30  found " & integer'image(to_integer(unsigned(RAM(319))))  severity failure;
	assert RAM(320) = std_logic_vector(to_unsigned(196, 8)) report "TEST FALLITO (WORKING ZONE). Expected  196  found " & integer'image(to_integer(unsigned(RAM(320))))  severity failure;
	assert RAM(321) = std_logic_vector(to_unsigned(53, 8)) report "TEST FALLITO (WORKING ZONE). Expected  53  found " & integer'image(to_integer(unsigned(RAM(321))))  severity failure;
	assert RAM(322) = std_logic_vector(to_unsigned(135, 8)) report "TEST FALLITO (WORKING ZONE). Expected  135  found " & integer'image(to_integer(unsigned(RAM(322))))  severity failure;
	assert RAM(323) = std_logic_vector(to_unsigned(99, 8)) report "TEST FALLITO (WORKING ZONE). Expected  99  found " & integer'image(to_integer(unsigned(RAM(323))))  severity failure;
	assert RAM(324) = std_logic_vector(to_unsigned(16, 8)) report "TEST FALLITO (WORKING ZONE). Expected  16  found " & integer'image(to_integer(unsigned(RAM(324))))  severity failure;
	assert RAM(325) = std_logic_vector(to_unsigned(12, 8)) report "TEST FALLITO (WORKING ZONE). Expected  12  found " & integer'image(to_integer(unsigned(RAM(325))))  severity failure;
	assert RAM(326) = std_logic_vector(to_unsigned(132, 8)) report "TEST FALLITO (WORKING ZONE). Expected  132  found " & integer'image(to_integer(unsigned(RAM(326))))  severity failure;
	assert RAM(327) = std_logic_vector(to_unsigned(244, 8)) report "TEST FALLITO (WORKING ZONE). Expected  244  found " & integer'image(to_integer(unsigned(RAM(327))))  severity failure;
	assert RAM(328) = std_logic_vector(to_unsigned(121, 8)) report "TEST FALLITO (WORKING ZONE). Expected  121  found " & integer'image(to_integer(unsigned(RAM(328))))  severity failure;
	assert RAM(329) = std_logic_vector(to_unsigned(36, 8)) report "TEST FALLITO (WORKING ZONE). Expected  36  found " & integer'image(to_integer(unsigned(RAM(329))))  severity failure;
	assert RAM(330) = std_logic_vector(to_unsigned(154, 8)) report "TEST FALLITO (WORKING ZONE). Expected  154  found " & integer'image(to_integer(unsigned(RAM(330))))  severity failure;
	assert RAM(331) = std_logic_vector(to_unsigned(4, 8)) report "TEST FALLITO (WORKING ZONE). Expected  4  found " & integer'image(to_integer(unsigned(RAM(331))))  severity failure;
	assert RAM(332) = std_logic_vector(to_unsigned(199, 8)) report "TEST FALLITO (WORKING ZONE). Expected  199  found " & integer'image(to_integer(unsigned(RAM(332))))  severity failure;
	assert RAM(333) = std_logic_vector(to_unsigned(167, 8)) report "TEST FALLITO (WORKING ZONE). Expected  167  found " & integer'image(to_integer(unsigned(RAM(333))))  severity failure;
	assert RAM(334) = std_logic_vector(to_unsigned(203, 8)) report "TEST FALLITO (WORKING ZONE). Expected  203  found " & integer'image(to_integer(unsigned(RAM(334))))  severity failure;
	assert RAM(335) = std_logic_vector(to_unsigned(66, 8)) report "TEST FALLITO (WORKING ZONE). Expected  66  found " & integer'image(to_integer(unsigned(RAM(335))))  severity failure;
	assert RAM(336) = std_logic_vector(to_unsigned(40, 8)) report "TEST FALLITO (WORKING ZONE). Expected  40  found " & integer'image(to_integer(unsigned(RAM(336))))  severity failure;
	assert RAM(337) = std_logic_vector(to_unsigned(59, 8)) report "TEST FALLITO (WORKING ZONE). Expected  59  found " & integer'image(to_integer(unsigned(RAM(337))))  severity failure;
	assert RAM(338) = std_logic_vector(to_unsigned(19, 8)) report "TEST FALLITO (WORKING ZONE). Expected  19  found " & integer'image(to_integer(unsigned(RAM(338))))  severity failure;
	assert RAM(339) = std_logic_vector(to_unsigned(143, 8)) report "TEST FALLITO (WORKING ZONE). Expected  143  found " & integer'image(to_integer(unsigned(RAM(339))))  severity failure;
	assert RAM(340) = std_logic_vector(to_unsigned(231, 8)) report "TEST FALLITO (WORKING ZONE). Expected  231  found " & integer'image(to_integer(unsigned(RAM(340))))  severity failure;
	assert RAM(341) = std_logic_vector(to_unsigned(65, 8)) report "TEST FALLITO (WORKING ZONE). Expected  65  found " & integer'image(to_integer(unsigned(RAM(341))))  severity failure;
	assert RAM(342) = std_logic_vector(to_unsigned(43, 8)) report "TEST FALLITO (WORKING ZONE). Expected  43  found " & integer'image(to_integer(unsigned(RAM(342))))  severity failure;
	assert RAM(343) = std_logic_vector(to_unsigned(171, 8)) report "TEST FALLITO (WORKING ZONE). Expected  171  found " & integer'image(to_integer(unsigned(RAM(343))))  severity failure;
	assert RAM(344) = std_logic_vector(to_unsigned(8, 8)) report "TEST FALLITO (WORKING ZONE). Expected  8  found " & integer'image(to_integer(unsigned(RAM(344))))  severity failure;
	assert RAM(345) = std_logic_vector(to_unsigned(157, 8)) report "TEST FALLITO (WORKING ZONE). Expected  157  found " & integer'image(to_integer(unsigned(RAM(345))))  severity failure;
	assert RAM(346) = std_logic_vector(to_unsigned(254, 8)) report "TEST FALLITO (WORKING ZONE). Expected  254  found " & integer'image(to_integer(unsigned(RAM(346))))  severity failure;
	assert RAM(347) = std_logic_vector(to_unsigned(58, 8)) report "TEST FALLITO (WORKING ZONE). Expected  58  found " & integer'image(to_integer(unsigned(RAM(347))))  severity failure;
	assert RAM(348) = std_logic_vector(to_unsigned(254, 8)) report "TEST FALLITO (WORKING ZONE). Expected  254  found " & integer'image(to_integer(unsigned(RAM(348))))  severity failure;
	assert RAM(349) = std_logic_vector(to_unsigned(2, 8)) report "TEST FALLITO (WORKING ZONE). Expected  2  found " & integer'image(to_integer(unsigned(RAM(349))))  severity failure;
	assert RAM(350) = std_logic_vector(to_unsigned(225, 8)) report "TEST FALLITO (WORKING ZONE). Expected  225  found " & integer'image(to_integer(unsigned(RAM(350))))  severity failure;
	assert RAM(351) = std_logic_vector(to_unsigned(16, 8)) report "TEST FALLITO (WORKING ZONE). Expected  16  found " & integer'image(to_integer(unsigned(RAM(351))))  severity failure;
	assert RAM(352) = std_logic_vector(to_unsigned(37, 8)) report "TEST FALLITO (WORKING ZONE). Expected  37  found " & integer'image(to_integer(unsigned(RAM(352))))  severity failure;
	assert RAM(353) = std_logic_vector(to_unsigned(57, 8)) report "TEST FALLITO (WORKING ZONE). Expected  57  found " & integer'image(to_integer(unsigned(RAM(353))))  severity failure;
	assert RAM(354) = std_logic_vector(to_unsigned(150, 8)) report "TEST FALLITO (WORKING ZONE). Expected  150  found " & integer'image(to_integer(unsigned(RAM(354))))  severity failure;
	assert RAM(355) = std_logic_vector(to_unsigned(225, 8)) report "TEST FALLITO (WORKING ZONE). Expected  225  found " & integer'image(to_integer(unsigned(RAM(355))))  severity failure;
	assert RAM(356) = std_logic_vector(to_unsigned(16, 8)) report "TEST FALLITO (WORKING ZONE). Expected  16  found " & integer'image(to_integer(unsigned(RAM(356))))  severity failure;
	assert RAM(357) = std_logic_vector(to_unsigned(185, 8)) report "TEST FALLITO (WORKING ZONE). Expected  185  found " & integer'image(to_integer(unsigned(RAM(357))))  severity failure;
	assert RAM(358) = std_logic_vector(to_unsigned(35, 8)) report "TEST FALLITO (WORKING ZONE). Expected  35  found " & integer'image(to_integer(unsigned(RAM(358))))  severity failure;
	assert RAM(359) = std_logic_vector(to_unsigned(45, 8)) report "TEST FALLITO (WORKING ZONE). Expected  45  found " & integer'image(to_integer(unsigned(RAM(359))))  severity failure;
	assert RAM(360) = std_logic_vector(to_unsigned(75, 8)) report "TEST FALLITO (WORKING ZONE). Expected  75  found " & integer'image(to_integer(unsigned(RAM(360))))  severity failure;
	assert RAM(361) = std_logic_vector(to_unsigned(146, 8)) report "TEST FALLITO (WORKING ZONE). Expected  146  found " & integer'image(to_integer(unsigned(RAM(361))))  severity failure;
	assert RAM(362) = std_logic_vector(to_unsigned(8, 8)) report "TEST FALLITO (WORKING ZONE). Expected  8  found " & integer'image(to_integer(unsigned(RAM(362))))  severity failure;
	assert RAM(363) = std_logic_vector(to_unsigned(85, 8)) report "TEST FALLITO (WORKING ZONE). Expected  85  found " & integer'image(to_integer(unsigned(RAM(363))))  severity failure;
	assert RAM(364) = std_logic_vector(to_unsigned(136, 8)) report "TEST FALLITO (WORKING ZONE). Expected  136  found " & integer'image(to_integer(unsigned(RAM(364))))  severity failure;
	assert RAM(365) = std_logic_vector(to_unsigned(246, 8)) report "TEST FALLITO (WORKING ZONE). Expected  246  found " & integer'image(to_integer(unsigned(RAM(365))))  severity failure;
	assert RAM(366) = std_logic_vector(to_unsigned(175, 8)) report "TEST FALLITO (WORKING ZONE). Expected  175  found " & integer'image(to_integer(unsigned(RAM(366))))  severity failure;
	assert RAM(367) = std_logic_vector(to_unsigned(184, 8)) report "TEST FALLITO (WORKING ZONE). Expected  184  found " & integer'image(to_integer(unsigned(RAM(367))))  severity failure;
	assert RAM(368) = std_logic_vector(to_unsigned(126, 8)) report "TEST FALLITO (WORKING ZONE). Expected  126  found " & integer'image(to_integer(unsigned(RAM(368))))  severity failure;
	assert RAM(369) = std_logic_vector(to_unsigned(143, 8)) report "TEST FALLITO (WORKING ZONE). Expected  143  found " & integer'image(to_integer(unsigned(RAM(369))))  severity failure;
	assert RAM(370) = std_logic_vector(to_unsigned(94, 8)) report "TEST FALLITO (WORKING ZONE). Expected  94  found " & integer'image(to_integer(unsigned(RAM(370))))  severity failure;
	assert RAM(371) = std_logic_vector(to_unsigned(194, 8)) report "TEST FALLITO (WORKING ZONE). Expected  194  found " & integer'image(to_integer(unsigned(RAM(371))))  severity failure;
	assert RAM(372) = std_logic_vector(to_unsigned(218, 8)) report "TEST FALLITO (WORKING ZONE). Expected  218  found " & integer'image(to_integer(unsigned(RAM(372))))  severity failure;
	assert RAM(373) = std_logic_vector(to_unsigned(99, 8)) report "TEST FALLITO (WORKING ZONE). Expected  99  found " & integer'image(to_integer(unsigned(RAM(373))))  severity failure;
	assert RAM(374) = std_logic_vector(to_unsigned(250, 8)) report "TEST FALLITO (WORKING ZONE). Expected  250  found " & integer'image(to_integer(unsigned(RAM(374))))  severity failure;
	assert RAM(375) = std_logic_vector(to_unsigned(188, 8)) report "TEST FALLITO (WORKING ZONE). Expected  188  found " & integer'image(to_integer(unsigned(RAM(375))))  severity failure;
    assert false report "Simulation Ended! TEST PASSATO" severity failure;
end process test;
end projecttb;
