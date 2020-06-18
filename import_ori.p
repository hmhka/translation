DEF NEW SHARED VAR pfolder AS CHAR.
DEF NEW SHARED VAR pfile AS CHAR.
DEF NEW SHARED VAR planguage AS CHAR EXTENT 5 INIT["En","Hin","Mar","Guj","Tag"].
DEF NEW SHARED VAR pori-lang AS CHAR.
DEF NEW SHARED VAR pother-lang AS CHAR.
DEF NEW SHARED VAR pcombine-lang AS CHAR.
DEF NEW SHARED VAR plang AS CHAR.
DEF NEW SHARED VAR psubtitle-type AS CHAR.
DEF NEW SHARED VAR pfilename-other-lang-input AS CHAR.
DEF NEW SHARED VAR pfilename-combine-lang-output AS CHAR.
DEF NEW SHARED VAR plecture-name AS CHAR.
ASSIGN pori-lang = planguage[1].
ASSIGN pother-lang = planguage[2].
ASSIGN pcombine-lang = pori-lang + pother-lang.

ASSIGN psubtitle-type = ".srt".
ASSIGN pfolder = "C:\vimeo-files\ImportantLectures\Navratri1979".
ASSIGN pfolder = "C:\vimeo-files\ImportantLectures".
ASSIGN plecture-name = "1979-0314_1_Extracts_Mothers_Comments_Early_SY_Experiences_1".
ASSIGN pfile = plecture-name + "_" + pori-lang + psubtitle-type.

DEF VAR pfilename AS CHAR.
DEF BUFFER b_lectures_text FOR lectures_text.
/*ASSIGN pfilename = "C:\vimeo-files\16Weeks-Colombia\MPG\09TheAttention_hin.srt".*/
/*ASSIGN pfilename = "C:\vimeo-files\16Weeks-Colombia\MPG\01Introduction_en.srt".*/

ASSIGN pfilename = pfolder + "\" + pfile.
ASSIGN pfilename-other-lang-input = pfolder + "\" + plecture-name + "_" + pother-lang + psubtitle-type.
ASSIGN pfilename-combine-lang-output = pfolder + "\" + plecture-name + "_" + pcombine-lang + psubtitle-type.

/*
MESSAGE pfilename SKIP
    pfilename-other-lang-input SKIP
    pfilename-combine-lang-output
    VIEW-AS ALERT-BOX INFO BUTTONS OK.
  */

IF SEARCH(pfilename) = ? THEN DO:
     MESSAGE  "File Not Found." SKIP
         pfilename
         VIEW-AS ALERT-BOX INFO BUTTONS OK.
     RETURN NO-APPLY.
END.

IF SEARCH(pfilename) = ? THEN DO:
     MESSAGE  "Second Language File Not Found." SKIP
         pfilename-other-lang-input
         VIEW-AS ALERT-BOX INFO BUTTONS OK.
     RETURN NO-APPLY.
END.

/*
ASSIGN pfilename = "C:\vimeo-files\SahajaYoga-InnerPeace\01-InnerPeaceDay1_en.srt".
*/
DEF VAR pcons AS INT.

FOR EACH lectures_text: 
    DELETE lectures_text.
END.

INPUT FROM VALUE(pfilename).
REPEAT:
    ASSIGN pcons = pcons + 1.
    CREATE lectures_text.
    IMPORT UNFORMATTED lectures_text.english-text.
    ASSIGN lectures_text.cons = pcons.
    IF lectures_text.english-text = "" THEN DO:
        ASSIGN lectures_text.isempty = TRUE.
    END.

    
    IF lectures_text.english-text MATCHES "*:*:*,*-->*" THEN DO:
        ASSIGN lectures_text.istimer = TRUE.
        FIND b_lectures_text WHERE b_lectures_text.cons = lectures_text.cons - 1 NO-ERROR.
        IF AVAILABLE b_lectures_text THEN DO:
            ASSIGN b_lectures_text.IsTimerNum = TRUE. 
        END.

    END.
    

   /* MESSAGE lectures_text.hindi-text.*/

END.
INPUT CLOSE.

FOR EACH lectures_text BREAK BY cons:
    IF lectures_text.istimer = TRUE OR lectures_text.IsTimerNum = TRUE THEN DO:
    END.
    ELSE DO:
    END.
END.

OUTPUT TO "c:\tmp\aaa.txt" /*CONVERT SOURCE "ISO8859-1" TARGET "UTF-8" */.
FOR EACH lectures_text BREAK BY cons:
    IF lectures_text.isempty = FALSE THEN DO:
        PUT UNFORMATTED
          lectures_text.english-text SKIP
            .
    END.
    ELSE DO:
        PUT UNFORMATTED "" SKIP(1).
    END.
END.

RUN C:\pvr\translation\import_other_language.p.

/**
/*
FOR EACH lectures_text BREAK BY cons:
     
    IF lectures_text.isempty = FALSE THEN
    EXPORT DELIMITER "^" lectures_text.cons " "
      lectures_text.hindi-text /*FORMAT "x(20)"*/
        .

    ELSE DO:
        PUT UNFORMATTED "" SKIP(1).
    END.
    /*
    IMPORT 
        HindiTest.HindiText NO-ERROR.
    ASSIGN HindiTest.cons = pcons.
    */

END.
  */


**/
