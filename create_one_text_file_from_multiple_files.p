DEF VAR n AS INT.
DEF VAR pcons AS INT.
DEF VAR pfilename-out AS CHAR FORMAT "x(500)".
ASSIGN pfilename-out = "c:\tmp\all_files.txt".

DEF TEMP-TABLE det
    FIELD pcons AS INT
    FIELD ptext AS CHAR FORMAT "x(1000)"
INDEX idx AS PRIMARY UNIQUE pcons.

OUTPUT TO VALUE(pfilename-out).
OUTPUT CLOSE.

n = 0.
FOR EACH lectures_file WHERE lectures_file.file-name <> "":
    n = n + 1.

    IF n >= 1 THEN DO:
        MESSAGE lectures_file.file-fullname. PAUSE 0.
        INPUT FROM VALUE(lectures_file.file-fullname).
        REPEAT:
            pcons = pcons + 1.
            CREATE det.
            ASSIGN det.pcons = pcons.
            IMPORT UNFORMATTED det.ptext.
        END.
        INPUT CLOSE.
        OUTPUT TO VALUE(pfilename-out) APPEND.
        EXPORT "$$$$" lectures_file.file-fullname "$$$$".
        FOR EACH det BREAK BY det.pcons:
            /*PUT UNFORMATTED det.ptext SKIP.*/
            IF det.ptext <> "" THEN DO:
                PUT UNFORMATTED det.ptext SKIP.
            END.
            ELSE DO:
                PUT UNFORMATTED  SKIP.
            END.
            DELETE det.
        END.
        OUTPUT CLOSE.
    END.
END.

OS-COMMAND NO-WAIT VALUE(pfilename-out).
