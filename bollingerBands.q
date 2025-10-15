bollingerBands:{[symb;startDate;endDate;num]
	/getting first val from list so it is an atom
	if[(type symb) ~ 11h; symb:first symb];
	
	/Getting data to make use of open, high, low, close data
	tab:.man.getOHLC[symb;startDate;endDate];
	
	/calculating the simple moving average (sma),standard deviation (sd), typical price (TP)
	tab:update sma:mavg[num;TP], sd:mdev[num;TP] from update TP:avg(high;low;close) from tab;
	
	/adding the upper band (sma+2*sd) and down (sma-2*sd) to data for the output graph  
	select date,TP,sma,up:sma+2*sd,down:sma-2*sd from tab
	};
/bollingerBands[`A;2024.09.01;2024.09.20;7]
