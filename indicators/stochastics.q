stoOscCalc:{[c;h;l;n]
  lows:mmin[n;l];
  highs:mmax[n;h];
  (a#0n),(a:n-1)_100*reciprocal[highs-lows]*c-lows }

/k-smoothing for %D
/for fast stochastic oscillation smoothing is set to one k=1/slow k=3 default
/d-smoothing for %D -  this generally set for 3
/general set up n=14,k=1(fast),slow(slow),d=3

stoOscK:{[c;h;l;n;k] (a#0nf),(a:n+k-2)_mavg[k;stoOscCalc[c;h;l;n]] }

stoOscD:{[c;h;l;n;k;d] (a#0n),(a:n+k+d-3)_mavg[d;stoOscK[c;h;l;n;k]]}


addstochcols:{[k;d;tab;startDate;endDate;lookback]
   //t:getrows[tabname;startDate-lookback;endDate;symcol;symb];
  //t:select from `:db/lohlc where date within (startDate-lookback;endDate), symbol in symb;
   tab:update high:mmax[lookback;high], low:mmin[lookback;low] from tab;
   update
    sC:stoOscCalc[close;high;low;5],
    sK:stoOscK[close;high;low;5;k],
    sD:stoOscD[close;high;low;5;k;d]
    from tab}
stochsignals:{[t]
  update tradesignal:?[(sK<sD)&(prev[sK>sD])&(sK>80)&(sD>80);1;?[(sK>sD)&(prev[sK<sD])&(sK<20)&(sD<20);-1;0]] from t
  };
