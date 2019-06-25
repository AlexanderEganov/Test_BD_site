const
  a1: array [0..24] of integer = (0,0,0,0,2,1,5,1,5,1,8,1,10,0,13,14,15,16,17,14,16,18,0,22,23);
  D: array [0..24] of integer = (0,0,0,0,3,1,3,1,3,1,3,1,3,3,3,3,3,3,3,4,4,4,2,1,2);
  a2: array [0..24] of integer = (0,0,0,0,3,3,4,5,6,7,9,9,11,0,0,0,0,0,0,4,8,12,19,20,21);
  p1: array [0..3] of real = (0.5,1,2,3);

var
  p: array [0..24] of real;
  i: integer;

begin

  for i:=0 to 3 do
    p[i]:=p1[i];
    
  i:=4;
  repeat
    case D[i] of
      1: p[i]:=p[a1[i]]+p[a2[i]];
      2: p[i]:=p[a1[i]]-p[a2[i]];
      3: p[i]:=p[a1[i]]*p[a2[i]];
      4: p[i]:=p[a1[i]]/p[a2[i]];
    end;
    writeln(p[i]);
    i:=i+1;
  until i=24;
  
  writeln(p[23],'    ', sin(0.5));
  
end.