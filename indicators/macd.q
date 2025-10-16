macd:{[tab;fastPeriod;slowPeriod]

 	/ fast - short EMA period (default 12)
 	/ slow - long EMA period (default 26)
 	/ signalLine  - signal EMA period (default 9)	
	/fast:12;
	fast:fastPeriod;
	/slow:26;
	slow:slowPeriod;
	signalLine:9;
	
	/get the closing price data from the function .man.getTS
	closPx:exec close from tab;

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
	select date, close, ema12:ema12, ema26:ema26, macd:macdLine, signal:signalLine, histogram:hist from tab
	};

macdsignals:{[t]  update tradesignal:?[(prev[macd]>=signal)&(macd<signal);1;?[(prev[macd]<=signal)&(macd>signal);-1;0]] from t};
/macd[2024.09.01;2024.09.30;`A]
