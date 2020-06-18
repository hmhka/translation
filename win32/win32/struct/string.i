/* ---------------------------------------
   STRING functions to be used for 
   string members in structures.
   by Jurjen.
   --------------------------------------- */

&IF DEFINED(Variable)<>2 &THEN
  &SCOP Variable lpString
&ENDIF 

DEFINE VARIABLE {&Variable} as memptr no-undo.

FUNCTION GetPointer_{&Variable} returns integer (txt as CHAR) :
  SET-SIZE({&Variable})=0.
  if txt=? THEN RETURN 0.
  SET-SIZE({&Variable})=LENGTH(txt) + 1.
  PUT-STRING({&Variable},1) = txt.
  RETURN GET-POINTER-VALUE({&Variable}).
END FUNCTION.

FUNCTION GetText_{&Variable} returns CHAR (ptr as INTEGER) :
  if ptr=0 THEN RETURN ?.
  SET-POINTER-VALUE({&Variable})=ptr.
  RETURN GET-STRING({&Variable},1).
END FUNCTION.

PROCEDURE Release_{&Variable} :
  set-size({&Variable}) = 0.
END PROCEDURE.

&IF DEFINED(Destructor)<>0 &THEN
   DestroyProcs = DestroyProcs + ',Release_{&Variable}'.
&ENDIF

