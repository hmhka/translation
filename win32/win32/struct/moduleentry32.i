/* ---------------------------------------
   MODULEENTRY32 structure declaration
   by Jurjen.
   --------------------------------------- */
&IF DEFINED(Variable)<>2 &THEN
  &SCOP Variable lpME
&ENDIF

define VARIABLE {&Variable} as memptr no-undo.
define temp-table {&Variable} no-undo
  FIELD th32ModuleId  as INTEGER
  FIELD th32ProcessId as INTEGER
  FIELD GlblcntUsage  as INTEGER 
  FIELD ProccntUsage  as INTEGER 
  FIELD modBaseAddr   as INTEGER 
  FIELD modBaseSize   as INTEGER 
  FIELD hModule       as INTEGER 
  FIELD szModule      as CHARACTER 
  FIELD szExepath     as CHARACTER.
create {&Variable}.

procedure buf2mem_{&Variable} :
  set-size  ({&Variable})     = 0.
  set-size  ({&Variable})     = 548.
  put-long  ({&Variable},  1) = GET-SIZE({&Variable}).
  put-long  ({&Variable},  5) = {&Variable}.th32ModuleId.
  put-long  ({&Variable},  9) = {&Variable}.th32ProcessId.
  put-long  ({&Variable}, 13) = {&Variable}.GlblcntUsage.
  put-long  ({&Variable}, 17) = {&Variable}.ProccntUsage.
  put-long  ({&Variable}, 21) = {&Variable}.modBaseAddr.
  put-long  ({&Variable}, 25) = {&Variable}.modBaseSize.
  put-long  ({&Variable}, 29) = {&Variable}.hModule.
  put-string({&Variable}, 33) = {&Variable}.szModule.
  put-string({&Variable},289) = {&Variable}.szExepath.
end procedure.

procedure mem2buf_{&Variable} :
  assign
    {&Variable}.th32ModuleId  = get-long  ({&Variable},  5)
    {&Variable}.th32ProcessId = get-long  ({&Variable},  9)
    {&Variable}.GlblcntUsage  = get-long  ({&Variable}, 13)
    {&Variable}.ProccntUsage  = get-long  ({&Variable}, 17)
    {&Variable}.modBaseAddr   = get-long  ({&Variable}, 21)
    {&Variable}.modBaseSize   = get-long  ({&Variable}, 25)
    {&Variable}.hModule       = get-long  ({&Variable}, 29)
    {&Variable}.szModule      = get-string({&Variable}, 33)
    {&Variable}.szExepath     = get-string({&Variable},289).
end procedure.

PROCEDURE Release_{&Variable} :
  set-size({&Variable})    = 0.
  IF AVAILABLE {&Variable} THEN DELETE {&Variable}.
END PROCEDURE.

&IF DEFINED(Destructor)<>0 &THEN
   DestroyProcs = DestroyProcs + ',Release_{&Variable}'.
&ENDIF

