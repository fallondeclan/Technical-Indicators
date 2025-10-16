//table to use 
.man.getOHLC:{ [sym;start_date;end_date] select symbol,date,open,high,low,close,volume from `:./db/lohlc where symbol=sym,date within (start_date;end_date)};


//movingAverage - with filters
.man.movingaverage:{[sym;start_date;end_date;mavg1;mavg2;mavg3]update sma1:mavg[mavg1;close],sma2:mavg[mavg2;close],sma3:mavg[mavg3;close] from `.man.getOHLC[sym;start_date;end_date]};

//movingAverage - with no filters
.man.simplemovingaverage:{[sym;start_date;end_date;mavg1;mavg2;mavg3]select symbol,date,open,high,low,close,sma1,sma2,sma3 from `.man.movingaverage[sym;start_date;end_date;mavg1;mavg2;mavg3]};
