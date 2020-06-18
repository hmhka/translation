/* ---------------------------------------
   DOCINFO structure declaration
   by Jurjen.
   --------------------------------------- */
&IF DEFINED(Variable)<>2 &THEN
  &SCOP Variable lpDocInfo
&ENDIF 

{win32/struct/string.i &variable="{&Variable}_Docname"}
{win32/struct/string.i &variable="{&Variable}_Output"}
{win32/struct/string.i &variable="{&Variable}_Datatype"}

define VARIABLE {&Variable} as memptr no-undo.
define temp-table {&Variable} no-undo
  field lpszDocName   as CHAR    INITIAL ?
  field lpszOutput    as CHAR    INITIAL ?
  field lpszDatatype  as CHAR    INITIAL ?
  field fwType        as INTEGER INITIAL 0.
create {&Variable}.

procedure buf2mem_{&Variable} :
  set-size({&Variable})    = 20.
  put-long({&Variable}, 1) = 20.
  put-long({&Variable}, 5) = GetPointer_{&Variable}_Docname({&Variable}.lpszDocname).
  put-long({&Variable}, 9) = GetPointer_{&Variable}_Output({&Variable}.lpszOutput).
  put-long({&Variable},13) = GetPointer_{&Variable}_Datatype({&Variable}.lpszDatatype).
  put-long({&Variable},17) = {&Variable}.fwType.
end procedure.

procedure mem2buf_{&Variable} :
  assign
    {&Variable}.lpszDocname   = GetText_{&Variable}_Docname(get-long({&Variable}, 5))
    {&Variable}.lpszOutput    = GetText_{&Variable}_Docname(get-long({&Variable}, 9))
    {&Variable}.lpszDatatype  = GetText_{&Variable}_Docname(get-long({&Variable},13))
    {&Variable}.fwType        = get-long({&Variable},17).
end procedure.

PROCEDURE Release_{&Variable} :
  set-size({&Variable})    = 0.
  IF AVAILABLE {&Variable} THEN DELETE {&Variable}.
  RUN Release_{&Variable}_Docname.
  RUN Release_{&Variable}_Output.
  RUN Release_{&Variable}_Datatype.
END PROCEDURE.

&IF DEFINED(Destructor)<>0 &THEN
   DestroyProcs = DestroyProcs + ',Release_{&Variable}'.
&ENDIF

