macd:{[startDate;endDate;symb;fastPeriod;slowPeriod]
	/getting first val from list so it is an atom
	if[(type symb) ~ 11h; symb:first symb];	
	
	/getting table using .man.getTS
	tab:.man.getTS[symb;startDate;endDate];

 	/ fast - short EMA period (default 12)
 	/ slow - long EMA period (default 26)
 	/ signalLine  - signal EMA period (default 9)	
	/fast:12;
	fast:fastPeriod;
	/slow:26;
	slow:slowPeriod;
	signalLine:9;
	
	/get the closing price data from the function .man.getTS
	closPx:exec tab[symb] from tab;

	/now create the multipliers 
	calcFast:2 %(fast +1);
	calcSlow:2 %(slow + 1);
	calcSig:2 %(signalLine + 1);

	/compute ema12 and ema26 using built in ema function
	ema12:(ema[calcFast] closPx);
	ema26:(ema[calcSlow] closPx);
	
	/MACD line 
	macdLine:ema12 - ema26;

	/Signal Line (EMA of MACD line)
	signalLine:ema[calcSig] macdLine;

	/hist line is subtract signalLine from macdLine
	hist: macdLine - signalLine;
	
	/output as a table to create graph
	res:select date, closePrice:closPx, ema12:ema12, ema26:ema26, macd:macdLine, signal:signalLine, histogram:hist from tab;
	res
	};
/macd[2024.09.01;2024.09.30;`A]
