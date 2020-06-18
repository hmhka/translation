DEF VAR pfilename-input AS CHAR.
DEF VAR pfilename-output AS CHAR.
DEF VAR pfilename-bat AS CHAR.
DEF VAR pcons AS INT.

DEF TEMP-TABLE tt_lectures_text LIKE lectures_text.
ASSIGN pfilename-input  = "C:\vimeo-files\16Weeks-Colombia\MPG\09TheAttention_hin.srt".
ASSIGN pfilename-output = "c:\tmp\aaa1.txt".
ASSIGN pfilename-bat    = "c:\pvr\translation\OpenFileInChrome.bat".


FOR EACH tt_lectures_text: 
    DELETE tt_lectures_text.
END.

INPUT FROM VALUE(pfilename-input).
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
    END.
END.
INPUT CLOSE.

OUTPUT TO VALUE(pfilename-output)  /*CONVERT SOURCE "ISO8859-1" TARGET "UTF-8" */.
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

OUTPUT TO VALUE("c:\pvr\translation\OpenFileInChrome.bat").
  PUT UNFORMATTED '"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"' " " pfilename-output.
OUTPUT CLOSE.

OS-COMMAND VALUE(pfilename-bat).
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
