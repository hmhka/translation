DEF VAR pfilename-output AS CHAR.
DEF VAR pfilename-bat AS CHAR.
DEF VAR pcons AS INT.

ASSIGN pfilename-output = "c:\tmp\aaa1.txt".
ASSIGN pfilename-bat    = "c:\pvr\translation\OpenFileInChrome.bat".

OUTPUT TO VALUE(pfilename-bat).
  PUT UNFORMATTED '"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" /new-window ' " " pfilename-output.
OUTPUT CLOSE.

OS-COMMAND SILENT VALUE(pfilename-bat).

/*
ON CHOOSE OF b1e IN FRAME f
DO:
    System.Windows.Forms.SendKeys:Send("e").
END.
 
ON CHOOSE OF b2 IN FRAME f
DO:
    System.Windows.Forms.SendKeys:Send("~{Home}").
END.
 
ON CHOOSE OF b3 IN FRAME f
DO:
    System.Windows.Forms.SendKeys:Send("~{LEFT}").
END.
 
ON CHOOSE OF b4 IN FRAME f
DO:
    System.Windows.Forms.SendKeys:Send("~{RIGHT}").
END.
*/
