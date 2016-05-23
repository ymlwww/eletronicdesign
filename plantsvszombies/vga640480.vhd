library	ieee;
use		ieee.std_logic_1164.all;
use		ieee.std_logic_unsigned.all;
use		ieee.std_logic_arith.all;

entity vga640480 is
	 port(
			address		:		  out	STD_LOGIC_VECTOR(13 DOWNTO 0);
			reset       :         in  STD_LOGIC;
			clk25       :		  out std_logic; 
			q		    :		  in STD_LOGIC;
			clk_0       :         in  STD_LOGIC; --100Mʱ������
			hs,vs       :         out STD_LOGIC; --��ͬ������ͬ���ź�
			mousex: in std_logic_vector(9 downto 0);
			mousey: in std_logic_vector(9 downto 0);
			r,g,b       :         out STD_LOGIC_vector(2 downto 0)
	  );
end vga640480;

architecture behavior of vga640480 is
	
	signal r1,g1,b1   : std_logic_vector(2 downto 0);					
	signal hs1,vs1    : std_logic;				
	signal vector_x : std_logic_vector(9 downto 0);		--X����
	signal vector_y : std_logic_vector(8 downto 0);		--Y����
	signal clk1	:	 std_logic;
	signal clk :  	 std_logic;
	signal biasx: std_logic_vector(9 downto 0);
	signal biasy: std_logic_vector(9 downto 0);
begin

clk25 <= clk;
 -----------------------------------------------------------------------
  process(clk_0)	--��100M�����źŶ���Ƶ
    begin
        if(clk_0'event and clk_0='1') then 
             clk1 <= not clk1;
        end if;
 	end process;
  process(clk1)	--��50M�����źŶ���Ƶ
    begin
        if(clk1'event and clk1='1') then 
             clk <= not clk;
        end if;
 	end process;

 -----------------------------------------------------------------------
	 process(clk,reset)	--������������������������
	 begin
	  	if reset='0' then
	   		vector_x <= (others=>'0');
	  	elsif clk'event and clk='1' then
	   		if vector_x=799 then
	    		vector_x <= (others=>'0');
	   		else
	    		vector_x <= vector_x + 1;
	   		end if;
	  	end if;
	 end process;

  -----------------------------------------------------------------------
	 process(clk,reset)	--����������������������
	 begin
	  	if reset='0' then
	   		vector_y <= (others=>'0');
	  	elsif clk'event and clk='1' then
	   		if vector_x=799 then
	    		if vector_y=524 then
	     			vector_y <= (others=>'0');
	    		else
	     			vector_y <= vector_y + 1;
	    		end if;
	   		end if;
	  	end if;
	 end process;
 
  -----------------------------------------------------------------------
	 process(clk,reset) --��ͬ���źŲ�����ͬ������96��ǰ��16��
	 begin
		  if reset='0' then
		   hs1 <= '1';
		  elsif clk'event and clk='1' then
		   	if vector_x>=656 and vector_x<752 then
		    	hs1 <= '0';
		   	else
		    	hs1 <= '1';
		   	end if;
		  end if;
	 end process;
 
 -----------------------------------------------------------------------
	 process(clk,reset) --��ͬ���źŲ�����ͬ������2��ǰ��10��
	 begin
	  	if reset='0' then
	   		vs1 <= '1';
	  	elsif clk'event and clk='1' then
	   		if vector_y>=490 and vector_y<492 then
	    		vs1 <= '0';
	   		else
	    		vs1 <= '1';
	   		end if;
	  	end if;
	 end process;
 -----------------------------------------------------------------------
	 process(clk,reset) --��ͬ���ź�����
	 begin
	  	if reset='0' then
	   		hs <= '0';
	  	elsif clk'event and clk='1' then
	   		hs <=  hs1;
	  	end if;
	 end process;

 -----------------------------------------------------------------------
	 process(clk,reset) --��ͬ���ź�����
	 begin
	  	if reset='0' then
	   		vs <= '0';
	  	elsif clk'event and clk='1' then
	   		vs <=  vs1;
	  	end if;
	 end process;
	
 -----------------------------------------------------------------------	
	biasx <= vector_x - mousex;
	biasy <= vector_y - mousey;
	process(reset,clk,vector_x,vector_y) -- XY���궨λ����
	begin  
		if reset='0' then
			        r1  <= "000";
					g1	<= "000";
					b1	<= "000";	
		elsif(clk'event and clk='1')then
		 			
			if vector_x>=mousex and vector_x-mousex<=31 and vector_y >= mousey and vector_y - mousey <= 15 then
				address <= "0001" & vector_y(4 downto 0) & vector_x(4 downto 0);
				if q = '0' then
					r1 <="111";				  	
					b1 <="111";
					g1 <="111";
				else
					r1  <= "000";
					g1	<= "000";
					b1	<= "111"; 
				end if;
			else 
					r1  <= "000";
					g1	<= "000";
					b1	<= "000";
			end if;
		end if;		 
	    end process;	

	-----------------------------------------------------------------------
	process (hs1, vs1, r1, g1, b1)	--ɫ������
	begin
		if hs1 = '1' and vs1 = '1' then
			r	<= r1;
			g	<= g1;
			b	<= b1;
		else
			r	<= (others => '0');
			g	<= (others => '0');
			b	<= (others => '0');
		end if;
	end process;

end behavior;

