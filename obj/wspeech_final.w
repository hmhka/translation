&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI ADM2
&ANALYZE-RESUME
/* Connected Databases 
          smndsy           PROGRESS
*/
&Scoped-define WINDOW-NAME wWin
{adecomm/appserv.i}
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS wWin 
/*------------------------------------------------------------------------

  File: 

  Description: from cntnrwin.w - ADM SmartWindow Template

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  History: New V9 Version - January 15, 1998
          
------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AB.              */
/*----------------------------------------------------------------------*/

/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */

CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

{src/adm2/widgetprto.i}

    /*
def var ptick as int.

def var pdur-ctrl as log.
def var pduration as int.
assign ptick = 0.
      */
DEF NEW SHARED VAR plectures-code as int.
DEF NEW SHARED VAR plectures-filename like lectures.lectures-filename.

DEF NEW SHARED VAR psrc-lang as char.
DEF NEW SHARED VAR pdes-lang as char.

DEF NEW SHARED VAR psrc-folder as char.
DEF NEW SHARED VAR pdes-folder as char.

DEF NEW SHARED VAR psrc-folder-temp as char.
DEF NEW SHARED VAR pdes-folder-temp as char.

DEF NEW SHARED VAR pdes-folder-srt as char.
DEF NEW shared var pdes-file-srt as char.

DEF NEW SHARED VAR psrc-file as char.
DEF NEW SHARED VAR pdes-file as char.

DEF NEW SHARED VAR pspeech-ori-eng-file as char.
DEF NEW SHARED VAR pspeech-ori-hin-file as char.
DEF NEW SHARED VAR pspeech-ori-mar-file as char.

DEF NEW SHARED VAR pprocess-type as int.

def var ptime-from like speech_text.time-from.
def var ptime-to like speech_text.time-to.


def new shared var psrt-type as int.

def new shared var pcons-ini as int.
def new shared var pcons-fin as int.

def var ptranslate-one-line as logical.

def var ptick as int.

def var pdur-ctrl as log.
def var pduration as int.
assign ptick = 0.

    DEF VAR pcur-pos-ini as int.
    def var pcur-ini as char.

    DEF VAR pcur-pos-fin as int.
    def var pcur-fin as char.
    def var pdur as int.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartWindow
&Scoped-define DB-AWARE no

&Scoped-define ADM-CONTAINER WINDOW

&Scoped-define ADM-SUPPORTED-LINKS Data-Target,Data-Source,Page-Target,Update-Source,Update-Target,Filter-target,Filter-Source

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fMain
&Scoped-define BROWSE-NAME BROWSE-1

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES speech_text

/* Definitions for BROWSE BROWSE-1                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-1 speech_text.cons ~
speech_text.srt-num speech_text.speech-ori-eng speech_text.speech-corr-hin ~
speech_text.speech-auto-guj speech_text.speech-auto-mar ~
speech_text.speech-auto-spa speech_text.speech-auto-tag ~
speech_text.speech-auto-tam speech_text.speech-auto-kan ~
speech_text.speech-auto-chi-cn speech_text.speech-auto-per ~
speech_text.IsEmpty speech_text.IsTimer speech_text.IsTimerNum ~
speech_text.time-from speech_text.time-to speech_text.srt-timing ~
speech_text.lectures-code speech_text.IsText 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-1 speech_text.speech-ori-eng ~
speech_text.speech-corr-hin speech_text.speech-auto-guj ~
speech_text.speech-auto-mar speech_text.speech-auto-spa ~
speech_text.speech-auto-tag speech_text.speech-auto-tam ~
speech_text.speech-auto-kan speech_text.speech-auto-chi-cn ~
speech_text.speech-auto-per 
&Scoped-define ENABLED-TABLES-IN-QUERY-BROWSE-1 speech_text
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-BROWSE-1 speech_text
&Scoped-define QUERY-STRING-BROWSE-1 FOR EACH speech_text ~
      WHERE (STRING(speech_text.lectures-code) matches wsearch OR ~
speech_text.speech-ori-eng matches wsearch) ~
 AND speech_text.IsText NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-1 OPEN QUERY BROWSE-1 FOR EACH speech_text ~
      WHERE (STRING(speech_text.lectures-code) matches wsearch OR ~
speech_text.speech-ori-eng matches wsearch) ~
 AND speech_text.IsText NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-1 speech_text
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-1 speech_text


/* Definitions for FRAME fMain                                          */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-1 RECT-2 RECT-3 RECT-4 wsearch ~
BtnSearch wdes-lang wsrc-lang BROWSE-1 BtnPlay btnStop BtnPause ~
BtnAssignPosition wenglish whindi wother-lang BtnGenerateSrtFile ~
BtnTranslate 
&Scoped-Define DISPLAYED-OBJECTS wsearch wdes-lang wsrc-lang wenglish ~
whindi wother-lang wstart-time wend-time 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wWin AS WIDGET-HANDLE NO-UNDO.

/* Definitions of handles for OCX Containers                            */
DEFINE VARIABLE CtrlFrame AS WIDGET-HANDLE NO-UNDO.
DEFINE VARIABLE chCtrlFrame AS COMPONENT-HANDLE NO-UNDO.
DEFINE VARIABLE CtrlFrame-4 AS WIDGET-HANDLE NO-UNDO.
DEFINE VARIABLE chCtrlFrame-4 AS COMPONENT-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON BtnAssignPosition 
     LABEL "Assign Position" 
     SIZE 20.33 BY .81.

DEFINE BUTTON BtnGenerateSrtFile  NO-FOCUS FLAT-BUTTON
     LABEL "SRT Files" 
     SIZE 14.33 BY .81.

DEFINE BUTTON BtnPause 
     LABEL "Pause" 
     SIZE 10 BY .81.

DEFINE BUTTON BtnPlay 
     LABEL "Play" 
     SIZE 10 BY .81.

DEFINE BUTTON BtnSearch 
     LABEL "<?>" 
     SIZE 4.5 BY .81.

DEFINE BUTTON btnStop 
     LABEL "Stop" 
     SIZE 10 BY .81.

DEFINE BUTTON BtnTranslate  NO-FOCUS FLAT-BUTTON
     LABEL "Translate" 
     SIZE 14.33 BY .81.

DEFINE VARIABLE wdes-lang AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 10
     LIST-ITEM-PAIRS "","",
                     "English","en",
                     "Hindi","hi",
                     "Marathi","mr",
                     "Gujrati","gu",
                     "Tamil","ta",
                     "Tagalog","tl",
                     "Kannada","kn",
                     "Spanish","es",
                     "Persian","fa",
                     "Chinese","zh-CN"
     DROP-DOWN-LIST
     SIZE 16 BY 1
     FONT 4 NO-UNDO.

DEFINE VARIABLE wend-time AS CHARACTER FORMAT "X(256)":U 
     LABEL "End" 
     VIEW-AS FILL-IN 
     SIZE 10.33 BY .81 NO-UNDO.

DEFINE VARIABLE wenglish AS CHARACTER FORMAT "X(256)":U 
     LABEL "English" 
     VIEW-AS FILL-IN 
     SIZE 167.83 BY 1
     BGCOLOR 22 FONT 9 NO-UNDO.

DEFINE VARIABLE whindi AS CHARACTER FORMAT "X(256)":U 
     LABEL "Hindi" 
     VIEW-AS FILL-IN 
     SIZE 167.83 BY 1
     BGCOLOR 19 FONT 9 NO-UNDO.

DEFINE VARIABLE wother-lang AS CHARACTER FORMAT "X(256)":U 
     LABEL "Marathi" 
     VIEW-AS FILL-IN 
     SIZE 167.83 BY 1
     BGCOLOR 21 FONT 9 NO-UNDO.

DEFINE VARIABLE wsearch AS CHARACTER FORMAT "X(256)":U 
     LABEL "Search" 
     VIEW-AS FILL-IN 
     SIZE 20.5 BY .81 NO-UNDO.

DEFINE VARIABLE wstart-time AS CHARACTER FORMAT "X(256)":U 
     LABEL "Start" 
     VIEW-AS FILL-IN 
     SIZE 11.33 BY .81 NO-UNDO.

DEFINE VARIABLE wsrc-lang AS CHARACTER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "", "",
"English", "en",
"Hindi", "hi",
"Marathi", "ma"
     SIZE 28.67 BY .73 TOOLTIP "Source Language"
     FONT 4 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 30.83 BY 1.31.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 19 BY 1.31.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 16 BY 1.31.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 16 BY 1.31.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-1 FOR 
      speech_text SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-1 wWin _STRUCTURED
  QUERY BROWSE-1 NO-LOCK DISPLAY
      speech_text.cons FORMAT "->>>>>>9":U WIDTH 6.67 COLUMN-FONT 4
      speech_text.srt-num FORMAT "->,>>>,>>9":U WIDTH 7.67 COLUMN-FONT 4
      speech_text.speech-ori-eng FORMAT "x(100)":U WIDTH 48
      speech_text.speech-corr-hin FORMAT "x(1000)":U WIDTH 46.5
            COLUMN-FGCOLOR 9
      speech_text.speech-auto-guj FORMAT "x(1000)":U WIDTH 48.33
            COLUMN-FGCOLOR 3
      speech_text.speech-auto-mar COLUMN-LABEL "Auto Marathi" FORMAT "x(1000)":U
            WIDTH 48.33
      speech_text.speech-auto-spa FORMAT "x(1000)":U WIDTH 48.33
      speech_text.speech-auto-tag COLUMN-LABEL "Auto Tagalog" FORMAT "x(1000)":U
            WIDTH 48.33
      speech_text.speech-auto-tam FORMAT "x(1000)":U WIDTH 48
      speech_text.speech-auto-kan FORMAT "x(1000)":U WIDTH 48
      speech_text.speech-auto-chi-cn FORMAT "x(1000)":U WIDTH 40
      speech_text.speech-auto-per FORMAT "x(1000)":U WIDTH 40
      speech_text.IsEmpty FORMAT "yes/no":U
      speech_text.IsTimer FORMAT "yes/no":U
      speech_text.IsTimerNum FORMAT "yes/no":U
      speech_text.time-from FORMAT "x(15)":U
      speech_text.time-to FORMAT "x(15)":U
      speech_text.srt-timing FORMAT "x(30)":U
      speech_text.lectures-code FORMAT "->,>>>,>>9":U WIDTH 6.67
      speech_text.IsText FORMAT "yes/no":U
  ENABLE
      speech_text.speech-ori-eng
      speech_text.speech-corr-hin
      speech_text.speech-auto-guj
      speech_text.speech-auto-mar
      speech_text.speech-auto-spa
      speech_text.speech-auto-tag
      speech_text.speech-auto-tam
      speech_text.speech-auto-kan
      speech_text.speech-auto-chi-cn
      speech_text.speech-auto-per
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 113.83 BY 9.96
         FONT 5
         TITLE "Speech" FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fMain
     wsearch AT ROW 1.5 COL 9.5 COLON-ALIGNED WIDGET-ID 12
     BtnSearch AT ROW 1.5 COL 32.5 WIDGET-ID 10
     wdes-lang AT ROW 1.58 COL 69 COLON-ALIGNED NO-LABEL WIDGET-ID 40
     wsrc-lang AT ROW 1.62 COL 40.5 NO-LABEL WIDGET-ID 34
     BROWSE-1 AT ROW 2.88 COL 56.67 WIDGET-ID 200
     BtnPlay AT ROW 12.08 COL 2.33 WIDGET-ID 98
     btnStop AT ROW 12.08 COL 12.17 WIDGET-ID 100
     BtnPause AT ROW 12.08 COL 22.17 WIDGET-ID 96
     BtnAssignPosition AT ROW 12.08 COL 32.33 WIDGET-ID 94
     wenglish AT ROW 13.42 COL 1.67 WIDGET-ID 60
     whindi AT ROW 14.85 COL 9 COLON-ALIGNED WIDGET-ID 56
     wother-lang AT ROW 16.38 COL 2 WIDGET-ID 58
     wstart-time AT ROW 18.12 COL 11.17 COLON-ALIGNED WIDGET-ID 84
     wend-time AT ROW 18.12 COL 29.33 COLON-ALIGNED WIDGET-ID 24
     BtnGenerateSrtFile AT ROW 1.5 COL 105 WIDGET-ID 80
     BtnTranslate AT ROW 1.5 COL 89.17 WIDGET-ID 18
     RECT-1 AT ROW 1.27 COL 39.33 WIDGET-ID 66
     RECT-2 AT ROW 1.27 COL 69.67 WIDGET-ID 68
     RECT-3 AT ROW 1.27 COL 88.33 WIDGET-ID 70
     RECT-4 AT ROW 1.27 COL 104 WIDGET-ID 82
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 179 BY 18.5 WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartWindow
   Allow: Basic,Browse,DB-Fields,Query,Smart,Window
   Container Links: Data-Target,Data-Source,Page-Target,Update-Source,Update-Target,Filter-target,Filter-Source
   Other Settings: APPSERVER
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW wWin ASSIGN
         HIDDEN             = YES
         TITLE              = "<insert SmartWindow title>"
         HEIGHT             = 18.5
         WIDTH              = 179
         MAX-HEIGHT         = 28.81
         MAX-WIDTH          = 186.67
         VIRTUAL-HEIGHT     = 28.81
         VIRTUAL-WIDTH      = 186.67
         RESIZE             = no
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = ?
         FGCOLOR            = ?
         THREE-D            = yes
         MESSAGE-AREA       = yes
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB wWin 
/* ************************* Included-Libraries *********************** */

{src/adm2/containr.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW wWin
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fMain
   FRAME-NAME                                                           */
/* BROWSE-TAB BROWSE-1 wsrc-lang fMain */
ASSIGN 
       BROWSE-1:COLUMN-RESIZABLE IN FRAME fMain       = TRUE
       BROWSE-1:COLUMN-MOVABLE IN FRAME fMain         = TRUE.

ASSIGN 
       speech_text.speech-auto-guj:COLUMN-READ-ONLY IN BROWSE BROWSE-1 = TRUE
       speech_text.speech-auto-mar:COLUMN-READ-ONLY IN BROWSE BROWSE-1 = TRUE
       speech_text.speech-auto-spa:COLUMN-READ-ONLY IN BROWSE BROWSE-1 = TRUE
       speech_text.speech-auto-tag:COLUMN-READ-ONLY IN BROWSE BROWSE-1 = TRUE.

/* SETTINGS FOR FILL-IN wend-time IN FRAME fMain
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN wenglish IN FRAME fMain
   ALIGN-L                                                              */
ASSIGN 
       wenglish:READ-ONLY IN FRAME fMain        = TRUE.

ASSIGN 
       whindi:READ-ONLY IN FRAME fMain        = TRUE.

/* SETTINGS FOR FILL-IN wother-lang IN FRAME fMain
   ALIGN-L                                                              */
ASSIGN 
       wother-lang:READ-ONLY IN FRAME fMain        = TRUE.

/* SETTINGS FOR FILL-IN wstart-time IN FRAME fMain
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wWin)
THEN wWin:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-1
/* Query rebuild information for BROWSE BROWSE-1
     _TblList          = "smndsy.speech_text"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "(STRING(speech_text.lectures-code) matches wsearch OR
speech_text.speech-ori-eng matches wsearch)
 AND speech_text.IsText"
     _FldNameList[1]   > smndsy.speech_text.cons
"speech_text.cons" ? "->>>>>>9" "integer" ? ? 4 ? ? ? no ? no no "6.67" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > smndsy.speech_text.srt-num
"speech_text.srt-num" ? ? "integer" ? ? 4 ? ? ? no ? no no "7.67" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > smndsy.speech_text.speech-ori-eng
"speech_text.speech-ori-eng" ? ? "character" ? ? ? ? ? ? yes ? no no "48" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > smndsy.speech_text.speech-corr-hin
"speech_text.speech-corr-hin" ? ? "character" ? 9 ? ? ? ? yes ? no no "46.5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > smndsy.speech_text.speech-auto-guj
"speech_text.speech-auto-guj" ? ? "character" ? 3 ? ? ? ? yes ? no no "48.33" yes no yes "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > smndsy.speech_text.speech-auto-mar
"speech_text.speech-auto-mar" "Auto Marathi" ? "character" ? ? ? ? ? ? yes ? no no "48.33" yes no yes "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > smndsy.speech_text.speech-auto-spa
"speech_text.speech-auto-spa" ? ? "character" ? ? ? ? ? ? yes ? no no "48.33" yes no yes "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > smndsy.speech_text.speech-auto-tag
"speech_text.speech-auto-tag" "Auto Tagalog" ? "character" ? ? ? ? ? ? yes ? no no "48.33" yes no yes "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > smndsy.speech_text.speech-auto-tam
"speech_text.speech-auto-tam" ? ? "character" ? ? ? ? ? ? yes ? no no "48" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > smndsy.speech_text.speech-auto-kan
"speech_text.speech-auto-kan" ? ? "character" ? ? ? ? ? ? yes ? no no "48" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > smndsy.speech_text.speech-auto-chi-cn
"speech_text.speech-auto-chi-cn" ? ? "character" ? ? ? ? ? ? yes ? no no "40" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   > smndsy.speech_text.speech-auto-per
"speech_text.speech-auto-per" ? ? "character" ? ? ? ? ? ? yes ? no no "40" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[13]   = smndsy.speech_text.IsEmpty
     _FldNameList[14]   = smndsy.speech_text.IsTimer
     _FldNameList[15]   = smndsy.speech_text.IsTimerNum
     _FldNameList[16]   = smndsy.speech_text.time-from
     _FldNameList[17]   = smndsy.speech_text.time-to
     _FldNameList[18]   = smndsy.speech_text.srt-timing
     _FldNameList[19]   > smndsy.speech_text.lectures-code
"speech_text.lectures-code" ? ? "integer" ? ? ? ? ? ? no ? no no "6.67" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[20]   = smndsy.speech_text.IsText
     _Query            is NOT OPENED
*/  /* BROWSE BROWSE-1 */
&ANALYZE-RESUME

 


/* **********************  Create OCX Containers  ********************** */

&ANALYZE-SUSPEND _CREATE-DYNAMIC

&IF "{&OPSYS}" = "WIN32":U AND "{&WINDOW-SYSTEM}" NE "TTY":U &THEN

CREATE CONTROL-FRAME CtrlFrame ASSIGN
       FRAME           = FRAME fMain:HANDLE
       ROW             = 2.96
       COLUMN          = 2.33
       HEIGHT          = 8.96
       WIDTH           = 52.5
       WIDGET-ID       = 2
       HIDDEN          = no
       SENSITIVE       = yes.

CREATE CONTROL-FRAME CtrlFrame-4 ASSIGN
       FRAME           = FRAME fMain:HANDLE
       ROW             = 17.31
       COLUMN          = 4.67
       HEIGHT          = .85
       WIDTH           = 4.83
       WIDGET-ID       = 28
       HIDDEN          = yes
       SENSITIVE       = yes.

PROCEDURE adm-create-controls:
      CtrlFrame:NAME = "CtrlFrame":U .
/* CtrlFrame OCXINFO:CREATE-CONTROL from: {6BF52A52-394A-11d3-B153-00C04F79FAA6} type: WMP */
      CtrlFrame-4:NAME = "CtrlFrame-4":U .
/* CtrlFrame-4 OCXINFO:CREATE-CONTROL from: {F0B88A90-F5DA-11CF-B545-0020AF6ED35A} type: PSTimer */
      CtrlFrame:MOVE-AFTER(BROWSE-1:HANDLE IN FRAME fMain).
      CtrlFrame-4:MOVE-AFTER(wother-lang:HANDLE IN FRAME fMain).

END PROCEDURE.

&ENDIF

&ANALYZE-RESUME /* End of _CREATE-DYNAMIC */


/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wWin
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON END-ERROR OF wWin /* <insert SmartWindow title> */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON WINDOW-CLOSE OF wWin /* <insert SmartWindow title> */
DO:
  /* This ADM code must be left here in order for the SmartWindow
     and its descendents to terminate properly on exit. */

  chCtrlFrame:WMP:controls:stop().

  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-1
&Scoped-define SELF-NAME BROWSE-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-1 wWin
ON MOUSE-SELECT-DBLCLICK OF BROWSE-1 IN FRAME fMain /* Speech */
DO:
  IF available speech_text THEN DO:
      assign ptranslate-one-line = true.
      assign pcons-ini = speech_text.cons
             pcons-fin = speech_text.cons.
      apply "Choose" to BtnTranslate.
      assign ptranslate-one-line = false.
      apply "Value-Changed" to self.


  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-1 wWin
ON VALUE-CHANGED OF BROWSE-1 IN FRAME fMain /* Speech */
DO:
  IF available speech_text THEN do:
     assign wenglish:screen-value = speech_text.speech-ori-eng.
     assign whindi:screen-value = speech_text.speech-corr-hin.

    ASSIGN 
        psrc-lang = wsrc-lang:screen-value
        pdes-lang = wdes-lang:screen-value
        .

    assign ptime-from = speech_text.time-from.
    assign ptime-to   = speech_text.time-to.


    assign wother-lang:label = pdes-lang.

    IF pdes-lang = "hi"    THEN wother-lang:screen-value = speech_text.speech-corr-hin .
    IF pdes-lang = "gu"    THEN wother-lang:screen-value = speech_text.speech-auto-guj .
    IF pdes-lang = "mr"    THEN wother-lang:screen-value = speech_text.speech-auto-mar .
    IF pdes-lang = "ta"    THEN wother-lang:screen-value = speech_text.speech-auto-tam .

    IF pdes-lang = "tl"    THEN wother-lang:screen-value = speech_text.speech-auto-tag .
    IF pdes-lang = "kn"    THEN wother-lang:screen-value = speech_text.speech-auto-kan .
    IF pdes-lang = "es"    THEN wother-lang:screen-value = speech_text.speech-auto-spa .
    IF pdes-lang = "zh-Cn" THEN wother-lang:screen-value = speech_text.speech-auto-chi-cn .
    IF pdes-lang = "fa"    THEN wother-lang:screen-value = speech_text.speech-auto-per .




  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BtnAssignPosition
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnAssignPosition wWin
ON CHOOSE OF BtnAssignPosition IN FRAME fMain /* Assign Position */
DO:
    
    DEF VAR pcur-pos-ini as int.
    def var pcur-ini as char.

    DEF VAR pcur-pos-fin as int.
    def var pcur-fin as char.
    def var pdur as int.

    run c:\pvr\translation\lib\convert_miliseconds.p(INPUT "00:01:00,000", output pcur-pos-ini).
    assign pcur-ini = string(pcur-pos-ini / 1000).

    run c:\pvr\translation\lib\convert_miliseconds.p(INPUT "00:01:03,000", output pcur-pos-fin).
    assign pcur-fin = string(pcur-pos-fin / 1000).

    assign pdur = INT(pcur-fin) - INT(pcur-ini).

    chCtrlFrame:WMP:controls:currenTPOSITION = pcur-ini.

    apply "Choose" to BtnPlay.  
    
    assign pduration = 300.
    assign pduration = pdur + 3.
    assign ptick = 0.
    assign pdur-ctrl = true.
    /*
    chCtrlFrame:WMP:controls:currenTPOSITION = "100".
      */
    

    /*
    run c:\pvr\translation\lib\convert_miliseconds.p(INPUT ptime-from, output pcur-pos-ini).
    assign pcur-ini = string(pcur-pos-ini / 1000) no-error.
      
    run c:\pvr\translation\lib\convert_miliseconds.p(INPUT ptime-to, output pcur-pos-fin) no-error.


    assign pcur-fin = string(pcur-pos-fin / 1000) no-error.
      
     
    assign pdur = INT(pcur-fin) - INT(pcur-ini).

    chCtrlFrame:WMP:controls:currenTPOSITION = pcur-ini.

    
    /*
    assign pduration = 300.
    */
    assign pduration = pdur + 3.
    assign ptick = 0.
    assign pdur-ctrl = true.
    /*
    chCtrlFrame:WMP:controls:currenTPOSITION = "100".
      */
      
    apply "Choose" to BtnPlay.  
      */

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BtnGenerateSrtFile
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnGenerateSrtFile wWin
ON CHOOSE OF BtnGenerateSrtFile IN FRAME fMain /* SRT Files */
DO:
    IF wsrc-lang:screen-value = "" THEN do:
       MESSAGE "Please select source language "
           VIEW-AS ALERT-BOX INFO BUTTONS OK.
       return no-apply.
    END.
    IF wdes-lang:screen-value = "" THEN do:
       MESSAGE "Please select target language "
           VIEW-AS ALERT-BOX INFO BUTTONS OK.
       return no-apply.
    END.

    FIND lectures_default where lectures_default.cons = 1 no-lock no-error.
    IF not available lectures_default THEN do:
       MESSAGE "lectures_default table not available" 
           VIEW-AS ALERT-BOX INFO BUTTONS OK.
    END.

    ASSIGN 
        psrc-lang = "en" 
        pdes-lang = "hi" 
        .

    ASSIGN 
        psrc-lang = wsrc-lang:screen-value
        pdes-lang = wdes-lang:screen-value
        .

    assign pdes-folder-srt = lectures_default.des-folder-srt.
    assign pdes-file-srt = pdes-folder-srt + plectures-filename + "_" + psrc-lang + pdes-lang + ".srt".
    run c:\pvr\translation\lib\generate_srt.p.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BtnPause
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnPause wWin
ON CHOOSE OF BtnPause IN FRAME fMain /* Pause */
DO:
    /*
    assign pdur-ctrl = false.
    assign ptick = 0.
    */
  chCtrlFrame:WMP:controls:pause().

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BtnPlay
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnPlay wWin
ON CHOOSE OF BtnPlay IN FRAME fMain /* Play */
DO:
    /*
  chCtrlFrame:WMP:URL = "c:\temp\candling.mp4".
      */
  chCtrlFrame:WMP:URL = "C:\pvr\translation\video\0942-1984-09-16.mp4".
  chCtrlFrame:WMP:controls:play().
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BtnSearch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnSearch wWin
ON CHOOSE OF BtnSearch IN FRAME fMain /* <?> */
DO:
  assign wsearch = "*" + wsearch:screen-value + "*".

  /*
  chCtrlFrame:WMP:URL = "c:\temp\candling.mp4".
    */
  
  /*
  chCtrlFrame:WMP:URL = "C:\pvr\translation\video\plectures-filename" + ".mp4".
    */
  /*
  chCtrlFrame:WMP:controls:stop().
    */
  {&OPEN-QUERY-BROWSE-1}
  APPLY "value-changed" TO browse-1.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnStop
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnStop wWin
ON CHOOSE OF btnStop IN FRAME fMain /* Stop */
DO:
  chCtrlFrame:WMP:controls:stop().
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BtnTranslate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnTranslate wWin
ON CHOOSE OF BtnTranslate IN FRAME fMain /* Translate */
DO:
    IF wsrc-lang:screen-value = "" THEN do:
       MESSAGE "Please select source language "
           VIEW-AS ALERT-BOX INFO BUTTONS OK.
       return no-apply.
    END.

    IF wdes-lang:screen-value = "" THEN do:
       MESSAGE "Please select target language "
           VIEW-AS ALERT-BOX INFO BUTTONS OK.
       return no-apply.
    END.

    FIND lectures_default where lectures_default.cons = 1 no-lock no-error.
    IF not available lectures_default THEN do:
       MESSAGE "lectures_default table not available" 
           VIEW-AS ALERT-BOX INFO BUTTONS OK.
    END.


    MESSAGE "Confirm translation?"
      VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
      TITLE "" UPDATE choice AS LOGICAL.
    IF not choice THEN do:
       return no-apply.
    END.


    IF ptranslate-one-line THEN do:
    END.
    else do:
         assign pcons-ini = 0
                pcons-fin = 1000000.

    END.

    assign psrc-folder-temp = lectures_default.src-folder-temp
           pdes-folder-temp = lectures_default.des-folder-temp
        .
    ASSIGN 
        psrc-lang = "Hi"
        pdes-lang = "Gu" 
        .

    
    ASSIGN 
        psrc-lang = wsrc-lang:screen-value
        pdes-lang = wdes-lang:screen-value
        .

    assign pprocess-type = 5.

    IF pprocess-type = 5 THEN do:
      assign
          psrc-file = psrc-folder-temp + plectures-filename + "_" + psrc-lang + ".srt"
          pdes-file = pdes-folder-temp + plectures-filename + "_" + pdes-lang + ".srt"
          .
    END.
  SESSION:SET-WAIT-STATE("GENERAL").

  assign wstart-time:screen-value = string(time,"HH:MM:SS").
  run c:\pvr\translation\lib\py-command.p.
  assign wEND-time:screen-value = string(time,"HH:MM:SS").
  SESSION:SET-WAIT-STATE("").

  IF ptranslate-one-line THEN do:
  END.
  else do:
       APPLY "Choose" TO BtnSearch.
  END.


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME CtrlFrame-4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL CtrlFrame-4 wWin OCX.Tick
PROCEDURE CtrlFrame-4.PSTimer.Tick .
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  None required for OCX.
  Notes:       
------------------------------------------------------------------------------*/

DO WITH FRAME {&FRAME-NAME}:
    
END.
IF pdur-ctrl = true THEN do:
     assign ptick = ptick + 1.
     IF ptick = pduration then do:
        apply "Choose" to BTNPAUSE.
        assign ptick = 0.
        MESSAGE chCtrlFrame:WMP:controls:currenTPOSITION
            VIEW-AS ALERT-BOX INFO BUTTONS OK.
     END.
END.



END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME wdes-lang
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wdes-lang wWin
ON VALUE-CHANGED OF wdes-lang IN FRAME fMain
DO:
    APPLY "value-changed" TO browse-1.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME wsearch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wsearch wWin
ON ANY-PRINTABLE OF wsearch IN FRAME fMain /* Search */
DO:
    /*
     APPLY "Choose" TO BtnSearch.
     APPLY LAST-EVENT:LABEL TO SELF.
     apply "entry" to self.
     return no-apply.
     */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wsearch wWin
ON LEAVE OF wsearch IN FRAME fMain /* Search */
DO:
  APPLY "Choose" to BtnSearch.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK wWin 


/* ***************************  Main Block  *************************** */

/* Include custom  Main Block code for SmartWindows. */
{src/adm2/windowmn.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-create-objects wWin  _ADM-CREATE-OBJECTS
PROCEDURE adm-create-objects :
/*------------------------------------------------------------------------------
  Purpose:     Create handles for all SmartObjects used in this procedure.
               After SmartObjects are initialized, then SmartLinks are added.
  Parameters:  <none>
------------------------------------------------------------------------------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE control_load wWin  _CONTROL-LOAD
PROCEDURE control_load :
/*------------------------------------------------------------------------------
  Purpose:     Load the OCXs    
  Parameters:  <none>
  Notes:       Here we load, initialize and make visible the 
               OCXs in the interface.                        
------------------------------------------------------------------------------*/

&IF "{&OPSYS}" = "WIN32":U AND "{&WINDOW-SYSTEM}" NE "TTY":U &THEN
DEFINE VARIABLE UIB_S    AS LOGICAL    NO-UNDO.
DEFINE VARIABLE OCXFile  AS CHARACTER  NO-UNDO.

OCXFile = SEARCH( "wspeech_final.wrx":U ).
IF OCXFile = ? THEN
  OCXFile = SEARCH(SUBSTRING(THIS-PROCEDURE:FILE-NAME, 1,
                     R-INDEX(THIS-PROCEDURE:FILE-NAME, ".":U), "CHARACTER":U) + "wrx":U).

IF OCXFile <> ? THEN
DO:
  ASSIGN
    chCtrlFrame = CtrlFrame:COM-HANDLE
    UIB_S = chCtrlFrame:LoadControls( OCXFile, "CtrlFrame":U)
    chCtrlFrame-4 = CtrlFrame-4:COM-HANDLE
    UIB_S = chCtrlFrame-4:LoadControls( OCXFile, "CtrlFrame-4":U)
  .
  RUN initialize-controls IN THIS-PROCEDURE NO-ERROR.
END.
ELSE MESSAGE "wspeech_final.wrx":U SKIP(1)
             "The binary control file could not be found. The controls cannot be loaded."
             VIEW-AS ALERT-BOX TITLE "Controls Not Loaded".

&ENDIF

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI wWin  _DEFAULT-DISABLE
PROCEDURE disable_UI :
/*------------------------------------------------------------------------------
  Purpose:     DISABLE the User Interface
  Parameters:  <none>
  Notes:       Here we clean-up the user-interface by deleting
               dynamic widgets we have created and/or hide 
               frames.  This procedure is usually called when
               we are ready to "clean-up" after running.
------------------------------------------------------------------------------*/
  /* Delete the WINDOW we created */
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wWin)
  THEN DELETE WIDGET wWin.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI wWin  _DEFAULT-ENABLE
PROCEDURE enable_UI :
/*------------------------------------------------------------------------------
  Purpose:     ENABLE the User Interface
  Parameters:  <none>
  Notes:       Here we display/view/enable the widgets in the
               user-interface.  In addition, OPEN all queries
               associated with each FRAME and BROWSE.
               These statements here are based on the "Other 
               Settings" section of the widget Property Sheets.
------------------------------------------------------------------------------*/
  DISPLAY wsearch wdes-lang wsrc-lang wenglish whindi wother-lang wstart-time 
          wend-time 
      WITH FRAME fMain IN WINDOW wWin.
  ENABLE RECT-1 RECT-2 RECT-3 RECT-4 wsearch BtnSearch wdes-lang wsrc-lang 
         BROWSE-1 BtnPlay btnStop BtnPause BtnAssignPosition wenglish whindi 
         wother-lang BtnGenerateSrtFile BtnTranslate 
      WITH FRAME fMain IN WINDOW wWin.
  {&OPEN-BROWSERS-IN-QUERY-fMain}
  VIEW wWin.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE exitObject wWin 
PROCEDURE exitObject :
/*------------------------------------------------------------------------------
  Purpose:  Window-specific override of this procedure which destroys 
            its contents and itself.
    Notes:  
------------------------------------------------------------------------------*/
  DO WITH FRAME {&FRAME-NAME}:
      
  END.
  APPLY "Choose" to btnStop.
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE initializeObject wWin 
PROCEDURE initializeObject :
/*------------------------------------------------------------------------------
  Purpose:     Super Override
  Parameters:  
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  RUN SUPER.

  /* Code placed here will execute AFTER standard behavior.    */
  RUN SUPER.

  /* Code placed here will execute AFTER standard behavior.    */
  DO WITH FRAME {&FRAME-NAME}:
  END.
  assign wsearch = "*".

  assign plectures-code = 942.

  find lectures where lectures.lectures-code = plectures-code no-lock no-error.
  IF available lectures THEN do:
     assign  plectures-filename = lectures.lectures-filename.
  END.

  assign
      wsrc-lang:screen-value = " " 
      wdes-lang:screen-value = " " .


  APPLY "Choose" TO BtnSearch.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

