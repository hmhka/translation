def shared var plectures-code like lectures.lectures-code.

def var psrt-num as int.
def var ptime-from as char.
def var ptime-to as char.
def var ptiming as char.
FOR EACH speech_text where speech_text.lectures-code = plectures-code 
    BREAK BY speech_text.cons:
    IF speech_text.IsTimerNum THEN do:
       assign psrt-num = INT(speech_text.speech-ori-eng).
    END.
    IF speech_text.ISTEXT THEN do:
        assign speech_text.srt-num = psrt-num.
    END.
    
    IF speech_text.ISTimer THEN do:
        assign ptiming = speech_text.speech-ori-eng.
    END.
    IF speech_text.ISTEXT THEN do:
        assign speech_text.srt-timing = ptiming.
        assign speech_text.time-from = substring(ptiming,1,12).
        assign speech_text.time-to = substring(ptiming,18,13).
    END.
    

END.
