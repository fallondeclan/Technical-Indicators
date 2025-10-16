bollingerBands:{[tab;num]
        tab:update sma:mavg[num;TP], sd:mdev[num;TP] from update TP:avg(high;low;close) from tab;
        tab:update up:sma+2*sd,down:sma-2*sd from tab;
        tab
  };
       // };
/bollingerBands[`A;2024.09.01;2024.09.20;7]

bollingersignals:{[t] 
 update tradesignal:?[(prev[close]>=up)&(close<up);1;?[(prev[close]<=down)&(close>down);-1;0]] from t 
  };
