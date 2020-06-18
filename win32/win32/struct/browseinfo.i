/* ---------------------------------------
   BROWSEINFO structure declaration
   see SHBrowseForFolder
   by Jurjen.
   --------------------------------------- */
&IF DEFINED(Variable)<>2 &THEN
  &SCOP Variable lpBI
&ENDIF 

{win32/struct/string.i &variable="{&Variable}_DisplayName"}
{win32/struct/string.i &variable="{&Variable}_Title"}

define VARIABLE {&Variable} as memptr no-undo.
define temp-table {&Variable} no-undo
  field hwndOwner      as INTEGER INITIAL 0
  FIELD pidlRoot       as INTEGER INITIAL 0
  FIELD pszDisplayName as CHAR    INITIAL ?
  FIELD lpszTitle      as CHAR    INITIAL ?
  FIELD ulFlags        as INTEGER INITIAL 0
  /* callbacks are not supported so there is no point in defining them */
  FIELD iImage         as INTEGER INITIAL 0.
create {&Variable}.

procedure buf2mem_{&Variable} :
  set-size({&Variable})    = 32.
  put-long({&Variable}, 1) = {&Variable}.hwndOwner.
  put-long({&Variable}, 5) = {&Variable}.pidlRoot.
  put-long({&Variable}, 9) = GetPointer_{&Variable}_DisplayName(FILL(' ',260)).
  put-long({&Variable},13) = GetPointer_{&Variable}_Title({&Variable}.lpszTitle).
  put-long({&Variable},17) = {&Variable}.ulFlags.
  put-long({&Variable},21) = 0.  /* lpfn (callback function) */
  put-long({&Variable},25) = 0.  /* lParam for lpfn */
  put-long({&Variable},29) = {&Variable}.iImage.
end procedure.

procedure mem2buf_{&Variable} :
  ASSIGN
    {&Variable}.pszDisplayName = GetText_{&Variable}_DisplayName(GET-LONG({&Variable},9))
    {&Variable}.iImage         = GET-LONG({&Variable}, 29).
end procedure.

PROCEDURE Release_{&Variable} :
  set-size({&Variable})    = 0.
  IF AVAILABLE {&Variable} THEN DELETE {&Variable}.
  RUN Release_{&Variable}_DisplayName.
  RUN Release_{&Variable}_Title.
END PROCEDURE.

&IF DEFINED(Destructor)<>0 &THEN
   DestroyProcs = DestroyProcs + ',Release_{&Variable}'.
&ENDIF

