DEF SHARED VAR plectures-code as int.
DEF SHARED VAR plectures-filename like lectures.lectures-filename.

DEF SHARED VAR psrc-lang as char.
DEF SHARED VAR pdes-lang as char.

DEF SHARED VAR psrc-folder as char.
DEF SHARED VAR pdes-folder as char.

DEF SHARED VAR psrc-file as char.
DEF SHARED VAR pdes-file as char.

DEF SHARED VAR pspeech-ori-eng-file as char.
DEF SHARED VAR pspeech-ori-hin-file as char.
DEF SHARED VAR pspeech-ori-mar-file as char.

DEF SHARED VAR pprocess-type as int.
def shared var pori-corr as char.

def var pcons as int.
def buffer b_speech_text for speech_text.

def var ptot-lines as int.
assign ptot-lines = 0.
FOR EACH speech_text where speech_text.lectures-code = plectures-code NO-LOCK:
    assign ptot-lines = ptot-lines + 1.

END.


IF pprocess-type = 1 THEN DO:  
    IF psrc-lang = "en" and SEARCH(pspeech-ori-eng-file) = ? THEN DO:
        MESSAGE pspeech-ori-eng-file " does not exist"
            VIEW-AS ALERT-BOX INFO BUTTONS OK.
        return no-apply.
    END.
    IF psrc-lang = "hi" and SEARCH(pspeech-ori-hin-file) = ? THEN DO:
        MESSAGE pspeech-ori-hin-file " does not exist"
            VIEW-AS ALERT-BOX INFO BUTTONS OK.
        return no-apply.
    END.
    IF psrc-lang = "mr" and SEARCH(pspeech-ori-mar-file) = ? THEN DO:
        MESSAGE pspeech-ori-mar-file " does not exist"
            VIEW-AS ALERT-BOX INFO BUTTONS OK.
        return no-apply.
    END.


    FOR EACH speech_text: 
        DELETE speech_text.
    END.
    
    IF psrc-lang = "en" THEN INPUT FROM VALUE(pspeech-ori-eng-file).
    IF psrc-lang = "hi" THEN INPUT FROM VALUE(pspeech-ori-hin-file).
    IF psrc-lang = "mr" THEN INPUT FROM VALUE(pspeech-ori-mar-file).
    
    REPEAT:
        ASSIGN pcons = pcons + 1.
        CREATE speech_text.


        IF psrc-lang = "en" THEN  IMPORT UNFORMATTED speech_text.speech-ori-eng.
        IF psrc-lang = "hi" THEN  IMPORT UNFORMATTED speech_text.speech-ori-hin.
        IF psrc-lang = "mr" THEN  IMPORT UNFORMATTED speech_text.speech-ori-mar.

        ASSIGN speech_text.cons = pcons
               speech_text.lectures-code = plectures-code.

        IF (psrc-lang = "en" AND speech_text.speech-ori-eng = "") OR
           (psrc-lang = "hi" AND speech_text.speech-ori-hin = "") OR
           (psrc-lang = "mr" AND speech_text.speech-ori-mar = "") then do:
           ASSIGN speech_text.isempty = TRUE. 
        END.
            
        IF speech_text.speech-ori-eng MATCHES "*:*:*,*-->*" or 
           speech_text.speech-ori-hin MATCHES "*:*:*,*-->*" or
           speech_text.speech-ori-mar MATCHES "*:*:*,*-->*" THEN DO:
            ASSIGN speech_text.istimer = TRUE.
            FIND b_speech_text WHERE b_speech_text.cons = speech_text.cons - 1 NO-ERROR.
            IF AVAILABLE b_speech_text THEN DO:
                ASSIGN b_speech_text.IsTimerNum = TRUE. 
            END.
        END.
       /* MESSAGE speech_text.hindi-text.*/
    END.
    INPUT CLOSE.
    FOR EACH  speech_text where  speech_text.lectures-code = plectures-code:
        IF speech_text.isempty = false and speech_text.istimer = false and speech_text.IsTimerNum = false THEN do:
           assign speech_text.istext = true.
        END.
    END.

END.  /* IF pprocess-type = 1 */

IF pprocess-type = 2 THEN DO:  
    IF psrc-lang = "en" AND SEARCH(pspeech-ori-eng-file) = ? THEN DO:
        MESSAGE pspeech-ori-eng-file " does not exist"
            VIEW-AS ALERT-BOX INFO BUTTONS OK.
        return no-apply.
    END.
    IF psrc-lang = "hi" AND SEARCH(pspeech-ori-hin-file) = ? THEN DO:
        MESSAGE pspeech-ori-hin-file " does not exist"
            VIEW-AS ALERT-BOX INFO BUTTONS OK.
        return no-apply.
    END.
    IF psrc-lang = "mr" AND SEARCH(pspeech-ori-mar-file) = ? THEN DO:
        MESSAGE pspeech-ori-mar-file " does not exist"
            VIEW-AS ALERT-BOX INFO BUTTONS OK.
        return no-apply.
    END.

    assign pcons = 0.

    IF psrc-lang = "en" THEN INPUT FROM VALUE(pspeech-ori-eng-file).
    IF psrc-lang = "hi" THEN INPUT FROM VALUE(pspeech-ori-hin-file).
    IF psrc-lang = "mr" THEN INPUT FROM VALUE(pspeech-ori-mar-file).
    REPEAT:
        ASSIGN pcons = pcons + 1.
        FIND speech_text where speech_text.cons = pcons
                           and speech_text.lectures-code = plectures-code no-error.
        IF available speech_text THEN do:
           IF psrc-lang = "en" THEN IMPORT UNFORMATTED speech_text.speech-corr-eng.
           IF psrc-lang = "hi" THEN IMPORT UNFORMATTED speech_text.speech-corr-hin.
           IF psrc-lang = "mr" THEN IMPORT UNFORMATTED speech_text.speech-corr-mar.
           message pcons speech_text.speech-corr-hin. pause 0.
        END.
        release speech_text.
        IF pcons = ptot-lines THEN leave.
    END.
    INPUT CLOSE.
END.





/*
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
ASSIGN plecture-name = "1980-0517_What_Is_A_Sahaja_Yogi_Winchester_Version_2".
ASSIGN pfile = plecture-name + "_" + pori-lang + psubtitle-type.

DEF VAR pfilename AS CHAR.
DEF BUFFER b_speech_text FOR speech_text.
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

FOR EACH speech_text: 
    DELETE speech_text.
END.

INPUT FROM VALUE(pfilename).
REPEAT:
    ASSIGN pcons = pcons + 1.
    CREATE speech_text.
    IMPORT UNFORMATTED speech_text.speech-ori-eng.
    ASSIGN speech_text.cons = pcons.
    IF speech_text.speech-ori-eng = "" THEN DO:
        ASSIGN speech_text.isempty = TRUE.
    END.

    
    IF speech_text.speech-ori-eng MATCHES "*:*:*,*-->*" THEN DO:
        ASSIGN speech_text.istimer = TRUE.
        FIND b_speech_text WHERE b_speech_text.cons = speech_text.cons - 1 NO-ERROR.
        IF AVAILABLE b_speech_text THEN DO:
            ASSIGN b_speech_text.IsTimerNum = TRUE. 
        END.

    END.
    

   /* MESSAGE speech_text.hindi-text.*/

END.
INPUT CLOSE.

FOR EACH speech_text BREAK BY cons:
    IF speech_text.istimer = TRUE OR speech_text.IsTimerNum = TRUE THEN DO:
    END.
    ELSE DO:
    END.
END.

OUTPUT TO "c:\tmp\aaa.txt" /*CONVERT SOURCE "ISO8859-1" TARGET "UTF-8" */.
FOR EACH speech_text BREAK BY cons:
    IF speech_text.isempty = FALSE THEN DO:
        PUT UNFORMATTED
          speech_text.speech-ori-eng SKIP
            .
    END.
    ELSE DO:
        PUT UNFORMATTED "" SKIP(1).
    END.
END.

RUN C:\pvr\translation\import_other_language.p.

/**
/*
FOR EACH speech_text BREAK BY cons:
     
    IF speech_text.isempty = FALSE THEN
    EXPORT DELIMITER "^" speech_text.cons " "
      speech_text.hindi-text /*FORMAT "x(20)"*/
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

  */
