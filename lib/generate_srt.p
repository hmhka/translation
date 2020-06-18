DEF SHARED VAR plectures-code as int.
DEF SHARED VAR plectures-filename like lectures.lectures-filename.

DEF SHARED VAR psrc-lang as char.
DEF SHARED VAR pdes-lang as char.

DEF SHARED VAR psrc-folder as char.
DEF SHARED VAR pdes-folder as char.

DEF SHARED VAR psrc-folder-temp as char.
DEF SHARED VAR pdes-folder-temp as char.

DEF SHARED VAR pdes-folder-srt as char.
DEF SHARED VAR pdes-file-srt as char.

DEF SHARED VAR psrc-file as char.
DEF SHARED VAR pdes-file as char.

DEF SHARED VAR pspeech-ori-eng-file as char.
DEF SHARED VAR pspeech-ori-hin-file as char.
DEF SHARED VAR pspeech-ori-mar-file as char.

DEF SHARED VAR pprocess-type as int.
def shared var psrt-type as int.


DEF VAR pcom as char.

OUTPUT TO VALUE(pdes-file-srt).
FOR EACH speech_text where speech_text.lectures-code = plectures-code 
    BREAK BY speech_text.cons.

    IF psrc-lang = "en" THEN put unformatted speech_text.speech-ori-eng skip.
    IF psrc-lang = "hi" THEN put unformatted speech_text.speech-ori-hin skip.
    IF psrc-lang = "mr" THEN put unformatted speech_text.speech-ori-mar skip.


    IF pdes-lang = "hi" THEN put unformatted speech_text.speech-ori-hin skip.

    IF psrc-lang = "en" THEN do:
      IF speech_text.speech-ori-eng = "" THEN do:
         put unformatted skip (1). 
      END.
    END.

    /*IF pdes-lang = "hi" and speech_text.istext    THEN put unformatted "[" speech_text.speech-corr-hin "]" skip.*/
    IF pdes-lang = "hi" and speech_text.istext    THEN put unformatted "[" speech_text.speech-auto-hin "]" skip.
    IF pdes-lang = "gu" and speech_text.istext    THEN put unformatted "[" speech_text.speech-auto-guj "]" skip.
    IF pdes-lang = "mr" and speech_text.istext    THEN put unformatted "[" speech_text.speech-auto-mar "]" skip.
    IF pdes-lang = "ta" and speech_text.istext    THEN put unformatted "[" speech_text.speech-auto-tam "]" skip.
    IF pdes-lang = "tl" and speech_text.istext    THEN put unformatted "[" speech_text.speech-auto-tag "]" skip.
    IF pdes-lang = "kn" and speech_text.istext    THEN put unformatted "[" speech_text.speech-auto-kan "]" skip.
    IF pdes-lang = "es" and speech_text.istext    THEN put unformatted "[" speech_text.speech-auto-spa "]" skip.
    IF pdes-lang = "zh-CN" and speech_text.istext THEN put unformatted "[" speech_text.speech-auto-chi-cn "]" skip.
    IF pdes-lang = "fa" and speech_text.istext    THEN put unformatted "[" speech_text.speech-auto-per "]" skip.

    /*IF pt = 20 THEN leave.*/
END.
output close.

os-command no-wait value(pdes-file-srt).


/*
    /*
    IF psrt-type = 2 THEN do:
      IF speech_text.istext THEN do:
         put unformatted "[" 
             speech_text.speech-corr-hin "]" skip (1). 
      END.
    END.
    IF psrt-type = 3 THEN do:
      IF speech_text.istext THEN do:
         put unformatted "["
             speech_text.speech-auto-guj "]" skip (1). 
      END.
    END.
    IF psrt-type = 4 THEN do:
      IF speech_text.istext THEN do:
         put unformatted "["
             speech_text.speech-auto-mar "]" skip (1). 
      END.
    END.
    IF psrt-type = 5 THEN do:
      IF speech_text.istext THEN do:
         put unformatted "["
             speech_text.speech-auto-tam "]" skip (1). 
      END.
    END.
    IF psrt-type = 6 THEN do:
      IF speech_text.istext THEN do:
         put unformatted "["
             speech_text.speech-auto-tag "]" skip (1). 
      END.
    END.
    IF psrt-type = 7 THEN do:
      IF speech_text.istext THEN do:
         put unformatted "["
             speech_text.speech-auto-kan "]" skip (1). 
      END.
    END.

    IF psrt-type = 8 THEN do:
      IF speech_text.istext THEN do:
         put unformatted "["
             speech_text.speech-auto-spa "]" skip (1). 
      END.
    END.
    IF psrt-type = 9 THEN do:
      IF speech_text.istext THEN do:
         put unformatted "["
             speech_text.speech-auto-chi-cn "]" skip (1). 
      END.
    END.
    IF psrt-type = 10 THEN do:
      IF speech_text.istext THEN do:
         put unformatted "["
             speech_text.speech-auto-per "]" skip (1). 
      END.
    END.
      */

*/
