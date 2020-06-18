DEF VAR pfilename-txt AS CHAR FORMAT "x(500)".
DEF VAR pfilename-bat AS CHAR FORMAT "x(500)".
DEF VAR pcom-txt AS CHAR FORMAT "x(200)".
DEF VAR pname AS CHAR FORMAT "x(200)".
    DEF VAR pname-new AS CHAR FORMAT "x(200)".
    DEF VAR pname-folder AS CHAR FORMAT "x(200)".
    DEF VAR pname-file AS CHAR FORMAT "x(200)".

DEF VAR pcons AS INT.

DEF TEMP-TABLE det 
    FIELD pcons AS INT
    FIELD pfullfilename AS CHAR
    FIELD pfilename AS CHAR
    FIELD pfoldername AS CHAR
    INDEX idx AS PRIMARY UNIQUE pcons.

ASSIGN pfilename-txt = "c:\tmp\list_SubtitleFiles.txt".
ASSIGN pfilename-bat = "c:\tmp\list_SubtitleFiles.bat".

OUTPUT TO VALUE (pfilename-bat).
    PUT UNFORMATTED "cd c:\tmp\SubtitleFiles" SKIP.
    PUT UNFORMATTED "dir /b /s /a > " + pfilename-txt SKIP.
    /*PUT UNFORMATTED "pause" SKIP.*/
OUTPUT CLOSE.


OS-COMMAND NO-WAIT VALUE(pfilename-bat).

ASSIGN pcons = 0.
INPUT FROM VALUE(pfilename-txt).
REPEAT:
    pcons = pcons + 1.
    CREATE det.
    ASSIGN det.pcons = pcons.
    IMPORT UNFORMATTED det.pfullfilename.
    MESSAGE det.pfullfilename. PAUSE 0.
END.
INPUT CLOSE.

FOR EACH det BREAK BY det.pcons:
    ASSIGN pname = det.pfullfilename.
    RUN CHECK_filename.

    CREATE lectures_file.
    ASSIGN lectures_file.file-num = det.pcons
           lectures_file.file-fullname = det.pfullfilename
           lectures_file.file-name = pname-file
           lectures_file.file-path = pname-folder.
END.



/*
ASSIGN pcom-txt = "cd c:\tmp\SubtitleFiles dir /b /s /a > " + pfilename-txt.
*/
/*OS-COMMAND NO-WAIT VALUE(pfilename-txt).*/


PROCEDURE CHECK_filename.
    
    ASSIGN pname-new = REPLACE(pname,"\",",").
    ASSIGN pname-folder = 
                        ENTRY(1,pname-new) + "\" + 
                        ENTRY(2,pname-new) + "\" + 
                        ENTRY(3,pname-new) + "\" + 
                        ENTRY(4,pname-new) + "\" 
        .
    ASSIGN pname-file = ENTRY(5,pname-new).
END.





