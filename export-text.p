OUTPUT TO "c:\tmp\aaa.txt" CONVERT SOURCE "ISO8859-1" TARGET "UTF-8" .
    
FOR EACH HindiTest BREAK BY cons:
     
    EXPORT hinditest.cons
      HindiTest.HindiText FORMAT "x(20)"
        .
    /*
    IMPORT 
        HindiTest.HindiText NO-ERROR.
    ASSIGN HindiTest.cons = pcons.
    */

END.

