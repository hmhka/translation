def var ptxt as char extent 500.
def var i as int.
FOR each lectures break by lectures.lectures-date-txt:
    IF first-of(lectures-date-txt) THEN do:
       assign i = 0.
    END.
    assign i = i + 1.
    assign lectures.sub-count = string(i,"9999").

END.
