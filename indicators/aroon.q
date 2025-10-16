//Aroon Indicator
aroonFunc:{[c;n;f]
  m:reverse each a _'(n+1+a:til count[c]-n)#\:c;
  #[n;0ni],{x? y x}'[m;f] };

aroon:{[c;n;f] 100*reciprocal[n]*n-aroonFunc[c;n;f]};

/- aroon[tab`high;25;max]-- aroon up
/- aroon[tab`low;25;max]-- aroon down
aroonOsc:{[h;l;n] aroon[h;n;max] - aroon[l;n;min]};

addarooncols:{[t;startDate;endDate;n]
    select from 
    (select
    date,
    close,
    aroonUp:aroon[high;n;max],
    aroonDown:aroon[low;n;min],
    aroonOsc:aroonOsc[high;low;n]
    from t) where date within (startDate;endDate)};

aroonsignals:{[t]
//  update position:0^fills ?[tradesignal=1;position;0N] from
//  update position:sums tradesignal*close from
//  update tradesignal:?[(i in {x[1] x[1] binr 0,x[-1]}group tradesignal); 1;?[tradesignal=-1;-1;0]] from
//  update tradesignal:?[(i in {x[-1] x[-1] binr 0,x[1]}group tradesignal); -1;?[tradesignal=1;1;0]] from
//  update tradesignal:?[i>=first i where tradesignal=-1;tradesignal;0] from 
  update tradesignal:?[(aroonOsc>0)&(prev[aroonOsc]<0);1;?[(aroonOsc<0)&(prev[aroonOsc]>0);-1;0]] from t
  };
