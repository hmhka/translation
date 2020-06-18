/* ---------------------------------------
   OPENFILENAME structure declaration
   by Jurjen.
   --------------------------------------- */
&IF DEFINED(Variable)<>2 &THEN
  &SCOP Variable lpOFN
&ENDIF 

define VARIABLE {&Variable} as memptr no-undo.
define temp-table {&Variable} no-undo
  FIELD hwndOwner         as INTEGER INITIAL 0
  FIELD hInstance         as INTEGER INITIAL 0
  FIELD lpstrFilter       as CHAR    INITIAL ?
  FIELD lpstrCustomFilter as CHAR    INITIAL ?
  FIELD nMaxCustFilter    as INTEGER INITIAL 0
  FIELD nFilterIndex      as INTEGER INITIAL 0
  FIELD lpstrFile         as CHAR    INITIAL ?
  FIELD nMaxFile          as INTEGER INITIAL 0
  FIELD lpstrFileTitle    as CHAR    INITIAL ?
  FIELD nMaxFileTitle     as INTEGER INITIAL 0
  FIELD lpstrInitialDir   as CHAR    INITIAL ?
  FIELD lpstrTitle        as CHAR    INITIAL ?
  FIELD Flags             as INTEGER INITIAL 0
  FIELD nFileOffset       as INTEGER
  FIELD nFileExtention    as INTEGER
  FIELD lpstrDefExt       as CHAR    INITIAL ?
  FIELD lCustData         as INTEGER INITIAL 0
  FIELD lpfnHook          as INTEGER INITIAL 0
  FIELD lpTemplateName    as CHAR    INITIAL ?.
create {&Variable}.

/* create memptr's for each of the string members: */
{win32/struct/string.i &variable="{&Variable}_Filter"}
{win32/struct/string.i &variable="{&Variable}_CustomFilter"}
{win32/struct/string.i &variable="{&Variable}_File"}
{win32/struct/string.i &variable="{&Variable}_FileTitle"}
{win32/struct/string.i &variable="{&Variable}_InitialDir"}
{win32/struct/string.i &variable="{&Variable}_Title"}
{win32/struct/string.i &variable="{&Variable}_DefExt"}
{win32/struct/string.i &variable="{&Variable}_Template"}


/* transfer the temp-table record to the memptr. */
/* might as well add a couple of sanity checks */
procedure buf2mem_{&Variable} :

  DEF VAR cFile as CHAR NO-UNDO.
  DEF VAR nLen  as INTEGER NO-UNDO.
  nLen = LENGTH({&Variable}.lpstrFile).
  if nLen=? THEN nLen=0.
  {&Variable}.nMaxFile = MAXIMUM(256, {&Variable}.nMaxFile, nLen).

  set-size ({&Variable})    = 76.
  put-long ({&Variable}, 1) = 76.
  put-long ({&Variable}, 5) = {&Variable}.hwndOwner.
  put-long ({&Variable}, 9) = {&Variable}.hInstance.

  DEF VAR cFilter as CHAR    NO-UNDO.
  DEF VAR i       as INTEGER NO-UNDO INITIAL 1.
  cFilter = {&Variable}.lpstrFilter + '||'.
  put-long ({&Variable},13) = GetPointer_{&Variable}_Filter(cFilter).
  /* replace each '|' by 0 */
  DO WHILE i <= GET-SIZE({&Variable}_Filter) :
    IF GET-BYTE({&Variable}_Filter, i)=ASC('|') THEN 
       PUT-BYTE({&Variable}_Filter, i)=0.
    i = i + 1.
  END.

  put-long ({&Variable},17) = GetPointer_{&Variable}_CustomFilter({&Variable}.lpstrCustomFilter).
  put-long ({&Variable},21) = if {&Variable}.lpstrCustomFilter=? THEN 0 ELSE MAXIMUM(40,LENGTH({&Variable}.lpstrCustomFilter)).
  put-long ({&Variable},25) = {&Variable}.nFilterIndex.

  IF {&Variable}.lpstrFile=? THEN DO:
     cFile = FILL(' ', {&Variable}.nMaxFile).
     put-long({&Variable},29) = GetPointer_{&Variable}_File(cFile).
     PUT-BYTE({&Variable}_File,1)=0.
  END.
  ELSE DO:
     cFile = {&Variable}.lpstrFile.
     IF LENGTH(cFile)<256 THEN 
        cFile = cFile + FILL(' ', 256 - LENGTH(cFile)).
     put-long({&Variable},29) = GetPointer_{&Variable}_File(cFile).
  END.

  put-long ({&Variable},33) = LENGTH(cFile).
  put-long ({&Variable},37) = GetPointer_{&Variable}_FileTitle({&Variable}.lpstrFileTitle).
  put-long ({&Variable},41) = {&Variable}.nMaxFileTitle.
  put-long ({&Variable},45) = GetPointer_{&Variable}_InitialDir({&Variable}.lpstrInitialDir).
  put-long ({&Variable},49) = GetPointer_{&Variable}_Title({&Variable}.lpstrTitle).
  put-long ({&Variable},53) = {&Variable}.Flags.
  put-short({&Variable},57) = {&Variable}.nFileOffset.
  put-short({&Variable},59) = {&Variable}.nFileExtention.
  put-long ({&Variable},61) = GetPointer_{&Variable}_DefExt({&Variable}.lpstrDefExt).
  put-long ({&Variable},65) = {&Variable}.lCustData.
  put-long ({&Variable},69) = {&Variable}.lpfnHook.
  put-long ({&Variable},73) = GetPointer_{&Variable}_Template({&Variable}.lpTemplateName).

end procedure.

/* transfer the memptr to the temp-table record */
/* am getting lazy so I will do only the members that can be modified */
procedure mem2buf_{&Variable} :
  assign
    {&Variable}.lpstrCustomFilter = GetText_{&Variable}_CustomFilter(get-long({&Variable}, 17))
    {&Variable}.nFilterIndex      = GET-LONG({&Variable}, 25)
    {&Variable}.lpstrFile         = GetText_{&Variable}_File(get-long({&Variable}, 29))
    {&Variable}.lpstrFileTitle    = GetText_{&Variable}_FileTitle(get-long({&Variable}, 37))
    {&Variable}.nFileOffset       = GET-SHORT({&Variable}, 57)
    {&Variable}.nFileExtention    = GET-SHORT({&Variable}, 59).
end procedure.

/* clean up */
PROCEDURE Release_{&Variable} :
  set-size({&Variable})    = 0.
  IF AVAILABLE {&Variable} THEN DELETE {&Variable}.
  RUN Release_{&Variable}_Filter.
  RUN Release_{&Variable}_CustomFilter.
  RUN Release_{&Variable}_File.
  RUN Release_{&Variable}_FileTitle.
  RUN Release_{&Variable}_InitialDir.
  RUN Release_{&Variable}_Title.
  RUN Release_{&Variable}_DefExt.
  RUN Release_{&Variable}_Template.
END PROCEDURE.

/* add Release_XXX procedure to the list of things to do "on close" */
&IF DEFINED(Destructor)<>0 &THEN
   DestroyProcs = DestroyProcs + ',Release_{&Variable}'.
&ENDIF


