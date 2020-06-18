DEF SHARED VAR plectures-code as int.
DEF SHARED VAR plectures-filename like lectures.lectures-filename.

DEF SHARED VAR psrc-lang as char.
DEF SHARED VAR pdes-lang as char.

DEF SHARED VAR psrc-folder as char.
DEF SHARED VAR pdes-folder as char.

DEF SHARED VAR psrc-folder-temp as char.
DEF SHARED VAR pdes-folder-temp as char.


DEF SHARED VAR psrc-file as char.
DEF SHARED VAR pdes-file as char.

DEF SHARED VAR pspeech-ori-eng-file as char.
DEF SHARED VAR pspeech-ori-hin-file as char.
DEF SHARED VAR pspeech-ori-mar-file as char.

DEF SHARED VAR pprocess-type as int.

def shared var pcons-ini as int.
def shared var pcons-fin as int.


DEF VAR pcom as char.

/*
ASSIGN 
    psrc-lang = "Hi" 
    pdes-lang = "Gu" 
    .
assign
    psrc-file = psrc-folder-temp + "lecture_" + psrc-lang + ".txt"
    pdes-file = pdes-folder-temp + "lecture_" + pdes-lang + ".txt"
    .
  */
DEF VAR pt as int.
assign pt = 0.
OUTPUT TO VALUE(psrc-file).
FOR EACH speech_text where speech_text.lectures-code = plectures-code 
                       AND speech_text.ISTEXT = true
                       and speech_text.cons >= pcons-ini
                       and speech_text.cons <= pcons-fin
    BREAK BY speech_text.cons.
    IF psrc-lang = "en" THEN do:
         put unformatted 
             STRING(speech_text.cons,"99999")
             "  " 
             speech_text.speech-ori-eng skip. 

    END.
    IF psrc-lang = "hi" THEN do:
         put unformatted 
             STRING(speech_text.cons,"99999")
             "  " 
             speech_text.speech-corr-hin skip. 

    END.
    assign pt = pt + 1.
    /*IF pt = 20 THEN leave.*/
END.
output close.
OS-COMMAND NO-WAIT VALUE(psrc-file).

assign pcom = "python C:\pvr\translation\html\py-translate1.py" 
          +  " -input " + psrc-file
          +  " -output " + pdes-file  
          +  " -target_lang " +  pdes-lang  
          +  " -source_lang " + psrc-lang
    .

    

OS-COMMAND SILENT VALUE(pcom).


OS-COMMAND NO-WAIT VALUE(pdes-file).
  
  
def var pcons as int.
def var ptexto-ori as char format "x(1000)".
def var ptexto as char format "x(1000)".

def var ptexto-cons as int.
def var ptexto-cons-text as char.
def var ptexto-text as char format "x(1000)".
         
    assign pcons = 0.
    INPUT FROM VALUE(pdes-file).
    REPEAT:
        ASSIGN pcons = pcons + 1.
        import unformatted ptexto-ori.
        assign ptexto-cons-text = SUBSTRING(ptexto-ori,1,6) no-error.
        assign ptexto-cons-text = replace(ptexto-cons-text,".","").
        assign ptexto-cons-text = replace(ptexto-cons-text," ","").
        assign ptexto-cons = INT(ptexto-cons-text) no-error.
        
        assign ptexto-text = replace(ptexto-ori,SUBSTRING(ptexto-ori,1,6),"").
        assign ptexto-text = ptexto-text no-error.
        FIND speech_text where speech_text.lectures-code = plectures-code 
                           and speech_text.cons = ptexto-cons no-error.
        IF available speech_text THEN do:
           assign ptexto-text = replace(ptexto-text,"&quot;",'"').
           IF pdes-lang = "hi" THEN assign speech_text.speech-auto-hin = ptexto-text.
           IF pdes-lang = "gu" THEN assign speech_text.speech-auto-guj = ptexto-text.
           IF pdes-lang = "mr" THEN assign speech_text.speech-auto-mar = ptexto-text.
           IF pdes-lang = "es" THEN assign speech_text.speech-auto-spa = ptexto-text.
           IF pdes-lang = "tl" THEN assign speech_text.speech-auto-tag = ptexto-text.

           IF pdes-lang = "kn" THEN assign speech_text.speech-auto-kan = ptexto-text.
           IF pdes-lang = "ta" THEN assign speech_text.speech-auto-tam = ptexto-text.
           IF pdes-lang = "zh-CN" THEN assign speech_text.speech-auto-chi-cn = ptexto-text.
           IF pdes-lang = "fa" THEN assign speech_text.speech-auto-per = ptexto-text.
           
        END.
    END.
    INPUT CLOSE.
         




    /*
python py-translate1.py -input lecture_hi.txt -output lecture_gu1.txt -target_lang gu -source_lang hi    
    */
