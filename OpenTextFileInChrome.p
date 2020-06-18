DEFINE VARIABLE cProgramName  AS CHARACTER  NO-UNDO.
DEFINE VARIABLE cPageAddress  AS CHARACTER  NO-UNDO.
DEFINE VARIABLE iReturnResult AS INTEGER    NO-UNDO.

ASSIGN
    cProgramName = "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
    cPageAddress    = "http://www.progress.com".
    cPageAddress    = "C:\tmp\SubtitleFiles\16Steps\01Introduction_en.srt".

RUN WinExec (INPUT cProgramName + CHR(32) + cPageAddress , INPUT 1, OUTPUT iReturnResult).

PROCEDURE WinExec EXTERNAL "KERNEL32.DLL":
    DEFINE INPUT  PARAMETER ProgramName AS CHARACTER.
    DEFINE INPUT  PARAMETER VisualStyle AS LONG.
    DEFINE RETURN PARAMETER StatusCode  AS LONG.
END PROCEDURE.
