DEF VAR pfilename AS CHAR.
DEF BUFFER b_lectures_text FOR lectures_text.
/*ASSIGN pfilename = "C:\vimeo-files\16Weeks-Colombia\MPG\09TheAttention_hin.srt".*/
/*ASSIGN pfilename = "C:\vimeo-files\16Weeks-Colombia\MPG\01Introduction_en.srt".*/
DEF VAR pfolder AS CHAR.
DEF VAR pfile AS CHAR.
ASSIGN pfolder = "C:\vimeo-files\ImportantLectures".
ASSIGN pfile = "EkadashaRudraPuja84_en.srt".

ASSIGN pfilename = pfolder + "\" + pfile.

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
