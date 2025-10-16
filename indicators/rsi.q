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

rsiMain:{[close;n]
  diff:-[close;prev close];
  rs:relativeStrength[n;diff*diff>0]%relativeStrength[n;abs diff*diff<0];
  rsi:100*rs%(1+rs);
  rsi };

rsiMain2:{[tab;startDate;endDate;symcol;symb;timeP]
        /getting first val from list so it is an atom
        if[(type symb) ~ 11h; symb:first symb];

        /rsi always usings 14 day period so subtract from start date - working days only
        startDayRange:startDate - til 30;
        endDayRange:endDate + til 30;

        getrows[tab;[startDayRange where not (startDayRange mod 7) <= 1][timeP];[endDayRange where not (endDayRange mod 7) <= 1][timeP];symcol;symb;`date`close]
        };
addRSIcols:{[tab;startDate;endDate;timeP]
        tab:?[tab;();0b;`date`rsi`close!(`date;(`rsiMain;`close;timeP);`close)];
        select from tab where date within (startDate;endDate)
        };
rsisignals:{[t]
 update tradesignal:?[(rsi>70)&(prev[rsi]>70);1;?[(rsi>30)&(prev[rsi]<30)&(not null prev[rsi]);-1;0]] from t 
  };
/rsiMain2[2024.09.01;2024.09.14;`A;14]
