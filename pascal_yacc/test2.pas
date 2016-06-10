program test;
var
  x: array [1 .. 5] of integer;
  a, c, d: integer;
begin
  b := 1;
  c := 3;
  a[2] :=c;
  for b := 1 TO b * 2 + 1 do
  BEGIN
    if (x[b] >= 2) then
      WRITE(b);
    for d:= 1 To (1 + 2) * 30 do
      WRITE(c);
  END;
end.
