/function to return the closing prices for 14 day period
getRsiClosePrices:{[symb;startDate]
	/getting first val from list so it is an atom
	if[(type symb) ~ 11h; symb:first symb];	
	
	/rsi always usings 14 day period so subtract from start date - working days only 
	dayRange:startDate + til 30;
	
	/getting table using .man.getTS
	tab:.man.getTS[symb;startDate;[dayRange where not (dayRange mod 7) <= 1][14]];
	tab
	};
/getRsiClosePrices[`A;2024.09.01]


relativeStrength:{[num;y]
  	begin:num#0Nf;
  	start:avg((num+1)#y);
  	begin,start,{(y+x*(z-1))%z}\[start;(num+1)_y;num] 
	};

rsiMain2:{[startDate;symb;timeP]
	/getting first val from list so it is an atom
	if[(type symb) ~ 11h; symb:first symb];	
	
	/rsi uses 14 working day period so subtract from start date - working days only 
	startDayRange:startDate - til 30;
	endDayRange:startDate + til 30;
 
	/getting table using .man.getTS inputs generated from the start and end day ranges with input from user
	tab:.man.getTS[symb;[startDayRange where not (startDayRange mod 7) <= 1][timeP-1];[endDayRange where not (endDayRange mod 7) <= 1][timeP-1]];
	tab:select date,close:tab[symb] from tab;
	closPx:exec close from tab;
	
	/calculating the difference between closing price and its previous closing price
	diff:-[closPx;prev closPx];
  	
	rs:relativeStrength[timeP-1;diff*diff>0]%relativeStrength[timeP-1;abs diff*diff<0];
  	
	rsi:100*rs%(1+rs);
	
	/getting the values for the selected user time period
	tab: neg[timeP]#tab;
	rsi: neg[timeP]#rsi;
	tab:update rsi:rsi from tab;
	
	select date,rsi,overbought:70, oversold:30 from tab where date>=startDate

	};
/rsiMain2[2024.09.01;`A;14]
