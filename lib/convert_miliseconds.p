def INPUT PARAMETER ptime-ini as CHAR format "x(12)".
def OUTPUT PARAMETER ptot-msec as int.
/*
def var ptime-ini as CHAR format "x(12)".
def var ptot-msec as int.
  */

def var pmilisec as int.
def var phour as int.
def var phour-msec as int.
def var pmin as int.
def var pmin-msec as int.
def var psec as int.
def var psec-msec as int.
def var pmsec as int.
def var ptime as char.

/*
assign ptime-ini = "00:01:14,122".
  */

    assign phour = INT(SUBSTRING(ptime-ini,1,2)).


    assign pmin  = INT(SUBSTRING(ptime-ini,4,2)).
    assign psec  = INT(SUBSTRING(ptime-ini,7,2)).
    assign pmsec = INT(SUBSTRING(ptime-ini,10,3)).

    IF phour > 0 THEN phour-msec = phour * 1000 * 60 * 60.
    IF pmin  > 0 THEN pmin-msec  = pmin * 1000 * 60.
    IF psec  > 0 THEN psec-msec  = psec * 1000.
    ASSIGN ptot-msec = phour-msec + pmin-msec + psec-msec + pmsec.






