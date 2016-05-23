library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity zomby is
--所有僵尸的攻击力都是1/s，所以不用存储
	port(
		 zombykind: in std_logic_vector(4 downto 0);
		 lifetime: out std_logic_vector(7 downto 0);
		 recovertime: out std_logic_vector(5 downto 0);
		 fire: out std_logic_vector(6 downto 0);
		 fireinterval: out std_logic_vector(3 downto 0);
		 fireradius: out std_logic_vector(6 downto 0);
		 price: out std_logic_vector(6 downto 0);
		 sunariseinterval: out std_logic_vector(5 downto 0);
		 preparetime: out std_logic_vector(5 downto 0);
		 address:out std_logic_vector(18 downto 0); --注意加零
		 --address的具体每位分布待定
		 lasttime:out std_logic_vector(3 downto 0)
	);
end zomby;

architecture zombybehavioral of zomby is
	signal addressinfo:std_logic_vector(31 downto 0);
	--address info：第一位到第三位存储僵尸的生命值，生命值一共六种，270,500,540,640,1370,1670
	--第四位到第五位存储植物的价格，价格有2,3,4,5,一共四种
	--剩下十九位存储动画的的开头地址，默认每个动画是5帧，也就是一共是5个连续的地址
begin	
	--读取sram
	--process(address) --此部分内容有待sram读写程序完善
	--此process的目的在于读取sram
	--begin
	--此部分需要对addressinfo赋值
	--end process;
	
	
end zombybehavioral;
