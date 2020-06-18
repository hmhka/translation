/* ---------------------------------------
   RECT structure declaration
   by Jurjen.
   --------------------------------------- */

&IF DEFINED(Variable)<>2 &THEN
  &SCOP Variable lpRect
&ENDIF 

define VARIABLE {&Variable} as memptr no-undo.
define temp-table {&Variable} no-undo
  field left   as integer
  field top    as integer
  field right  as integer
  field bottom as integer.
create {&Variable}.

procedure buf2mem_{&Variable} :
  set-size({&Variable})    = 16.
  put-long({&Variable}, 1) = {&Variable}.left.
  put-long({&Variable}, 5) = {&Variable}.top.
  put-long({&Variable}, 9) = {&Variable}.right.
  put-long({&Variable},13) = {&Variable}.bottom.
end procedure.

procedure mem2buf_{&Variable} :
  assign
    {&Variable}.left   = get-long({&Variable}, 1)
    {&Variable}.top    = get-long({&Variable}, 5)
    {&Variable}.right  = get-long({&Variable}, 9)
    {&Variable}.bottom = get-long({&Variable},13).
end procedure.

PROCEDURE Release_{&Variable} :
  set-size({&Variable})    = 0.
  IF AVAILABLE {&Variable} THEN DELETE {&Variable}.
END PROCEDURE.

&IF DEFINED(Destructor)<>0 &THEN
   DestroyProcs = DestroyProcs + ',Release_{&Variable}'.
&ENDIF

