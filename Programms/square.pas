const c = 100;
a = 2000;

var
i, t: integer;
y: array [1..100] of real;
ca, am, S, p: real;

begin
  t:=50;
  p:=4;

  for i:=1 to 100 do
    y[i]:=(0.9+0.2*random)*c + a*exp((-sqr((i-t)/p)));
  
//  for i:=1 to 100 do
//    writeln(y[i],'   ');
  ca:=0;
  
  for i:=1 to 30 do
    ca:=ca+y[i]+y[i+70];
  ca:=ca/60;
  
//  writeln(ca);
  
  am:=0;
  for i:=1 to 100 do
  begin
    y[i]:=y[i]-ca;
    if y[i]>am then
    begin
      am:=y[i];
      t:=i;
    end;
  end;
  
  S:=0;
  i:=t;
//  writeln(t);
  
  repeat
    S:=S+y[i];
    i:=i+1;
  until
    y[i]<0;
    
  S:=S-y[i];
  
  i:=t-1;
  repeat
    S:=S+y[i];
    i:=i-1;
  until
    y[i]<0;
    
  S:=S-y[i];
  
  p:=S/(am*sqrt(pi));
  writeln(am,'        ',s,'          ',p,'           ',ca);

end.