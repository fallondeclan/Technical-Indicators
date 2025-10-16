// q load-indicators.q -p 5001 -hdb ~/path/to/hdb

defaults:`p`hdb!(5001;enlist["hdb"]);
params:.Q.def[defaults;.Q.opt .z.X];
params[`hdb]:raze params`hdb;
show params;

loadqfiles:{[dir]
  files: key hsym `$dir;
  qFiles: files where (files like "*.q");
  {system "l ", string x} each .Q.dd[hsym[`$dir]] each qFiles};
getrows:{[tablename;startDate;endDate;symcol;symb;columns]
  columns:$[columns~`;();columns!columns];
  ?[tablename;((within;`date;(enlist;startDate;endDate));(in;symcol;(),symb));0b;columns]};
singlePositionPNL:{[t;f]
  update position:0^fills ?[tradesignal=1;position;0N] from
  update position:sums tradesignal*close from
  update tradesignal:?[(i in {x[1] x[1] binr 0,x[-1]}group tradesignal); 1;?[tradesignal=-1;-1;0]] from
  update tradesignal:?[(i in {x[-1] x[-1] binr 0,x[1]}group tradesignal); -1;?[tradesignal=1;1;0]] from
  update tradesignal:?[i>=first i where tradesignal=-1;tradesignal;0] from
  f[t]
  };
loadhdb:{[dir]
   $["/"~first dir;
    system "l ",dir;
   system "l ",(raze system"pwd"),"/",dir]};
loadqfiles["indicators"];
loadhdb[params`hdb];
