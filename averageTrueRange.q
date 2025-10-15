/Average True Range TI
atr:{[symb;startDate;endDate;period]
	/getting first val from list so it is an atom
	if[(type symb) ~ 11h; symb:first symb];

	tab:.man.getOHLC[symb;startDate;endDate];
	
	/Adding previous closing prices to the table.
	tab:update prevClose:prev close from tab;
	
	/True Range (TR) is taking the max value from the 3 calculations 	
	tab:update TR:max(high - low; abs high - prevClose; abs low - prevClose) from tab;
	
	/Getting the moving average of this TR from the day period inputted by user. 
	tab:update ATR:period mavg TR from tab;
	tab
	};
/atr[`A;2024.10.01;2024.10.30;14]