onBalanceVolume:{[symb;startDate;endDate]
	/getting first val from list so it is an atom
	if[(type symb) ~ 11h; symb:first symb];

	tab:.man.getOHLC[symb;startDate;endDate];
	/taking the volume data and comparing each value to the previous in the list.
	vols:exec volume from tab;
	volDiff:-[vols;prev vols];
	
	/adding the volume differences to list to show on graph 
	tab:update OBV:volDiff from tab;
	tab
	};
/onBalanceVolume[`A;2024.09.01;2024.09.20]