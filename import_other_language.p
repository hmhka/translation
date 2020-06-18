DEF SHARED VAR pfolder AS CHAR.
DEF SHARED VAR pfile AS CHAR.
DEF SHARED VAR planguage AS CHAR EXTENT 5 INIT["En","Hin","Mar","Guj","hin"].
DEF SHARED VAR pori-lang AS CHAR.
DEF SHARED VAR pother-lang AS CHAR.
DEF SHARED VAR pcombine-lang AS CHAR.
DEF SHARED VAR plang AS CHAR.
DEF SHARED VAR psubtitle-type AS CHAR.
DEF SHARED VAR pfilename-other-lang-input AS CHAR.
DEF SHARED VAR pfilename-combine-lang-output AS CHAR.
DEF SHARED VAR plecture-name AS CHAR.

/*
DEF VAR pother-lang-srt AS CHAR.
DEF VAR pfin-lang-srt AS CHAR.
ASSIGN pother-lang-srt = "_" + plang + ".srt".
ASSIGN pfin-lan-srt  = "_" + pori-lang + plang + ".srt".
  */
/*
ASSIGN pfolder = "C:\vimeo-files\ImportantLectures".
ASSIGN pfile = "19910915GaneshaPujaTalk_Hin.srt".
  */

DEF VAR pfilename-input AS CHAR.
DEF VAR pfilename-output AS CHAR.
DEF VAR pfilename-bat AS CHAR.
DEF VAR pcons AS INT.

DEF TEMP-TABLE tt_lectures_text LIKE lectures_text.
/*ASSIGN pfilename-input  = "C:\vimeo-files\16Weeks-Colombia\MPG\01Introduction_hin.srt".*/


ASSIGN pfilename-input  = pfolder + "\" + pfile.

/*
ASSIGN pfilename-input  = "C:\vimeo-files\SahajaYoga-InnerPeace\01-InnerPeaceDay1_hin.srt".
*/
/*ASSIGN pfilename-output = REPLACE(pfilename-input,"_hin.srt","_EngHin.srt").*/
/*
ASSIGN pfilename-output = REPLACE(pfilename-input,potherlang-srt,"_EngHin.srt").
*/
ASSIGN pfilename-bat    = "c:\pvr\translation\OpenFileInChrome.bat".

MESSAGE pfilename-other-lang-input
    VIEW-AS ALERT-BOX INFO BUTTONS OK.

FOR EACH tt_lectures_text: 
    DELETE tt_lectures_text.
END.


/*INPUT FROM VALUE(pfilename-other-lang-input) /*CONVERT SOURCE "ISO8859-1" TARGET "UTF-8"*/.*/
/*INPUT FROM VALUE(pfilename-other-lang-input) CONVERT SOURCE "UTF-8" TARGET "ISO8859-1".*/
INPUT FROM VALUE(pfilename-other-lang-input) NO-CONVERT.

/*INPUT FROM VALUE(pfilename-other-lang-input) BINARY NO-MAP no-convert.*/
/*INPUT FROM VALUE(pfilename-other-lang-input) .*/
REPEAT:
    ASSIGN pcons = pcons + 1.
    CREATE tt_lectures_text.
    IMPORT UNFORMATTED tt_lectures_text.hindi-text.
    ASSIGN tt_lectures_text.cons = pcons.
    IF tt_lectures_text.hindi-text = "" THEN DO:
        ASSIGN tt_lectures_text.isempty = TRUE.
    END.
    FIND lectures_text WHERE lectures_text.cons = tt_lectures_text.cons NO-ERROR.
    IF AVAILABLE lectures_text THEN DO:
        ASSIGN lectures_text.hindi-text = tt_lectures_text.hindi-text.
        /*
        MESSAGE lectures_text.hindi-text
            VIEW-AS ALERT-BOX INFO BUTTONS OK.
            */
    END.
END.
INPUT CLOSE.

MESSAGE pfilename-combine-lang-output
    VIEW-AS ALERT-BOX INFO BUTTONS OK.
/*OUTPUT TO VALUE(pfilename-combine-lang-output)  /*CONVERT SOURCE "ISO8859-1" TARGET "UTF-8" */.*/
/*OUTPUT TO VALUE(pfilename-combine-lang-output)  CONVERT SOURCE "ISO8859-1" TARGET "UTF-8" .*/
OUTPUT TO VALUE(pfilename-combine-lang-output) BINARY NO-CONVERT .
/*OUTPUT TO VALUE(pfilename-combine-lang-output) NO-CONVERT .*/
FOR EACH lectures_text BREAK BY lectures_text.cons:
    IF lectures_text.isempty = FALSE THEN DO:
        PUT UNFORMATTED lectures_text.english-text SKIP.
        IF lectures_text.istimer = TRUE OR lectures_text.IsTimerNum = TRUE THEN DO:
        END.
        ELSE DO:
            PUT UNFORMATTED lectures_text.hindi-text SKIP.
        END.
    END.
    ELSE DO:
        PUT UNFORMATTED "" SKIP(1).
    END.
END.
OUTPUT CLOSE.
OS-COMMAND NO-WAIT VALUE(pfilename-combine-lang-output).

/*

OUTPUT TO VALUE("c:\pvr\translation\OpenFileInChrome.bat").
  PUT UNFORMATTED '"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"' " " pfilename-output.
OUTPUT CLOSE.

OS-COMMAND VALUE(pfilename-bat).
*/
/*
open -a "Google Chrome" index.html
  */

/*
FOR EACH tt_lectures_text:
    FIND lectures_text WHERE lectures_text.cons = tt_lectures_text.cons NO-ERROR.
    IF AVAILABLE lectures_text THEN DO:
        ASSIGN lectures_text.hindi-text = tt_lectures_text.hindi-text.
    END.

END.
  */
